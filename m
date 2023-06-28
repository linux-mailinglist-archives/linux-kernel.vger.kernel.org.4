Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D346B740DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjF1Jw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:52:57 -0400
Received: from mx1.sberdevices.ru ([37.18.73.165]:14222 "EHLO
        mx1.sberdevices.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjF1JfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:35:02 -0400
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6D6B8100010;
        Wed, 28 Jun 2023 12:34:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6D6B8100010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687944899;
        bh=GclWWL59oht8VgFW8Tc4TABopkyYORqVnTmqa0M/qOg=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=isgdeBQNhCOXqAPWFxY23/4YS2SM5oveSMYOXgZN04ijpuuJPs8QDSJo86zoxFWSq
         akx548USahmjFutrW98GiQW9Yu5c3HMUQyRrw8PBE4RxahH3AYcuCpE66ts5FHhudy
         UcgvLJxbfBkOGNYZnxlYDseuBe13CHMgxp5XJTcdciGCUwpvDTiamXOo7D+JYIEvqL
         39cJ82LQBy62R7fdzuQWngyJXD2ZY7eifYTKneKsO6/Bvv2S27QlWD9jxGMj1WI/Es
         wmm7viJHorE3OsE//MeQ/HQMsgGk0Rs4bNAlJJPH6F0j4qvFx4CdkpHLc9m2xMeuGU
         hhdW8OtiOlxJg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 12:34:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 12:34:02 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 2/2] mtd: rawnand: meson: support for 512B ECC step size
Date:   Wed, 28 Jun 2023 12:29:36 +0300
Message-ID: <20230628092937.538683-3-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230628092937.538683-1-AVKrasnov@sberdevices.ru>
References: <20230628092937.538683-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178300 [Jun 28 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/28 08:00:00 #21591748
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson NAND supports both 512B and 1024B ECC step size.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 345212e8c691..6cc4f63b86c8 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -135,6 +135,7 @@ struct meson_nfc_nand_chip {
 struct meson_nand_ecc {
 	u32 bch;
 	u32 strength;
+	u32 size;
 };
 
 struct meson_nfc_data {
@@ -190,7 +191,8 @@ struct meson_nfc {
 };
 
 enum {
-	NFC_ECC_BCH8_1K		= 2,
+	NFC_ECC_BCH8_512	= 1,
+	NFC_ECC_BCH8_1K,
 	NFC_ECC_BCH24_1K,
 	NFC_ECC_BCH30_1K,
 	NFC_ECC_BCH40_1K,
@@ -198,15 +200,16 @@ enum {
 	NFC_ECC_BCH60_1K,
 };
 
-#define MESON_ECC_DATA(b, s)	{ .bch = (b),	.strength = (s)}
+#define MESON_ECC_DATA(b, s, sz)	{ .bch = (b), .strength = (s), .size = (sz) }
 
 static struct meson_nand_ecc meson_ecc[] = {
-	MESON_ECC_DATA(NFC_ECC_BCH8_1K, 8),
-	MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24),
-	MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30),
-	MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40),
-	MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50),
-	MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60),
+	MESON_ECC_DATA(NFC_ECC_BCH8_512, 8,  512),
+	MESON_ECC_DATA(NFC_ECC_BCH8_1K,  8,  1024),
+	MESON_ECC_DATA(NFC_ECC_BCH24_1K, 24, 1024),
+	MESON_ECC_DATA(NFC_ECC_BCH30_1K, 30, 1024),
+	MESON_ECC_DATA(NFC_ECC_BCH40_1K, 40, 1024),
+	MESON_ECC_DATA(NFC_ECC_BCH50_1K, 50, 1024),
+	MESON_ECC_DATA(NFC_ECC_BCH60_1K, 60, 1024),
 };
 
 static int meson_nand_calc_ecc_bytes(int step_size, int strength)
@@ -224,8 +227,27 @@ static int meson_nand_calc_ecc_bytes(int step_size, int strength)
 
 NAND_ECC_CAPS_SINGLE(meson_gxl_ecc_caps,
 		     meson_nand_calc_ecc_bytes, 1024, 8, 24, 30, 40, 50, 60);
-NAND_ECC_CAPS_SINGLE(meson_axg_ecc_caps,
-		     meson_nand_calc_ecc_bytes, 1024, 8);
+
+static const int axg_stepinfo_strengths[] = { 8 };
+static const struct nand_ecc_step_info axg_stepinfo_1024 = {
+	.stepsize = 1024,
+	.strengths = axg_stepinfo_strengths,
+	.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
+};
+
+static const struct nand_ecc_step_info axg_stepinfo_512 = {
+	.stepsize = 512,
+	.strengths = axg_stepinfo_strengths,
+	.nstrengths = ARRAY_SIZE(axg_stepinfo_strengths)
+};
+
+static const struct nand_ecc_step_info axg_stepinfo[] = { axg_stepinfo_1024, axg_stepinfo_512 };
+
+static const struct nand_ecc_caps meson_axg_ecc_caps = {
+	.stepinfos = axg_stepinfo,
+	.nstepinfos = ARRAY_SIZE(axg_stepinfo),
+	.calc_ecc_bytes = meson_nand_calc_ecc_bytes,
+};
 
 static struct meson_nfc_nand_chip *to_meson_nand(struct nand_chip *nand)
 {
@@ -1259,7 +1281,8 @@ static int meson_nand_bch_mode(struct nand_chip *nand)
 		return -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(meson_ecc); i++) {
-		if (meson_ecc[i].strength == nand->ecc.strength) {
+		if (meson_ecc[i].strength == nand->ecc.strength &&
+		    meson_ecc[i].size == nand->ecc.size) {
 			meson_chip->bch_mode = meson_ecc[i].bch;
 			return 0;
 		}
@@ -1278,7 +1301,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	struct meson_nfc *nfc = nand_get_controller_data(nand);
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
-	int nsectors = mtd->writesize / 1024;
+	int nsectors = mtd->writesize / 512;
 	int raw_writesize;
 	int ret;
 
-- 
2.35.0

