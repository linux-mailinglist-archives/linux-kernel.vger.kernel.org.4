Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A0A6CA836
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjC0OuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjC0Ot6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:49:58 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9D107;
        Mon, 27 Mar 2023 07:49:55 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 27BF624000D;
        Mon, 27 Mar 2023 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679928594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YN5cJMJG4IXHnQqhhSstOio0T65vBkkJvcu1CZWpss4=;
        b=ln2omZ5aBM/K8Ucq/aNBLNRbN/LoC0+oJ9gZ+rPTmilgwrLgvCXvUBXXgw2jcTFqcjcbhd
        qEtG3OxnJJnUGkMLYI6Zjy/OaXZ3x60xVx/pz40Cc2nw7mmPU0TJDmWEKF0DQkmyl3CeGw
        rYy4cPWr58gd4jy8QufL5m4v2OYJJUE4SCmtVU90FeDwMSv/FdsS2ZVFTnGo4DI/kYPfCu
        VA+AOc6WOp2dLR55JMBu3m53y19bCL8nlTG3nIzJDG2weenQMkTX6CPK3ieeHKyRTIaejy
        MwRbinfwTGlFaroeZQZu8zhqKIybqNjZCYcVMEG9B/LBIG5m+fYhnoihi8aR7Q==
Date:   Mon, 27 Mar 2023 16:49:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>, <richard@nod.at>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <quic_srichara@quicinc.com>, <qpic_varada@quicinc.com>,
        <quic_sjaganat@quicinc.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] mtd: rawnand: qcom: Add initial support for qspi
 nand
Message-ID: <20230327164949.465750a0@xps-13>
In-Reply-To: <745e6bd6-96a5-ceab-1f0c-31440d34e4c8@quicinc.com>
References: <1602307902-16761-1-git-send-email-mdalam@codeaurora.org>
        <1602307902-16761-3-git-send-email-mdalam@codeaurora.org>
        <20201029100751.713e27df@collabora.com>
        <b70ddb40-a1f1-f967-6b7b-057a39b0bcc2@quicinc.com>
        <20230306153851.0dcdda27@xps-13>
        <745e6bd6-96a5-ceab-1f0c-31440d34e4c8@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

+ Mark

quic_mdalam@quicinc.com wrote on Mon, 27 Mar 2023 19:24:02 +0530:

> On 3/6/2023 8:08 PM, Miquel Raynal wrote:
> > Hello,
> >=20
> > quic_mdalam@quicinc.com wrote on Mon, 6 Mar 2023 19:45:58 +0530:
> >  =20
> >> On 10/29/2020 2:37 PM, Boris Brezillon wrote: =20
> >>> Hello,
> >>>
> >>> On Sat, 10 Oct 2020 11:01:39 +0530
> >>> Md Sadre Alam <mdalam@codeaurora.org> wrote: =20
> >>>   >>>> This change will add initial support for qspi (serial nand). =
=20
> >>>>
> >>>> QPIC Version v.2.0 onwards supports serial nand as well so this
> >>>> change will initialize all required register to enable qspi (serial
> >>>> nand).
> >>>>
> >>>> This change is supporting very basic functionality of qspi nand flas=
h.
> >>>>
> >>>> 1. Reset device (Reset QSPI NAND device).
> >>>>
> >>>> 2. Device detection (Read id QSPI NAND device). =20
> >>> Unfortunately, that's not going to work in the long term. You're
> >>> basically hacking the raw NAND framework to make SPI NANDs fit. I do
> >>> understand the rationale behind this decision (re-using the code for
> >>> ECC and probably other things), but that's not going to work. So I'd
> >>> recommend doing the following instead:
> >>>
> >>> 1/ implement a SPI-mem controller driver
> >>> 2/ implement an ECC engine driver so the ECC logic can be shared
> >>>      between the SPI controller and raw NAND controller drivers
> >>> 3/ convert the raw NAND driver to the exec_op() interface (none of
> >>>      this hack would have been possible if the driver was using the n=
ew
> >>>      API)
> >>>
> >>> Regards,
> >>>
> >>> Boris =20
> >>>   >>   =C2=A0=C2=A0 Sorry for late reply, again started working on th=
is feature support.=C2=A0 The QPIC v2 on wards there is serial nand support=
 got added , its not a standard SPI controller =20
> >>
> >>   =C2=A0=C2=A0 its QPIC controller having support for serial nand. All=
 SPI related configuration done by QPIC hardware and its not exposed as SPI=
 bus to the external world. Only based on
> >>
> >>   =C2=A0=C2=A0 QPIC_SPI_CFG =3D 1, serial functionality will get selec=
ted. So that no need to implement as SPI-mem controller driver, since its n=
ot a SPI controller.
> >>
> >>   =C2=A0 Please check the below diagram for top view of QPIC controlle=
r. =20
> >=20
> > One of the hard things in the Linux kernel is to make devices fit
> > frameworks. This feature does not fit the raw NAND framework. It does
> > not follow any of the conventions taken there. It is not gonna be
> > accepted there. You need to expose spi-mem functionalities, even if the
> > spi-proper features are not available. I believe your situation still
> > fits the spi-mem abstraction.
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20
>=20
> I have started writing the driver code for SPI NAND. Please check the bel=
ow design,
> is this fine as per Boris suggestion.

Thanks.


>            |------------------------|                      |-------------=
-----------------|                        |--------------------------------=
-|
>            |qcom spi nand driver    |--------------------->|common ECC en=
gine driver      |<-----------------------|qcom raw nand driver            =
 |
>            |                        |                      |             =
                 |                        |                                =
 |
>            |                        |                      |drivers/mtd/n=
and/ecc-qcom.c   |                        |drivers/mtd/nand/raw/qcom_nand.c=
 |
>            |                        |                      |             =
                 |                        |                                =
 |
>            |drivers/spi/spi-qpic.c  |                      |-------------=
-----------------|                        |                                =
 |
>            |                        |                      |common API fi=
le:              |                        |                                =
 |
>            |                        |                      |common API: r=
eset, read id,   |                        |                                =
 |
>            |                        |--------------------->|erase, read p=
age, write page, |<-----------------------|                                =
 |
>            |------------------------|                      |bad block che=
ck etc.          |                        |                                =
 |
>                                                            |             =
                 |                        |--------------------------------=
-|
>                                                            |drivers/mtd/n=
and/raw/qpic_comm|
>                                                            |    on.c     =
                 |
>                                                            |-------------=
-----------------|
>=20
>=20
> Here ECC engine driver as separate file under (drivers/mtd/nand/ecc-qcom.=
c) and all
> common APIs like reset, read id, erase, write page, read page, check bloc=
k bad etc.

I'm not sure how generic these APIs are, please try to not put anything
raw NAND or SPI-NAND specific in the common file. I don't want to see
"if (raw)" or "if (spi)" conditions there.

> as separate file under drivers/mtd/nand/raw/qpic_common.c.APIs under ECC =
engine drivers
> and qpic_common.c will be exported and used by spi-qpic.c driver (Serial =
NAND) and qcom_nand.c
> (raw nand driver).

On my side, I don't have a strong opinion yet but it looks good to me.

Can you confirm you are considering switching to the ->exec_op() API in
the raw NAND driver?

Thanks,
Miqu=C3=A8l
