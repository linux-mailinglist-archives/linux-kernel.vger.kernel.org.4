Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F84613D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJaSaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJaSaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:30:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3E81261B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:30:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so16687144pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5k2kjKOqFGzBefe+qr3Mti/d55gJgmafgGT79rRaih4=;
        b=aLhbg1SM+r0TJCwZqdXrjOKx+go3Pxe8gLFFimbfOa13DPJTsknJu7n+RauUt6dKMO
         qFq25d8J0EP6eSxDV3DrV7t9/GmLiMUOFcmpmjDK3arA0JY+Y9Waj2i5jGdTjs5/a1ne
         6O1euWSNbi6Sw5RG9cF1gBRwaJpcPBE2jSzAS6qwvJMxA89br7wTHh6lmiPWhvYyw72Z
         VGrgzEfnRno49PJ/w68CTpniF/iEBt2ykBh/WlQdW5szgCt3nbeSBaQmlnSHc2k/qYgn
         THJiPUn4QKeT7/LYLNgNHdfEHfjByZ6TRAsPvfpuCXlBbNiDdcsPU/bBIx/Y+vcjK02j
         pi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k2kjKOqFGzBefe+qr3Mti/d55gJgmafgGT79rRaih4=;
        b=UVgF1DvJUmn+YS4aXbvOJ3UIWVWgNzkNwyjLy2isDdtC2ixM8wqa1HR98++mGZpVII
         ds43wdcp9znU6kBjaldPh0W7OgIZaljlaTd5RZlL9UuNJHGwK9C4H9aB7SkheVypmRoK
         ZA3B0+ZrNC0baduF6Z7pMZAKs0h6F0/1MIWA8WrOul44mdiJa9ukIKOSJYNSLL8gzsTg
         FJu9r4ZYHvPHnKcgdUoOlLRef0f2SRIgqE1kCKV13vf+2SrZCnF9Cfq6Rz+6RVuDF//i
         cBRtvieu2VoxolbEvsS4siLS9Dm/hr5us0C4CcokwXqv2oy39A/geJbMDNL1YU+J9TI2
         FhwQ==
X-Gm-Message-State: ACrzQf2/iFEFLqgNnMBttRRFWA77G6f9o4Wd7EUG3Sn4I51dmRRr7HQ1
        3Dg8AZuRbriNXD5fpItWloM0M0UCRX+fKFF6+Jw6tw==
X-Google-Smtp-Source: AMsMyM4K2fFgyIy0JkUBXL8VCWQd/QWs7sP3V2nyHYeDbuPas57cKZcI9jh+b9f8MwIvPtuw0pKYIUrtdbeuY/DueJ0=
X-Received: by 2002:a17:902:b218:b0:184:710c:8c52 with SMTP id
 t24-20020a170902b21800b00184710c8c52mr15596285plr.95.1667241006751; Mon, 31
 Oct 2022 11:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221006141442.2475978-1-me@inclyc.cn> <20221029122552.2855941-1-me@inclyc.cn>
In-Reply-To: <20221029122552.2855941-1-me@inclyc.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Oct 2022 11:29:54 -0700
Message-ID: <CAKwvOdkyJycxTUR8rUoLCspat+qMdVC9zrw0odcQyxzG8qFUag@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
To:     YingChi Long <me@inclyc.cn>
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, david.laight@aculab.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Oct 29, 2022 at 5:27 AM YingChi Long <me@inclyc.cn> wrote:
>
> WG14 N2350 made very clear that it is an UB having type definitions with
> in "offsetof". This patch change the implementation of macro
> "TYPE_ALIGN" to builtin "_Alignof" to avoid undefined behavior.
>
> I've grepped all source files to find any type definitions within
> "offsetof".
>
>     offsetof\(struct .*\{ .*,
>
> This implementation of macro "TYPE_ALIGN" seemes to be the only case of
> type definitions within offsetof in the kernel codebase.
>
> I've made a clang patch that rejects any definitions within
> __builtin_offsetof (usually #defined with "offsetof"), and tested
> compiling with this patch, there are no error if this patch applied.
>
> ISO C11 _Alignof is subtly different from the GNU C extension
> __alignof__. __alignof__ is the preferred alignment and _Alignof the
> minimal alignment. For 'long long' on x86 these are 8 and 4
> respectively.
>
> The macro TYPE_ALIGN we're replacing has behavior that matches
> _Alignof rather than __alignof__.
>
> Signed-off-by: YingChi Long <me@inclyc.cn>
> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
> Link: https://godbolt.org/z/sPs1GEhbT
> Link: https://gcc.gnu.org/onlinedocs/gcc/Alignment.html
> Link: https://reviews.llvm.org/D133574

YingChi,
You may retain my reviewed by tag when resending a rebased patch that
hasn't changed significantly.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

That reminds me, I need to resend one of my own patches; the x86
maintainers must be very busy.

> ---
> v3:
> - commit message changes suggested by Nick and David
>
> v2: https://lore.kernel.org/all/20220927153338.4177854-1-me@inclyc.cn/
> Signed-off-by: YingChi Long <me@inclyc.cn>
> ---
>  arch/x86/kernel/fpu/init.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index 8946f89761cc..851eb13edc01 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -133,9 +133,6 @@ static void __init fpu__init_system_generic(void)
>         fpu__init_system_mxcsr();
>  }
>
> -/* Get alignment of the TYPE. */
> -#define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
> -
>  /*
>   * Enforce that 'MEMBER' is the last field of 'TYPE'.
>   *
> @@ -143,8 +140,8 @@ static void __init fpu__init_system_generic(void)
>   * because that's how C aligns structs.
>   */
>  #define CHECK_MEMBER_AT_END_OF(TYPE, MEMBER) \
> -       BUILD_BUG_ON(sizeof(TYPE) != ALIGN(offsetofend(TYPE, MEMBER), \
> -                                          TYPE_ALIGN(TYPE)))
> +       BUILD_BUG_ON(sizeof(TYPE) !=         \
> +                    ALIGN(offsetofend(TYPE, MEMBER), _Alignof(TYPE)))
>
>  /*
>   * We append the 'struct fpu' to the task_struct:
> --
> 2.37.4
>


-- 
Thanks,
~Nick Desaulniers
