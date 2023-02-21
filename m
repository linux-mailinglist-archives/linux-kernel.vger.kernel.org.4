Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153A269E31E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjBUPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBUPKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:10:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012341C584
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4EC5B80EF6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF7CC433EF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676992249;
        bh=lV97D4c1VEB0wFmmyQoHz+1Trom7MWaJMJymyq/loK8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EC3jEkvqGL7Un7sIfOxPG+dDdim9VCuBEe4uD+Dczf2f1a+fJ21KjVx0hcz2rm3hO
         XfBERL+oNsprZ/5TE1tcLzYa9qcbkE96k0l1JPas4CDTDFjmuKxAwKuhInqnkwSYTz
         ekz2iuiKmkzdeuAjSQRMFrXWU19gh29Tas36WoVZImZ3jtgLAUTCk+GIrS6Hf7Vy3s
         +2bFXxbHDUXcv7cVkpGtPcLJvhUXEbL9fUBPPftI12zp/bG5nDXY0KovEBL9uBdaJk
         jNDwjvJDCv4chZbmK4177SxuUdvzx/EXEI6WtVHDm6hVKHy+NvN0GAvJVY93a24G1e
         H37Th89LiFkvA==
Received: by mail-lf1-f43.google.com with SMTP id m6so6209318lfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:10:49 -0800 (PST)
X-Gm-Message-State: AO0yUKVUAjob6RCKDKZPkCZdyaySuNx+1UClZGct6lghVtWXrRZKYlTY
        0/hq5vR4y3k1vEz3ZhUdFBB+HXtNz51k2dy0pEs=
X-Google-Smtp-Source: AK7set/11edeYtVLCbGGJ0ppOi0X9juj5clw5Rfpz9RWixb9w8NqyIJr6wtgvT55ONqSy4QI1JJ6T3EFLiQE5T3iy/8=
X-Received: by 2002:a05:6512:3d90:b0:4dc:7e56:9839 with SMTP id
 k16-20020a0565123d9000b004dc7e569839mr1746074lfv.5.1676992247383; Tue, 21 Feb
 2023 07:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20230221012740.2929481-1-linyujun809@huawei.com> <Y/SewFthY/rGct7C@FVFF77S0Q05N>
In-Reply-To: <Y/SewFthY/rGct7C@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Feb 2023 16:10:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHyv1_56-CdX-egQTxnJn5ob15=TrfSOGmp+s019EfT2w@mail.gmail.com>
Message-ID: <CAMj1kXHyv1_56-CdX-egQTxnJn5ob15=TrfSOGmp+s019EfT2w@mail.gmail.com>
Subject: Re: [PATCH -next] arm64: Optimize the comparison of unsigned
 expressions to avoid compiling error
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Lin Yujun <linyujun809@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, kristina.martsenko@arm.com,
        james.morse@arm.com, maz@kernel.org, samitolvanen@google.com,
        andreyknvl@gmail.com, masahiroy@kernel.org, joey.gouly@arm.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wanghai38@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 11:37, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Feb 21, 2023 at 09:27:40AM +0800, Lin Yujun wrote:
> > while compile arch/arm64/include/asm/cpufeature.h with
> > -Werror=3Dtype-limits enabled, errors shown as below:
> >
> > ./arch/arm64/include/asm/cpufeature.h: In function 'system_supports_4kb=
_granule':
> > ./arch/arm64/include/asm/cpufeature.h:653:14: error: comparison of unsi=
gned expression >=3D 0 is always true [-Werror=3Dtype-limits]
> >   return (val >=3D ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN) &&
> >               ^~
> > ./arch/arm64/include/asm/cpufeature.h: In function 'system_supports_64k=
b_granule':
> > ./arch/arm64/include/asm/cpufeature.h:666:14: error: comparison of unsi=
gned expression >=3D 0 is always true [-Werror=3Dtype-limits]
> >   return (val >=3D ID_AA64MMFR0_TGRAN64_SUPPORTED_MIN) &&
> >               ^~

