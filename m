Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB6710DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbjEYN4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbjEYN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:56:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0BE189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685022969; x=1716558969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/51Vo0R05mz1U21BlbdotZ1dIf8ZzyWdeNyPt9wnvw=;
  b=LCFG/ecSaCjg4emZSjth13I/Pyi5+iK5pkMl+EskzivJq9Qiwsdfy7NH
   1pQx1K2qWxtxTkq76Nq18+zVWwviv5HYK5XwQFXIQaet/vjpvLbQ48Nii
   oPjgDZOwLLK6y9GBZW+mDxGb1CYqKBqWb/amA3K/lE9bJ6aj1yA54/hy0
   G7IkAHY0DrP+EIBMiL+hR1oi0y59g6kG2cLVFT25cq7pmpaK7hmL1A7Ud
   Bh7H7Nx5d0Kx/tqP8Yicj9YXvWgNibs+/0Re5Iu/xq1QXWzm5AWinWLQ6
   UKM80Z6M0xC7faLo9rQu5iGANwm+qFRIUh55EruAMRkWV2YdSXMeRFtka
   w==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="asc'?scan'208";a="153915101"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 06:56:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 06:56:07 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 06:56:05 -0700
Date:   Thu, 25 May 2023 14:55:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <anup@brainfault.org>
CC:     Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alexandre Ghiti <alex@ghiti.fr>, <robh@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        <jeeheng.sia@starfivetech.com>, <linux-kernel@vger.kernel.org>,
        <palmer@rivosinc.com>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230525-shrapnel-precut-26500fca4a48@wendy>
References: <20230517-preacher-primer-f41020b3376a@wendy>
 <CAHVXubhMLgb54_7zV2yFuGPoMKCkUXwozHbDvghc7kQqNLK-JA@mail.gmail.com>
 <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr>
 <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
 <20230525-guacamole-swimmer-68048a73baac@wendy>
 <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
 <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OFwHiDdDsq9ntBHt"
Content-Disposition: inline
In-Reply-To: <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--OFwHiDdDsq9ntBHt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 07:13:11PM +0530, Anup Patel wrote:
> On Thu, May 25, 2023 at 7:08=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Thu, May 25, 2023 at 06:51:28PM +0530, Anup Patel wrote:
> >
> > > > We should only rely on this node name for known bad versions of ope=
nsbi
> > > > IMO. Going forward, if something needs to be reserved for firmware,=
 the
> > > > firmware should make sure that it is reserved by using the property=
 for
> > > > that purpose :)
> >
> > > There is no issue with OpenSBI since it does the right thing by marki=
ng
> > > memory as reserved in the DT. This real issue is with the kernel hand=
ling
> > > of reserved memory for hibernate.
> >
> > I don't think we are talking about the same thing here. I meant the
> > no-map property which OpenSBI does not set.
>=20
> Yes, we are talking about the same thing. It's not just OpenSBI not
> setting no-map property in reserved memory node because other
> SBI implementations would be doing the same thing (i.e. not setting
> no-map property)

Other SBI implementations doing the same thing doesn't make it any more
correct though, right?

> > > Like Atish mentioned, not just OpenSBI, there will be other entities
> > > (like TSM) or some other M-mode firmware which will also reserve
> > > memory in DT/ACPI so clearly kernel needs a SBI implementation
> > > independent way of handling reserved memory for hibernate.
> >
> > > > > Another option is to use compatible string or label property to i=
ndicate
> > > > > that this memory region is not to be saved/restored during hibern=
ation.
> > > > > This can be documented in RISC-V DT bindings as well as the booti=
ng guide
> > > > > doc that alex was talking about.
> > > >
> > > > Sure, a dt-binding for sbi reserved regions doesn't immediately sou=
nd
> > > > like an awful idea... But we still have to work around the borked
> > > > firmware - be that disabling hibernation or using the mmode_resv no=
de
> > > > when we know that the version of OpenSBI is one of those with the
> > > > problem.
> >
> > Did you skip over this? I was agreeing that defining a common binding f=
or
> > sbi reserved regions was a good idea.

--OFwHiDdDsq9ntBHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG9o3gAKCRB4tDGHoIJi
0gmsAQDEkuoMF0HDEcJQCW9qndjbk4bpKWaSwzgKHMvPTLClDwD/Tx9ATCMUdkIN
Yr7l0UleTYU8XObDH+OTvhupiW7CAAA=
=9IgR
-----END PGP SIGNATURE-----

--OFwHiDdDsq9ntBHt--
