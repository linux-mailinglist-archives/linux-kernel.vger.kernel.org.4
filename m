Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8745EE6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiI1Ut6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiI1Utu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:49:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C8DE84
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:49:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y136so13568537pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Muz0iZYPBEL4BjLhrH/LWskHKQEsZ1MozpD+q6Dp2Ys=;
        b=Z6ZsnWziaTdbzfdsBmqxxlVloFWWTaG/m8HNXNrbs04EjLlp5GPkv3zsGaL0x+fR2U
         a0vj99rS+jqi+9xktdZtMYu22HAp7b+RAjxI72zP0nHNvP01r6Q5n8vIx+A6NaIOiSn8
         PT3yJM4xFjAeP6tCZTS3IoOESWr/CAb9by+CyaIWWnCcNCIxLVlCVUTXEewqt3ZAz8nh
         jS2O1T7C9Tc7tkxoVH3RKoHoq/GRMe7skP66vnShBM2IqNCY1TP48Nx8JzZOjfQdRT79
         rGHidppoLrZfotRyuLqWJGo4SQ972tqOR9KvE1PPsvH4fZt9LJ5Ny6lOBzGwKSDmiO84
         dBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Muz0iZYPBEL4BjLhrH/LWskHKQEsZ1MozpD+q6Dp2Ys=;
        b=VHMLX93KpjeY4r/ab5FUD5NYs9B5xSesEyV9wf63q1MHjsS/wITPyZJ62Z8kLXYcCi
         tJFuaP8PVesJ7pLOmtaG8EtQTz/IS0hRlM7eIXA8NPa3TbwexAMrCBy03cKGlUU4QTjQ
         zhZ6YyodkkQ7WnlMm7QsauWFjoyhru8eN2u9Ursl0eoG5fulzDOkxuhaYk7L0ii+aP+4
         njN+58Zsnfm/xCVEZ7Mp9StfoX7Lmkb6OfO3Cc5PRhP9Fae6gHgVx41XH9CQ9tgg2/ND
         hTHkyBVYhjJ7EHxcm/3ddQf/767wL5N1Lvp6jh1JMyAKg4zKMBqXizFO88V8GYCZAIqr
         VRfg==
X-Gm-Message-State: ACrzQf0hHIacJq3EbnK+D1ssRKut+NL2CaYtBhuUGtSyfFEecL924DJZ
        NxLmhp6WXip+mL86Dh6BjyrxnSYBirnwzq9+X+1AzQ==
X-Google-Smtp-Source: AMsMyM5uymmBeUqU9NmOZtncCLBk5pP5CwYJAlTjAJL6GBbLAsWiB4Fo0mpAqM2hgWiGoEBDgT8gs2Pu3MkGO+CKFew=
X-Received: by 2002:a62:1ad5:0:b0:540:4830:7df6 with SMTP id
 a204-20020a621ad5000000b0054048307df6mr35612367pfa.37.1664398184344; Wed, 28
 Sep 2022 13:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <202209271333.10AE3E1D@keescook> <20220927210248.3950201-1-ndesaulniers@google.com>
 <a753c608-813a-f880-67ca-f16fe503b152@rasmusvillemoes.dk> <CAKwvOd=C=yhC5-fBVxD18GSWOibPpSJ1G4bfM=X0bw+LpTsfgg@mail.gmail.com>
In-Reply-To: <CAKwvOd=C=yhC5-fBVxD18GSWOibPpSJ1G4bfM=X0bw+LpTsfgg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Sep 2022 13:49:32 -0700
Message-ID: <CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com>
Subject: Re: [PATCH v3] x86, mem: move memmove to out of line assembler
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>
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

On Wed, Sep 28, 2022 at 12:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Sep 28, 2022 at 12:24 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > On 27/09/2022 23.02, Nick Desaulniers wrote:
> >
> > > +     /*
> > > +      * Handle data forward by movs.
> > > +      */
> > > +.p2align 4
> > > +.Lforward_movs:
> > > +     movl    -4(src, n), tmp0
> > > +     leal    -4(dest, n), tmp1
> > > +     shrl    $2, n
> > > +     rep     movsl
> > > +     movl    tmp0, (tmp1)
> > > +     jmp     .Ldone
> >
> > So in the original code, %1 was forced to be %esi and %2 was forced to
> > be %edi and they were initialized by src and dest. But here I fail to
> > see how those registers have been properly set up before the rep movs;
> > your names for those are tmp0 and tmp2. You have just loaded the last
> > word of the source to %edi, and AFAICT %esi aka tmp2 is entirely
> > uninitialized at this point (the only use is in L16_byteswap).
> >
> > I must be missing something. Please enlighten me.
>
> No, you're right.  It looks like rep movsl needs src in %esi and dest
> needs to be in %edi, so I can't reuse the input registers from
> -mregparm=3; a pair of movs is required.  A v4 is required.
>
> Probably should write a test for memcpy where n > magic constant 680.

This unit test hangs with v3 (and passes with my local v4 which I
haven't sent out yet):
```
index 62f8ffcbbaa3..c2e852762846 100644
--- a/lib/memcpy_kunit.c
+++ b/lib/memcpy_kunit.c
@@ -107,6 +107,8 @@ static void memcpy_test(struct kunit *test)
 #undef TEST_OP
 }

+static unsigned char larger_array [2048];
+
 static void memmove_test(struct kunit *test)
 {
 #define TEST_OP "memmove"
@@ -181,6 +183,20 @@ static void memmove_test(struct kunit *test)
        ptr = &overlap.data[2];
        memmove(ptr, overlap.data, 5);
        compare("overlapping write", overlap, overlap_expected);
+
+       /* Verify larger overlapping moves. */
+       larger_array[256] = 0xaa;
+       memmove(larger_array, larger_array + 256, 1024);
+       KUNIT_ASSERT_EQ(test, larger_array[0], 0xaa);
+       KUNIT_ASSERT_EQ(test, larger_array[256], 0x00);
+       KUNIT_ASSERT_NULL(test,
+               memchr(larger_array + 1, 0xaa, ARRAY_SIZE(larger_array) - 1));
```
I'll include the tests in my v4, including another for overlapping
memmove forwards.
-- 
Thanks,
~Nick Desaulniers