The usefulness of this diagnostic is debatable even when the right
hand is a literal '0' but warning about symbolic constants like this
is actively evil.

In general, preprocessor #defined values can depend on Kconfig
settings or other build configuration switches, and this warning
encourages us to remove the expression altogether, which could mean
introducing a bug if the macro may assume values >0 in other
configurations.

Ergo, we must ignore -Wtype-limits until it is fixed, and can at least
distinguish literal 0 constants from ones instantiated by a CPP macro.


>
> When is the `-Werror=3Dtype-limits` flag enabled by the build system?
>
> We have patterns like this all over the kernel, and I don't think this is
> indicative of a real problem, and I don't think that we need to change co=
de to
> make this warning disappear.
>
> > Modify the return judgment statement, use
> > "((val - min) < (val - max - 1))" to confirm that returns
> > true in =E2=80=9Cmin <=3D val <=3D max=E2=80=9D cases, false in other c=
ases.
>
> That expression is far less clear than the existing code, so I do not thi=
nk
> that is a good idea.
>
> > Fixes: 79d82cbcbb3d ("arm64/kexec: Test page size support with new TGRA=
N range values")
>
> What functional error does this fix?
>
> What configuration is broken?
>
> Thanks,
> Mark.
>
> > Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> > ---
> >  arch/arm64/include/asm/cpufeature.h | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/a=
sm/cpufeature.h
> > index 03d1c9d7af82..0a6bda025141 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -54,6 +54,9 @@ enum ftr_type {
> >  #define FTR_VISIBLE_IF_IS_ENABLED(config)            \
> >       (IS_ENABLED(config) ? FTR_VISIBLE : FTR_HIDDEN)
> >
> > +#define IN_RANGE_INCLUSIVE(val, min, max)            \
> > +     (((val) - (min)) < ((val) - (max) - 1))
> > +
> >  struct arm64_ftr_bits {
> >       bool            sign;   /* Value is signed ? */
> >       bool            visible;
> > @@ -693,8 +696,9 @@ static inline bool system_supports_4kb_granule(void=
)
> >       val =3D cpuid_feature_extract_unsigned_field(mmfr0,
> >                                               ID_AA64MMFR0_EL1_TGRAN4_S=
HIFT);
> >
> > -     return (val >=3D ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN) &&
> > -            (val <=3D ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX);
> > +     return IN_RANGE_INCLUSIVE(val,
> > +             ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN,
> > +             ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MAX);
> >  }
> >
> >  static inline bool system_supports_64kb_granule(void)
> > @@ -706,8 +710,9 @@ static inline bool system_supports_64kb_granule(voi=
d)
> >       val =3D cpuid_feature_extract_unsigned_field(mmfr0,
> >                                               ID_AA64MMFR0_EL1_TGRAN64_=
SHIFT);
> >
> > -     return (val >=3D ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN) &&
> > -            (val <=3D ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX);
> > +     return IN_RANGE_INCLUSIVE(val,
> > +             ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MIN,
> > +             ID_AA64MMFR0_EL1_TGRAN64_SUPPORTED_MAX);
> >  }
> >
> >  static inline bool system_supports_16kb_granule(void)
> > @@ -719,8 +724,9 @@ static inline bool system_supports_16kb_granule(voi=
d)
> >       val =3D cpuid_feature_extract_unsigned_field(mmfr0,
> >                                               ID_AA64MMFR0_EL1_TGRAN16_=
SHIFT);
> >
> > -     return (val >=3D ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN) &&
> > -            (val <=3D ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX);
> > +     return IN_RANGE_INCLUSIVE(val,
> > +             ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MIN,
> > +             ID_AA64MMFR0_EL1_TGRAN16_SUPPORTED_MAX);
> >  }
> >
> >  static inline bool system_supports_mixed_endian_el0(void)
> > --
> > 2.34.1
> >
