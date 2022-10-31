Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7218613410
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiJaKzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJaKzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:55:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74027218B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:55:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z24so16245012ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs8b348OkSvTZqWJZHM3b1AfWz+B6VWXkmO4oUM6MwQ=;
        b=GLQL1XmTK3l1MirtqdQhFQskqagjOJx76LN8rUQJq3GZ4Mkv1D49mfJND9JGc/6WJ9
         L9KjFp0hJNQHI2P0+u/PretVy/enlwJknoyBAFt+pyfT8nHuCe+rrplW1fChhyLSwDvp
         a44TAW8ApFiZHwEPywv7GPSba8s0tlAP97J8tlCGsHyGLb+EoO7gz5ajTKK4iU7sQRx9
         uSqZEKEMHbUDIfApVz4DoxRDtoIe1ekrT3Wexfmqs/PloIaVGp8UAwrcqp2IoiDHFteZ
         qJVF9+n7X9UXmdSWz4xqySyZt0+XLyJOcya1rl/VYPtkT1HmejeJyNyxE4cSLHLrekei
         iulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs8b348OkSvTZqWJZHM3b1AfWz+B6VWXkmO4oUM6MwQ=;
        b=LD5Gt4Ie/a9pFO+w8jLC6fRkY1ETQVeC/23XoDtbhmfgTKGpq7alzU/6c/eg1LWG7k
         Auatp9ervD3SgKHDmBPSqL47tkA51HOhOagEKuplYY6yasW5FmFm4/o0/us5j4goZ8cC
         e68XvQgQXqLtNyaf1e0CeFaUSthLHlHMFG3Z0oQ2Od1rLyUxiaY2zm8MqLlXdky2zrTW
         uw9ucagyBs88nQUuBQBxtnzBzWK/xriMnCsndJJSwUaHkgq7mPfOjWN92mAbhy8bbRUR
         s7ztswdAI3aE1+fDqUbRs3DJkt3Vb3Q100zCc/n7gAeM7b6/eTzT5zWCXiqOEEJl2m7e
         4zwQ==
X-Gm-Message-State: ACrzQf0kCrU61kkjbhLNUlNu1HVOMBcNtxmYvogMxljPfkmTCn+qHzN9
        N7ufCD7KJfCOWtGhCJer69riNA==
X-Google-Smtp-Source: AMsMyM5LkywZEAMftHb2Eca7dcpiTQKMZhT2b3Mw0/Ejx0460lEOmxkSj2AeSl5MitKpJv2S5HizeA==
X-Received: by 2002:a2e:8781:0:b0:26d:e758:ce84 with SMTP id n1-20020a2e8781000000b0026de758ce84mr4895538lji.178.1667213716770;
        Mon, 31 Oct 2022 03:55:16 -0700 (PDT)
Received: from mutt (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id o17-20020ac25e31000000b0049476667228sm1234690lfg.65.2022.10.31.03.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 03:55:16 -0700 (PDT)
Date:   Mon, 31 Oct 2022 11:55:14 +0100
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] mempool: Do not use ksize() for poisoning
Message-ID: <20221031105514.GB69385@mutt>
References: <20221028154823.you.615-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028154823.you.615-kees@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-28 08:53, Kees Cook wrote:
> Nothing appears to be using ksize() within the kmalloc-backed mempools
> except the mempool poisoning logic. Use the actual pool size instead
> of the ksize() to avoid needing any special handling of the memory as
> needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Link: https://lore.kernel.org/lkml/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/
> Cc: David Rientjes <rientjes@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This replaces mempool-use-kmalloc_size_roundup-to-match-ksize-usage.patch
> v4: add review/ack tags, explicitly call out subject change
> v3: https://lore.kernel.org/lkml/20221025233421.you.825-kees@kernel.org/
> v2: https://lore.kernel.org/lkml/20221018090323.never.897-kees@kernel.org/
> v1: https://lore.kernel.org/lkml/20220923202822.2667581-14-keescook@chromium.org/
> ---
>  mm/mempool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hi,

I see the following kernel paninc when I boot an arm64 allmodconfig kernel from todays linux-next tag next-20221031
This is the .config file I built [1], and here is the full log [2].

[   17.445316][    T1] [fffe00001188f9bf] address between user and kernel address ranges
[   17.449021][    T1] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
[   17.453097][    T1] Modules linked in:
[   17.455384][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B T  6.1.0-rc3-next-20221031 #2 1e3e4f9d63a6fa6d1a293981bef64866cf5e5454
[   17.463100][    T1] Hardware name: linux,dummy-virt (DT)
[   17.466247][    T1] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   17.470778][    T1] pc : __poison_element+0x3c/0x80
[   17.473688][    T1] lr : __poison_element+0x38/0x80
[   17.476614][    T1] sp : ffff80000eea7b50
[   17.478996][    T1] x29: ffff80000eea7b50 x28: ffff000008c88468 x27: ffff000008c88450
[   17.483694][    T1] x26: 0000000000000cc0 x25: ffff000008c88448 x24: ffff000008b3cf80
[   17.488338][    T1] x23: ffff000008c8844c x22: ffff000008c88460 x21: ffff000008d52a40
[   17.493032][    T1] x20: ffff000008d52a40 x19: ffff000008b3cf7f x18: 0000000000000000
[   17.497707][    T1] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   17.502413][    T1] x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
[   17.507109][    T1] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   17.511775][    T1] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
[   17.516447][    T1] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   17.521116][    T1] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000ffffffa5
[   17.525782][    T1] Call trace:
[   17.527664][    T1]  __poison_element+0x3c/0x80
[   17.530409][    T1]  poison_element.isra.0+0x50/0x180
[   17.533419][    T1]  mempool_init_node+0x224/0x340
[   17.536298][    T1]  mempool_create+0x78/0x100
[   17.538989][    T1]  dma_bus_init+0x124/0x2a4
[   17.541607][    T1]  do_one_initcall+0x29c/0x680
[   17.544381][    T1]  do_initcalls+0x178/0x240
[   17.547005][    T1]  kernel_init_freeable+0x2e4/0x36c
[   17.550018][    T1]  kernel_init+0x30/0x180
[   17.552534][    T1]  ret_from_fork+0x10/0x20
[   17.555130][    T1] Code: 94057fb5 8b130280 940575a3 12800b40
(38336a80) 
[   17.559124][    T1] ---[ end trace 0000000000000000 ]---
[   17.562259][    T1] Kernel panic - not syncing: Oops: Fatal exception
[   17.566094][    T1] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

When I revert this patch the kernel boots fine.
Any idea what goes wrong?


Cheers,
Anders
[1] https://people.linaro.org/~anders.roxell/next-20221031.config
[2] http://ix.io/4eAH
