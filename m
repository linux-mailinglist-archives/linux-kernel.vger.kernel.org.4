Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A247472EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjGDNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGDNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:41:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F2E6D;
        Tue,  4 Jul 2023 06:41:13 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688478072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJLhG5xef0Dm9kVxipRfJ1zAKqJpL9r++IajKk5AkNU=;
        b=pZo+4NrPp2dycBIRoGMvUMInSYsTFLDpojazcKafyNd55aRmC80dmZ1TZdYaeVs3mfgjBE
        z6ngQq4XpQ7bf5wQ2kp6Wzt7xDHanylnonV7EkM+d+LnLuDobkEPsoLkh+3gpPDbbgwy29
        vbjXtpOZPjanZTztmEfCWazX4Lgpl+QXBjT/gdKdhQcq1+x+DdcRUuscmFGFmhgGn/2V6H
        vCyMqXZ2ZVDsIKLbSwQGOD2dMUUzCWV/hB7/CdX44FztFNvbk5M+8U0Zr2R6dumBq+AmIY
        9VbRtRlJnIx8NOokmg9NJjeqGgYG+rmqreo7wsMxVxuXqXZIPGyqvZVsvtM/fQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F5DEC000B;
        Tue,  4 Jul 2023 13:41:08 +0000 (UTC)
Date:   Tue, 4 Jul 2023 15:41:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/2] mtd: rawnand: meson: support for 512B ECC
 step size
Message-ID: <20230704154106.5c5aafd8@xps-13>
In-Reply-To: <ee2eb73a-fb25-58ae-cf7e-83d971b7b8b2@sberdevices.ru>
References: <20230628092937.538683-1-AVKrasnov@sberdevices.ru>
        <20230628092937.538683-3-AVKrasnov@sberdevices.ru>
        <20230704103617.4affae8a@xps-13>
        <9e6eaa87-887c-f955-113a-43860c8ea00c@sberdevices.ru>
        <20230704114110.25ca9de4@xps-13>
        <aede4639-0e99-565a-c997-c414342c66af@sberdevices.ru>
        <20230704115628.55320428@xps-13>
        <ee2eb73a-fb25-58ae-cf7e-83d971b7b8b2@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

> >>>> Yes, this code looks strange. 'nsectors' is used to calculate space =
in OOB
> >>>> that could be used by ECC engine (this value will be passed as 'ooba=
vail'
> >>>> to 'nand_ecc_choose_conf()'). Idea of 512 is to consider "worst" case
> >>>> for ECC, e.g. minimal number of bytes for ECC engine (and at the sam=
e time
> >>>> maximum number of free bytes). For Meson, if ECC step size is 512, t=
hen we
> >>>> have 4 x 2 free bytes in OOB (if step size if 1024 then we have 2 x =
2 free
> >>>> bytes in OOB).
> >>>>
> >>>> I think this code could be reworked in the following way:
> >>>>
> >>>> if ECC step size is already known here (from DTS), calculate 'nsecto=
rs' using
> >>>> given value (div by 512 for example). Otherwise calculate 'nsectors'=
 in the
> >>>> current manner:   =20
> >>>
> >>> It will always be known when these function are run. There is no
> >>> guessing here.   =20
> >>
> >> Hm I checked, that but if step size is not set in DTS, here it will be=
 0,=20
> >> then it will be selected in 'nand_ecc_choose_conf()' according provide=
d 'ecc_caps'
> >> and 'oobavail'...
> >>
> >> Anyway, I'll do the following thing:
> >>
> >> int nsectors;
> >>
> >> if (nand->ecc.size)
> >>     nsectors =3D mtd->writesize / nand->ecc.size; <--- this is for 512=
 ECC =20
> >=20
> > You should set nand->ecc.size in ->attach_chip() instead. =20
>=20
> Sorry, didn't get it... if ECC step size is set in DTS, then here, in chi=
p attach
> callback it will be already known (DT part was processed in 'rawnand_dt_i=
nit()').
> If ECC step size is unknown (e.g. 0 here), 'nand_ecc_choose_conf()' will =
set it
> according provided ecc caps. What do You mean for "You should set ..." ?

The current approach is wrong, it decides the number of ECC chunks
(called nsectors in the driver) and then asks the core to decide the
number of ECC chunks to use.

Just provide mtd->oobsize - 2 as last parameter and then rely on the
core's logic to find the right ECC step-size/strength?

There is no point in requesting a particular step size without a
specific strength, or? So I believe you should provide both in the DTS
if you want particular parameters to be applied, otherwise you can let
the core decide what is best.

Thanks,
Miqu=C3=A8l
