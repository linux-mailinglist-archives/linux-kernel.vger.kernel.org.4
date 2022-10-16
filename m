Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8C5FFFE3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJPOlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJPOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 10:40:58 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3AE3B9AF;
        Sun, 16 Oct 2022 07:40:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id AE8D7DF919;
        Sun, 16 Oct 2022 07:40:27 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zy-5r13ibeDh; Sun, 16 Oct 2022 07:40:26 -0700 (PDT)
Date:   Sun, 16 Oct 2022 16:39:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1665931226; bh=W0L64e3HzKHkWHGerf0WHl/H2DONAMdk6gTSQ4fNdTQ=;
        h=Date:From:To:Subject:From;
        b=MlCG9O2oVZUmje8MmQvatYPJUdnaXr005yNJZIFe70CU1pElMsar9IHaIt+kmD2lw
         7IXa+LsfgOdhuHMWny2WNuY2K5w/LtsH2Z+qZL0TQSCb5/N9sC6mf80M7w1PpFegRj
         vZcjWqykUs8dpv7s3wuVXTGxTZgxBK3kUS2S+i1qg8Ev8qqbh/cjVTMcS+u48SJkHK
         BC0RxNUxid/QIWxyXHqacrQsrf6v0rBBXDgtkB8LWY1fh9zHTO8i2tsEmbmc44fWfH
         tRUn96ccfNtpmqDlTmKtJI3BeVESX+G1AIz2X1fbfNW464Ro4ZH7lS29HdxSSxCReJ
         Y5ygQj6ugN32w==
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
Subject: [PATCHv3 1/1 RESEND] media: imx: Round line size to 4 bytes
Message-ID: <20221016163928.1ef0a4fe.dorota.czaplejewicz@puri.sm>
Organization: Purism
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QpoY6r56b903uL_dAD/ortP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QpoY6r56b903uL_dAD/ortP
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


--Sig_/QpoY6r56b903uL_dAD/ortP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExKRqtqfFqmh+lu1oADBpX4S8ZncFAmNMF6AACgkQADBpX4S8
Znc18Q//ZXmRYoc4koc60UEB7ck4lTlcbVygMZYzL90FsKffHt0SP9FfNIW/o0zt
CtyoFABKucBevZDcIBh5yACDrcJCe5lJWoSoLHN9vh6ozPo0AlqGFEYcFqT1THZQ
aQH+1PmJ2U7DX8fAtu3yPJALoAwTCeUQUsRtFIM5//wf4kQzZoynO1uoTokOR8Nn
TPteseorgNrLqmPkiTtgrVzoXf5UWpt0RzZd25AHDcOElSOoWnabsEIaJ+VgfZ2W
I06AnV9Dkr6c++9moMwRl+HGCrr0K6c6jcuji0n/CRnG863jD5zURSfyXdW480eU
dgaNqRmJQw/fOmP5S0/MiFTvnIv0LT0rumqX+ZHIAResnWlw6D7Fh/hkVLOsOh23
4zxc8CfFyG6b8uRePnJa3AbfqO62duLwu9JTGzrglNiIn3v74p9nD7hvkLyNDE2m
QLpkLPVVJA6IjODkCBEQmuscJ6M0ZnFSieGVV/xY374rgU6qef+EIhUBsn69lfvh
5fti4aKXidGSwFBzQWC57A8wjcMWA+B+Ym23J2eazgtka1gCe86UFGosbYZMpYyZ
muRVmaRQcHrOuhXNQXgjrvCKLsYhT0gIn6nbswaqWlWPHvQPrRq965/Mflir3lFA
3KB2gVhIHtNO+RWgwMIC+LsbV/Uf1aQSjgK12gloXaJnIP6HwOQ=
=Omue
-----END PGP SIGNATURE-----

--Sig_/QpoY6r56b903uL_dAD/ortP--
