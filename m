Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A374C19D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGIIz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 04:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjGIIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 04:55:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E4198
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 01:55:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8b64850b0so181195ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688892955; x=1691484955;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYYU7/G2/wkuSwiSmg0hQBzzuEXoRo9K02SqwMbp/OA=;
        b=6trN39Cc6Zukh1HpqlWyVSEJJrQxrFUi/9vFx0x5lEybwTnx5UywG7y4J8P0geGlP1
         gsSH/5dkH2a6Iw8qUQdcX5/MuvJkNkW9e4K32Qt0qMteD6ukjr73Xfgj8hP6IPCkCzT8
         Ka3LJIjSUptC1HJXT6jhvZUOsTOlpvVtNreCprTufjhN4b7KltGtdbfkuD8KLeyqQTpw
         t96DGpX9uYMjKy2fECWpvZzm/XGYINaTlKN7ocow+4vQpALJaW/QRQkhLrWpEwq7GJqY
         fzJ6JH6+bdms0+VFLSpZnjnapPh1swkcGNHEUY769brmF2N5Su+0fAySb1azUVXXc5/J
         pRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688892955; x=1691484955;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYYU7/G2/wkuSwiSmg0hQBzzuEXoRo9K02SqwMbp/OA=;
        b=cfFxB0e2EakDgNhoQus1w/xCGMwvqtlWSGBMoFn2V6i7u58l5mPtNE0YbAkbN283cR
         mA7dtrVg6jmNKYf9ZdL0Zq042S2SSc3vNmnTtkVtHL7e0RJAzDtr7zM1MHHHUnz3u3yp
         7vaNKZOvKkH3gz0j+KaN43qApYF7RbF/yT9I8bppi8w6zSOa06mfKosqSE1TxSbBsA+Y
         jgtuEIchp11NzGXK4AWnTdiENTZNbGpCylEtXS6H6afQpXFt6VzNuvfj4raJo6AZ6qXQ
         ydkC29rEm6qxfFhzLP8sLVV0dNlXb4/fmzzMwO6OeeBkTz9ddnFISlfqz6D5WKOvXZWg
         SCqg==
X-Gm-Message-State: ABy/qLZBiuTJ+LsA4Dc3a/E6L4I9of0AEkKMOffjCuHls00B8mGjVyPO
        KPWlabak8DY18LAUmfR1PzLc6A==
X-Google-Smtp-Source: APBJJlESC8Jkb1OeLbqwghyL9wt8ovu8UD4SBA250/yXEM2soqPIlW9pqS5B2OAZapf3ikHSGYqjNg==
X-Received: by 2002:a17:902:fa05:b0:1b8:b41d:2920 with SMTP id la5-20020a170902fa0500b001b8b41d2920mr220437plb.7.1688892954733;
        Sun, 09 Jul 2023 01:55:54 -0700 (PDT)
Received: from [2620:0:1008:15:8c68:d6c6:eab:4ddf] ([2620:0:1008:15:8c68:d6c6:eab:4ddf])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b001b549fce345sm5972308plc.230.2023.07.09.01.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 01:55:54 -0700 (PDT)
Date:   Sun, 9 Jul 2023 01:55:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Julian Pidancet <julian.pidancet@oracle.com>
cc:     Christoph Lameter <cl@linux.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] mm/slub: disable slab merging in the default
 configuration
In-Reply-To: <17349901-df3a-494e-fa71-2584d92526b5@google.com>
Message-ID: <3bcfa538-4474-09b7-1812-b4260b09256a@google.com>
References: <20230629221910.359711-1-julian.pidancet@oracle.com> <38083ed2-333b-e245-44e4-2f355e4f9249@google.com> <CTSGWINSM18Q.3HQ1DN27GNA1R@imme> <8813897d-4a52-37a0-fe44-a9157716be9b@google.com> <17349901-df3a-494e-fa71-2584d92526b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023, David Rientjes wrote:

