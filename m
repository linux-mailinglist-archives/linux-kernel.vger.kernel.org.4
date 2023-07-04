Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0422747543
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjGDP0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjGDP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:26:10 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8FCBD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:26:08 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688484367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5qqU0Kxcet4KnwRLYAfKVI4AV4hzg5i/RVgRnzmxGo=;
        b=DTuSkRut6d2zmR+QLC356DceKemf8eFqnjdqrLQjyKbT5Y1e+DeqXx0oTqytEN6A8HYcDJ
        bK6nwL9BwtfIK4bayKvc6tFGZJmHH4j/vM4WY9Nb01SPL9SeZ1fqb9bGY8kBwPmnxic1Ij
        wJCItyIbgdBfHhSMxEti1k8WMY58DpmkUR+o2hZwc0weZx7ZPVoAZ6IEM73xRn9Mh2UMPc
        LEhyLh10p5bojoP9RFZsG5M3GFB2Txq1kLQIp62UowGfjnipDGJ6ZVN6f6pG2iMuHgk15a
        rxphBspFw/6E76rN3KxNWYQPpmv9Ry8N2xbkI8APSjdy5bqd5Ww1O8l2s1cNMw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id E673B1BF206;
        Tue,  4 Jul 2023 15:26:05 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:26:04 +0200
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
Message-ID: <20230704172604.6924d2af@xps-13>
In-Reply-To: <20230627193738.19596-4-william.zhang@broadcom.com>
References: <20230627193738.19596-1-william.zhang@broadcom.com>
        <20230627193738.19596-4-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue, 27 Jun 2023 12:37:36 -0700:

> During the panic write path to execute another nand command, if
> there is a pending command, we should wait for the command instead of
> calling BUG_ON so we don't crash while crashing.
>=20
> Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom S=
TB NAND controller")

The Fixes tag looks wrong.

> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Kursad Oney <kursad.oney@broadcom.com>
> Reviewed-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 37c2c7cfa00e..ea03104692bf 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1608,7 +1608,17 @@ static void brcmnand_send_cmd(struct brcmnand_host=
 *host, int cmd)
> =20
>  	dev_dbg(ctrl->dev, "send native cmd %d addr 0x%llx\n", cmd, cmd_addr);
> =20
> -	BUG_ON(ctrl->cmd_pending !=3D 0);
> +	/*
> +	 * If we came here through _panic_write and there is a pending
> +	 * command, try to wait for it. If it times out, rather than
> +	 * hitting BUG_ON, just return so we don't crash while crashing.
> +	 */
> +	if (oops_in_progress) {
> +		if (ctrl->cmd_pending &&
> +			bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0))
> +			return;
> +	} else
> +		BUG_ON(ctrl->cmd_pending !=3D 0);
>  	ctrl->cmd_pending =3D cmd;
> =20
>  	ret =3D bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0);


Thanks,
Miqu=C3=A8l
