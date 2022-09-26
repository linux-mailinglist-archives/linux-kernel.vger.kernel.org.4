Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5145EB0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiIZTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiIZTCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:02:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F2991DAA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:02:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 78so7358815pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nTHwQqOEzO9J0EyXdleudhWZo5RUR0fx/qLlJ3mG2fc=;
        b=T0NiENDiz5yeBAX3HvINK5aGNVhUb4dN95NalospMQCICBmGtNzWnsIoiQX/KpOVoD
         05oR9RUjZgl3budHhxhTmpdjYVFuCTMKnuNMh8I+dG5rkkGgLm741xfIGbIjXiu9sTTf
         Nxp3asGHMyvXsN/qkfRDjzoGUEFvMrlLV5eg5vnEH9pcHVNhQ9r/Hqajc5voF9KoDWmp
         NfJPna77AtdSLNzG+eDIPiGQNAH7nAOmJjaTVRoRlpGh2ZWAtMYCI5orEdTNv7X+RVmc
         rbdd36g752IDfxLKVRTR49U0Y/5fIt3OgwmZRjuSyLjMvlCMMS/6nyR+GrrEcYQ0cQxA
         9GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nTHwQqOEzO9J0EyXdleudhWZo5RUR0fx/qLlJ3mG2fc=;
        b=qbS2D8rde4FQCSthSftvKRCMJCe7U3ZkMgURGCvfDPWGPzrvGPWGGlu6lF80VK4YZt
         V58ZoBH0wKOitQtRmur8smWUJQAo33jnRpfHMAHf8rYp5z7VnAi/SujzFrnHoXP4R28c
         H9RuOgAL0Ag01qTzKHsaYj9mqDsXRubfuVAc+tOw2EJFRUj2kuUMgeX/CvkSSUoi2lbo
         HT12cSQ/y+BSp1+XecKBINfAycmfrTDfGYenVpFspmQCJceVjJ8bCjH99u9JcIS/Ivcw
         BP30vYOnB+A8ju+R2RpNeTu1PvPPh2C75l1cAH+cySkvq+KQY0mqgVj+lbeXPHjcD/Ev
         D8HA==
X-Gm-Message-State: ACrzQf1odbBFZLik03PC8Rv+ZH5/1KpltQp3mAp1ipYU50r4Sm3bxmp0
        vcFV9PuWZOkKW3s9dFnab1wSFLSfk3Gv0li5HkW8iQ==
X-Google-Smtp-Source: AMsMyM6AnoYO5U4eknxUJEThrT5EyFRFZwlwQvcj8rkUBG7jQa8LYeZ1ON2tH8pAiLPvFslarCPJF1Qf9op3QSsMEAw=
X-Received: by 2002:a05:6a00:4c11:b0:53e:4f07:fce9 with SMTP id
 ea17-20020a056a004c1100b0053e4f07fce9mr25816999pfb.66.1664218947867; Mon, 26
 Sep 2022 12:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220925153151.2467884-1-me@inclyc.cn> <YzFqXbVptttrzoDe@hirez.programming.kicks-ass.net>
 <0ed40d5b-a404-f424-c9c4-2adf1bf9750b@inclyc.cn>
In-Reply-To: <0ed40d5b-a404-f424-c9c4-2adf1bf9750b@inclyc.cn>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 12:02:15 -0700
Message-ID: <CAKwvOdm-0hdqqA3iBz8nB3Ppo-HUixeH8etrSGajgjXnTB3-8g@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: use __alignof__ to avoid UB in TYPE_ALIGN
To:     YingChi Long <me@inclyc.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
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

+Jiri

Hi YingChi,
Thank you very much for the patch and your consideration when
implementing this check in clang.

It looks like you sent a few different versions of this patch; please
use `-v2`, `-v3`, etc. when invoking `git format-patch` to include the
patch version in the subject line.

On Mon, Sep 26, 2022 at 6:19 AM YingChi Long <me@inclyc.cn> wrote:
>
> Seems GCC __alignof__ is not evaluated to the minimum alignment of some
> TYPE,
> and depends on fields of the struct.
>
>  > Notably I think 'long long' has 4 byte alignment on i386 and some other
>  > 32bit archs.
>
> C11 _Alignof matches in the case (see godbolt link below). How about
> switch to
> _Alignof?
>
>
> Link: https://godbolt.org/z/T749MfM9o
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=10360
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52023
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69560

I think you should additionally include the following 2 link tags:

Link: https://reviews.llvm.org/D133574
Link: https://gcc.gnu.org/onlinedocs/gcc/Alignment.html

While Peter is right that there is a subtle distinction between GNU
__alignof__ and ISO C11 _Alignof, reading
commit 25ec02f2c144 ("x86/fpu: Properly align size in
CHECK_MEMBER_AT_END_OF() macro")
wasn't the intent of 25ec02f2c144 to account for alignment of members
within structs? Hence shouldn't we be using __alignof__ and not
_Alignof? (If I've understood all those GCC bug report comments
correctly; will reread them again after lunch).

$ ARCH=i386 make LLVM=1 -j$(nproc) defconfig all
$ ARCH=i386 make -j$(nproc) defconfig all
$ make LLVM=1 -j$(nproc) defconfig all
$ make -j$(nproc) defconfig all

will all build either way (with __alignof__ vs _Alignof).  The comment
in fpu__init_task_struct_size() in arch/x86/kernel/fpu/init.c alludes
to struct fpu being dynamically sized; perhaps on certain kernel
configs which would be needed to tease out potential build failures.

Also, commit messages on other versions state:

>> _alignof__() will in fact return the 'sane' result

Please use more descriptive language rather than 'sane.' That
statement tells readers nothing about the distinctions between
__alignof__ and _Alignof.

Finally, I wonder if it's possible to use static_assert (defined in
include/linux/build_bug.h) here rather than BUILD_BUG_ON?

>
> On 2022/9/26 17:01, Peter Zijlstra wrote:
> > On Sun, Sep 25, 2022 at 11:31:50PM +0800, YingChi Long wrote:
> >> WG14 N2350 made very clear that it is an UB having type definitions with
> >> in "offsetof". This patch change the implementation of macro
> >> "TYPE_ALIGN" to builtin "__alignof__" to avoid undefined behavior.
> >>
> >> I've grepped all source files to find any type definitions within
> >> "offsetof".
> >>
> >>      offsetof\(struct .*\{ .*,
> >>
> >> This implementation of macro "TYPE_ALIGN" seemes to be the only case of
> >> type definitions within offsetof in the kernel codebase.
> >>
> >> Signed-off-by: YingChi Long <me@inclyc.cn>
> >> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2350.htm
> >> ---
> >>   arch/x86/kernel/fpu/init.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> >> index 621f4b6cac4a..41425ba0b6b1 100644
> >> --- a/arch/x86/kernel/fpu/init.c
> >> +++ b/arch/x86/kernel/fpu/init.c
> >> @@ -134,7 +134,7 @@ static void __init fpu__init_system_generic(void)
> >>   }
> >>
> >>   /* Get alignment of the TYPE. */
> >> -#define TYPE_ALIGN(TYPE) offsetof(struct { char x; TYPE test; }, test)
> >> +#define TYPE_ALIGN(TYPE) __alignof__(TYPE)
> > IIRC there's a problem with alignof() in that it will return the ABI
> > alignment instead of that preferred or natural alignment for some types.
> >
> > Notably I think 'long long' has 4 byte alignment on i386 and some other
> > 32bit archs.
> >
> > That said; please just replace the *one* instance of TYPE_ALIGN entirely
> > and get rid of the thing.
> >



-- 
Thanks,
~Nick Desaulniers