> On Mon, 3 Jul 2023, David Rientjes wrote:
> 
> > hackbench
> 
> Running hackbench on Skylake with v6.1.30 (A) and v6.1.30 + your patch 
> (B), for example:
> 
>               LABEL             | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV   |   DIRECTION    
> --------------------------------+-------+------------+------------+------------+------------+-----------+----------------
>   SReclaimable                  |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 11    | 129480.000 | 233208.000 | 189936.364 | 204316.000 | 31465.625 |                
>   (B) <same sha>                | 11    | 139084.000 | 236772.000 | 198931.273 | 213672.000 | 30013.204 |                
>                                 |       | +7.42%     | +1.53%     | +4.74%     | +4.58%     | -4.62%    | <not defined>  
>   SUnreclaim                    |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 11    | 305400.000 | 538744.000 | 422148.000 | 449344.000 | 65005.045 |                
>   (B) <same sha>                | 11    | 305780.000 | 518300.000 | 422219.636 | 450252.000 | 61245.137 |                
>                                 |       | +0.12%     | -3.79%     | +0.02%     | +0.20%     | -5.78%    | <not defined>  
> 
> Amount of reclaimable slab significantly increases which is likely not a 
> problem because, well, it's reclaimable.  But I suspect we'll find other 
> interesting data points with the other suggested benchmarks.
> 
> And benchmark results:
> 
>               LABEL             | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV   |   DIRECTION    
> --------------------------------+-------+------------+------------+------------+------------+-----------+----------------
>   hackbench_process_pipes_234   |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 7     | 1.735      | 1.979      | 1.831      | 1.835      | 0.086291  |                
>   (B) <same sha>                | 7     | 1.687      | 2.023      | 1.886      | 1.911      | 0.10276   |                
>                                 |       | -2.77%     | +2.22%     | +3.00%     | +4.14%     | +19.09%   | <not defined>  
>   hackbench_process_pipes_max   |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 7     | 1.735      | 1.979      | 1.831      | 1.835      | 0.086291  |                
>   (B) <same sha>                | 7     | 1.687      | 2.023      | 1.886      | 1.911      | 0.10276   |                
>                                 |       | -2.77%     | +2.22%     | +3.00%     | +4.14%     | +19.09%   | - is good      
>   hackbench_process_sockets_234 |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 7     | 7.883      | 7.909      | 7.899      | 7.899      | 0.0087808 |                
>   (B) <same sha>                | 7     | 7.872      | 7.961      | 7.907      | 7.904      | 0.028019  |                
>                                 |       | -0.14%     | +0.66%     | +0.10%     | +0.06%     | +219.09%  | <not defined>  
>   hackbench_process_sockets_max |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 7     | 7.883      | 7.909      | 7.899      | 7.899      | 0.0087808 |                
>   (B) <same sha>                | 7     | 7.872      | 7.961      | 7.907      | 7.904      | 0.028019  |                
>                                 |       | -0.14%     | +0.66%     | +0.10%     | +0.06%     | +219.09%  | - is good      
>   hackbench_thread_pipes_234    |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 7     | 2.146      | 2.677      | 2.410      | 2.418      | 0.18143   |                
>   (B) <same sha>                | 7     | 2.016      | 2.514      | 2.268      | 2.241      | 0.17474   |                
>                                 |       | -6.06%     | -6.09%     | -5.88%     | -7.32%     | -3.69%    | <not defined>  
>   hackbench_thread_pipes_max    |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 7     | 2.146      | 2.677      | 2.410      | 2.418      | 0.18143   |               
>   (B) <same sha>                | 7     | 2.016      | 2.514      | 2.268      | 2.241      | 0.17474   |                
>                                 |       | -6.06%     | -6.09%     | -5.88%     | -7.32%     | -3.69%    | - is good      
>   hackbench_thread_sockets_234  |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 7     | 8.025      | 8.127      | 8.084      | 8.085      | 0.029755  |                
>   (B) <same sha>                | 7     | 7.990      | 8.093      | 8.042      | 8.035      | 0.035152  |                
>                                 |       | -0.44%     | -0.42%     | -0.53%     | -0.62%     | +18.14%   | <not defined>  
>   hackbench_thread_sockets_max  |       |            |            |            |            |           |                
>   (A) v6.1.30                   | 7     | 8.025      | 8.127      | 8.084      | 8.085      | 0.029755  |                
>   (B) <same sha>                | 7     | 7.990      | 8.093      | 8.042      | 8.035      | 0.035152  |                
>                                 |       | -0.44%     | -0.42%     | -0.53%     | -0.62%     | +18.14%   | - is good    

