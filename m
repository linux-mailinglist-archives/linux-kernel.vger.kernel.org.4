Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496735B8BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiINPcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiINPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:32:48 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4186F48CAB;
        Wed, 14 Sep 2022 08:32:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 11A11E0E70;
        Wed, 14 Sep 2022 08:32:44 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Poz8d05vzgzF; Wed, 14 Sep 2022 08:32:43 -0700 (PDT)
Date:   Wed, 14 Sep 2022 17:32:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1663169563; bh=uuekv8jywcRwSksg0sQmwcM0xjq7DU2XBG5Ob1vzVl4=;
        h=Date:From:To:Subject:From;
        b=OkUJ3VqYSP1qeb3ENwgc6YjP9UfCi1JhEp/XtdeAl/0PP+aONZ9l/UMtF2u1ZrE/A
         3So+tYWo8C5RuIU93EZqd3lN8gKfKnjDih/PYiJj1gPK0wdqKY/jfJDVQqSUyO+rr2
         pli8BvBfeyIcr7b6TAqCIQv5icuc5/fMw74cdyfjUxkckhn2Z0QU0cQlO8MEhCRSYf
         7y8MEkmOoP+YupcjitsBaU1ixQ/r19uC0U7PgTwG1f3fLyKX9RHemaJ0OVbrWBVZQ1
         LlywltdOpwAXNbEWyJ9Weq6XuOAW4w4/GJezqRlDF41YFANDydNgeKesBS+juzHxaC
         YGKh5+uy/YoSg==
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
Subject: [PATCHv2 1/1] media: imx: Round line size to 4 bytes
Message-ID: <20220914173236.3040f3a1.dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bMSIG0H6irvYAHTcxUTprHh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bMSIG0H6irvYAHTcxUTprHh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Section 13.7.6.13 "CSI Image Parameter Register" of the
i.MX 8M Quad Applications Processors Reference Manual
states that the line size should be divisible by 8 bytes.
However, the hardware also accepts sizes divisible by 4 bytes,
which are needed to fully utilize the S5K3L6XX sensors.

This patch accepts line sizes divisible 4-bytes in non-planar mode.

---
Hello,

the Librem 5 is using an out-of-tree driver for s5k3l6xx, and rounding to 4=
 is optimal to operate it.

Please ignore my previous series, I sent it by mistake.

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


--Sig_/bMSIG0H6irvYAHTcxUTprHh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmMh9BQACgkQADBpX4S8
ZncG4hAAo00Tw14UNMOxAIVFO3bqf/GOJ/lLevA4FKvmNw5xktYXH9b793e8xFkY
ECO5AYCr9IJmOzKuD8s2zLkPm2iN5xcbqGUKX0gb059p4nQrUEI14A2a+1KBdPkJ
pZC9B+1KbRyfwDsfF4DOyz81kxHRvq1EWYuQQerLsZ4iAeiW2ku99hhR8N9dNNEl
jA87/Ke8SmN8rQMhgXGn20Kvqb7DKGI0G3+2Yx9Q9Sm6J1NxHkA+dWu4JWB49acJ
XkK/NN3CMY1+3CiPBlOWPqwVYPR7kS+EtMNuMZE8fgkKFw7E6kZYNFjbZKQBGXBd
rQoe/ZkGco7h32T6zMyzo3kqM7Em8k7SMzlJEyT0kHLlUiR3hH+orb2XiEc+WAqx
AwKeGzvzT+06I47ykeZfs/mlEikl236Iu3Rm1VDyV2R/VwLfNV0cdrovMz13UAET
qF5q3ZRAfZPb/bK8hJOsvnhPi794QFqhfQSfyKj1Qu5cUZUlpQWRDV0gd6Omyd+n
UOkvk5CbBY6xlC9CNZ/0EOOK3YaUN9b2mO7KX9bKEDTdlbx9UaerMnf7DHKCHJbn
KzTDWn67D54CPFC2T/QqDunaLMbQQntdQ8rkjta05Kz3iE+ZenzarfyypXPRj47f
avAz1VGxyoaNB2aHnAqNsta9GXROT/YM5Dt0G/CmFS/XSKmdIvE=
=AiNw
-----END PGP SIGNATURE-----

--Sig_/bMSIG0H6irvYAHTcxUTprHh--
