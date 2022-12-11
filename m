Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D5D649211
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiLKCwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLKCw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:52:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA9F13F35
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:52:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DEA44CE0ADC
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 02:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9BBC433D2;
        Sun, 11 Dec 2022 02:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670727144;
        bh=yVMfp1uldktAIyVGvt7Bwh+o9jSNVgi13RdkbJkMSso=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ii8rmZPLgA65CJBwT9eRtatBx4UujWU5YmhkOIbXTyN/p8hD3c0QeM0Yg3XyxuA4e
         0mS7XyVuhbpQrg8pKgTB2ZgLPak8OBEVwvUCgFjSaapqe5FW2UJay+PoYCYQYFM6Sq
         MuzVq1pq8Cn15ourdetznTtcScCwSQ2h5S5Sy9ukKKZXGAofsvPSKcOjFRKJ+NTWzn
         fKswUWgUgAdMpfXHfO6orI4DhhnWvmLLwaVVDbsq426NjAhjujhkt+vzAZku9ADsWq
         mwUXnCZZY0E5GkGRPbCy2QSvl23+zQboHu97R2eDzsvtulb+0VKDMqruWJFFTF6Jjb
         CMTSQ/WBcXRcQ==
Message-ID: <810bd221-1f35-db79-e9f3-a521464b3eaf@kernel.org>
Date:   Sun, 11 Dec 2022 10:52:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221209112813.73700-1-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: do decrease_sleep_time() if any of the victims have
 been selected
In-Reply-To: <20221209112813.73700-1-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/9 19:28, Yuwei Guan wrote:
> In non-foreground gc mode, if no victim is selected, the gc process
> will wait for no_gc_sleep_time before waking up again. In this
> subsequent time, even though a victim will be selected, the gc process
> still waits for no_gc_sleep_time before waking up. The configuration
> of wait_ms is not reasonable.
> 
> After any of the victims have been selected, we need to do
> decrease_sleep_time() to reduce wait_ms.
> 
> If it is GC_URGENT_HIGH or GC_URGENT_MID gc mode,
> wait_ms will keep urgent_sleep_time after executing decrease_sleep_time().
> 
> In decrease_sleep_time() wait_time will be reduced to max_sleep_time
> from no_gc_sleep_time, if *wait is no_gc_sleep_time. And then it goes
> down in the next step.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>   fs/f2fs/gc.c | 2 ++
>   fs/f2fs/gc.h | 7 ++++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index f0c6506d8975..c023ffeb9268 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -141,6 +141,8 @@ static int gc_thread_func(void *data)
>   			/* don't bother wait_ms by foreground gc */
>   			if (!foreground)
>   				wait_ms = gc_th->no_gc_sleep_time;
> +		} else {
> +			decrease_sleep_time(gc_th, &wait_ms);

Once BGGC selects valid victim, it will go faster and fater?

How about:

	} else {
		/* reset wait_ms to default sleep time */
		if (wait_ms == gc_th->no_gc_sleep_time)
			wait_ms = gc_th->min_sleep_time;
	}

Thanks,

>   		}
>   
>   		if (foreground)
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 19b956c2d697..6402584dcd72 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -150,8 +150,13 @@ static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
>   {
>   	unsigned int min_time = gc_th->min_sleep_time;
>   
> -	if (*wait == gc_th->no_gc_sleep_time)
> +	if (*wait == gc_th->urgent_sleep_time)
> +		return;
> +
> +	if (*wait == gc_th->no_gc_sleep_time) {
>   		*wait = gc_th->max_sleep_time;
> +		return;
> +	}
>   
>   	if ((long long)*wait - (long long)min_time < (long long)min_time)
>   		*wait = min_time;
