Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365E0747532
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGDPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGDPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:21:47 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB8DBD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:21:46 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688484104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K38v2/1tVPSmRbW0dpHienxuBMNg/NRz5CODwmaB/Fo=;
        b=MVT3MhpJYHr9CqEyl6hcRGgdI9qBgna0aFj1cKzA5cANC+BnxMMa8aOd5KM3y89AFnvyyz
        lZY/h8bzbCt8rpLZjUxNrwpb/SMIbLl8QsHHtZ+UAL4m45wJTPo/4buqTfd1iqIUc5AB30
        Z/QaZAugdLGhvjPofrboTWpNTQeWSA25NjEnMId3p2IzfbsVRmQc0+KvsMkACclGR/sj7v
        KPNn1+QdUfJx+sHCfEAn/3YzP1AFZx2uZH3oQq8yn27sAa4hHqd5QfIWlZW1FGj7umL5lh
        NqKvQL2yoJzD6hRc5QoRgoTxezfIHDiPn5U3t7ZdYI8RpLo+NmPEe3cMAWFQFw==
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
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C854D1BF205;
        Tue,  4 Jul 2023 15:21:42 +0000 (UTC)
Date:   Tue, 4 Jul 2023 17:21:41 +0200
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
        Boris Brezillon <bbrezillon@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v3 2/5] mtd: rawnand: brcmnand: Fix potential false time
 out warning
Message-ID: <20230704172141.1369c9e8@xps-13>
In-Reply-To: <20230627193738.19596-3-william.zhang@broadcom.com>
References: <20230627193738.19596-1-william.zhang@broadcom.com>
        <20230627193738.19596-3-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue, 27 Jun 2023 12:37:35 -0700:

> If system is busy during the command status polling function, the driver
> may not get the chance to poll the status register till the end of time
> out and return the premature status.  Do a final check after time out
> happens to ensure reading the correct status.
>=20
> Fixes: 9d2ee0a60b8b ("mtd: nand: brcmnand: Check flash #WP pin status bef=
ore nand erase/program")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Cc: stable here and in patch 1 as well.

> ---
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index 69709419516a..37c2c7cfa00e 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1080,6 +1080,14 @@ static int bcmnand_ctrl_poll_status(struct brcmnan=
d_controller *ctrl,
>  		cpu_relax();
>  	} while (time_after(limit, jiffies));
> =20
> +	/*
> +	 * do a final check after time out in case CPU is busy and driver does
> +	 * not get the enough time to poll to avoid false alarm

Do a final... ...the CPU was busy and the driver did not get enough
time to perform the polling to avoid false alarms.

> +	 */
> +	val =3D brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS);
> +	if ((val & mask) =3D=3D expected_val)
> +		return 0;
> +
>  	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
>  		 expected_val, val & mask);
> =20

Otherwise looks good.

Thanks,
Miqu=C3=A8l
