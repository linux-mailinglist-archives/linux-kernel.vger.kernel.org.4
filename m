Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33693614E2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKAPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiKAPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:19:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95763B5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 08:17:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA152B81BED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB47C433C1;
        Tue,  1 Nov 2022 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667315871;
        bh=vPFxSX5tdfDxM0GAlj0EtKyOoh8TOU8IF/wbZdlbQJg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tOaCLU+P43XRFjDjmirIAIdR3msJhGtnKSJFIiQymEC40DZ06RWjG22zC9CT8Ck75
         x2Buh9CewAett6IFLQLozPri5hzkq702ejDoCJEYVP1KI4XBcKFptTZH4M9ALXeud2
         swuHc+enFVy7H+luFxawRP7Tf/iOW7UXFDHXZ2zXtT7bRHto4WXweiJG8NZoQ8kypM
         jyYvZKdMuv3b9M3fEgrZAzWQ3drIV8l3shfh3+Zm4H87Kai6DBfw9hOoql6EoK6JjP
         E3MQTIAy166W+CNIxObCXn40mkEjCtztXhV6zAp/mtwSyBPSwIfVJ+IUCZUAeOuhbo
         05CiSKZsVLcfw==
Message-ID: <fd3f0cc6-1d7c-85bd-9887-ec32dd36601a@kernel.org>
Date:   Tue, 1 Nov 2022 23:17:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] f2fs: stop discard thread if has fsck tag
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221028143733.57322-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221028143733.57322-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/28 22:37, Yangtao Li wrote:
> Under the current logic, after the fsck flag is set,
> the discard thread will still run periodically.
> 
> So stop the discard thread from running to avoid
> energy consumption after the fsck flag is set.
> 
> Fixes: d618477473eb ("f2fs: stop issue discard if something wrong with f2fs")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> - commit msg changes.
>   fs/f2fs/segment.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7786351de429..b3600bcadfc7 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1716,8 +1716,8 @@ static int issue_discard_thread(void *data)
>   		if (kthread_should_stop())
>   			return 0;
>   		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
> -			wait_ms = dpolicy.max_interval;
> -			continue;
> +			dcc->f2fs_issue_discard = NULL;
> +			return 0;

I don't think there will be much energy consumption, I guess
we can keep as it is.

>   		}
>   		if (!atomic_read(&dcc->discard_cmd_cnt))
>   			continue;
