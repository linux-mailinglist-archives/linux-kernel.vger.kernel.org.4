Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BD97173FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjEaC70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjEaC7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:59:18 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46EB12B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:59:13 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B1FC82C05CC;
        Wed, 31 May 2023 14:58:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1685501939;
        bh=pX0AGkZ7cP1J451OpS7d6oUS57yjJPdDVs8gC+pj+vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/o8VpgQmgLlAeeHPzDEcU75bwt2oXjZAm6TS5jyeM8P6eqvJiXvUkJLzp7y9ct7j
         sui37RibmhyC9aohzYj91POf+ncxgDO7JurHxzALErI24NvjjRKrM/sTmJRKLnaWSV
         kuGAdzjjUVR7pzoSgHcmY3XLyRZ5ubOU0qQU6YtduqwlBf/44uU/W17kwe1aILZJBO
         duCoUTWJtPLZbGingEQfitax4SbcbkbfyYHfJK6v8R3IbMeO7EIYv1bcT8Rt3w+b6+
         GQ61kQq+VZOlN3+fGLJ3Y90KEV6oGkC6/P+rY3gsuqf0MTwWwHZcXTjRl4fLXL8tqy
         ykBB7PXD2sZdA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6476b7f30002>; Wed, 31 May 2023 14:58:59 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 6CE7113EE4D;
        Wed, 31 May 2023 14:58:59 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 68543281742; Wed, 31 May 2023 14:58:59 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, arnd@arndb.de, daniel.lezcano@linaro.org,
        neil.armstrong@linaro.org, f.fainelli@gmail.com,
        christophe.kerello@foss.st.com, liang.yang@amlogic.com,
        jdelvare@suse.de
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] mtd: rawnand: marvell: add support for AC5 SoC
Date:   Wed, 31 May 2023 14:58:47 +1200
Message-Id: <20230531025847.1284862-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531025847.1284862-1-chris.packham@alliedtelesis.co.nz>
References: <20230531025847.1284862-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=P0xRbXHiH_UA:10 a=FN2KoAgMzK-72ix3NDkA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AC5/AC5X SoC from Marvell. The NFC on this SoC only
supports SDR modes up to 3.

Marvell's SDK includes some predefined values for the ndtr registers.
These haven't been incorporated as the existing code seems to get good
values based on measurements taken with an oscilloscope.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/mtd/nand/raw/Kconfig        |  2 +-
 drivers/mtd/nand/raw/marvell_nand.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b523354dfb00..0f4cbb497010 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -160,7 +160,7 @@ config MTD_NAND_MARVELL
 	  including:
 	  - PXA3xx processors (NFCv1)
 	  - 32-bit Armada platforms (XP, 37x, 38x, 39x) (NFCv2)
-	  - 64-bit Aramda platforms (7k, 8k) (NFCv2)
+	  - 64-bit Aramda platforms (7k, 8k, ac5) (NFCv2)
=20
 config MTD_NAND_SLC_LPC32XX
 	tristate "NXP LPC32xx SLC NAND controller"
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
index 30c15e4e1cc0..b9a8dd324211 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -375,6 +375,7 @@ static inline struct marvell_nand_chip_sel *to_nand_s=
el(struct marvell_nand_chip
  *			BCH error detection and correction algorithm,
  *			NDCB3 register has been added
  * @use_dma:		Use dma for data transfers
+ * @max_mode_number:	Maximum timing mode supported by the controller
  */
 struct marvell_nfc_caps {
 	unsigned int max_cs_nb;
@@ -383,6 +384,7 @@ struct marvell_nfc_caps {
 	bool legacy_of_bindings;
 	bool is_nfcv2;
 	bool use_dma;
+	unsigned int max_mode_number;
 };
=20
 /**
@@ -2376,6 +2378,9 @@ static int marvell_nfc_setup_interface(struct nand_=
chip *chip, int chipnr,
 	if (IS_ERR(sdr))
 		return PTR_ERR(sdr);
=20
+	if (nfc->caps->max_mode_number && nfc->caps->max_mode_number < conf->ti=
mings.mode)
+		return -EOPNOTSUPP;
+
 	/*
 	 * SDR timings are given in pico-seconds while NFC timings must be
 	 * expressed in NAND controller clock cycles, which is half of the
@@ -3073,6 +3078,13 @@ static const struct marvell_nfc_caps marvell_armad=
a_8k_nfc_caps =3D {
 	.is_nfcv2 =3D true,
 };
=20
+static const struct marvell_nfc_caps marvell_ac5_caps =3D {
+	.max_cs_nb =3D 2,
+	.max_rb_nb =3D 1,
+	.is_nfcv2 =3D true,
+	.max_mode_number =3D 3,
+};
+
 static const struct marvell_nfc_caps marvell_armada370_nfc_caps =3D {
 	.max_cs_nb =3D 4,
 	.max_rb_nb =3D 2,
@@ -3121,6 +3133,10 @@ static const struct of_device_id marvell_nfc_of_id=
s[] =3D {
 		.compatible =3D "marvell,armada-8k-nand-controller",
 		.data =3D &marvell_armada_8k_nfc_caps,
 	},
+	{
+		.compatible =3D "marvell,ac5-nand-controller",
+		.data =3D &marvell_ac5_caps,
+	},
 	{
 		.compatible =3D "marvell,armada370-nand-controller",
 		.data =3D &marvell_armada370_nfc_caps,
--=20
2.40.1

