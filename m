Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DDF5F544E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJEMTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJEMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1803A4DF25
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664972365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0IP2Q/SFyk+E5joRy/Gl92dMItD+kKxqDH/MwB9IYM=;
        b=PO62T3vEmQ4wYbHnjIwOCgOKLiHlTVLhGNiB7riZiOGNtuNMWOpL5J2HOhMGPdulq8Om20
        gnK0bh51P8X9zafHyXkVuF2u4D/C1ElcVibgaY5hcUjtkwCzQw3Bf/4oWWFNnlZMKImHSm
        PIUU33qPWTZGsvek7vfluzbYWah8jDU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-332-68eOuNUcONKHKTi58mqqcA-1; Wed, 05 Oct 2022 08:19:24 -0400
X-MC-Unique: 68eOuNUcONKHKTi58mqqcA-1
Received: by mail-wr1-f70.google.com with SMTP id n8-20020adf8b08000000b0022e4d3dc8d2so1857979wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 05:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0IP2Q/SFyk+E5joRy/Gl92dMItD+kKxqDH/MwB9IYM=;
        b=Ixwf7qVmRFPvzROJI/h6Wf2lGeL82nzuIWQomkZlVK99gf2b2ZysdxbApqqudenkIn
         rbY3vpMiOUiC4AiOcwYSBWImscdOAUhNFcCWKBcefjCFzvA0EnK0oR0+jtMERetWVLhD
         7FMyGXbq85TaZ2J4C4nTiYOXSTyFOauUV14QvBcQ2l3aBPmC+DYvqCNbeBAX7ydz++ks
         JrrSCNKBN19HEZoh4X2Z23eVfQRkvFgdjLNiFEftKv29g5xk8qvqcCa9NfAFNPdSmhqy
         ml+rRcBt5Zbwe3vDjP5MnAboLGh1CI8FVUGJqn++fsL699UdF3Nhf1O1Ojil5LAe7IEm
         NQtg==
X-Gm-Message-State: ACrzQf3l/tXDp+/I9xUpkOkN5KnqdK0OWcLJ28c5UNOBCz/Z3sFOiYG1
        5DSWlRpfySCT8TBUNt94bvv0OnYPGIP9oRlgnChky5MmqiqrfyF4J9Y7LoQSinLB97PIs2rbRlM
        EDBR93abHoUCTGA4kVcnz5K+B
X-Received: by 2002:a05:600c:3b8c:b0:3b4:8ad1:d894 with SMTP id n12-20020a05600c3b8c00b003b48ad1d894mr3140336wms.113.1664972361812;
        Wed, 05 Oct 2022 05:19:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66bVwTHS3ezLO9XJqEXHFj4hjLkIIwdQIbGvhgdXuFEVfqrQZOAb1/bfpx9fSGV5jtlxazSA==
X-Received: by 2002:a05:600c:3b8c:b0:3b4:8ad1:d894 with SMTP id n12-20020a05600c3b8c00b003b48ad1d894mr3140317wms.113.1664972361616;
        Wed, 05 Oct 2022 05:19:21 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003b477532e66sm9478522wms.2.2022.10.05.05.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 05:19:20 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH bitmap-for-next 1/5] blk_mq: Fix cpumask_check() warning
 in blk_mq_hctx_next_cpu()
In-Reply-To: <Yzshzw6hKhbtdxSd@yury-laptop>
References: <20221003153420.285896-1-vschneid@redhat.com>
 <20221003153420.285896-2-vschneid@redhat.com>
 <Yzshzw6hKhbtdxSd@yury-laptop>
Date:   Wed, 05 Oct 2022 13:19:20 +0100
Message-ID: <xhsmha66a31kn.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/22 10:54, Yury Norov wrote:
> On Mon, Oct 03, 2022 at 04:34:16PM +0100, Valentin Schneider wrote:
>> A recent commit made cpumask_next*() trigger a warning when passed
>> n = nr_cpu_ids - 1. This means extra care must be taken when feeding CPU
>> numbers back into cpumask_next*().
>>
>> The warning occurs nearly every boot on QEMU:
>
> [...]
>
>> Fixes: 78e5a3399421 ("cpumask: fix checking valid cpu range")
>
> No! It fixes blk-mq bug, which has been revealed after 78e5a3399421.
>
>> Suggested-by: Yury Norov <yury.norov@gmail.com>
>
> OK, maybe I suggested something like this. But after looking into the code
> of blk_mq_hctx_next_cpu() code for more, I have a feeling that this should
> be overridden deeper.
>
> Can you check - did this warning raise because hctx->next_cpu, or
> because cpumask_next_and() was called twice after jumping on
> select_cpu label?
>

It seems to always happen when hctx->next_cpu == nr_cpu_ids-1 at the start
of the function - no jumping involved.

>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  block/blk-mq.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index c96c8c4f751b..30ae51eda95e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2046,8 +2046,13 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>>
>>      if (--hctx->next_cpu_batch <= 0) {
>>  select_cpu:
>
> Because we have backward looking goto, I have a strong feeling that the
> code should be reorganized.
>
>> -		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
>> -				cpu_online_mask);
>> +		if (next_cpu == nr_cpu_ids - 1)
>> +			next_cpu = nr_cpu_ids;
>> +		else
>> +			next_cpu = cpumask_next_and(next_cpu,
>> +						    hctx->cpumask,
>> +						    cpu_online_mask);
>> +
>>              if (next_cpu >= nr_cpu_ids)
>>                      next_cpu = blk_mq_first_mapped_cpu(hctx);
>
> This simply means 'let's start from the beginning', and should be
> replaced with cpumask_next_and_wrap().

I hadn't looked in depth there, but that's a strange behaviour.
If we get to the end of the cpumask, blk_mq_first_mapped_cpu() does:

        int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);

        if (cpu >= nr_cpu_ids)
                cpu = cpumask_first(hctx->cpumask);
        return cpu;

That if branch means the returned CPU is offline, which then triggers:

        if (!cpu_online(next_cpu)) {
                if (!tried) {
                        tried = true;
                        goto select_cpu;
                }

but going back to select_cpu doesn't make much sense, we've already checked
that hctx->cpumask and cpu_online_mask were disjoint.

>
>>              hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
>
>
> Maybe something like this would work?
>
>         if (--hctx->next_cpu_batch > 0 && cpu_online(next_cpu)) {
>                 hctx->next_cpu = next_cpu;
>                 return next_cpu;
>         }
>
>         next_cpu = cpumask_next_and_wrap(next_cpu, hctx->cpumask, cpu_online_mask)
>         if (next_cpu < nr_cpu_ids) {
>                 hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
>                 hctx->next_cpu = next_cpu;
>                 return next_cpu;
>         }
>
>         /*
>          * Make sure to re-select CPU next time once after CPUs
>          * in hctx->cpumask become online again.
>          */
>         hctx->next_cpu = next_cpu;
>         hctx->next_cpu_batch = 1;
>         return WORK_CPU_UNBOUND;
>
> I didn't test it and likely screwed some corner case. I'm just
> trying to say that picking next cpu should be an easier thing.
>

Agreed, your suggestion looks sane, let me play with that a bit.

> Thanks,
> Yury

