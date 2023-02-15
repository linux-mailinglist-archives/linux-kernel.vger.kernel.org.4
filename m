Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4120697A05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjBOKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjBOKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:37:28 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D593B3647C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:37:20 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ENlbPE008365;
        Wed, 15 Feb 2023 04:37:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=sHSvGYlnsISZ23PnykHZ2seFs84/4K/dAUTOh+6PFPM=;
 b=D7VqkJFXxquJuzVJDIkRosicdkumxv8cxk7Pdu9nesH8bPIYEQkNcW596VWZ5m3GLeeh
 fJjrC3uqmyJRE9+ueTveewFlIOKOWPmt6xpTdVFtwp2oYZLw3O2/DWN8cBhg4d/H23h3
 cYSbmr6RZ/AWUc5PILAXeW/26PrJ3zLCj2diHCnkJbY6MV4I3dZJfmJD1sko2eigbCYb
 hVOroamkcY5qxuy3mg6+fNImdftaJFK2maWqiVK9K2oDXMGk3EwHs107L3el3BcNNbkQ
 jzvNN4WctDxfJytr3wbSvkAjrOkInW23OrMSy1/Vm26bmJdpv9Khp1YGsa+gpqDCjOhX /A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wgk07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 04:37:06 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 15 Feb
 2023 04:37:05 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Wed, 15 Feb 2023 04:37:05 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5188D2A1;
        Wed, 15 Feb 2023 10:37:05 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l45: Remove separate tables module
Date:   Wed, 15 Feb 2023 10:37:05 +0000
Message-ID: <20230215103705.3302716-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YQ7upivJme4_0c-OB85oAMaHMIULGx21
X-Proofpoint-ORIG-GUID: YQ7upivJme4_0c-OB85oAMaHMIULGx21
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
 sound/soc/codecs/Kconfig  | 5 -----
 sound/soc/codecs/Makefile | 4 +---
 2 files changed, 1 insertion(+), 8 deletions(-)

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
-- 
2.30.2

