Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A45768167D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjA3QeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjA3QeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:34:04 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331D35240;
        Mon, 30 Jan 2023 08:34:02 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D06E924000D;
        Mon, 30 Jan 2023 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675096441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgN2oDAm7jnjRYWg9B2QaY9780SaXO7w1csXZxFZCmE=;
        b=EGoqFJy7VLLxtPtG+Wya2mCyjbxp+643c8y5pLlX380I8DJtrdlrDZRrZhOKRM+761zceH
        pqCkFzSy24eJMD7GH4wCInBYfUWPUVL1yRcvkL4HbQ1Hd44JKzxwf5R/siXdsFF3jcKwJr
        4tYTGnjV+gg9/tTvuc7OMeUp+zMjQezXKm6ENaO09tsoRx/s/2jmSN+mR4wR5eUz3Dy/o7
        RDB6qNlo23Uv1bclo2LPgMz6c+Obp2J9ZdC0iysLvvKA7PT2Zysvk0Pb1jQGdICjeEHRIg
        9clXkXZ1tNOnlmSNmaxUBjA9tqDMRaaxT5DmPPiQD8XdJMmAnVsutyYKp4fehQ==
Date:   Mon, 30 Jan 2023 17:33:55 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
Subject: Re: [RESEND PATCH v5 00/10] Add MediaTek MT7986 SPI NAND and ECC
 support
Message-ID: <20230130173355.5e65a1c5@xps-13>
In-Reply-To: <Y9ft8BIzESLQ0TTh@sirena.org.uk>
References: <20230130030656.12127-1-xiangsheng.hou@mediatek.com>
        <20230130171145.2c844d34@xps-13>
        <Y9ft8BIzESLQ0TTh@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiangsheng,

broonie@kernel.org wrote on Mon, 30 Jan 2023 16:18:56 +0000:

> On Mon, Jan 30, 2023 at 05:11:45PM +0100, Miquel Raynal wrote:
> > xiangsheng.hou@mediatek.com wrote on Mon, 30 Jan 2023 11:06:46 +0800: =
=20
>=20
> > > This patch series add MediaTek MT7986 SPI NAND and ECC controller
> > > support, split ECC engine with rawnand controller in bindings and
> > > change to YAML schema. =20
>=20
> > I would like to pick-up patches 3, 7 and 10 and apply them in the mtd
> > tree as they look completely orthogonal with all the other (spi/DT)
> > changes, am I right? =20
>=20
> > Mark, is it okay for you? =20
>=20
> That's fine, assuming there's no dependency issues.  Xiangsheng, it's
> generally best to avoid mixing patches for multiple subsystems into a
> single series when it's not needed since it makes merging things more
> complex.

Well, kernel test robot just reported an issue with a wrong file name,
so let's split the series. I now expect a series with the spi and
relevant changes (for Mark) and another series with the three mtd
patches -fixed, of course- which I'll apply on my side.

Thanks, Miqu=C3=A8l
