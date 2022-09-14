Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19D5B87B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiINL7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiINL7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:59:07 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802147D7BF;
        Wed, 14 Sep 2022 04:59:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 57730E0FB7;
        Wed, 14 Sep 2022 04:58:31 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d7N0A5w4eyZy; Wed, 14 Sep 2022 04:58:30 -0700 (PDT)
Date:   Wed, 14 Sep 2022 13:58:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1663156710; bh=lBd6GXJ3wPOnH/QiUaG6oifUeJRoTS3Bd9+aDFujht4=;
        h=Date:From:To:Subject:From;
        b=k3aQV+q7sa6uuCqXsGWxJRNGDd92fJpaIOKgsu0g7LGup2RvsS2SkJo7jK28YhWyi
         APho/OdYnxPUpRuSCvze7Pwds9g++2EqGfRJkjquLpmpBwBBSMippT5LwQrJNi/xFm
         34ZLLIM1EQoAdiLPfILt2zH/c8OOY46UqRxxT9PXMm5nCJ96+WLalJc2bDN6oJMZ6F
         8gtjzK9mZdbukvI1rvr2MHpAe+Z04lwUxSPkWlgqedFDkCYOdw2jCqTYNUCt9Be9KW
         UGQzrREsWdNJJJn8I7oOaq/AQF+EHs41YdDgkXG8xC+40gGxCipN4i9unkVOK1eLdm
         z+lSUdi06cf7A==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, phone-devel@vger.kernel.org
Subject: [PATCH 1/2] media: imx: Round line size to 4 bytes
Message-ID: <20220914113436.1503790-1-dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//_7_vU7zTeYx5tO9_.AIcp6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//_7_vU7zTeYx5tO9_.AIcp6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This has been broken in e352833d, which does not actually copy the logic
from 056f9af9.

Section 13.7.6.13 "CSI Image Parameter Register" of the
i.MX 8M Quad Applications Processors Reference Manual
states that the line size should be divisible by 8 bytes.
However, the hardware also accepts sizes divisible by 4 bytes.

This patch accepts line sizes divisible 4-bytes in non-planar mode.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
---
Hi,

in recent kernels, I've noticed that the Librem 5 camera driver no longer w=
orks. The s5k3l6xx out of tree sensor driver uses sizes divisible by 4 and =
not by 8, for which I submitted the patch 056f9af9 . The new kernels no lon=
ger accept sizes divisible by 4.

I tracked down the source: previously, the video device on the imx8m used i=
mx_media_mbus_fmt_to_pix_fmt. e352833d introduced imx7_csi_mbus_fmt_to_pix_=
fmt, which is what is used now exclusively. However, imx7_csi_mbus_fmt_to_p=
ix_fmt *does not* contain the same logic, and does not provide an explanati=
on why the logic is different.

I don't know why the "imx_*" is not used any more on the i.MX8M SoC, but I =
presume that "imx7_*" is the correct code path. That indicates that "imx_*"=
 is *not* the correct code for this SoC.

Under those assumptions, I added the relaxed rounding to the "imx7_*" funct=
ion, to match what the SoC can do (patch 1). I also reverted my original pa=
tch (patch 2), because if "imx7_*" is the correct function for my SoC, then=
 I had never intended to mess with whatever other SoC is handled by the "im=
x_" function.

Cheers,
Dorota

 drivers/staging/media/imx/imx7-media-csi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/m=
edia/imx/imx7-media-csi.c
index 643547bfa90f..bafbb5ef08d5 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1000,10 +1000,10 @@ static int imx7_csi_mbus_fmt_to_pix_fmt(struct v4l2=
_pix_format *pix,
 	}
=20
 	/* Round up width for minimum burst size */
-	width =3D round_up(mbus->width, 8);
+	width =3D round_up(mbus->width, 4);
=20
 	/* Round up stride for IDMAC line start address alignment */
-	stride =3D round_up((width * cc->bpp) >> 3, 8);
+	stride =3D round_up((width * cc->bpp) >> 3, 4);
=20
 	pix->width =3D width;
 	pix->height =3D mbus->height;
--=20
2.37.3


--Sig_//_7_vU7zTeYx5tO9_.AIcp6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmMhwdAACgkQADBpX4S8
ZncCcQ//falHr+LJFMHENDl4d2MOkyUiQLbaZDimP6Sr8c9oFKvdBt57DEdh7bHl
qp7wiARfP+itGVunBVwN80lZIGRIXlBctzx7lYSKyf8vc9OYhgZ/Ml9j5BhmefAG
hRSSdlLg/JypqgdZn7FOBo9KrzMH8SUAJY4J5pTiA/pgUQ2tcbB0xIQztCWnXUST
c84dA5fhNMTLT0Fsqug5Z4gIWWSul/nQvvksfVL+4/M+BN7tjpSBP08Hk6YeMHy/
G/6/Tbb/1wHR7vqcLBM0BzHLy7QwJMLVugmqzWnu8QhrHHjCrOKXalUi/kFQ9z+q
B/KoinQIGpb+BkAFxT+8LMy4r9J98EreyZRu/lxbPE9Wg6XsfKRKmUA1bxL3iYai
Ve31PDk5gq/1gDpyjuGDw7hm3+8VOPP7PE3PS+8qrxwmTHaBNBPMzw8jznMAof7+
z0uwdMga/PxzyKLQU6+zdpOpfMGwhiii0ZF8U0CvaYGSyb1t2g7IHfIz/lCl8RbQ
0iYrQ06qEdsN4iuepqN9EZAMKSFRoi7pCB8gZo+HLq2KAEr1RCmfEAJD1BqI9H99
nBV4jfcUz27XlM8YAjJ7R4kXsenWYSz7G+MGd/VIC1rMR+txur139EgdB8z4rw06
4tD3j6tYlif6uZ9m/L2ObYtGCZbh+FGlziywfyUsiZXTw7gxnEs=
=u5/B
-----END PGP SIGNATURE-----

--Sig_//_7_vU7zTeYx5tO9_.AIcp6--
