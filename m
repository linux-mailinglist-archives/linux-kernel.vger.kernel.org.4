Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70569619F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKDSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:07:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9672AE26
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:07:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y13so5170886pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qg78ANf/M2jEd3KO/CDqW7vrKt5orr3ONjK7IQbi6F0=;
        b=UdfwPZjWfNlUJ2FfHGNt3Xf451L2UPrtmjSLgGoyBsuky91bOzKSZhsVAnU9Z9eJyO
         AD5RjWqPfcsEY/ygC57ONT1aNwxa4cA8PnCrdyQQkjN79qNhQMd7jnOdM7LUSL7TJ9qT
         6CW0UGAScq8feTw5SfaaXSmYTNgt7BIdcMF0uLj1kGFsmkVzdEsLrYGf3IT3JiCJh1mV
         6EoPri61DuCkda1kUSvxNUF8XfrVFk4waVhZOiPeWMRARREMktu2oe++JJczU56AffG7
         3g4Qb/JaLeHkbMdBmfTDrTArreBmsZjYAkJ6LHgmueX7diyKqR77ahmiNu8H4/sl8DY9
         AYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qg78ANf/M2jEd3KO/CDqW7vrKt5orr3ONjK7IQbi6F0=;
        b=tSnIxEmuciYJnh6Zdj1FLmF1amsarKyKiHjOL+WQ0YMb3zr4we1E+roay7rkN55HGL
         y9zCzs9pErTr6/oqNwveXdgeyIZW8aGHf55a1k3/r2Px07YqlSH/RupWERjFYOde1MgE
         sW2eMZ5HrY8qjIz7A2FmoW9VQ6t35tpm0C8sf6a6o1i3FDwtgL89Cwzkblv2EaIEgtFi
         INlkLSZ6dbVCX2ei9uOC1QMieahmB1W6Ti6rwQW417Jz+ZtlKrQlkOkp4RXHgybXdFyn
         8B1S1wBeVSOByu+z/LBCn4AVYuPNucpkSxMWdom7PcTb+7nZJXnyq1ZQJHV+kRgSqoH6
         QcEg==
X-Gm-Message-State: ACrzQf3/cYMql9mJlbbjT3rs9rG0yyk1uq7xgAYWvTZN/xXdIwfVAqv3
        C6kwrkHHYuVOrypXOOwn0pQpdKekF/tnHMKjxS6uCQ==
X-Google-Smtp-Source: AMsMyM5PwJ1ZBcYSgFHLKu87CEEV1wah9U9YGFQ3+my8JFfs8yDRx6QkMpj1gRLcPLxD0GIU26MUYd360ifmqqv7Hsc=
X-Received: by 2002:a62:820a:0:b0:56d:2b5f:20dd with SMTP id
 w10-20020a62820a000000b0056d2b5f20ddmr34264216pfd.66.1667585244330; Fri, 04
 Nov 2022 11:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221103210748.1343090-1-ndesaulniers@google.com> <94597E96-D4FB-4312-8F8B-473AAC0503F7@zytor.com>
In-Reply-To: <94597E96-D4FB-4312-8F8B-473AAC0503F7@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Nov 2022 11:07:12 -0700
Message-ID: <CAKwvOdmFTvpdFi08CMbxcnqHEcCTOtgkMWDx6Zyewxnb_pjo_g@mail.gmail.com>
Subject: Re: [PATCH] x86/msr-index: make SPEC_CTRL_IBRS assembler-portable
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Huang Rui <ray.huang@amd.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>
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

On Fri, Nov 4, 2022 at 2:55 AM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On November 3, 2022 2:07:48 PM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >GNU binutils' assembler (GAS) didn't support L suffixes on immediates
> >until binutils 2.28 release. Building arch/x86/entry/entry_64.S with GAS
> >v2.27 will produce the following assembler errors:
> >
> >  arch/x86/entry/entry_64.S: Assembler messages:
> >  arch/x86/entry/entry_64.S:308: Error: found 'L', expected: ')'
> >  arch/x86/entry/entry_64.S:308: Error: found 'L', expected: ')'
> >  arch/x86/entry/entry_64.S:308: Error: junk `L<<(0)))' after expression
> >  arch/x86/entry/entry_64.S:596: Error: found 'L', expected: ')'
> >  arch/x86/entry/entry_64.S:596: Error: found 'L', expected: ')'
> >  arch/x86/entry/entry_64.S:596: Error: junk `L<<(0)))' after expression
> >
> >These come from the use of the preprocessor defined SPEC_CTRL_IBRS in
> >the IBRS_ENTER and IBRS_EXIT assembler macros. SPEC_CTRL_IBRS was using
> >the BIT macros from include/linux/bits.h which are only portable between
> >C and assembler for assemblers such as GAS v2.28 (or newer) or clang
> >because they use the L suffixes for immediate operands, which older GAS
> >releases cannot parse. The kernel still supports GAS v2.23 and newer
> >(and older for branches of stable). Let's expand the value of
> >SPEC_CTRL_IBRS in place so that assemblers don't have issues parsing the
> >value.
> >
> >Fixes: 2dbb887e875b ("x86/entry: Add kernel IBRS implementation")
> >Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >---
> >Some other ideas considered:
> >* Use U64_C from include/asm-generic/int-ll64.h rather than BIT for the
> >  value of SPEC_CTRL_IBRS.
> >  * Do so for the entirety of arch/x86/include/asm/msr-index.h or just
> >    SPEC_CTRL_IBRS? include/asm-generic/int-ll64.h doesn't define a UL
> >    suffix; add one?
> >* Make include/linux/bits.h assembler-portable (for older assemblers)
> >  via the use of include/asm-generic/int-ll64.h.
> >
> > arch/x86/include/asm/msr-index.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> >index 10ac52705892..0192d853136c 100644
> >--- a/arch/x86/include/asm/msr-index.h
> >+++ b/arch/x86/include/asm/msr-index.h
> >@@ -46,7 +46,7 @@
> > #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT               BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
> >
> > #define MSR_IA32_SPEC_CTRL            0x00000048 /* Speculation Control */
> >-#define SPEC_CTRL_IBRS                        BIT(0)     /* Indirect Branch Restricted Speculation */
> >+#define SPEC_CTRL_IBRS                        1          /* Indirect Branch Restricted Speculation */
> > #define SPEC_CTRL_STIBP_SHIFT         1          /* Single Thread Indirect Branch Predictor (STIBP) bit */
> > #define SPEC_CTRL_STIBP                       BIT(SPEC_CTRL_STIBP_SHIFT)      /* STIBP mask */
> > #define SPEC_CTRL_SSBD_SHIFT          2          /* Speculative Store Bypass Disable bit */
>
> Let's fix the macro instead.

Ah, I need to do more homework; this issue is specific to stable
backports of the retbleed mitigations.
commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
available in assembly")
fixed this exact problem already.  Ok, I'll work with stable to get
that backported as part of the series.  Sorry for the noise.
-- 
Thanks,
~Nick Desaulniers
