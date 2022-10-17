Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27292601DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJQXjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiJQXiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:38:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B307985AA7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:38:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so20874820wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab8e8SMdV/PMxntneBmOuTYsu5dIocv7IIIRxn/jwGU=;
        b=AxOFHsoIKvP7ysD7tzrCFiEpFNFKWLTlRj8jM8+8JPqgP6LM7SbMGw5w2QYLqfHWGq
         txOceHGNtwyPyi2DSDUcIRWmvm5hc4w/3f+gFwaZzRKyVD5lx7D+mcjw023+uujfBNVQ
         uLsRGaBA3svAV6n5xS9slXluhHbhOg8F1Ys1lsrmqw22Pz2cjJVWgeu0yGKiCqpflhhD
         VT9VCm2LouZBuunSikA6NEKj/WwZmLt/4y8zj9Gsty4UDYuMXwK6AOEIvDuvh+s6arl+
         uQHSv0fixWyaT/IQIy4YcEOg7g4QLB1pMyh/XCa11ZHx/S9OVn1d0jjQ0+Ifskuci3fw
         wUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab8e8SMdV/PMxntneBmOuTYsu5dIocv7IIIRxn/jwGU=;
        b=eICovTcjThAa5wDDBMgDiSytKn7XOm0+QsOk7gVdQ7i3E5Y+v0O1/xk5f1h/zhZ/R2
         B2JMJVJMdoh+8DjHz3j/AUBCk2N5p2IPfxUbx6dclAishUS5RNzBsTtgT5VvkHH56M8+
         gMVQUmohilRKnZDeLKfEf0ISvKcTTHuEDxT/mIqhizPcCNv83jd9QEZUNeILiH7X2DnS
         Z596Kb1cJjjnViCIlo1FGI2qqk7scyNf5lpto3HoHiUFo3mz6c5dOF9w09DILC7aRD+a
         nrY/Jjs0lFNWND/l96USmInpIlnprkadiaEK4HwK6Ex1tiSbsLcl2tSZs4W+Fv42w24O
         irBQ==
X-Gm-Message-State: ACrzQf0HX6lfrTHENMwPkDu6E8VTu+kWnCeDUmLpKA9wvz4MRqdoTzbN
        DkzG4rmoDPsJqX2+2lgqrGX8i8uG/sDEj5F4lcxxFg==
X-Google-Smtp-Source: AMsMyM6cDzWa62kol1J9oBTBfz70biRId88baWm1Hx3dZgUJogBdkdCDQVXwT4O1LcvykbnI0RLK2e/sNbGOm2TIx4I=
X-Received: by 2002:a5d:4889:0:b0:22b:214:38dd with SMTP id
 g9-20020a5d4889000000b0022b021438ddmr136371wrq.32.1666049917198; Mon, 17 Oct
 2022 16:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221017222620.715153-1-nhuck@google.com> <Y03fBQPM7h7+cfGK@sol.localdomain>
In-Reply-To: <Y03fBQPM7h7+cfGK@sol.localdomain>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Mon, 17 Oct 2022 16:38:25 -0700
Message-ID: <CAJkfWY5CXFQfSkM=U6u_DdLjDyLDoubqy2FeSZg5k7GBkOTnsQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 4:02 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Oct 17, 2022 at 03:26:20PM -0700, Nathan Huckleberry wrote:
> > The key_powers array is not guaranteed to be 16-byte aligned, so using
> > movaps to operate on key_powers is not allowed.
> >
> > Switch movaps to movups.
> >
> > Fixes: 34f7f6c30112 ("crypto: x86/polyval - Add PCLMULQDQ accelerated implementation of POLYVAL")
> > Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > ---
> >  arch/x86/crypto/polyval-clmulni_asm.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/crypto/polyval-clmulni_asm.S b/arch/x86/crypto/polyval-clmulni_asm.S
> > index a6ebe4e7dd2b..32b98cb53ddf 100644
> > --- a/arch/x86/crypto/polyval-clmulni_asm.S
> > +++ b/arch/x86/crypto/polyval-clmulni_asm.S
> > @@ -234,7 +234,7 @@
> >
> >       movups (MSG), %xmm0
> >       pxor SUM, %xmm0
> > -     movaps (KEY_POWERS), %xmm1
> > +     movups (KEY_POWERS), %xmm1
> >       schoolbook1_noload
> >       dec BLOCKS_LEFT
> >       addq $16, MSG
>
> I thought that crypto_tfm::__crt_ctx is guaranteed to be 16-byte aligned,
> and that the x86 AES code relies on that property.
>
> But now I see that actually the x86 AES code manually aligns the context.
> See aes_ctx() in arch/x86/crypto/aesni-intel_glue.c.
>
> Did you consider doing the same for polyval?

I'll submit a v2 aligning the tfm_ctx. I think that makes more sense
than working on unaligned keys.

Is there a need to do the same changes on arm64? The keys are also
unaligned there.

>
> If you do prefer this way, it would be helpful to leave a comment for
> schoolbook1_iteration that mentions that the unaligned access support of
> vpclmulqdq is being relied on, i.e. pclmulqdq wouldn't work.
>
> - Eric

Thanks,
Huck
