Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8429667D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbjALSAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjALR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:59:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772E57DE0D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:18:55 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CF7JfD026944;
        Thu, 12 Jan 2023 11:18:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=oiMd4WrK0Y9BeberYzyibU3Ja1FQD3WINBfFgZgaxeE=;
 b=hQhorqXm15mCNMA3UraK2h9I9pVxSLcVkmgluVBfdPWDFtaTXb+GWdeSLsyU0epP2HVw
 Cbo6dyWjjbQwzcuQmSOTpY7nKhHpI5s9CIsGGKSIFE6N8jUq6tA17pdZ0ek4bUsTM7zb
 mfhuV2keLrrojSYBj53gk7ollAYJ4wTtLFeJeeZtxFQHud3liLDzyZ3cqcbpzUDRqZnY
 dMknC0SBjUjD4cjCvzDapI4I6Gg8Y81JhxLmKhboG+QVC1BA3j6rbt9cjUKSA2tc3TWO
 cxeIGP0hV7jqjTLGvTiILY2qSUk7/Nkj935OsycEVIoea0OoccfBpA/FeQ7VOdVEIecs qQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n1k582d2g-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:18:43 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 12 Jan
 2023 11:18:40 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Thu, 12 Jan 2023 11:18:40 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 87D2611CB;
        Thu, 12 Jan 2023 17:18:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Date:   Thu, 12 Jan 2023 17:18:40 +0000
Message-ID: <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PIqSdmW65vTh42YKbBI4N4XajQ5pJHZt
X-Proofpoint-GUID: PIqSdmW65vTh42YKbBI4N4XajQ5pJHZt
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Some SoundWire devices have larger width device specific register
maps, in addition to the standard SoundWire 8-bit map. Update the
helpers to allow accessing arbitrarily sized register values and remove
the explicit 8-bit restriction from regmap_sdw_config_check.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This patch requires the patch commit 62dc9f3f2fd0 ("soundwire: bus:
export sdw_nwrite_no_pm and sdw_nread_no_pm functions") from Vinod's
SoundWire tree to build, so not sure if we want to push these patches
through his tree or merge his tree across.

 drivers/base/regmap/regmap-sdw.c | 39 ++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 95801fd411b26..09899ae99fc19 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -6,43 +6,52 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/soundwire/sdw.h>
+#include <linux/types.h>
 #include "internal.h"
 
-static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
+static int regmap_sdw_write(void *context, const void *val_buf, size_t val_size)
 {
 	struct device *dev = context;
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	/* First word of buffer contains the destination address */
+	u32 addr = le32_to_cpu(*(const __le32 *)val_buf);
+	const u8 *val = val_buf;
 
-	return sdw_write_no_pm(slave, reg, val);
+	return sdw_nwrite_no_pm(slave, addr, val_size - sizeof(addr), val + sizeof(addr));
 }
 
-static int regmap_sdw_read(void *context, unsigned int reg, unsigned int *val)
+static int regmap_sdw_gather_write(void *context,
+				   const void *reg_buf, size_t reg_size,
+				   const void *val_buf, size_t val_size)
 {
 	struct device *dev = context;
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	int read;
+	u32 addr = le32_to_cpu(*(const __le32 *)reg_buf);
 
-	read = sdw_read_no_pm(slave, reg);
-	if (read < 0)
-		return read;
+	return sdw_nwrite_no_pm(slave, addr, val_size, val_buf);
+}
 
-	*val = read;
-	return 0;
+static int regmap_sdw_read(void *context,
+			   const void *reg_buf, size_t reg_size,
+			   void *val_buf, size_t val_size)
+{
+	struct device *dev = context;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	u32 addr = le32_to_cpu(*(const __le32 *)reg_buf);
+
+	return sdw_nread_no_pm(slave, addr, val_size, val_buf);
 }
 
 static const struct regmap_bus regmap_sdw = {
-	.reg_read = regmap_sdw_read,
-	.reg_write = regmap_sdw_write,
+	.write = regmap_sdw_write,
+	.gather_write = regmap_sdw_gather_write,
+	.read = regmap_sdw_read,
 	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
 	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
 };
 
 static int regmap_sdw_config_check(const struct regmap_config *config)
 {
-	/* All register are 8-bits wide as per MIPI Soundwire 1.0 Spec */
-	if (config->val_bits != 8)
-		return -ENOTSUPP;
-
 	/* Register addresses are 32 bits wide */
 	if (config->reg_bits != 32)
 		return -ENOTSUPP;
-- 
2.30.2

