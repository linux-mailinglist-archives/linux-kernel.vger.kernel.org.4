Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70341741546
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjF1Pc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjF1Pc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:27 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CEA2D76
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:32:25 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a1ebb79579so2149965b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687966344; x=1690558344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X03Y75bvNhnTmos1H6AfZQjMtVVY5Cei9R6VsPWcTsM=;
        b=d81dGm7F+VAi2UDjpgMluQFrNaM8KszJeV6usZe+52wn6FUtRqwgVLKT8nbZhwm0kB
         MXyg1RSnjIVtLt3sSeJ/3lQX719N3x/lzl4vbP9HyTEjuwgWlUQHnO51IqK+Dy0o2OQP
         c6WvfeknQC1iG6Xty3vPQr/bLS7p9tp26LH31krfMP77ISbgi6QsfPDgtEIO+t8HCjRM
         1XOSHMuv39ORvDQRKQIMDwOurHskTYsNkm31eEyjvotjOS74zKndLCyI0S/Z+UQPCr/b
         PIwf5NWvaYRPwk7cOCg1MX82JD1KrNqeSpsH9KH7BAs5gjlSktC+5KrNzGYSqWByO8+Y
         j1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966344; x=1690558344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X03Y75bvNhnTmos1H6AfZQjMtVVY5Cei9R6VsPWcTsM=;
        b=L2vw7byYNUjHd0rLnEBaSMdUvs6N0k58E4Wg1srIC7/xo7tE24h4fM0jvReBqAoaZ8
         w+KiM4tzFVPcO44NzI2MoJSIEBlbJKVo8aC8QfDM/vHVgHrGOMM8Y70wOD7hV50ydGfh
         +jQpZKiVHkdf9XpmF85YprkjnlDRINDgIPetY58gKK03s5ETwqA4O2K3CLNfSPFBBQxu
         2KjHX6CN18vPpbkZbml58vyJp0s4BCNVF6HrIMKH30Vk2TzJhb+SgloYRP3XKyubOOMb
         1ZdlCynK+KWQgfscXeMEbWLEws0ghO5HQeDqggPu+VM528vsdRIhfZDIO5EJs8qetQ8Z
         K6Gg==
X-Gm-Message-State: AC+VfDx9i0tIdCx5YuiaGJgJUWIfR5Iger0eOR+OEzLB3olG5qVa4Cja
        WgVoIy+ZNMr3rbqHqPIqKZvp4vYyOPTz8vzOuIU=
X-Google-Smtp-Source: ACHHUZ4nYjtlk2ZCzVIQbPbD6s427lTb7z5wR09D9IAhBEPVkbvW9XtpIdrupQ3ZTBZuDpTK4gLQbMV1S1shLhtn3d0=
X-Received: by 2002:a05:6808:124c:b0:3a1:b941:fb4b with SMTP id
 o12-20020a056808124c00b003a1b941fb4bmr15699110oiv.3.1687966344545; Wed, 28
 Jun 2023 08:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230628020657.957880-1-goldstein.w.n@gmail.com> <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local>
In-Reply-To: <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 28 Jun 2023 10:32:12 -0500
Message-ID: <CAFUsyfKYQk87fxCDj9FpM9xzLwZVRrfUZgyUCF5G+HuC0N2pXg@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        edumazet@google.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 4:12=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> + Linus who's been poking at this yesterday.
>
Linus, if you're planning a patch and want to just integrate the codes
here I'm happy drop this patch

> + lkml. Please always CC lkml when sending patches.

Ah, will do so in the future.
>
> On Tue, Jun 27, 2023 at 09:06:57PM -0500, Noah Goldstein wrote:
> > The special case for odd aligned buffers is unnecessary and mostly
> > just adds overhead. Aligned buffers is the expectations, and even for
> > unaligned buffer, the only case that was helped is if the buffer was
> > 1-byte from word aligned which is ~1/7 of the cases. Overall it seems
> > highly unlikely to be worth to extra branch.
> >
> > It was left in the previous perf improvement patch because I was
> > erroneously comparing the exact output of `csum_partial(...)`, but
> > really we only need `csum_fold(csum_partial(...))` to match so its
> > safe to remove.
> >
> > All csum kunit tests pass.
> >
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> > ---
> >  arch/x86/lib/csum-partial_64.c | 37 ++--------------------------------
> >  1 file changed, 2 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial=
_64.c
> > index cea25ca8b8cf..d06112e98893 100644
> > --- a/arch/x86/lib/csum-partial_64.c
> > +++ b/arch/x86/lib/csum-partial_64.c
> > @@ -11,28 +11,6 @@
> >  #include <asm/checksum.h>
> >  #include <asm/word-at-a-time.h>
> >
> > -static inline unsigned short from32to16(unsigned a)
> > -{
> > -     unsigned short b =3D a >> 16;
> > -     asm("addw %w2,%w0\n\t"
> > -         "adcw $0,%w0\n"
> > -         : "=3Dr" (b)
> > -         : "0" (b), "r" (a));
> > -     return b;
> > -}
> > -
> > -static inline __wsum csum_tail(u64 temp64, int odd)
> > -{
> > -     unsigned int result;
> > -
> > -     result =3D add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> > -     if (unlikely(odd)) {
> > -             result =3D from32to16(result);
> > -             result =3D ((result >> 8) & 0xff) | ((result & 0xff) << 8=
);
> > -     }
> > -     return (__force __wsum)result;
> > -}
> > -
> >  /*
> >   * Do a checksum on an arbitrary memory area.
> >   * Returns a 32bit checksum.
> > @@ -47,17 +25,6 @@ static inline __wsum csum_tail(u64 temp64, int odd)
> >  __wsum csum_partial(const void *buff, int len, __wsum sum)
> >  {
> >       u64 temp64 =3D (__force u64)sum;
> > -     unsigned odd;
> > -
> > -     odd =3D 1 & (unsigned long) buff;
> > -     if (unlikely(odd)) {
> > -             if (unlikely(len =3D=3D 0))
> > -                     return sum;
> > -             temp64 =3D ror32((__force u32)sum, 8);
> > -             temp64 +=3D (*(unsigned char *)buff << 8);
> > -             len--;
> > -             buff++;
> > -     }
> >
> >       /*
> >        * len =3D=3D 40 is the hot case due to IPv6 headers, but annotat=
ing it likely()
> > @@ -73,7 +40,7 @@ __wsum csum_partial(const void *buff, int len, __wsum=
 sum)
> >                   "adcq $0,%[res]"
> >                   : [res] "+r"(temp64)
> >                   : [src] "r"(buff), "m"(*(const char(*)[40])buff));
> > -             return csum_tail(temp64, odd);
> > +             return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff=
);
> >       }
> >       if (unlikely(len >=3D 64)) {
> >               /*
> > @@ -143,7 +110,7 @@ __wsum csum_partial(const void *buff, int len, __ws=
um sum)
> >                   : [res] "+r"(temp64)
> >                   : [trail] "r"(trail));
> >       }
> > -     return csum_tail(temp64, odd);
> > +     return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> >  }
> >  EXPORT_SYMBOL(csum_partial);
> >
> > --
> > 2.34.1
> >
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
