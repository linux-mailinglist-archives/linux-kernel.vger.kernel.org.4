Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27097110E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbjEYQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbjEYQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:26:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF089197
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:26:39 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PEEWVF026032;
        Thu, 25 May 2023 11:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=bFYPw6wLCSpL41YWCAF1soDlcwsIVO5BLl0PUe5WOmc=;
 b=ntu5YbYuiPo83bytVZS1AKrdJwMP0qAZW9ItjbVED/iDpqnkmJRhjqS5OGkI283JBatv
 KJh2Inp/oEHD4HxuGfGpP9jmEJzdjs1FdhtXyffrilXeUUHnLxoLur89GWSCc55eS+pO
 Wx0clDcEiX5+A9lAlzeDkBAOEY7anrcg5oQDNWdFeUIOLexA+DYEMxrahHzFggE98ono
 9CAY95FpH4e8c7aoe5QlNPxeZN8K6LZ7xDEVV4hLBZo6sXuvT3Amfxy4DFseFhJ7ocos
 Gs5on/xQ2MYBCo/f+ALXv3dHeNtlZzQrcpBWkjRlIe96BCtg5MvWwRJlhBfquT6GNM1m Nw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm74vu-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:26:28 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 11:26:26 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 11:26:26 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B867745;
        Thu, 25 May 2023 16:26:25 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 09/12] ASoC: cs35l56: Make a common function to shutdown the DSP
Date:   Thu, 25 May 2023 17:26:15 +0100
Message-ID: <20230525162618.20146-10-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525162618.20146-1-rf@opensource.cirrus.com>
References: <20230525162618.20146-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e3sOcIB2Flbu9qQPgp_1FQqNhxD4yS0k
X-Proofpoint-GUID: e3sOcIB2Flbu9qQPgp_1FQqNhxD4yS0k
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

Move issuing of a CS35L56_MBOX_CMD_SHUTDOWN command and then waiting for
the DSP to reach CS35L56_HALO_STATE_SHUTDOWN in the register appropriate
for the hardware revision into a common function.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 26 ++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.c        | 17 +----------------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index ae9e8f55962a..5b32aa7468cb 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -274,6 +274,7 @@ extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 
 void cs35l56_reread_firmware_registers(struct cs35l56_base *cs35l56_base);
 int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command);
+int cs35l56_firmware_shutdown(struct cs35l56_base *cs35l56_base);
 int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base);
 void cs35l56_wait_control_port_ready(void);
 void cs35l56_wait_min_reset_pulse(void);
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 7e02d023338c..95ef71c7b8f1 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -218,6 +218,32 @@ int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_mbox_send, SND_SOC_CS35L56_SHARED);
 
+int cs35l56_firmware_shutdown(struct cs35l56_base *cs35l56_base)
+{
+	int ret;
+	unsigned int reg;
+	unsigned int val;
+
+	ret = cs35l56_mbox_send(cs35l56_base, CS35L56_MBOX_CMD_SHUTDOWN);
+	if (ret)
+		return ret;
+
+	if (cs35l56_base->rev < CS35L56_REVID_B0)
+		reg = CS35L56_DSP1_PM_CUR_STATE_A1;
+	else
+		reg = CS35L56_DSP1_PM_CUR_STATE;
+
+	ret = regmap_read_poll_timeout(cs35l56_base->regmap,  reg,
+				       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
+				       CS35L56_HALO_STATE_POLL_US,
+				       CS35L56_HALO_STATE_TIMEOUT_US);
+	if (ret < 0)
+		dev_err(cs35l56_base->dev, "Failed to poll PM_CUR_STATE to 1 is %d (ret %d)\n",
+			val, ret);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_firmware_shutdown, SND_SOC_CS35L56_SHARED);
+
 int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
 {
 	unsigned int reg;
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index f472bde6d21a..dbe9134ae09a 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -676,8 +676,6 @@ static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
 
 static void cs35l56_patch(struct cs35l56_private *cs35l56)
 {
-	unsigned int reg;
-	unsigned int val;
 	int ret;
 
 	/*
@@ -694,23 +692,10 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 		flush_work(&cs35l56->sdw_irq_work);
 	}
 
-	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_SHUTDOWN);
+	ret = cs35l56_firmware_shutdown(&cs35l56->base);
 	if (ret)
 		goto err;
 
-	if (cs35l56->base.rev < CS35L56_REVID_B0)
-		reg = CS35L56_DSP1_PM_CUR_STATE_A1;
-	else
-		reg = CS35L56_DSP1_PM_CUR_STATE;
-
-	ret = regmap_read_poll_timeout(cs35l56->base.regmap, reg,
-				       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
-				       CS35L56_HALO_STATE_POLL_US,
-				       CS35L56_HALO_STATE_TIMEOUT_US);
-	if (ret < 0)
-		dev_err(cs35l56->base.dev, "Failed to poll PM_CUR_STATE to 1 is %d (ret %d)\n",
-			val, ret);
-
 	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
 	ret = wm_adsp_power_up(&cs35l56->dsp);
 	if (ret) {
-- 
2.30.2

