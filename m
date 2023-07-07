Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825C474B509
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGGQSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGQSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:18:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11AB1BEE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:18:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so2818576a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688746730; x=1691338730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwphiLKBiEsc7end01Y8mmEBaeTtS1uM+mpDszrjNwU=;
        b=kLJvIcllBwq3yuN7T4W5b/a9y5XRFLkSDvzTLkaIXA5rjr3sDKw+zwZB9eXr3Wo+Rm
         CnegdWjDjTi1vU7Au9bDR1xfGmtpynB4ocTa4raBPAmzXOetWr/X8lWdxQEUZ30Y5cqg
         nssvL/k0HrWueSeLqFJ7k7URhQNdosToSXpYGj3BWNjVkw9VB+HD3G2EyCu8/51Q55Lg
         wfa4k2NL4mxqjsu/BvDlFJ9se/xU3aCf69Iw0DSBAC7Wjhd2me8Tcuq/eOhRa0qXio2u
         bZpQRprslU43SNWWy8AmwP3J/bKbj9CPy0WMnUgwoK2m+Lqm+YuPKzhJ2ejG7pixXfIK
         yF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688746730; x=1691338730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwphiLKBiEsc7end01Y8mmEBaeTtS1uM+mpDszrjNwU=;
        b=FTWFggtlomc7kAKG0KtgaZ7heNfxwkKlJxjA9KQwlhFEHYi+qUS211VRvKOZbGvcT7
         D2ZQE/68HtG69kj6szpUmwhiKkAzipIPm5F20zbw9uyRh9mm5fsbG72uwgraKMcx/x3A
         UadKUG9sXL9r8ZH3jxaTjdQPEbB7/rA2GIVoXShCzhPHeVr6OMX9CCncMwSQDrkJJIyx
         ycAO8Ajrm7B30VxYtLNioTYjPVkGUAnCVqzZv9At+hIRhzMDeyHouGVSXw0dGwOZv8EG
         w1fJ5Y0VIe8ZMBShvtCySP7WqtL3bg/nhqdnkdJysvzHP2T6ZqnElIhX3EjTYfO0Gnxo
         amkQ==
X-Gm-Message-State: ABy/qLYekXhWuxLJ2IN+eYUVYLSr7fi38c0I6OxIvb1Neptoi4JCK13g
        nVNAk5CIROD3nMwKAzvAzzQn2AOcfabpk3j0ZLyKyw==
X-Google-Smtp-Source: APBJJlGNXWN5iR0lxERw28DBQHWKhrGGYB0EGkwrVdX0DNT38+8FUlx2ZocVTPj1M0RsuZ0At5riiFSUnWNrWNAhazs=
X-Received: by 2002:aa7:cf96:0:b0:51d:7fa6:62ca with SMTP id
 z22-20020aa7cf96000000b0051d7fa662camr4182986edx.14.1688746730201; Fri, 07
 Jul 2023 09:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy> <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
 <ZKgLKvBoWKSxzm6r@sunil-laptop> <CAN3iYbOe+i4jVhz0sSQwVQ2PMB7UvaTPyN_sLtZj0uiOD2emDA@mail.gmail.com>
 <20230707-gargle-enjoyable-f9f7f87fc7ea@spud>
In-Reply-To: <20230707-gargle-enjoyable-f9f7f87fc7ea@spud>
From:   =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>
Date:   Sat, 8 Jul 2023 00:18:39 +0800
Message-ID: <CAN3iYbObSC_g=+oN6mxCp_OAzLVcw7nnt_iud1-p_XBdYQ9hjQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     Conor Dooley <conor@kernel.org>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>, cuiyunhui@bytedance.com,
        jrtc27@jrtc27.com, kernel@esmil.dk,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, weidong.wd@bytedance.com,
        Dong Wei <Dong.Wei@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 12:07=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey,
>
> On Fri, Jul 07, 2023 at 11:56:48PM +0800, =E8=91=9B=E5=A3=AB=E5=BB=BA wro=
te:
> > On Fri, Jul 7, 2023 at 8:55=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.=
com> wrote:
> >
> > > On Fri, Jul 07, 2023 at 08:05:48PM +0800, =E8=91=9B=E5=A3=AB=E5=BB=BA=
 wrote:
> > > > Hi Sunil,
> > > >
> > > > From Sunil:
> > > > IMO, if the question is generic like "Is UEFI mandatory for RISC-V?=
",
> > > > the answer will be solid "no" because we can use DT without UEFI. B=
ut if
> > > > you ask whether UEFI is mandatory for ACPI support on RISC-V, then =
the
> > > > answer will be "yes".
> > > > ---- Why UEFI is mandatory for ACPI support on RISC-V?  As we know,=
 on X86,
> > > > ACPI works well without UEFI. Is there any limitation on RISC-V
> > > > architecture?
> > > Yes, the limitation is RISC-V can not use IA-PC BIOS. Please see
> > > section 5.2.5 and 15 in ACPI spec.
> > >
> > > I don't have much to add to Ard's reasons.
> > >
> > > https://lore.kernel.org/linux-riscv/CAMj1kXFZren0Q19DimwQaETCLz64D4bZ=
QC5B2N=3Di3SAWHygkTQ@mail.gmail.com/
> > >
>
> > I don't think that's the limitation on RISC-V. BTW, how does OSPM find =
the
> > RSDP on ARM systems? Does it meet 5.2.5?
> >
> > Here are
> > 1. Purpose: purpose is to provide another option on Firmware Solution; =
Our
> > purpose is NOT to ban UEFI.
> > 2. Both ARM and RISC-V starts from UBOOT solution, and that's close to
> > coreboot, so we would like to enable flexible and rich ecosystem.
> > 3. We don't like to push coreboot and UEFI together, so we don't plan t=
o
> > enable UEFI in coreboot(maybe from Uboot); because that makes the solut=
ion
> > complex.
> > 4. I think we should fix the request and problem, banning or protecting
> > something is NOT the goal of us.
> >
> > I think the solution is for both RISC-V and ARM, and also it works on X=
86
> > if it's done.
> > Let me know what the problem and impact is, please.
>
> If you are going to keep arguing this, please stop sending top-posted
> HTML to the mailing list. It makes it impossible for those not in the CC
> list to follow along.

Thanks Conor, I will follow the rules.

>
>
> Thanks,
> Conor.