My takeaway from running half a dozen benchmarks on Intel is that
performance is more impacted than slab memory usage.  There are slight
regressions in memory usage, but only measurable for SReclaimable which
would be the better form (as opposed to SUnreclaimable).

There are some substantial performance degradations, most notably 
context_switch1_per_thread_ops which regressed ~21%.  I'll need to repeat
that test to confirm it and can also try on cascadelake if it reproduces.

There are some more negligible redis, specjbb, and will-it-scale
regressions which don't look terribly concerning.

I'll try running performance tests on AMD Zen3 and also ARM with
PAGE_SIZE == 4KB and 64KB.

Unixbench memory usage and performance is within +/- 1% for every metric,
so it's not presented here.

Full results for Skylake, removing results where mean is +/- 1% of
baseline:

============================== MEMORY USAGE ==============================

hackbench
              LABEL             | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV   |   DIRECTION    
--------------------------------+-------+------------+------------+------------+------------+-----------+----------------
  SReclaimable                  |       |            |            |            |            |           |                
  (A) v6.1.30                   | 11    | 129480.000 | 233208.000 | 189936.364 | 204316.000 | 31465.625 |                
  (B) v6.1.30 slab_nomerge      | 11    | 139084.000 | 236772.000 | 198931.273 | 213672.000 | 30013.204 |                
                                |       | +7.42%     | +1.53%     | +4.74%     | +4.58%     | -4.62%    | - is good

redis
             LABEL             | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV   |   DIRECTION    
-------------------------------+-------+------------+------------+------------+------------+-----------+----------------
  SReclaimable                 |       |            |            |            |            |           |                
  (A) v6.1.30                  | 298   | 137056.000 | 238664.000 | 226005.477 | 226940.000 | 8109.328  |                
  (B) v6.1.30 slab_nomerge     | 302   | 139664.000 | 242664.000 | 229096.689 | 230098.000 | 8215.134  |                
                               |       | +1.90%     | +1.68%     | +1.37%     | +1.39%     | +1.30%    | - is good 

specjbb2015
               LABEL               | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV  |   DIRECTION    
-----------------------------------+-------+------------+------------+------------+------------+----------+----------------
  SReclaimable                     |       |            |            |            |            |          |                
  (A) v6.1.30                      | 1602  | 118344.000 | 217932.000 | 203559.618 | 205372.000 | 5314.410 |                
  (B) v6.1.30 slab_nomerge         | 1655  | 128000.000 | 222536.000 | 208099.973 | 209396.000 | 4608.582 |                
                                   |       | +8.16%     | +2.11%     | +2.23%     | +1.96%     | -13.28%  | - is good 

============================== PERFORMANCE ==============================

hackbench
              LABEL             | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV   |   DIRECTION    
--------------------------------+-------+------------+------------+------------+------------+-----------+----------------
  hackbench_process_pipes_234   |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 1.735      | 1.979      | 1.831      | 1.835      | 0.086291  |                
  (B) v6.1.30 slab_nomerge      | 7     | 1.687      | 2.023      | 1.886      | 1.911      | 0.10276   |                
                                |       | -2.77%     | +2.22%     | +3.00%     | +4.14%     | +19.09%   | - is good 
  hackbench_thread_pipes_234    |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 2.146      | 2.677      | 2.410      | 2.418      | 0.18143   |                
  (B) v6.1.30 slab_nomerge      | 7     | 2.016      | 2.514      | 2.268      | 2.241      | 0.17474   |                
                                |       | -6.06%     | -6.09%     | -5.88%     | -7.32%     | -3.69%    | - is good

redis
             LABEL             | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV   |   DIRECTION    
