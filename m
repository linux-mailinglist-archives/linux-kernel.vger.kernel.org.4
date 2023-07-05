Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EFF748C10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjGESjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGESje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:39:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2C170B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:39:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39ecf031271so5458052b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688582371; x=1691174371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvoAfH46ozWPM/+XuG3GB1n0yU4PyVD6tOel9blObwA=;
        b=ISOjIOPaJJm4/UJA7iyu6DBCtd4SKtahfvAWjsyYoXvjzympIDw5Px7LRrJF9rDSUz
         tC5sG/dW4VrfNmM/xFo7sRGPNKnwH+8De6F2vfWDHTriE01PZlFJzVGynj6zPvV1kywc
         DMUp3ZNa8XX5pdePeMqoyqsedrn6333BiZx730UJzTvARaIsBwhq8xS2hownrLjYpTYO
         uH52wjLtdGwkEqEhpFq/hQUnNMAVx9CiQflz7MD3+fW8XIL6Xx2+N5//cQJk0dbDR2pg
         h6+nOPxH0RqSzl4GKoOKYR/HCjS+7C3LE0O1cjcVUTAFmNXtR4Pg0EzLeRDwTKyfdEIN
         lxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688582371; x=1691174371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvoAfH46ozWPM/+XuG3GB1n0yU4PyVD6tOel9blObwA=;
        b=kdIpbV0Jcgfx+dWU/6SPeJwpxRAAhoMvisYissdlkkoA6VeWkLcobryYLUbj8fbqdp
         U5zXaFzd1RC31NbFfiZgmNQ4Ld18oDkHJxayAlLIpecnu7xE6e3Ygh8AkRXIqQDvoa0G
         m81Vq3Fq3+HPIV/xxyhD6wuasa/bJaJjx6sRyB0H7cetzYoS88zw/R40XiUG7K9TwjlL
         37MFv76uN5DgoNgM2FF/AsmGm2O5SLSIW53GTrG818LX6forkSK+pspqXxfPDPH2jGRC
         3fKZU0qNlEYqwrqtsT0EegjRe4jLIJUTeHjCk8+YHs8ptNOCR6CUNq1QFkcrX6nkTXKA
         kOmg==
X-Gm-Message-State: AC+VfDxBUrCZj50IlpUwjIIicMzN0vliRasULAxTBk3lV0lL23xaz6YF
        I46QV0Z/FAfUN69aanQSBq4=
X-Google-Smtp-Source: ACHHUZ7NjqcdefXJO80KRaddKrWxRiCyTgWxDffA3L/uSgOHzwZBaE/MF1TXFqcFhDNlFqVWzUJ6DQ==
X-Received: by 2002:a05:6808:18aa:b0:3a1:d8cb:17d4 with SMTP id bi42-20020a05680818aa00b003a1d8cb17d4mr18429678oib.35.1688582371422;
        Wed, 05 Jul 2023 11:39:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9cde])
        by smtp.gmail.com with ESMTPSA id j7-20020aa783c7000000b006687b41c4dasm627602pfn.110.2023.07.05.11.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 11:39:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 5 Jul 2023 08:39:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Sandeep Dhavale <dhavale@google.com>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, kernel-team@android.com
Subject: Re: [PATCH 14/24] workqueue: Generalize unbound CPU pods
Message-ID: <ZKW4374Xc6YrRrEW@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-15-tj@kernel.org>
 <CAB=BE-S=cxewXu7nqJY1DC5w9Bapar_C0cTjpZOQ-Qd5GGwYyw@mail.gmail.com>
 <c307ba94-0d8c-3cbf-19da-44ee31751428@amd.com>
 <ZIEBB-A1arYKSK2P@slm.duckdns.org>
 <fb3461cd-3fc2-189a-a86b-c638816a2440@amd.com>
 <ZIJbMQOu_k07jkFf@slm.duckdns.org>
 <d686347e-f76c-7f9c-3f1a-f4326f5167ca@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d686347e-f76c-7f9c-3f1a-f4326f5167ca@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 05, 2023 at 12:34:48PM +0530, K Prateek Nayak wrote:
> - Apart from tbench and netperf, the rest of the benchmarks show no
>   difference out of the box.

Just looking at the data, it's a bit difficult for me to judge. I suppose
most of differences are due to run-to-run variances? It'd be really useful
if the data contains standard deviation (whether historical or directly from
multiple runs).

