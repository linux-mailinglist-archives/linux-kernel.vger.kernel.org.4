Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D263BFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiK2MZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiK2MY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:24:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CBD4A041;
        Tue, 29 Nov 2022 04:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669724697; x=1701260697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sgAPAU2YJaG40uPP2ZS1Letyp9PAABP/Vbd40Hx4+eQ=;
  b=pGz/KLPJv1mLdsP/4BGuOHR/7UIiM5eHPjjk454ke4gHjOxaVJZjQaaq
   48tyQ8o7+0W9v3NQNWEoZyYTc04UQwaTmY6F3DrfW/3bzfbny7umNqjdG
   ROU4q7oFy77kA4CbAMpZeNoQFy+3U8H3NrrePStb6JiXH4skhufQmpK2O
   9PEtCXQQFKtFuGEJO+ce6t1ay+QoA3e5kW+qMoKK9FwOH81C4ogzf5RR2
   lquzMH8BzksjP9c7D15E2AXkblc1IY4Wm3JxdLbnUIgFLWAd5umt9xEq8
   IS/i0nMrV5QToVnLdhcvF1X59hPNK0OUhG+5nr1izUJFzD54YkseeUXx+
   g==;
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="189146869"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2022 05:24:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 29 Nov 2022 05:24:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 29 Nov 2022 05:24:50 -0700
Date:   Tue, 29 Nov 2022 12:24:32 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Vlastimil Babka <vbabka@suse.cz>, David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-hardening@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: Re: [PATCH 0/6] slab: Provide full coverage for __alloc_size
 attribute
Message-ID: <Y4X6AHdMZcxvFnDP@wendy>
References: <20221101222520.never.109-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221101222520.never.109-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:33:08PM -0700, Kees Cook wrote:
> Hi,
> 
> This is a series to work around a deficiency in GCC (>=11) and Clang
> (<16) where the __alloc_size attribute does not apply to inlines. :(
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
> 
> This manifests as reduced overflow detection coverage for many allocation
> sites under CONFIG_FORTIFY_SOURCE=y, where the allocation size was
> not actually being propagated to __builtin_dynamic_object_size(). In
> addition to working around the issue, expand use of __alloc_size (and
> __realloc_size) to more places and provide KUnit tests to validate all
> the covered allocator APIs.

Hello Kees!

It would appear that one of the macros you've added here is doing Bad
Things^TM to allmodconfig on RISC-V since the 22nd:

../lib/fortify_kunit.c: In function 'alloc_size_kmalloc_const_test':
../lib/fortify_kunit.c:140:1: error: the frame size of 2384 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
  140 | }                                                                       \
      | ^
../lib/fortify_kunit.c:209:1: note: in expansion of macro 'DEFINE_ALLOC_SIZE_TEST_PAIR'
  209 | DEFINE_ALLOC_SIZE_TEST_PAIR(kmalloc)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

CONFIG_GCC_VERSION=110100
CONFIG_AS_VERSION=23700
CONFIG_LD_VERSION=23700

The report came out of my CI (which I should have passed on sooner) so
I do not have anything other than stderr - I can get you anything else
you'd like/need though if you LMK.

Thanks,
Conor.

> Kees Cook (6):
>   slab: Clean up SLOB vs kmalloc() definition
>   slab: Remove special-casing of const 0 size allocations
>   slab: Provide functional __alloc_size() hints to kmalloc_trace*()
>   string: Add __realloc_size hint to kmemdup()
>   driver core: Add __alloc_size hint to devm allocators
>   kunit/fortify: Validate __alloc_size attribute results
> 
>  include/linux/device.h         |   7 +-
>  include/linux/fortify-string.h |   2 +-
>  include/linux/slab.h           |  36 ++---
>  include/linux/string.h         |   2 +-
>  lib/Makefile                   |   1 +
>  lib/fortify_kunit.c            | 255 +++++++++++++++++++++++++++++++++
>  mm/slab_common.c               |  14 ++
>  7 files changed, 296 insertions(+), 21 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
