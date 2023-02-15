Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A633D697CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjBONKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjBONJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:09:56 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45FB35A1;
        Wed, 15 Feb 2023 05:09:54 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7F38024000E;
        Wed, 15 Feb 2023 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676466592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQNw6Dq9MEONpewdlcGZDEALhVDCV7c2JF/ae4aR+zc=;
        b=Lb6Z+sWwhf/HaYVZ3oqF2F+/HNFVbkJEkNugc4G3shx/12OKTtKc5klA0fHtfIbLDXtikx
        0SQXZEIsJHvp0zow7IFM7zVwR/eKFiW1RPS9iT7aMiYyUubB5g5NV+HYZAlr0WAGZ08W87
        9QhkZlgVBCSqMvFSEriybxrKrG8vHYABGHcdMHewCooBcscnIG43XvHAXyLEgDAlmSUSa9
        zr+eQs83f0PO0YHWzLH8f1XV0i+4+sD47/qSWwfu342iiHHhI3GX2HbEGhjkS+/w3Jmi6i
        Mv4PQKDVufPvQoAfjE0dCxbR0gvlHqPOz/1v4FtorkW2/MhV/zANthyFvw5ldQ==
Date:   Wed, 15 Feb 2023 14:09:50 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: mxic-ecc: Fix
 mxic_ecc_data_xfer_wait_for_completion() when irq is used
Message-ID: <20230215140950.2e7428b8@xps-13>
In-Reply-To: <beddbc374557e44ceec897e68c4a5d12764ddbb9.1676459308.git.christophe.jaillet@wanadoo.fr>
References: <beddbc374557e44ceec897e68c4a5d12764ddbb9.1676459308.git.christophe.jaillet@wanadoo.fr>
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

Hi Christophe,

christophe.jaillet@wanadoo.fr wrote on Wed, 15 Feb 2023 12:08:45 +0100:

> wait_for_completion_timeout() and readl_poll_timeout() don't handle their
> return value the same way.
>=20
> wait_for_completion_timeout() returns 0 on time out (and >0 in all other
> cases)
> readl_poll_timeout() returns 0 on success and -ETIMEDOUT upon a timeout.

That's a shame, but yeah, excellent catch!

> In order for the error handling path to work in both cases, the logic
> against wait_for_completion_timeout() needs to be inverted.
>=20
> Fixes: 48e6633a9fa2 ("mtd: nand: mxic-ecc: Add Macronix external ECC engi=
ne support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
>=20
> This is really spurious.
> If I'm right, this means that it never worked!
>=20
> Can any one with the hardware test?

The design I used for development and testing had no interrupt line
available for that IIRC, so I only tested the polling case ('else'
side) and completely overlooked that difference. I might have mentioned
it in the cover letter, if I didn't, it's an oversight.

> ---
>  drivers/mtd/nand/ecc-mxic.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
> index 8afdca731b87..6b487ffe2f2d 100644
> --- a/drivers/mtd/nand/ecc-mxic.c
> +++ b/drivers/mtd/nand/ecc-mxic.c
> @@ -429,6 +429,7 @@ static int mxic_ecc_data_xfer_wait_for_completion(str=
uct mxic_ecc_engine *mxic)
>  		mxic_ecc_enable_int(mxic);
>  		ret =3D wait_for_completion_timeout(&mxic->complete,
>  						  msecs_to_jiffies(1000));
> +		ret =3D ret ? 0 : -ETIMEDOUT;
>  		mxic_ecc_disable_int(mxic);
>  	} else {
>  		ret =3D readl_poll_timeout(mxic->regs + INTRPT_STS, val,


Thanks,
Miqu=C3=A8l