> - SPECjbb2015 Multi-jVM sees small uplift to max-jOPS with certain
>   affinity scopes.
> 
> - tbench and netperf seem to be unhappy throughout. None of the affinity
>   scopes seem to bring back the performance. I'll dig more into this.

Yeah, that seems pretty consistent.

> ~~~~~~~~~~
> ~ stream ~
> ~~~~~~~~~~
> 
> o NPS1
> 
> - 10 Runs:
> 
> Test:		base		   affinity_scopes
>  Copy:	 245676.59 (0.00 pct)	 333646.71 (35.80 pct)
> Scale:	 206545.41 (0.00 pct)	 205706.04 (-0.40 pct)
>   Add:	 213506.82 (0.00 pct)	 236739.07 (10.88 pct)
> Triad:	 217679.43 (0.00 pct)	 249263.46 (14.50 pct)
> 
> - 100 Runs:
> 
> Test:		base		   affinity_scopes
>  Copy:	 318060.91 (0.00 pct)	 326025.89 (2.50 pct)
> Scale:	 213943.40 (0.00 pct)	 207647.37 (-2.94 pct)
>   Add:	 237892.53 (0.00 pct)	 232164.59 (-2.40 pct)
> Triad:	 245672.84 (0.00 pct)	 246333.21 (0.26 pct)
> 
> o NPS2
> 
> - 10 Runs:
> 
> Test:		base		   affinity_scopes
>  Copy:	 296632.20 (0.00 pct)	 291153.63 (-1.84 pct)
> Scale:	 206193.90 (0.00 pct)	 216368.42 (4.93 pct)
>   Add:	 240363.50 (0.00 pct)	 245954.23 (2.32 pct)
> Triad:	 242748.60 (0.00 pct)	 238606.20 (-1.70 pct)
> 
> - 100 Runs:
> 
> Test:		base		   affinity_scopes
>  Copy:	 322535.79 (0.00 pct)	 315020.03 (-2.33 pct)
> Scale:	 217723.56 (0.00 pct)	 220172.32 (1.12 pct)
>   Add:	 248117.72 (0.00 pct)	 250557.17 (0.98 pct)
> Triad:	 257768.66 (0.00 pct)	 248264.00 (-3.68 pct)
> 
> o NPS4
> 
> - 10 Runs:
> 
> Test:		base		   affinity_scopes
>  Copy:	 274067.54 (0.00 pct)	 302804.77 (10.48 pct)
> Scale:	 224944.53 (0.00 pct)	 230112.39 (2.29 pct)
>   Add:	 229318.09 (0.00 pct)	 241939.54 (5.50 pct)
> Triad:	 230175.89 (0.00 pct)	 253613.85 (10.18 pct)
> 
> - 100 Runs:
> 
> Test:		base		   affinity_scopes
>  Copy:	 338922.96 (0.00 pct)	 348183.65 (2.73 pct)
> Scale:	 240262.45 (0.00 pct)	 245939.67 (2.36 pct)
>   Add:	 256968.24 (0.00 pct)	 260657.01 (1.43 pct)
> Triad:	 262644.16 (0.00 pct)	 262286.46 (-0.13 pct)

The differences seem more consistent and pronounced for this benchmark too.
Is this just expected variance for this benchmark?

> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~ Benchmarks run with multiple affinity scope ~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> o NPS1
> 
> - tbench
> 
> Clients:     base                     cpu                    cache                   numa                    system
>     1    450.40 (0.00 pct)       459.44 (2.00 pct)       457.12 (1.49 pct)       456.36 (1.32 pct)       456.75 (1.40 pct)
>     2    872.50 (0.00 pct)       869.68 (-0.32 pct)      890.59 (2.07 pct)       878.87 (0.73 pct)       890.14 (2.02 pct)
>     4    1630.13 (0.00 pct)      1621.24 (-0.54 pct)     1634.74 (0.28 pct)      1628.62 (-0.09 pct)     1646.57 (1.00 pct)
>     8    3139.90 (0.00 pct)      3044.58 (-3.03 pct)     3099.49 (-1.28 pct)     3081.43 (-1.86 pct)     3151.16 (0.35 pct)
>    16    6113.51 (0.00 pct)      5555.17 (-9.13 pct)     5465.09 (-10.60 pct)    5661.31 (-7.39 pct)     5742.58 (-6.06 pct)
>    32    11024.64 (0.00 pct)     9574.62 (-13.15 pct)    9282.62 (-15.80 pct)    9542.00 (-13.44 pct)    9916.66 (-10.05 pct)
>    64    19081.96 (0.00 pct)     15656.53 (-17.95 pct)   15176.12 (-20.46 pct)   16527.77 (-13.38 pct)   15097.97 (-20.87 pct)
>   128    30956.07 (0.00 pct)     28277.80 (-8.65 pct)    27662.76 (-10.63 pct)   27817.94 (-10.13 pct)   28925.78 (-6.55 pct)
>   256    42829.46 (0.00 pct)     38646.48 (-9.76 pct)    38355.27 (-10.44 pct)   37073.24 (-13.43 pct)   34391.01 (-19.70 pct)
>   512    42395.69 (0.00 pct)     36931.34 (-12.88 pct)   39259.49 (-7.39 pct)    36571.62 (-13.73 pct)   36245.55 (-14.50 pct)
>  1024    41973.51 (0.00 pct)     38817.07 (-7.52 pct)    38733.15 (-7.72 pct)    38864.45 (-7.40 pct)    35728.70 (-14.87 pct)
> 
> - netperf
> 
>                         base                    cpu                     cache                   numa                    system
>  1-clients:      100910.82 (0.00 pct)    103440.72 (2.50 pct)    102592.36 (1.66 pct)    103199.49 (2.26 pct)    103561.90 (2.62 pct)
>  2-clients:      99777.76 (0.00 pct)     100414.00 (0.63 pct)    100305.89 (0.52 pct)    99890.90 (0.11 pct)     101512.46 (1.73 pct)
>  4-clients:      97676.17 (0.00 pct)     96624.28 (-1.07 pct)    95966.77 (-1.75 pct)    97105.22 (-0.58 pct)    97972.11 (0.30 pct)
>  8-clients:      95413.11 (0.00 pct)     89926.72 (-5.75 pct)    89977.14 (-5.69 pct)    91020.10 (-4.60 pct)    92458.94 (-3.09 pct)
> 16-clients:      88961.66 (0.00 pct)     81295.02 (-8.61 pct)    79144.83 (-11.03 pct)   80216.42 (-9.83 pct)    85439.68 (-3.95 pct)
> 32-clients:      82199.83 (0.00 pct)     77914.00 (-5.21 pct)    75055.66 (-8.69 pct)    76813.94 (-6.55 pct)    80768.87 (-1.74 pct)
> 64-clients:      66094.87 (0.00 pct)     64419.91 (-2.53 pct)    63718.37 (-3.59 pct)    60370.40 (-8.66 pct)    66179.58 (0.12 pct)
> 128-clients:     43833.63 (0.00 pct)     42936.08 (-2.04 pct)    44554.69 (1.64 pct)     42666.82 (-2.66 pct)    45543.69 (3.90 pct)
> 256-clients:     38917.58 (0.00 pct)     24807.28 (-36.25 pct)   20517.01 (-47.28 pct)   21651.40 (-44.36 pct)   23778.87 (-38.89 pct)
> 
> - SPECjbb2015 Mutli-JVM
> 
> 	       max-jOPS	     critical-jOPS
> base:		 0.00%		 0.00%
> smt:            -1.11%		-1.84%
> cpu:             2.86%		-1.35%
> cache:           2.86%		-1.66%
> numa:            1.43%		-1.49%
> system:          0.08%		-0.41%
> 
> 
> I'll go dig deeper into the tbench and netperf regressions. I'm not sure
> why the regression is observed for all the affinity scopes. I'll look
> into IBS profile and see if something obvious pops up. Meanwhile if there
> is any specific data you would like me to collect or benchmark you would
> like me to test, let me know.

Yeah, that's a bit surprising given that in terms of affinity behavior
"numa" should be identical to base. The only meaningful differences that I
can think of is when the work item is assigned to its worker and maybe how
pwq max_active limit is applied. Hmm... can you monitor the number of
kworker kthreads while running the benchmark? No need to do the whole
matrix, just comparing base against numa should be enough.

Thanks.

-- 
tejun
