Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0AC747DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjGEHJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjGEHJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:09:36 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94BE72
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:09:34 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688540973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arY/aOqhycKUtUZKFsYeswU3gpzt6jGjmjUY7iJ7cWw=;
        b=NXaZQXW9D8gXPIcIeDy4cxkZz2tXlxYlab3MLyguLJqt4GjErwsnZuh6xPOVco95/DgfbT
        lKNQX+7RgCuoPUJjpU0xDJBGqtSnv64W6gn+UasRrgUx1f/jRU7F06Rh2+bRkNfM270qjj
        IvavsO4jmpvpqPG9DgjHxkb3RBY6U/vZD451ETnzFVPi25gz3Mj7SyBIXkbQBs8IPfeJ/7
        gB6nceBUwaXzItP03TXdDSOUryumTb4ed+URP6RfDJY2zJPdAMKQYkSKybcNj6lvAzJ2ZZ
        8QYYsdJbrGIpvMsPTeY58w0UrVmyzzFgeF7cq/Dxj/c1nxhuRbXvWP9kW6hbtg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 894C9E0008;
        Wed,  5 Jul 2023 07:09:31 +0000 (UTC)
Date:   Wed, 5 Jul 2023 09:09:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v3 3/5] mtd: rawnand: brcmnand: Fix crash during the
 panic_write
Message-ID: <20230705090930.45d8f1f3@xps-13>
In-Reply-To: <287ecf48-9a8b-6cca-2888-37f6c71c4b39@broadcom.com>
References: <20230627193738.19596-1-william.zhang@broadcom.com>
        <20230627193738.19596-4-william.zhang@broadcom.com>
        <20230704172604.6924d2af@xps-13>
        <287ecf48-9a8b-6cca-2888-37f6c71c4b39@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue, 4 Jul 2023 17:40:03 -0700:

> Hi Miquel,
>=20
> On 07/04/2023 08:26 AM, Miquel Raynal wrote:
> > Hi William,
> >=20
> > william.zhang@broadcom.com wrote on Tue, 27 Jun 2023 12:37:36 -0700:
> >  =20
> >> During the panic write path to execute another nand command, if
> >> there is a pending command, we should wait for the command instead of
> >> calling BUG_ON so we don't crash while crashing.
> >>
> >> Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadco=
m STB NAND controller") =20
> >=20
> > The Fixes tag looks wrong.
> >  =20
> The brcmnand_send_cmd function and BUG_ON line were added by this commit =
and the function didn't changed much since then. Not sure why you think it =
is wrong?

Ok, the title of that commit let me think it was moving code rather
than adding it. Alright.

> >> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> >> Reviewed-by: Kursad Oney <kursad.oney@broadcom.com>
> >> Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>
> >> ---
> >>
> >> Changes in v3: None
> >> Changes in v2: None
> >>
> >>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 12 +++++++++++-
> >>   1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/na=
nd/raw/brcmnand/brcmnand.c
> >> index 37c2c7cfa00e..ea03104692bf 100644
> >> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> @@ -1608,7 +1608,17 @@ static void brcmnand_send_cmd(struct brcmnand_h=
ost *host, int cmd) =20
> >>   >>   	dev_dbg(ctrl->dev, "send native cmd %d addr 0x%llx\n", cmd, cm=
d_addr);
> >>   >> -	BUG_ON(ctrl->cmd_pending !=3D 0); =20
> >> +	/*
> >> +	 * If we came here through _panic_write and there is a pending
> >> +	 * command, try to wait for it. If it times out, rather than
> >> +	 * hitting BUG_ON, just return so we don't crash while crashing.
> >> +	 */
> >> +	if (oops_in_progress) {
> >> +		if (ctrl->cmd_pending &&
> >> +			bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0))
> >> +			return;
> >> +	} else
> >> +		BUG_ON(ctrl->cmd_pending !=3D 0);
> >>   	ctrl->cmd_pending =3D cmd; =20
> >>   >>   	ret =3D bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTR=
L_RDY, 0); =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >  =20


Thanks,
Miqu=C3=A8l
