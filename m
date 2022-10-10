Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE205FA7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJJWfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJJWfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:35:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55A20BD7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:35:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so14277400pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o8aTfFEdi4IrDQkpWvZMcPZJzWibt89JJ0h0XlHUCWQ=;
        b=e1lyQBoAqNJtZtI3DVv8gdh9ihwwUAdS13M6PXLEg/2F1jkItICxGtUlAKTlCEOuuR
         qZ5osgVF3EM2tPdRk29tU2OjxCx86DTJtfUH20XCsVtr7bzYnvIHq2wu1stnDcE0x4KG
         2YEhQJ+QLy5wBicLAa4Iq/9Hb4ivru5f6GrIQXorOcrivamkEWHFujqFVs7EBGALGyxt
         2Dau4Y7iR4az5D6nfyWWoF0Fmxtc9bOKiwZvd6zrmiOK3StmHqBdkJyltZ9vr6c9xKFi
         cT6EUcRAkJ0jIgVlm0spsLfRzc/iF+v2zo8hxOwTk/VWGFuRb6R2W4tyI9acF15iw+v0
         XwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8aTfFEdi4IrDQkpWvZMcPZJzWibt89JJ0h0XlHUCWQ=;
        b=wr09k/2gFbhheGuJR4DxwqqXO5J/7G9KHPmmLghawsvw+bUz8aU5ENE/NSw2HoL8id
         Ly4NZ8xIXQ3+8KxaqKpFdA8GGKyjLBNpmB77pM42xMxfO1ApsMx/xpGUAtgVkozFyZMJ
         aslP+s9nI+nHNThHXoCbnAJuzX3KA6yuU7HOVopvYYjNBYR2Z9/KqZaTzWeDoCWICsdv
         S9E9Gv1NGFcT+6HiLLrP7nq//RNY/usWp/aUjMtGW7qtOFqigvAY4ucCrCdX/LxrTSqD
         uVwem5I78qj1A7fe+GrK6Hsqt5hgQOPvUWo1kK2kfMK2p3QFM5wubCp1UCjJU0DL0d2A
         zykw==
X-Gm-Message-State: ACrzQf03cm2dUSdYZS+dem/b5aaDzZlr+hHLuwJUERE4lOXq+Gt4Qea3
        OOZmzdWfBL+xjbdziiTfbfdmH4/F5EI47Ed3TfFgIg==
X-Google-Smtp-Source: AMsMyM5JfYd4wInrcYIE6hgmlF5BlVJQzwLFOGYIhvAxzBl22lj0XZrDwHRpQXWWo1bJWPVS6Ahz7DC+zvhkNqWpwkY=
X-Received: by 2002:a17:90b:1a81:b0:20a:71e5:728d with SMTP id
 ng1-20020a17090b1a8100b0020a71e5728dmr33430424pjb.107.1665441305834; Mon, 10
 Oct 2022 15:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220716001616.4052225-1-ndesaulniers@google.com>
 <CAK8P3a0ky5w82=d2N_iZ2HYujeCDKJJqjT8P25-_+VpsZYWA_A@mail.gmail.com>
 <CAKwvOdnfPeFpkD7zqt0EGk-xC_v_Lxt+2eOciMfbXihYG936Kw@mail.gmail.com> <ddc3156d-5580-4ec1-a218-2cdf5c1e9a48@app.fastmail.com>
In-Reply-To: <ddc3156d-5580-4ec1-a218-2cdf5c1e9a48@app.fastmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Oct 2022 15:34:54 -0700
Message-ID: <CAKwvOdnQ-tWa0oY0CKAwJD5WQDgVBvxDtf6=E3hS8Ytz5J1OKg@mail.gmail.com>
Subject: Re: [PATCH] arm: lib: implement aeabi_uldivmod via div64_u64_rem
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Gary Guo <gary@garyguo.net>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@sifive.com>,
        Philip Reames <listmail@philipreames.com>, jh@jhauser.us
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

On Mon, Oct 10, 2022 at 3:14 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Oct 10, 2022, at 11:23 PM, Nick Desaulniers wrote:
> > On Sat, Jul 16, 2022 at 2:47 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >> On Sat, Jul 16, 2022 at 2:16 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/nwfpe/softfloat.c#n2312
> > Any creative ideas on how to avoid this? Perhaps putting the `aSig -=
> > bSig;` in inline asm? Inserting a `barrier()` or empty asm statement
> > into the loops also seems to work.
>
> I was going to suggest adding a barrier() as well, should have
> read on first ;-)

barrier() forces reloads+spills in the loop.  The output with `-mllvm
-replexitval=never` is optimal (assuming the loop is faster than
__aeabi_uldivmod (which I think is unprovable).
https://godbolt.org/z/7dMabYYcM

As much I hate relying on compiler-internal flags, I think this is optimal:
```
diff --git a/arch/arm/nwfpe/Makefile b/arch/arm/nwfpe/Makefile
index 303400fa2cdf..2aec85ab1e8b 100644
--- a/arch/arm/nwfpe/Makefile
+++ b/arch/arm/nwfpe/Makefile
@@ -11,3 +11,9 @@ nwfpe-y                               += fpa11.o
fpa11_cpdo.o fpa11_cpdt.o \
                                   entry.o

 nwfpe-$(CONFIG_FPE_NWFPE_XP)   += extended_cpdo.o
+
+# Try really hard to avoid generating calls to __aeabi_uldivmod() from
+# float64_rem() due to loop elision.
+ifdef CONFIG_CC_IS_CLANG
+CFLAGS_softfloat.o     += -mllvm -replexitval=never
+endif
```

Part of me is tempted to move float64_rem() to its own file for that
flag, but indvars+loop-utils isn't eliding other loops in that file
(comparing the full disassembly before+after the above diff).

Long term, it might be nice for us to have `--rtlib` recognize
`--rtlib=linux-kernel@version` or something so that we could better
describe the effective compiler runtime to the compiler.  There are
already differences in compiler-rt and libgcc where we could make
better codegen decisions if we were to consider the target rtlib.
These libraries also change over time though...
-- 
Thanks,
~Nick Desaulniers
