Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10946815EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjA3QFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjA3QFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:05:33 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1F93D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:05:31 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1DA5B24000D;
        Mon, 30 Jan 2023 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675094730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1R+fAE3Pu9NbZG02p0c3zf0wEpQnvVjmM8iudp0VAMA=;
        b=MncjFSFozf2iV4vprkc87ZkYmgKIo+PLEjMVnSszBpIRt8xCBHPTQR44cEwK26SZL3DAgL
        k5Llmz/G0SQ/uqP1pbymMtH6uschkMtFXZAIKiQn2kov2V4Aa9O2aemYlLWHWeISsNiZwE
        8nN4encaf8u7oZv2ItKryf5Z8xJjF0K1UVeOrG3sxOhxcSooasPb5oYDlHQrKAuj6gAPqG
        alm8CGVuX9O5umoLwHvzM47Z1wNAR7IAkxvELC7p5j2Hcmz5LFCLRVSi1QRzDXKop36s84
        CHPoma+82PGqbx9/4YdFYaE+fbXE6mxxVn2awfMmRjlYN9UY2ZhaNxrCotnWMQ==
Date:   Mon, 30 Jan 2023 17:05:24 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Jianhui Zhao <zhaojh329@gmail.com>
Subject: Re: [PATCH] mtd: spinand: macronix: use scratch buffer for DMA
 operation
Message-ID: <20230130170524.295c27af@xps-13>
In-Reply-To: <Y8i85zM0u4XdM46z@makrotopia.org>
References: <Y8i85zM0u4XdM46z@makrotopia.org>
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

Hi Daniel,

daniel@makrotopia.org wrote on Thu, 19 Jan 2023 03:45:43 +0000:

> The mx35lf1ge4ab_get_eccsr() function uses an SPI DMA operation to
> read the eccsr, hence the buffer should not be on stack. Since commit
> 380583227c0c7f ("spi: spi-mem: Add extra sanity checks on the op param")
> the kernel emmits a warning and blocks such operations.
>=20
> Use the scratch buffer to get eccsr instead of trying to directly read
> into a stack-allocated variable.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Looks like my scripts did not properly sent the "applied" e-mail, so
here it is, I applied this patch to nand/next.

>  drivers/mtd/nand/spi/macronix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macro=
nix.c
> index dce835132a1e2..722a9738ba370 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -83,9 +83,10 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_=
device *spinand,
>  		 * in order to avoid forcing the wear-leveling layer to move
>  		 * data around if it's not necessary.
>  		 */
> -		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
> +		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
>  			return nanddev_get_ecc_conf(nand)->strength;
> =20
> +		eccsr =3D *spinand->scratchbuf;
>  		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
>  			    !eccsr))
>  			return nanddev_get_ecc_conf(nand)->strength;


Thanks,
Miqu=C3=A8l
