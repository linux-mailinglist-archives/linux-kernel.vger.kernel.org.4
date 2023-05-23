Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19CD70D949
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjEWJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjEWJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:39:34 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D14126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:39:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D2FBD1BF20F;
        Tue, 23 May 2023 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684834772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O5bZk8oOcESNGSdQ5mgZtmpIo26jm2QJWwpx00xpmQ0=;
        b=NjICiWfDtJZRcdn2/x9r+c8u9OU2M62cctVzWqVZbZCcTFhXrgt9sZQi9iG2j5ANjqky4K
        63VbvRv9jyon2JRP/cT0M5YFUcLCsOJcmf+hj2RjVoRzCGsG1GunVxmcvjV3rtsWe1lFDx
        cS8xL7jB72T0NrK4wDIn//WHtC4zOHqjEbG87zQgfuLO94ez69r6hxfNjxPjm62l0pQbdT
        66VbOEC7i9xVeA11cYGS2j6vss+zWd0PU2zl22VD3GbIB6WYQxrlUFDsEAjDN6bb2CVFtW
        hijyF385XRg+9DD06V34v3V0Niqk/nhRRHKAn+gwn8TWJPVUc1yQI3Shsct/qg==
Date:   Tue, 23 May 2023 11:39:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: marvell: ensure timing values are written
Message-ID: <20230523113930.48c631d4@xps-13>
In-Reply-To: <20230523032103.208213-1-chris.packham@alliedtelesis.co.nz>
References: <20230523032103.208213-1-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

chris.packham@alliedtelesis.co.nz wrote on Tue, 23 May 2023 15:21:03
+1200:

> When new timing values are calculated in marvell_nfc_setup_interface()
> ensure that they will be applied in marvell_nfc_select_target() by
> clearing the selected_chip pointer.
>=20
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

I believe this patch deserves Fixes+Cc:stable?

> ---
>=20
> Notes:
>     This at least gets me to a point where I can illustrated the problem
>     reported to me. It appears that despite the chip correctly reporting
>     support for SDR timing modes up to 4 the observed tWC is 20ns. I've n=
ot
>     seen any actual problem running in this state the only complaint is t=
hat
>     the datasheet says the minimum tWC is 25ns.
>    =20
>     If I make a change to my bootloader such that the NAND Clock Frequency
>     Select bit (0xF2440700:0) to 1 before booting the kernel _and_ I remo=
ve
>     the extra factor of 2 from the period_ns calculation I observe tWC of
>     about 60ns. If I don't remove the factor of 2 the NAND interface does=
n't
>     work (can't write BBT).
>=20
>  drivers/mtd/nand/raw/marvell_nand.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
> index afb424579f0b..3b5e4d5d220f 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -2457,6 +2457,12 @@ static int marvell_nfc_setup_interface(struct nand=
_chip *chip, int chipnr,
>  			NDTR1_WAIT_MODE;
>  	}
> =20
> +	/*
> +	 * Reset nfc->selected_chip so the next command will cause the timing
> +	 * registers to be restored in marvell_nfc_select_target().
> +	 */

s/restored/updated/ ?

Restored feels like the content vanished.

> +	nfc->selected_chip =3D NULL;
> +
>  	return 0;
>  }
> =20


Thanks,
Miqu=C3=A8l
