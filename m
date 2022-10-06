Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5AD5F6894
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJFNwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJFNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:52:16 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE049FFC;
        Thu,  6 Oct 2022 06:52:14 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id d22-20020a4a5216000000b0047f740d5847so1416399oob.13;
        Thu, 06 Oct 2022 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3w1N6cAYXcTYVDEoqLPleQfVTM3iy8dzcjzK6Lzia68=;
        b=PzkZ37yLE12Q6hbAvKYJ5ajfKdV8BPY9I0+haNFdbo/8aUbSry4iynrmovbQeLJsKb
         /+vOdlsI5pFcJgnC3fcL3XTS0SH38Uke8wmsDS89+MDByaPmykN3Fb/TMslv16vcZT+y
         lKbpaEGMuyBPsdLcT1gGKltpDPZHHnj2E03285P95eY8QkLAcEShvW9XwODnWsIjKOGu
         qhRsY2wHWIcCSVuGgzFspXAYMEFPdETb4g9sR1Sy3Zt5p2wtsBV04Yl2uA1iy0JN/9ir
         ZARWzyZ8o+EIamH0C/VEoou+yLPT7QWYg1ZsTwo9b/hMpASfq7gm74mqo/fj6TWWy26d
         SrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w1N6cAYXcTYVDEoqLPleQfVTM3iy8dzcjzK6Lzia68=;
        b=YaurmCcX3T4Y32U23aPVJt0RLIfiEFwNyF7zRQyLXV3LyBV3Nq7x7eNSNHRLIQlRAj
         fjMLKikaIdlelNjDCL9nVMRSxIwBQxD739UddmKdF86FfuxCJXE8JXKRJM2s3HyBA+Iq
         mNBc4MQuTYUgoUdnkYxfZDJbwbtUQpRGXKIdR86xz9W0McHFeUAlY4YiWVKqsOTIuExy
         PiG1nkD4/uPOfODr9kSD+L/fayPwXORAuDauj8P45LW8cTJMwY4yZXm2lr4IZtdmJi+o
         h6UEa6oVFs7tUAPza8y2gJATFmNEpjeFeXsqjrAfAwceqXdxxO61WckScjUHUDXzr3wl
         VraQ==
X-Gm-Message-State: ACrzQf2fTwGhut++rKz6C0W5ykKKlIrOTzyLR+P8DqBUopA4rtnpg4VU
        /HaDTnz4wctgJafi+gRkJ/Ri0kATD3Y=
X-Google-Smtp-Source: AMsMyM6zWqHd198tfHrixIxFqyGVKtlilHGal/7xFotzYoXGFZzqMUbEeMvNuavt+TknZbbChhTm1g==
X-Received: by 2002:a9d:4b11:0:b0:655:f017:962c with SMTP id q17-20020a9d4b11000000b00655f017962cmr1960106otf.322.1665064333727;
        Thu, 06 Oct 2022 06:52:13 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id bq13-20020a05680823cd00b00353f41440dasm2433469oib.56.2022.10.06.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:52:13 -0700 (PDT)
Date:   Thu, 6 Oct 2022 06:50:03 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH bitmap-for-next 4/4] blk_mq: Fix cpumask_check()
 warning in blk_mq_hctx_next_cpu()
Message-ID: <Yz7dC4zxby1CZphE@yury-laptop>
References: <20221006122112.663119-1-vschneid@redhat.com>
 <20221006122112.663119-5-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006122112.663119-5-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:21:12PM +0100, Valentin Schneider wrote:
> blk_mq_hctx_next_cpu() implements a form of cpumask_next_and_wrap() using
> cpumask_next_and_cpu() and blk_mq_first_mapped_cpu():
> 
> [    5.398453] WARNING: CPU: 3 PID: 162 at include/linux/cpumask.h:110 __blk_mq_delay_run_hw_queue+0x16b/0x180
> [    5.399317] Modules linked in:
> [    5.399646] CPU: 3 PID: 162 Comm: ssh-keygen Tainted: G                 N 6.0.0-rc4-00004-g93003cb24006 #55
> [    5.400135] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [    5.405430] Call Trace:
> [    5.406152]  <TASK>
> [    5.406452]  blk_mq_sched_insert_requests+0x67/0x150
> [    5.406759]  blk_mq_flush_plug_list+0xd0/0x280
> [    5.406987]  ? bit_wait+0x60/0x60
> [    5.407317]  __blk_flush_plug+0xdb/0x120
> [    5.407561]  ? bit_wait+0x60/0x60
> [    5.407765]  io_schedule_prepare+0x38/0x40
> [...]
> 
> This triggers a warning when next_cpu == nr_cpu_ids - 1, so rewrite it
> using cpumask_next_and_wrap() directly. The backwards-going goto can be
> removed, as the cpumask_next*() operation already ANDs hctx->cpumask and
> cpu_online_mask, which implies checking for an online CPU.
> 
> No change in behaviour intended.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  block/blk-mq.c | 39 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c96c8c4f751b..1520794dd9ea 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2038,42 +2038,29 @@ static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
>   */
>  static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>  {
> -	bool tried = false;
>  	int next_cpu = hctx->next_cpu;
>  
>  	if (hctx->queue->nr_hw_queues == 1)
>  		return WORK_CPU_UNBOUND;
>  
> -	if (--hctx->next_cpu_batch <= 0) {
> -select_cpu:
> -		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
> -				cpu_online_mask);
> -		if (next_cpu >= nr_cpu_ids)
> -			next_cpu = blk_mq_first_mapped_cpu(hctx);
> +	if (--hctx->next_cpu_batch > 0 && cpu_online(next_cpu))
> +		return next_cpu;
> +
> +	next_cpu = cpumask_next_and_wrap(next_cpu, hctx->cpumask, cpu_online_mask, next_cpu, false);

Last two parameters are simply useless. In fact, in many cases they
are useless for cpumask_next_wrap(). I'm working on simplifying the
cpumask_next_wrap() so that it would take just 2 parameters - pivot
point and cpumask.

Regarding 'next' version - we already have find_next_and_bit_wrap(),
and I think cpumask_next_and_wrap() should use it.

For the context: those last parameters are needed to exclude part of
cpumask from traversing, and to implement for-loop. Now that we have
for_each_cpu_wrap() based on for_each_set_bit_wrap(), it's possible
to remove them. I'm working on it.

> +	if (next_cpu < nr_cpu_ids) {
>  		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
> +		hctx->next_cpu = next_cpu;
> +		return next_cpu;
>  	}
>  
>  	/*
> -	 * Do unbound schedule if we can't find a online CPU for this hctx,
> -	 * and it should only happen in the path of handling CPU DEAD.
> +	 * No other online CPU in hctx->cpumask.
> +	 *
> +	 * Make sure to re-select CPU next time once after CPUs
> +	 * in hctx->cpumask become online again.
>  	 */
> -	if (!cpu_online(next_cpu)) {
> -		if (!tried) {
> -			tried = true;
> -			goto select_cpu;
> -		}
> -
> -		/*
> -		 * Make sure to re-select CPU next time once after CPUs
> -		 * in hctx->cpumask become online again.
> -		 */
> -		hctx->next_cpu = next_cpu;
> -		hctx->next_cpu_batch = 1;
> -		return WORK_CPU_UNBOUND;
> -	}
> -
> -	hctx->next_cpu = next_cpu;
> -	return next_cpu;
> +	hctx->next_cpu_batch = 1;
> +	return WORK_CPU_UNBOUND;
>  }
>  
>  /**
> -- 
> 2.31.1
