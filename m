Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7418D6AC385
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCFOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCFOjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:39:42 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B803E234D3;
        Mon,  6 Mar 2023 06:39:17 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 24CE820010;
        Mon,  6 Mar 2023 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678113535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CihFIQuO8EkmKbOqb/odYY87aF0bfbQPJr+dXyqKWM=;
        b=imwyQChFmKzT+FDHfXvNHpYEw+0cNlqq2MzSIf0Y6kQRaRnympSOGcJyCF6oa+u0s++p1f
        z0TZhBtyQLY3G4mMI2RJcpXyltBnvfqIRMmpCk/QB2jt1ItcexfiduaTzQHjv7dCHyT+Ew
        fg6wrc11NJX8dsfzZ/4AlqToIGTn5U+35lJ8Z4GQAiLBy/OH/HH/EFfE2xQ2XXcxinDmTE
        bi8an4Vs5CU+ULHj85iPNr/Vv9D8pPQwOFl6ugxdO2aOz3EYXuDOAfsmabOrOZimj4LV1b
        ZJq50BHsr/xVg9cHoEb7RR/WgqiM9jwk9lWFotMS6aOIPc22YDwZFiPRPZzArg==
Date:   Mon, 6 Mar 2023 15:38:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>, <richard@nod.at>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <quic_srichara@quicinc.com>, <qpic_varada@quicinc.com>,
        <quic_sjaganat@quicinc.com>
Subject: Re: [PATCH 2/5] mtd: rawnand: qcom: Add initial support for qspi
 nand
Message-ID: <20230306153851.0dcdda27@xps-13>
In-Reply-To: <b70ddb40-a1f1-f967-6b7b-057a39b0bcc2@quicinc.com>
References: <1602307902-16761-1-git-send-email-mdalam@codeaurora.org>
        <1602307902-16761-3-git-send-email-mdalam@codeaurora.org>
        <20201029100751.713e27df@collabora.com>
        <b70ddb40-a1f1-f967-6b7b-057a39b0bcc2@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

quic_mdalam@quicinc.com wrote on Mon, 6 Mar 2023 19:45:58 +0530:

> On 10/29/2020 2:37 PM, Boris Brezillon wrote:
> > Hello,
> >
> > On Sat, 10 Oct 2020 11:01:39 +0530
> > Md Sadre Alam <mdalam@codeaurora.org> wrote:
> > =20
> >> This change will add initial support for qspi (serial nand).
> >>
> >> QPIC Version v.2.0 onwards supports serial nand as well so this
> >> change will initialize all required register to enable qspi (serial
> >> nand).
> >>
> >> This change is supporting very basic functionality of qspi nand flash.
> >>
> >> 1. Reset device (Reset QSPI NAND device).
> >>
> >> 2. Device detection (Read id QSPI NAND device). =20
> > Unfortunately, that's not going to work in the long term. You're
> > basically hacking the raw NAND framework to make SPI NANDs fit. I do
> > understand the rationale behind this decision (re-using the code for
> > ECC and probably other things), but that's not going to work. So I'd
> > recommend doing the following instead:
> >
> > 1/ implement a SPI-mem controller driver
> > 2/ implement an ECC engine driver so the ECC logic can be shared
> >     between the SPI controller and raw NAND controller drivers
> > 3/ convert the raw NAND driver to the exec_op() interface (none of
> >     this hack would have been possible if the driver was using the new
> >     API)
> >
> > Regards,
> >
> > Boris
> > =20
>  =C2=A0=C2=A0 Sorry for late reply, again started working on this feature=
 support.=C2=A0 The QPIC v2 on wards there is serial nand support got added=
 , its not a standard SPI controller
>=20
>  =C2=A0=C2=A0 its QPIC controller having support for serial nand. All SPI=
 related configuration done by QPIC hardware and its not exposed as SPI bus=
 to the external world. Only based on
>=20
>  =C2=A0=C2=A0 QPIC_SPI_CFG =3D 1, serial functionality will get selected.=
 So that no need to implement as SPI-mem controller driver, since its not a=
 SPI controller.
>=20
>  =C2=A0 Please check the below diagram for top view of QPIC controller.

One of the hard things in the Linux kernel is to make devices fit
frameworks. This feature does not fit the raw NAND framework. It does
not follow any of the conventions taken there. It is not gonna be
accepted there. You need to expose spi-mem functionalities, even if the
spi-proper features are not available. I believe your situation still
fits the spi-mem abstraction.

Thanks,
Miqu=C3=A8l
