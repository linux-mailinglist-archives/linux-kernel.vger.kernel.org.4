Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC4A697A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjBOK6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjBOK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:58:27 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500431E37
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:58:25 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F5IwDI010319;
        Wed, 15 Feb 2023 04:58:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=5vFeQnutnA8zrv+fL98W7a9J8BNPZUM5glm08jQa940=;
 b=FlObZ950iKw2fEHgbshVTo7zHXB/6HEZU7yZ3/TPgMPBoPuDFtOidx7SEQlujolQRiMd
 HF1OVjKuc4yB2+bE4afBP16wIr2MBOfmeTO0HHw5ngvQTi1/axqvg71x/kuGiaxG55L6
 7klAqt5LI5PFBsfd3pfXQGc3CDtYPnsTlyWABOwNWJ25DYvEo3D4GSrcdI5NhiLzOpEF
 ZvuBfpQEvtXm03MUSfFny6dbpF/+tYPG7bKQDmK8uAsSQGVLw3B3VrJWENw7C4WOTtaP
 CWed7Na8GVxPXwSJjnPVQXQtG+4numJEdHgioUpXZtl9sKQyoRh+1/iLKJsLET3ymL3y Hw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wgkmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 04:58:19 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 15 Feb
 2023 04:58:18 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 15 Feb 2023 04:58:18 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DF5232A1;
        Wed, 15 Feb 2023 10:58:17 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/2] ASoC: cs35l45: Remove separate tables module
Date:   Wed, 15 Feb 2023 10:58:17 +0000
Message-ID: <20230215105818.3315925-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JKT1KBdgENUNCZR61kgkcOUxWvzbMRRr
X-Proofpoint-ORIG-GUID: JKT1KBdgENUNCZR61kgkcOUxWvzbMRRr
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to have a separate module for the tables file it just
holds regmap callbacks and register patches used by the main part of the
driver. Remove the separate module and merge it into the main driver
module.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Remove module macros as the bottom of cs35l45-tables.c

 sound/soc/codecs/Kconfig          | 5 -----
 sound/soc/codecs/Makefile         | 4 +---
 sound/soc/codecs/cs35l45-tables.c | 4 ----
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4621674e68bf1..bd72c426a93d1 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -688,9 +688,6 @@ config SND_SOC_CS35L41_I2C
 	select SND_SOC_CS35L41
 	select REGMAP_I2C
 
-config SND_SOC_CS35L45_TABLES
-	tristate
-
 config SND_SOC_CS35L45
 	tristate
 
@@ -699,7 +696,6 @@ config SND_SOC_CS35L45_SPI
 	depends on SPI_MASTER
 	select REGMAP
 	select REGMAP_SPI
-	select SND_SOC_CS35L45_TABLES
 	select SND_SOC_CS35L45
 	help
 	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
@@ -710,7 +706,6 @@ config SND_SOC_CS35L45_I2C
 	depends on I2C
 	select REGMAP
 	select REGMAP_I2C
-	select SND_SOC_CS35L45_TABLES
 	select SND_SOC_CS35L45
 	help
 	  Enable support for Cirrus Logic CS35L45 smart speaker amplifier
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a0a61554548eb..f1ca18f7946ca 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -63,8 +63,7 @@ snd-soc-cs35l41-lib-objs := cs35l41-lib.o
 snd-soc-cs35l41-objs := cs35l41.o
 snd-soc-cs35l41-spi-objs := cs35l41-spi.o
 snd-soc-cs35l41-i2c-objs := cs35l41-i2c.o
-snd-soc-cs35l45-tables-objs := cs35l45-tables.o
-snd-soc-cs35l45-objs := cs35l45.o
+snd-soc-cs35l45-objs := cs35l45.o cs35l45-tables.o
 snd-soc-cs35l45-spi-objs := cs35l45-spi.o
 snd-soc-cs35l45-i2c-objs := cs35l45-i2c.o
 snd-soc-cs42l42-objs := cs42l42.o
@@ -431,7 +430,6 @@ obj-$(CONFIG_SND_SOC_CS35L41)	+= snd-soc-cs35l41.o
 obj-$(CONFIG_SND_SOC_CS35L41_LIB)	+= snd-soc-cs35l41-lib.o
 obj-$(CONFIG_SND_SOC_CS35L41_SPI)	+= snd-soc-cs35l41-spi.o
 obj-$(CONFIG_SND_SOC_CS35L41_I2C)	+= snd-soc-cs35l41-i2c.o
-obj-$(CONFIG_SND_SOC_CS35L45_TABLES)	+= snd-soc-cs35l45-tables.o
 obj-$(CONFIG_SND_SOC_CS35L45)	+= snd-soc-cs35l45.o
 obj-$(CONFIG_SND_SOC_CS35L45_SPI)	+= snd-soc-cs35l45-spi.o
 obj-$(CONFIG_SND_SOC_CS35L45_I2C)	+= snd-soc-cs35l45-i2c.o
diff --git a/sound/soc/codecs/cs35l45-tables.c b/sound/soc/codecs/cs35l45-tables.c
index 5a2c2e684ef9f..5a2f47ca57716 100644
--- a/sound/soc/codecs/cs35l45-tables.c
+++ b/sound/soc/codecs/cs35l45-tables.c
@@ -196,7 +196,3 @@ unsigned int cs35l45_get_clk_freq_id(unsigned int freq)
 	return -EINVAL;
 }
 EXPORT_SYMBOL_NS_GPL(cs35l45_get_clk_freq_id, SND_SOC_CS35L45_TABLES);
-
-MODULE_DESCRIPTION("ASoC CS35L45 driver tables");
-MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
-MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.2

