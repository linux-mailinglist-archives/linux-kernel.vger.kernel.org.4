Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022FD6363D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiKWPgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiKWPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:36:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A71D748E5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:36:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F220F61DAC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B0BC433C1;
        Wed, 23 Nov 2022 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217802;
        bh=Db2IMqt/WnSC6DJcik+jIpLTIIOJDwi9tk6VSBExq7s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Pa9gjxejMoB6NBP/+t0yFzKXmAt+UwG4jEZ37OvVsQZrwr70uTQj0NrXgO6He/FsN
         3mPOKgWgo20myCQck0T9ZJH3Gy2o80QsyIiD9J2pHz4VpbKeGDmmYhdpajKsYbXHS/
         OjRDWWqa+EgnU/HBW4qXDIWEGkzXtDw0a/3guyLyTyk2T2im5mfhE7aBejwqgjBj9S
         oCueTveZ129pTh2AgcJ3wX4YfKokRQ3PUyh719uU9jJbxJSAU7Yo2eOfKGOWvILdaG
         9FgnVZJQeQfximeaxZsB2GVuLhlFM+f1Wqi5DBNLjpwap2Hkwy3/JibcbJ01/3Nqr4
         uNua9p+uZNZlg==
Message-ID: <6258327d-8205-644e-9879-c96448841720@kernel.org>
Date:   Wed, 23 Nov 2022 23:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: init discard policy after thread wakeup
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221118034600.59489-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221118034600.59489-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/18 11:46, Yangtao Li wrote:
> Under the current logic, after the discard thread wakes up, it will not
> run according to the expected policy, but will use the expected policy
> before sleep. Move the strategy selection to after the thread wakes up,
> so that the running state of the thread meets expectations.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8b0b76550578..609e90aa80c2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1685,6 +1685,11 @@ static int issue_discard_thread(void *data)
>   	set_freezable();
>   
>   	do {

		if (!atomic_read(&dcc->discard_cmd_cnt))
		       wait_ms = dpolicy.max_interval;

Thanks,

> +		wait_event_interruptible_timeout(*q,
> +				kthread_should_stop() || freezing(current) ||
> +				dcc->discard_wake,
> +				msecs_to_jiffies(wait_ms));
> +
>   		if (sbi->gc_mode == GC_URGENT_HIGH ||
>   			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
>   			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
> @@ -1692,14 +1697,6 @@ static int issue_discard_thread(void *data)
>   			__init_discard_policy(sbi, &dpolicy, DPOLICY_BG,
>   						dcc->discard_granularity);
>   
> -		if (!atomic_read(&dcc->discard_cmd_cnt))
> -		       wait_ms = dpolicy.max_interval;
> -
> -		wait_event_interruptible_timeout(*q,
> -				kthread_should_stop() || freezing(current) ||
> -				dcc->discard_wake,
> -				msecs_to_jiffies(wait_ms));
> -
>   		if (dcc->discard_wake)
>   			dcc->discard_wake = 0;
>   
> @@ -1713,12 +1710,11 @@ static int issue_discard_thread(void *data)
>   			continue;
>   		if (kthread_should_stop())
>   			return 0;
> -		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> +		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
> +			!atomic_read(&dcc->discard_cmd_cnt)) {
>   			wait_ms = dpolicy.max_interval;
>   			continue;
>   		}
> -		if (!atomic_read(&dcc->discard_cmd_cnt))
> -			continue;
>   
>   		sb_start_intwrite(sbi->sb);
>   
> @@ -1733,6 +1729,8 @@ static int issue_discard_thread(void *data)
>   		} else {
>   			wait_ms = dpolicy.max_interval;
>   		}
> +		if (!atomic_read(&dcc->discard_cmd_cnt))
> +			wait_ms = dpolicy.max_interval;
>   
>   		sb_end_intwrite(sbi->sb);
>   