-------------------------------+-------+------------+------------+------------+------------+-----------+----------------
  redis_medium_max_INCR        |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 108695.660 | 112637.980 | 110639.626 | 109757.440 | 1668.190  |                
  (B) v6.1.30 slab_nomerge     | 5     | 101853.740 | 106564.370 | 104166.478 | 104942.800 | 1833.377  |                
                               |       | -6.29%     | -5.39%     | -5.85%     | -4.39%     | +9.90%    | + is good      
  redis_medium_max_LPOP        |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 102944.200 | 108471.630 | 105572.750 | 106303.820 | 2016.986  |                
  (B) v6.1.30 slab_nomerge     | 5     | 101471.340 | 104231.810 | 103361.688 | 104090.770 | 1064.277  |                
                               |       | -1.43%     | -3.91%     | -2.09%     | -2.08%     | -47.23%   | + is good      
  redis_medium_max_LPUSH       |       |            |            |            |            |           |                
  (A) v6.1.30                  | 10    | 99255.590  | 108295.430 | 105960.440 | 106338.120 | 2553.802  |                
  (B) v6.1.30 slab_nomerge     | 10    | 100130.160 | 107032.000 | 104335.070 | 105091.705 | 2169.708  |                
                               |       | +0.88%     | -1.17%     | -1.53%     | -1.17%     | -15.04%   | + is good      
  redis_medium_max_LRANGE_100  |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 72427.030  | 73046.020  | 72671.814  | 72626.910  | 202.812   |                
  (B) v6.1.30 slab_nomerge     | 5     | 70811.500  | 72030.540  | 71519.286  | 71761.750  | 450.918   |                
                               |       | -2.23%     | -1.39%     | -1.59%     | -1.19%     | +122.33%  | + is good      
  redis_medium_max_MSET_10     |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 87642.420  | 89798.850  | 89044.390  | 89102.740  | 769.933   |                
  (B) v6.1.30 slab_nomerge     | 5     | 85287.840  | 89758.550  | 87876.598  | 88386.070  | 1641.608  |                
                               |       | -2.69%     | -0.04%     | -1.31%     | -0.80%     | +113.21%  | + is good      
  redis_medium_max_PING_BULK   |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 101729.400 | 108189.980 | 105003.228 | 105307.490 | 2171.756  |                
  (B) v6.1.30 slab_nomerge     | 5     | 100553.050 | 105340.770 | 102561.464 | 101947.190 | 1789.953  |                
                               |       | -1.16%     | -2.63%     | -2.33%     | -3.19%     | -17.58%   | + is good      
  redis_medium_max_PING_INLINE |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 102522.050 | 107503.770 | 105209.902 | 106033.300 | 1981.499  |                
  (B) v6.1.30 slab_nomerge     | 5     | 97541.950  | 107319.170 | 103729.414 | 104854.780 | 3304.256  |                
                               |       | -4.86%     | -0.17%     | -1.41%     | -1.11%     | +66.76%   | + is good      
  redis_medium_max_SET         |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 105663.570 | 112283.850 | 108917.118 | 109469.070 | 2663.234  |                
  (B) v6.1.30 slab_nomerge     | 5     | 103071.540 | 106723.590 | 105128.226 | 106179.660 | 1666.892  |                
                               |       | -2.45%     | -4.95%     | -3.48%     | -3.00%     | -37.41%   | + is good      
  redis_medium_max_SPOP        |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 104079.940 | 107238.610 | 105140.616 | 104964.840 | 1150.370  |                
  (B) v6.1.30 slab_nomerge     | 5     | 102637.790 | 103885.300 | 103343.934 | 103412.620 | 437.159   |                
                               |       | -1.39%     | -3.13%     | -1.71%     | -1.48%     | -62.00%   | + is good      
   redis_small_max_INCR        |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 98814.230  | 114942.530 | 107744.856 | 108813.920 | 6150.540  |                
  (B) v6.1.30 slab_nomerge     | 5     | 99800.400  | 109529.020 | 104451.708 | 104058.270 | 3732.461  |                
                               |       | +1.00%     | -4.71%     | -3.06%     | -4.37%     | -39.31%   | + is good      
  redis_small_max_LPOP         |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 104275.290 | 118764.840 | 108648.192 | 106951.880 | 5208.918  |                
  (B) v6.1.30 slab_nomerge     | 5     | 97560.980  | 115074.800 | 103120.496 | 99800.400  | 6353.203  |                
                               |       | -6.44%     | -3.11%     | -5.09%     | -6.69%     | +21.97%   | + is good      
  redis_small_max_LRANGE_100   |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 67980.970  | 72992.700  | 71589.644  | 72150.070  | 1832.810  |                
  (B) v6.1.30 slab_nomerge     | 5     | 64977.260  | 72046.110  | 70273.716  | 71684.590  | 2680.854  |                
                               |       | -4.42%     | -1.30%     | -1.84%     | -0.65%     | +46.27%   | + is good       
  redis_small_max_MSET_10      |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 90497.730  | 106044.540 | 100756.422 | 102880.660 | 5455.768  |                
  (B) v6.1.30 slab_nomerge     | 5     | 97276.270  | 106951.880 | 102818.856 | 102880.660 | 3293.135  |                
                               |       | +7.49%     | +0.86%     | +2.05%     | +0.00%     | -39.64%   | + is good        
  redis_small_max_PING_INLINE  |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 96153.850  | 108459.870 | 102493.414 | 102459.020 | 4995.757  |                
  (B) v6.1.30 slab_nomerge     | 5     | 84317.030  | 116144.020 | 99995.920  | 98039.220  | 11045.861 |                
                               |       | -12.31%    | +7.08%     | -2.44%     | -4.31%     | +121.10%  | + is good      
  redis_small_max_SADD         |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 106044.540 | 115606.940 | 109804.052 | 110375.270 | 3451.251  |                
  (B) v6.1.30 slab_nomerge     | 5     | 95693.780  | 109769.480 | 102329.518 | 102249.490 | 4602.161  |                
                               |       | -9.76%     | -5.05%     | -6.81%     | -7.36%     | +33.35%   | + is good      
  redis_small_max_SET          |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 91911.760  | 116686.120 | 104509.200 | 102354.150 | 8993.532  |                
  (B) v6.1.30 slab_nomerge     | 5     | 100502.520 | 113636.370 | 108815.700 | 109649.120 | 4750.002  |                
                               |       | +9.35%     | -2.61%     | +4.12%     | +7.13%     | -47.18%   | + is good      
  redis_small_max_SPOP         |       |            |            |            |            |           |                
  (A) v6.1.30                  | 5     | 96899.230  | 108695.650 | 103648.652 | 104931.800 | 3901.567  |                
  (B) v6.1.30 slab_nomerge     | 5     | 93457.940  | 108108.110 | 101680.560 | 101626.020 | 5096.944  |                
                               |       | -3.55%     | -0.54%     | -1.90%     | -3.15%     | +30.64%   | + is good 

