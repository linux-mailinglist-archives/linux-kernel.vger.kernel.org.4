Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DB9710E31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbjEYOVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241607AbjEYOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:21:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD0191
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685024466; x=1716560466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YCkWpWKLi5LA0hLoKYmV6Pn63lRC3AnzJmUk0eTfHn4=;
  b=Kk8PXdNbevFZ7tPkt421fyb9Tt7zG/F3a4pw6lIjQQg4+ACO2NzwDv+I
   blYp+tqFXrgEkkYtJu9+q/tBZ7qMuFWybnw9zGM/YdqvtWEQxUi/enkK5
   9EH6Sm9BuuANi+WNSRwhxPf06wwVohELijFVM6RTPXdKfNe08ieZOV4MT
   izx9eEBqitYaEX/7Pr++f9JZEaAXRnefwbO8STV+DkHwfQwZKX+UgIYmW
   cMdk51TTN94pJZKVJnHlz4iDmKKpMDkyYPaptzDpgxrV7Kmf+M8Drjv8c
   ZWO2D8r1yaxU2+DBzH7oooSvq5g/QLB8DLa/QvAzvr01KxpTh+GM3d4d4
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="asc'?scan'208";a="153919948"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 07:21:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 07:20:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 07:20:57 -0700
Date:   Thu, 25 May 2023 15:20:35 +0100
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
Message-ID: <20230525-citric-waged-a2f78d27eb0c@wendy>
References: <CAAhSdy3tKAk1xjinwnSWan0ivdDapcLvSb+hGNynPFZMUsoB9A@mail.gmail.com>
 <fe8d716c-fb4f-1f3f-6c69-de1d8b9fb6af@ghiti.fr>
 <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
 <20230525-guacamole-swimmer-68048a73baac@wendy>
 <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
 <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy>
 <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AIux2bwC0CEBr+0s"
Content-Disposition: inline
In-Reply-To: <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--AIux2bwC0CEBr+0s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 07:29:46PM +0530, Anup Patel wrote:
> On Thu, May 25, 2023 at 7:26=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Thu, May 25, 2023 at 07:13:11PM +0530, Anup Patel wrote:
> > > On Thu, May 25, 2023 at 7:08=E2=80=AFPM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > >
> > > > On Thu, May 25, 2023 at 06:51:28PM +0530, Anup Patel wrote:
> > > >
> > > > > > We should only rely on this node name for known bad versions of=
 opensbi
> > > > > > IMO. Going forward, if something needs to be reserved for firmw=
are, the
> > > > > > firmware should make sure that it is reserved by using the prop=
erty for
> > > > > > that purpose :)
> > > >
> > > > > There is no issue with OpenSBI since it does the right thing by m=
arking
> > > > > memory as reserved in the DT. This real issue is with the kernel =
handling
> > > > > of reserved memory for hibernate.
> > > >
> > > > I don't think we are talking about the same thing here. I meant the
> > > > no-map property which OpenSBI does not set.
> > >
> > > Yes, we are talking about the same thing. It's not just OpenSBI not
> > > setting no-map property in reserved memory node because other
> > > SBI implementations would be doing the same thing (i.e. not setting
> > > no-map property)
> >
> > Other SBI implementations doing the same thing doesn't make it any more
> > correct though, right?
>=20
> Like multiple folks suggested, we need DT binding for distinguishing
> firmware reserved memory from other reserved memory.

And I have agreed with multiple times!

> Until that
> happens we should either mark hibernate support as experimental
> or revert it.

That works for me. How about the below?

-- >8 --
=46rom 1d4381290a1600eff9b29b8ace6be73955d9726c Mon Sep 17 00:00:00 2001
=46rom: Conor Dooley <conor.dooley@microchip.com>
Date: Thu, 25 May 2023 15:09:08 +0100
Subject: [PATCH] RISC-V: mark hibernation as broken

Hibernation support depends on firmware marking its reserved
regions as not mappable by Linux. As things stand, the de-facto SBI
implementation (OpenSBI) does not do this, and other implementations may
not do so either, resulting in kernel panics during hibernation ([1],
[2]).

Disable support for hibernation until such time that an SBI
implementation independent way to communicate what regions are reserved
has been agreed upon.

Reported-by: Song Shuai <suagrfillet@gmail.com>
Link: https://lore.kernel.org/all/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_vhB+vm_1dH=
JxPNi75YDQ_Q@mail.gmail.com/ [1]
Reported-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ITXwaKfA6z8
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 13f058490608..b2495192f35a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -801,7 +801,7 @@ menu "Power management options"
 source "kernel/power/Kconfig"
=20
 config ARCH_HIBERNATION_POSSIBLE
-	def_bool y
+	def_bool n
=20
 config ARCH_HIBERNATION_HEADER
 	def_bool HIBERNATION
--=20
2.39.2


--AIux2bwC0CEBr+0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG9usgAKCRB4tDGHoIJi
0o+bAQC85DODqSEm+RKOlB9eGicWZIkp8ZTsFWp6dFDXuf2vnQEAro2D8OY5ZsL8
p9xN+HrUuCPopNZZedQoTMeZzPSUkwQ=
=Ks3R
-----END PGP SIGNATURE-----

--AIux2bwC0CEBr+0s--
