Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A370C297
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjEVPiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjEVPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:38:18 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E8CD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:38:17 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B94BC40005;
        Mon, 22 May 2023 15:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684769896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fobMpz8BL8MtzooPlML6W2zGP3RefL4jTmJUBQtPwS0=;
        b=ZaUeAfs7Wf2Cky73Ot2eCqOz0xclyiC70to6Qtse05PvYKAClitVRBnW8NgxQ3t30snZw7
        uH3MG4pd1LiMTddhHXvZLRHyN0I+xinwFPvkUKtLycsvKNZu5Z8qqQnsg9oFBOpa4APeIl
        SQYpoqwFdSSI6327uqqnTj88C/cyUNxpRFzGp2a1dSsbxhh6X3XjdudUxMLfzLUl5IrDWJ
        zMJelwFXFRHIqiEECa9auOyEwoG+Z+tVUYTMFIg277g/w4zvr0fSNZ37ZN0wk4FxtGa+4O
        7+melQk7RSLDW1pR4D3L7/jm7PxtaQ4DojMUodTBtD/B2vYX/KoGv6bFIfws0g==
Date:   Mon, 22 May 2023 17:38:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] mtd: rawnand: meson: always read whole OOB bytes
Message-ID: <20230522173813.08afe6b8@xps-13>
In-Reply-To: <20230515094440.3552094-4-AVKrasnov@sberdevices.ru>
References: <20230515094440.3552094-1-AVKrasnov@sberdevices.ru>
        <20230515094440.3552094-4-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Mon, 15 May 2023 12:44:37 +0300:

> This changes size of read access to OOB area by reading all bytes of
> OOB (free bytes + ECC engine bytes).

This is normally up to the user (user in your case =3D=3D jffs2). The
controller driver should expose a number of user accessible bytes and
then when users want the OOB area, they should access it entirely. On
top of that read, they can extract (or "write only") the user bytes.

> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 8526a6b87720..a31106c943d7 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -755,6 +755,30 @@ static int __meson_nfc_read_oob(struct nand_chip *na=
nd, int page,
>  	u32 oob_bytes;
>  	u32 page_size;
>  	int ret;
> +	int i;
> +
> +	/* Read ECC codes and user bytes. */
> +	for (i =3D 0; i < nand->ecc.steps; i++) {
> +		u32 ecc_offs =3D nand->ecc.size * (i + 1) +
> +			       NFC_OOB_PER_ECC(nand) * i;
> +
> +		ret =3D nand_read_page_op(nand, page, 0, NULL, 0);
> +		if (ret)
> +			return ret;
> +
> +		/* Use temporary buffer, because 'nand_change_read_column_op()'
> +		 * seems work with some alignment, so we can't read data to
> +		 * 'oob_buf' directly.

DMA?

> +		 */
> +		ret =3D nand_change_read_column_op(nand, ecc_offs, meson_chip->oob_buf,
> +						 NFC_OOB_PER_ECC(nand), false);
> +		if (ret)
> +			return ret;
> +
> +		memcpy(oob_buf + i * NFC_OOB_PER_ECC(nand),
> +		       meson_chip->oob_buf,
> +		       NFC_OOB_PER_ECC(nand));
> +	}
> =20
>  	oob_bytes =3D meson_nfc_get_oob_bytes(nand);
> =20


Thanks,
Miqu=C3=A8l