specjbb2015
               LABEL               | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV  |   DIRECTION    
-----------------------------------+-------+------------+------------+------------+------------+----------+----------------
  specjbb2015_single_Critical_JOPS |       |            |            |            |            |          |                
  (A) v6.1.30                      | 1     | 46294.000  | 46294.000  | 46294.000  | 46294.000  | 0        |                
  (B) v6.1.30 slab_nomerge         | 1     | 46167.000  | 46167.000  | 46167.000  | 46167.000  | 0        |                
                                   |       | -0.27%     | -0.27%     | -0.27%     | -0.27%     | ---      | + is good      
  specjbb2015_single_Max_JOPS      |       |            |            |            |            |          |                
  (A) v6.1.30                      | 1     | 68842.000  | 68842.000  | 68842.000  | 68842.000  | 0        |                
  (B) v6.1.30 slab_nomerge         | 1     | 67801.000  | 67801.000  | 67801.000  | 67801.000  | 0        |                
                                   |       | -1.51%     | -1.51%     | -1.51%     | -1.51%     | ---      | + is good   
                                   
vm-scalability
                 LABEL                 | COUNT |       MIN       |       MAX       |      MEAN       |     MEDIAN      |    STDDEV     | DIRECTION  
---------------------------------------+-------+-----------------+-----------------+-----------------+-----------------+---------------+------------
  300s_128G_truncate_throughput        |       |                 |                 |                 |                 |               |            
  (A) v6.1.30                          | 15    | 16398714804.000 | 17010339870.000 | 16772025703.867 | 16834675132.000 | 232697088.501 |            
  (B) v6.1.30 slab_nomerge             | 15    | 16704416343.000 | 17271437122.000 | 16948419991.200 | 16821799877.000 | 233146680.475 |            
                                       |       | +1.86%          | +1.53%          | +1.05%          | -0.08%          | +0.19%        | + is good  
  300s_512G_anon_wx_rand_mt_throughput |       |                 |                 |                 |                 |               |            
  (A) v6.1.30                          | 15    | 7198561.000     | 7359712.000     | 7263944.200     | 7259418.000     | 50394.115     |            
  (B) v6.1.30 slab_nomerge             | 15    | 7191842.000     | 7628158.000     | 7390629.000     | 7407204.000     | 171602.612    |            
                                       |       | -0.09%          | +3.65%          | +1.74%          | +2.04%          | +240.52%      | + is good  

