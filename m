Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9355EC3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiI0NOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiI0NNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:13:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A81591D2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:13:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a26so20637927ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xKQUJ8crDSiafngxlHWxH3oZauT5Eq9qaoxq/VTtdws=;
        b=QCzn9+LBEWtv03A3zMGdq2xANA/WgN/QhSTWl3M74FSY91wfGosM7O1ACH+OdpvawE
         u7oFFk3kwcfdA7yhe+NsGeCkvb2djwO5FLIjxmCKMH7rdlM0zQJjvqGQz/IIIJtV0aC5
         TECmKd4yjnBB9BPuma+AmqfHl99lj8jX3hsHL+szmPhbZs8Ovxj32ggBzL1Cao6b3K58
         gPk9skKwAo+hOw+jatMChu1pXB+6TmFRgBXsjzEojgs23mKEFvr6OpDXsPZTaoJka3d2
         bbNUvBeEamzTowLKXCBGcGnIhU4zfjF8LSCrTdb1vDImANmZsa6lTXSgO8AkYOUhft/C
         lc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xKQUJ8crDSiafngxlHWxH3oZauT5Eq9qaoxq/VTtdws=;
        b=R7iJ6KW89ZOUXs4gEDPYUB+60Duv3hK7IVpgGccUa1buWsSDN5t3BznG2guP5mW9yX
         dzBzfYVXiwWULSVBtGAFTh8vDgtuemeKbrJa2qYrBbyNoaXBaVV6hgiO6bG7kkumk2Sn
         vqSJgeiSFCEX8RXf9VcJLUwEaD45mF5tEznhRapESqiTYB6ToOWCxhq4wo9kgEUUp+vG
         9KHA7uKwLAltbP1wJrbnGWkx2xKMVOsFuPaL6e06b9RqCZ1A4bZ4+U6pFQIIZU8lda80
         VsdX33fgJXMKVTAaT3arLd23pzhAYbL6tFBJNSrMwhbP5GB1Z+fgSvfKcquxSemS51AT
         1keA==
X-Gm-Message-State: ACrzQf2nq2CKaEJiK1Qvns9ul5CcjUi+VeXLzsUQ3yHpziZUUVWVRrE6
        HpRYT4YCkVv6yx+N/PduAJsRZw==
X-Google-Smtp-Source: AMsMyM6IazSuWmATHKaG9FWJD3wvDPiaZfgItkify6a5DbB7PexUdLedG0xN1DdrVlMBYfTd77o9QQ==
X-Received: by 2002:a17:906:8473:b0:77b:efa8:50e4 with SMTP id hx19-20020a170906847300b0077befa850e4mr22495363ejc.250.1664284412975;
        Tue, 27 Sep 2022 06:13:32 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:693c:15a1:a531:bb4e])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402065800b004571907240asm1265720edx.36.2022.09.27.06.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:13:32 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:13:25 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm 1/3] kasan: switch kunit tests to console tracepoints
Message-ID: <YzL29buAUPzOa9CG@elver.google.com>
References: <653d43e9a6d9aad2ae148a941dab048cb8e765a8.1664044241.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653d43e9a6d9aad2ae148a941dab048cb8e765a8.1664044241.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 08:31PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Switch KUnit-compatible KASAN tests from using per-task KUnit resources
> to console tracepoints.
> 
> This allows for two things:
> 
> 1. Migrating tests that trigger a KASAN report in the context of a task
>    other than current to KUnit framework.
>    This is implemented in the patches that follow.
> 
> 2. Parsing and matching the contents of KASAN reports.
>    This is not yet implemented.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/Kconfig.kasan     |  2 +-
>  mm/kasan/kasan_test.c | 85 +++++++++++++++++++++++++++++++------------
>  mm/kasan/report.c     | 31 ----------------
>  3 files changed, 63 insertions(+), 55 deletions(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index ca09b1cf8ee9..ba5b27962c34 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -181,7 +181,7 @@ config KASAN_VMALLOC
>  
>  config KASAN_KUNIT_TEST
>  	tristate "KUnit-compatible tests of KASAN bug detection capabilities" if !KUNIT_ALL_TESTS
> -	depends on KASAN && KUNIT
> +	depends on KASAN && KUNIT && TRACEPOINTS
>  	default KUNIT_ALL_TESTS
>  	help
>  	  A KUnit-based KASAN test suite. Triggers different kinds of
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index f25692def781..3a2886f85e69 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -5,8 +5,12 @@
>   * Author: Andrey Ryabinin <a.ryabinin@samsung.com>
>   */
>  
> +#define pr_fmt(fmt) "kasan_test: " fmt
> +
> +#include <kunit/test.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/io.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> @@ -14,21 +18,28 @@
>  #include <linux/module.h>
>  #include <linux/printk.h>
>  #include <linux/random.h>
> +#include <linux/set_memory.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/tracepoint.h>
>  #include <linux/uaccess.h>
> -#include <linux/io.h>
>  #include <linux/vmalloc.h>
> -#include <linux/set_memory.h>
> +#include <trace/events/printk.h>
>  
>  #include <asm/page.h>
>  
> -#include <kunit/test.h>
> -
>  #include "kasan.h"
>  
>  #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
>  
> +static bool multishot;
> +
> +/* Fields set based on lines observed in the console. */
> +static struct {
> +	bool report_found;
> +	bool async_fault;
> +} test_status;
> +
>  /*
>   * Some tests use these global variables to store return values from function
>   * calls that could otherwise be eliminated by the compiler as dead code.
> @@ -36,35 +47,61 @@
>  void *kasan_ptr_result;
>  int kasan_int_result;
>  
> -static struct kunit_resource resource;
> -static struct kunit_kasan_status test_status;

Also remove this struct from kasan.h?
