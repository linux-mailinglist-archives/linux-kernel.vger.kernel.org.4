Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38306B1022
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCHRYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCHRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:24:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE294311DD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:24:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so1611778wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678296249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcGUcMsaep9Sz9s+gH/VvnsZCqctQ0iZxaFub1OCSCw=;
        b=ZU6ZJGzD4UDtFCQ35p1nXj3ZLJzS2aFS/dsinOjeKL18alNhvzkowov7XN8ZrG0fhn
         LHXgkERT1igoi9Me9dljwzniTIxl+/CBKCmEFJcPqt3pUipcZpZ9gGjZWG+wMuIRGF56
         8Dct37N74oD7lpJwV8GMn1ZllUh0j6c5WJC3xknA54HEY9OUY/rHzLe8fjdxeFwqyTtQ
         SY9gYgNGm+3X1tJ1062oSpXxlK20GWOd3gM2VxcIUyzgveS5hiTBC5kiTmYb9B4FjSj2
         GknA0+Osyur6B3vT8P0LbAzvabvc0JL+4Gjr7uCCQgzmfiQkotaQoP7F1oG16ywdsERj
         VdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcGUcMsaep9Sz9s+gH/VvnsZCqctQ0iZxaFub1OCSCw=;
        b=ANdd96/zY78QhBZ07nyzzuM+5IlJwYpeTXqJjLzhT8nKhU39Eqd5+tVQuxLY4zLLgi
         yX2gWCiCxhlElTGjgNo1VwjQaKDshXFulvOTZvKSw2dzWn+gL8MCQsMp5aNErNvWwG9J
         QM1spP3oi6i8h2cYpS+O5ZZ9DJmyMZ+L7zaSRdCbgAztco9Skid1q4RbkF6aujk5Hi/a
         CxtWo4/pmfw5k3lpwg2ynqB7EN4hFgItroAjIa2g2VPoENNPe+zhDTwgEOyKYZtsPCDf
         Ds06V1cJ/HK8Q+B48ftsjBY7yS2ssr3LNO1BNx1OZTMgNL4xbMbbDz1UZAjfR6OJo98m
         CXyg==
X-Gm-Message-State: AO0yUKVsG29fupo3Xtj3rsH35T7SgWs2gBHyV3YWzIjgk/nTLplLNh9e
        2tJL8tU1xuD2MAs/3jrKo0iTEkcs8gDy3GzQMPhJrvKkg7/6ew==
X-Google-Smtp-Source: AK7set9gNpVrN7hb/ZmjTIrII5MZaQHJrMpv//MkZZZyAjVSbynWSrzfr0tLOKx/OOwBTgYOySTPrBguhXnAmDJSKj8=
X-Received: by 2002:a05:600c:997:b0:3df:97fd:2221 with SMTP id
 w23-20020a05600c099700b003df97fd2221mr4000756wmp.7.1678296249000; Wed, 08 Mar
 2023 09:24:09 -0800 (PST)
MIME-Version: 1.0
References: <299fbb80-e3ab-3b7c-3491-e85cac107930@intel.com>
In-Reply-To: <299fbb80-e3ab-3b7c-3491-e85cac107930@intel.com>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date:   Wed, 8 Mar 2023 18:24:05 +0100
Message-ID: <CAPAsAGyG2_sUfb7aPSPuMatMraDbPCFKxhv2kSDkrV1XxQ8_bw@mail.gmail.com>
Subject: Re: KASLR vs. KASAN on x86
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 11:35=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> Hi KASAN folks,
>
> Currently, x86 disables (most) KASLR when KASAN is enabled:
>
> > /*
> >  * Apply no randomization if KASLR was disabled at boot or if KASAN
> >  * is enabled. KASAN shadow mappings rely on regions being PGD aligned.
> >  */
> > static inline bool kaslr_memory_enabled(void)
> > {
> >         return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
> > }
>
> I'm a bit confused by this, though.  This code predates 5-level paging
> so a PGD should be assumed to be 512G.  The kernel_randomize_memory()
> granularity seems to be 1 TB, which *is* PGD-aligned.
>
> Are KASAN and kernel_randomize_memory()/KASLR (modules and
> cpu_entry_area randomization is separate) really incompatible?  Does
> anyone have a more thorough explanation than that comment?
>

Yeah, I agree with you here, the comment doesn't make sense to me as well.
However, I see one problem with KASAN and kernel_randomize_memory()
compatibility:
vaddr_start - vaddr_end includes KASAN shadow memory
(Documentation/x86/x86_64/mm.rst):
   ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB |
virtual memory map (vmemmap_base)
   ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused =
hole
   ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN
shadow memory
   fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused =
hole
                    |            |                  |         |
vaddr_end for KASLR

So the vmemmap_base and probably some part of vmalloc could easily end
up in KASAN shadow.

> This isn't a big deal since KASAN is a debugging option after all.  But,
> I'm trying to unravel why this:
>
> >         if (kaslr_enabled()) {
> >                 pr_emerg("Kernel Offset: 0x%lx from 0x%lx (relocation r=
ange: 0x%lx-0x%lx)\n",
> >                          kaslr_offset(),
> >                          __START_KERNEL,
> >                          __START_KERNEL_map,
> >                          MODULES_VADDR-1);
>
> for instance uses kaslr_enabled() which includes just randomizing
> module_load_offset, but *not* __START_KERNEL.  I think this case should
> be using kaslr_memory_enabled() to match up with the check in
> kernel_randomize_memory().  But this really boils down to what the
> difference is between kaslr_memory_enabled() and kaslr_enabled().

This code looks correct to me. __START_KERNEL is just a constant, it's
never randomized.
The location of the kernel image (.text, .data ...) however is
randomized, kaslr_offset() - is the random number here.
So
kaslr_enabled() - randomization of the kernel image and modules.
kaslr_memory_enabled() - randomization of the linear mapping
(__PAGE_OFFSET), vmalloc (VMALLOC_START) and vmemmap (VMEMMAP_START)