will-it-scale
               LABEL               | COUNT |     MIN      |     MAX      |     MEAN     |    MEDIAN    |  STDDEV   |   DIRECTION    
-----------------------------------+-------+--------------+--------------+--------------+--------------+-----------+----------------
  context_switch1_per_thread_ops   |       |              |              |              |              |           |                
  (A) v6.1.30                      | 1     | 324721.000   | 324721.000   | 324721.000   | 324721.000   | 0         |                
  (B) v6.1.30 slab_nomerge         | 1     | 255999.000   | 255999.000   | 255999.000   | 255999.000   | 0         |                
    !! REGRESSED !!                |       | -21.16%      | -21.16%      | -21.16%      | -21.16%      | ---       | + is good      
  getppid1_scalability             |       |              |              |              |              |           |                
  (A) v6.1.30                      | 1     | 0.71943      | 0.71943      | 0.71943      | 0.71943      | 0         |                
  (B) v6.1.30 slab_nomerge         | 1     | 0.70923      | 0.70923      | 0.70923      | 0.70923      | 0         |                
                                   |       | -1.42%       | -1.42%       | -1.42%       | -1.42%       | ---       | + is good      
  mmap1_scalability                |       |              |              |              |              |           |                
  (A) v6.1.30                      | 1     | 0.18831      | 0.18831      | 0.18831      | 0.18831      | 0         |                
  (B) v6.1.30 slab_nomerge         | 1     | 0.18413      | 0.18413      | 0.18413      | 0.18413      | 0         |                
                                   |       | -2.22%       | -2.22%       | -2.22%       | -2.22%       | ---       | + is good      
  poll2_scalability                |       |              |              |              |              |           |                
  (A) v6.1.30                      | 1     | 0.45608      | 0.45608      | 0.45608      | 0.45608      | 0         |                
  (B) v6.1.30 slab_nomerge         | 1     | 0.44207      | 0.44207      | 0.44207      | 0.44207      | 0         |                
                                   |       | -3.07%       | -3.07%       | -3.07%       | -3.07%       | ---       | + is good      
  pthread_mutex1_scalability       |       |              |              |              |              |           |                
  (A) v6.1.30                      | 1     | 0.45207      | 0.45207      | 0.45207      | 0.45207      | 0         |                
  (B) v6.1.30 slab_nomerge         | 1     | 0.44194      | 0.44194      | 0.44194      | 0.44194      | 0         |                
                                   |       | -2.24%       | -2.24%       | -2.24%       | -2.24%       | ---       | + is good      
  pthread_mutex2_per_process_ops   |       |              |              |              |              |           |                
  (A) v6.1.30                      | 1     | 36292960.000 | 36292960.000 | 36292960.000 | 36292960.000 | 0         |                
  (B) <v6.1.30 slab_nomerge        | 1     | 35446930.000 | 35446930.000 | 35446930.000 | 35446930.000 | 0         |                
                                   |       | -2.33%       | -2.33%       | -2.33%       | -2.33%       | ---       | + is good      
  signal1_scalability              |       |              |              |              |              |           |                
  (A) v6.1.30                      | 1     | 0.55541      | 0.55541      | 0.55541      | 0.55541      | 0         |                
  (B) v6.1.30 slab_nomerge         | 1     | 0.54773      | 0.54773      | 0.54773      | 0.54773      | 0         |                
                                   |       | -1.38%       | -1.38%       | -1.38%       | -1.38%       | ---       | + is good      
  unix1_scalability                |       |              |              |              |              |           |                
  (A) v6.1.30                      | 1     | 0.55085      | 0.55085      | 0.55085      | 0.55085      | 0         |                
  (B) v6.1.30 slab_nomerge         | 1     | 0.53957      | 0.53957      | 0.53957      | 0.53957      | 0         |                
                                   |       | -2.05%       | -2.05%       | -2.05%       | -2.05%       | ---       | + is good   
