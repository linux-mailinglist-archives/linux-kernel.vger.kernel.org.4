Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC14F60C208
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJYDDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJYDDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:03:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84FD1211DB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83E47B81729
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D1DC433D6;
        Tue, 25 Oct 2022 03:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666666993;
        bh=C0BzoxkThe4sl0x6SHLn0j8oqMtjmakTknJ4uj7PQTI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WhOyePJz7tW6yocb59ISNSqfnILjY6mCjKZ209fPxjxprTu70KVjuJvAMcOA12pE6
         Ncz12n+2S2bZMYwqifAIcgGjGhbRJ/f63Xiv07gqs89xoVnPEBzPVSsQ1Gige+1ffM
         hVdq/qaNjVfos5hS55HOXcPnkbeU/0lFa3s8NUxSm65745aZRJE3OaVNfSQQkclNdJ
         s5VMhHAtxtlcfl9trvpDhdmmsXoeA4RgZuq5cmI9KJ6x+Cn0aLrgQm8CVD/Xm2QRV3
         2flOFndoW1FJnjd4POGuPSmvp92dpk8DgCMwmzLjlc0RBwQEDiegxI3iCAGhbkj0ft
         d3nlsQmLtIdxw==
Message-ID: <5f0e2e43-1167-7fb7-9dc6-02ed0fc1858b@kernel.org>
Date:   Tue, 25 Oct 2022 11:03:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] f2fs: fix gc mode when gc_urgent_high_remaining is 1
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221021174633.12541-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221021174633.12541-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/22 1:46, Yangtao Li wrote:
> Under the current logic, when gc_urgent_high_remaining is set to 1,
> the mode will be switched to normal at the beginning, instead of
> running in gc_urgent mode.
> 
> Let's switch the gc mode back to normal when the gc ends.
> 
> Fixes: 265576181b4a ("f2fs: remove gc_urgent_high_limited for cleanup")
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/gc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4546e01b2ee0..2f113fbcb85c 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -45,6 +45,7 @@ static int gc_thread_func(void *data)
>   	set_freezable();
>   	do {
>   		bool sync_mode, foreground = false;
> +		bool gc_normal_mode = false;
>   
>   		wait_event_interruptible_timeout(*wq,
>   				kthread_should_stop() || freezing(current) ||
> @@ -101,7 +102,7 @@ static int gc_thread_func(void *data)
>   			if (sbi->gc_urgent_high_remaining) {
>   				sbi->gc_urgent_high_remaining--;
>   				if (!sbi->gc_urgent_high_remaining)
> -					sbi->gc_mode = GC_NORMAL;
> +					gc_normal_mode = true;
>   			}
>   			spin_unlock(&sbi->gc_urgent_high_lock);

So, can we move above logic to the end of loop?

>   		}
> @@ -162,6 +163,10 @@ static int gc_thread_func(void *data)
>   		/* balancing f2fs's metadata periodically */
>   		f2fs_balance_fs_bg(sbi, true);
>   next:
> +		if (gc_normal_mode) {
> +			sbi->gc_mode = GC_NORMAL;
> +			gc_normal_mode = false;
> +		}
>   		sb_end_write(sbi->sb);
>   
>   	} while (!kthread_should_stop());
