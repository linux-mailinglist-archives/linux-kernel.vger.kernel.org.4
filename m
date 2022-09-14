Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF255B8C97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiINQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiINQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:12:02 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB582F86;
        Wed, 14 Sep 2022 09:12:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 69325E0DE4;
        Wed, 14 Sep 2022 09:11:59 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vobkclx-FXAG; Wed, 14 Sep 2022 09:11:58 -0700 (PDT)
Date:   Wed, 14 Sep 2022 18:11:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1663171918; bh=elFceSoq1Zd6llwZFMqA1XY98dpuih6uD8z1glKnQpA=;
        h=Date:From:To:Subject:From;
        b=qhbhsklArPEDmf0efT6EpeuH8Ev8nd5pK9+FSLHA81FZ0lTmq85z9/J6evfTPJ06T
         ZHex60osQ6L8Yvw4KSbRdiiwgKhqXLej2G7jO3UpzVyoQJ2+Sdczq+eILaT12q0M7e
         xzf9Lnw+Z8QmMjT2oRvo7HUJAOK35zGF+PprtDLucx3GE6JdTkAQm6L4Ug+UAKsLQh
         r+Xc8AGEwKp0nY8vdjDmU2lWgze8bw8f14nzo5gG91gTjQF1jd+lt8e2XV21XTlI9U
         J5YZc92JFTD3qWDpicm1bAXyba0jNe5cAY/HI7AFpxf7194nV42UUPC8BGzmBkd3DQ
         Bgo4lr/OefzCw==
From:   Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
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
Subject: [PATCHv3 1/1] media: imx: Round line size to 4 bytes
Message-ID: <20220914173236.3040f3a1.dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DGaLqs2tzG0GvDAj=hR6mZX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DGaLqs2tzG0GvDAj=hR6mZX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Section 13.7.6.13 "CSI Image Parameter Register" of the
i.MX 8M Quad Applications Processors Reference Manual
states that the line size should be divisible by 8 bytes.
However, the hardware also accepts sizes divisible by 4 bytes,
which are needed to fully utilize the S5K3L6XX sensors.

This patch accepts line sizes divisible by 4 bytes.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
---
Hello,

the Librem 5 is using an out-of-tree driver for s5k3l6xx, and rounding to 4=
 is optimal to operate it.

This revision improves the commit message.

Cheers,
Dorota Czaplejewicz

 drivers/staging/media/imx/imx7-media-csi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/m=
edia/imx/imx7-media-csi.c
index a0553c24cce4..af821b410c3f 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -999,10 +999,10 @@ static int imx7_csi_mbus_fmt_to_pix_fmt(struct v4l2_p=
ix_format *pix,
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


--Sig_/DGaLqs2tzG0GvDAj=hR6mZX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmMh/UcACgkQADBpX4S8
Zne/Zg//ZcNTMKOq24tmajCtAn0PdgbXzxTDAoFPk46xXmkPBW0LNNa2rYvUXAPl
fyEQxVUXtMlyoCtwwPm4n/qMJLgn2uKglo84FUxe6VVMHqyX2T0t+Ph1TidSf0Rm
x34X+ZkU1cAQgU6tT+njz/uXJ5tAo9L80FeFwUXAJsTU3B8PQth8QApnEfV6iQM0
sMbqL59HwxJqZJK9vw6gHdf5TQD87tlxvzh2/Fx9EbW0tRUFoTHL7Pb156Or22mO
kTZ8vtHpI7y25aEnzKhIEHqIrL5vKb0azfegx9mp7mYM7D+32ks9rLAQF+vRoGrL
vZVV7XbfQklW0GmzMGPjbWfLYEftPuHaX/0RvrJ1HIOZuqtQqwj3beqYHux7I6Xv
yh4IDa7jt/N3aZ/P2NHHOoMQ6RdEgPtzFRKcjUZQRqs9ciccNgkJvEgGGa+OCq3I
oJ8FVoiK9ckYqr5t3vHoMk6D8/OTe2sL4ex/fkTvCDngaVLYy3EYY6bch3A69gCR
8oeVsDjwmjp+Di6x1Tk7lF3wwDaGgmV1C/qLWTbacQ1i4vew/tPH9BFxrYxp+RcL
muNzTv1apXoDFhLG5HyCZMUCQNahC8u1/zvghc8oYFgFIMN7ewcphNTBZTyPpKbH
9Xpl18rMqmuHiwvnU92eiHEIYX/qF6JcOlc5sh90vw+aQoLfO/k=
=EUJP
-----END PGP SIGNATURE-----

--Sig_/DGaLqs2tzG0GvDAj=hR6mZX--
