Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587EF6C4FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCVQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCVQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:05:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC2A242
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:05:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a11so8983641lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679501101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQMj+UbSGYt/V4ItEl8Atz++wkEESN6wJSeRvZafcDU=;
        b=fXDTK4UwWJxghhGY844FVJkS0jod018sFRa0JBR2+G/lVjO/CNliTnwbakz6nPokPM
         ctesUpwtgM7AtGOBQBk/KcVJvZPTuY4YB+apo51lhApvb0i6T+YI89tfIMxJFGF/7ux5
         juJINe4wcZSKbe5qz65JOk30xQa36Jqx3MzzCnYaHQ5IYG6+PO2I14y5OIXs5kxDTkdF
         1GQzH/YyUtvAXNacXkMC5rRcgMYiaWgSG03Tag7KIj9qW4H+teBEqY4enNWq8SNghfg1
         9+EuKVWvhD8tt7Fbg3arhOW22QAjiVRVddT5aSc3tb9uQ5pIPLeFLjsMPz+Guw2w8av6
         2zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQMj+UbSGYt/V4ItEl8Atz++wkEESN6wJSeRvZafcDU=;
        b=uhHlFGY4SMUY16QONI/U6wiJUQjRAxFJWyuQPYPsh+Hs7tcvOZY4biDWaFo66GFsHl
         L9h9ugt0EK7SrY1wlily1lcc3HXguYy0681bHJr2m2udQlWqN/LuwX0bMGDOmiE+66MX
         vdVQaJwbDkxrfFdx38BA6O8/65weIExlQYsC3915z1TMzmQn7ywzkg62knnVc5e7Z1Tu
         aZALw9gsUiPN7u4X+0hQCOExxe1qK/oMRcUfqRGicL4GCI/J+MaA/koPI+RshPPBlN5u
         2tnLp0e4y/cV77+OBiRvFYdoZosCiaWFY4X3rqa9N3FrXJINkqPm/cH0Ru3jOzIEYgzg
         GyrQ==
X-Gm-Message-State: AO0yUKWuui23n5nWj6iIUC6RllO/JPxgBeNnNznxheQlIC0MvQVXZbjY
        1J98GEQOmoYocbIlNaiQs9tvt2aADysQFPBnq1lq4g==
X-Google-Smtp-Source: AK7set9V3VY49u6SCjZkRbppQZLZPGl6botYkgoHJVVX0x35uhukV8uSf3SrWFeWx07P5q2ZlbHvjlPYcJhJ919zgfU=
X-Received: by 2002:a2e:7e05:0:b0:299:ac4e:a8a6 with SMTP id
 z5-20020a2e7e05000000b00299ac4ea8a6mr2145466ljc.9.1679501101548; Wed, 22 Mar
 2023 09:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230314183220.513101-1-evan@rivosinc.com> <20230314183220.513101-4-evan@rivosinc.com>
 <8e132bed-c85a-4bfd-bff8-5147db1cec32@spud>
In-Reply-To: <8e132bed-c85a-4bfd-bff8-5147db1cec32@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 22 Mar 2023 09:04:25 -0700
Message-ID: <CALs-HsskLpLg=yEfULXZNOCFeFU3M9j9Kzcj49gPtw+0VGGhzA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, slewis@rivosinc.com,
        heiko@sntech.de, vineetg@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, you and Heiko are on the same wavelength these days. I'll make that ch=
ange.
-Evan

On Wed, Mar 22, 2023 at 8:36=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Mar 14, 2023 at 11:32:17AM -0700, Evan Green wrote:
> > We have an implicit set of base behaviors that userspace depends on,
> > which are mostly defined in various ISA specifications.
> >
> > Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> > @@ -125,6 +126,25 @@ static void hwprobe_one_pair(struct riscv_hwprobe =
*pair,
> >       case RISCV_HWPROBE_KEY_MIMPID:
> >               hwprobe_arch_id(pair, cpus);
> >               break;
> > +     /*
> > +      * The kernel already assumes that the base single-letter ISA
> > +      * extensions are supported on all harts, and only supports the
> > +      * IMA base, so just cheat a bit here and tell that to
> > +      * userspace.
> > +      */
> > +     case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
> > +             pair->value =3D RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
> > +             break;
> > +
> > +     case RISCV_HWPROBE_KEY_IMA_EXT_0:
> > +             pair->value =3D 0;
> > +             if (has_fpu())
> > +                     pair->value |=3D RISCV_HWPROBE_IMA_FD;
> > +
> > +             if (elf_hwcap & RISCV_ISA_EXT_c)
>
> Random thought while reviewing another patch, and I kinda felt a bit
> stupid following the existing code to try and make sure, but should this
> become a call to riscv_isa_extension_available(NULL, c)?
> It may be nice to propagate that helper, if it works, than check the bit
> directly.
>
> Cheers,
> Conor.
>
> > +                     pair->value |=3D RISCV_HWPROBE_IMA_C;
> > +
> > +             break;
> >
> >       /*
> >        * For forward compatibility, unknown keys don't fail the whole
> > --
> > 2.25.1
> >
