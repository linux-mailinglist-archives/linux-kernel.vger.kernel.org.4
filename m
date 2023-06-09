Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF047293AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbjFIIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbjFIIu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:50:29 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D836BB9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:50:27 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686300626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyp9wfGBHF8ywDwJ2so3K18RV8Zlylx9c1qCnhYw4jA=;
        b=bJz3CsbRvhGSTkXKPQRp5RHyEPp119tabplJTLwF4m3JaVYJ3rruw7e5SRlCbDMIJhiSkN
        2PasiRxoaw+LTLj4uNWWALLJYgQZjhUFf3Zbhh1ArvXIINmyCfpzg4hr2TDnWNcjBXU0JA
        X8zyYNT3TRpIw+1L1nNXnli8iiUehZVsuOUxo9lyDP3xNni4s2AN2EjL++jwTDw1fh9WXQ
        KCcQuk4Df4GqCCSHh98eu6Bz4cSHP9M6XeMJpbx6PvIcw01sMUfxE5/Tx9QyZb0jNNXQMy
        H+mXtShwoR5GfiF9qGps3mhuOpoB3lo+WTiDAP2GQ6PRHPYkzdgJiVMkfLVT4w==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EC6560009;
        Fri,  9 Jun 2023 08:50:24 +0000 (UTC)
Date:   Fri, 9 Jun 2023 10:50:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v1 3/5] mtd: nand: raw: rockchip-nand-controller: fix
 nand timing default
Message-ID: <20230609105023.5b629705@xps-13>
In-Reply-To: <f8a10a00-c3e4-9749-789d-39fba7944646@gmail.com>
References: <19bf714a-43f9-c30a-8197-91aaaf4a6e5d@gmail.com>
        <f8a10a00-c3e4-9749-789d-39fba7944646@gmail.com>
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

Hi Johan,

jbx6244@gmail.com wrote on Thu, 8 Jun 2023 18:30:40 +0200:

> Somehow not all NAND chips give a valid timing setting with the
> nand_get_sdr_timings() function.

nand_get_sdr_timings() is a core function and is not particularly
clever. All chips are supposed to support SDR mode 0 so if you chip
does not advertises that the chip is broken, not the controller. This
must be fixed in the chip manufacturer driver, not in the controller
driver.

> Don't consider it as an error,
> but fall back to the default value in order to continue to use
> the driver.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/mtd/nand/raw/rockchip-nand-controller.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mt=
d/nand/raw/rockchip-nand-controller.c
> index f56430f6c..e39431cfa 100644
> --- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> @@ -429,8 +429,10 @@ static int rk_nfc_setup_interface(struct nand_chip *=
chip, int target,
>  		return 0;
>=20
>  	timings =3D nand_get_sdr_timings(conf);
> -	if (IS_ERR(timings))
> -		return -EOPNOTSUPP;
> +	if (IS_ERR(timings)) {
> +		rknand->timing =3D 0x1081;

This is way to magical anyway :)

> +		return 0;
> +	}
>=20
>  	if (IS_ERR(nfc->nfc_clk))
>  		rate =3D clk_get_rate(nfc->ahb_clk);
> --
> 2.30.2
>=20


Thanks,
Miqu=C3=A8l
