Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D671A311
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjFAPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbjFAPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:47:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CEF136
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:47:53 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3515TBgw016524;
        Thu, 1 Jun 2023 10:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=WTpmV2BBoL8BWcYE51UQSNiOyWXZfAiUEby6Lgb82UU=;
 b=oE5IygySCns4pFk1giE5bWUNItMjjV8qKekGAkdEwGgPYfaZaQMgT+Yuf6mIwxQv0Os7
 Dv5ydJOVI7TlCzcZIWhygfeExwrBqe9A/ewDi07cydC89JFwBt5IHpBMadUCkmSq1Yh4
 1uCqS2WDe6K2mvIkrZfjni+aO/hKqz/feudlgQCHij81NmdyO527KAabS5BhNrIoSqFu
 nJe64PW7HNuKEh2NVv18yay5AAr1B5VV8n5JJlW1MXaskiPBPKuvXoEMGQM9wMNNt/eE
 AKPUobm40gPabv5iU0fCcIvKigDs3JqpoMLZ3k1LK16X2F/fKrb2XMXLzqVvM4f7lGb1 bQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3que9mxjyq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 10:47:33 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 1 Jun
 2023 16:47:31 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 16:47:31 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 71BF0468;
        Thu,  1 Jun 2023 15:47:31 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 03/12] ASoC: cs35l56: Convert utility functions to use common data structure
Date:   Thu, 1 Jun 2023 16:47:22 +0100
Message-ID: <20230601154731.3210572-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230601154731.3210572-1-rf@opensource.cirrus.com>
References: <20230601154731.3210572-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NRJsf2KJeFTRfV-s7x16CIntBi-IbXr8
X-Proofpoint-ORIG-GUID: NRJsf2KJeFTRfV-s7x16CIntBi-IbXr8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

Use the new cs35l56_base struct for utility functions.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 983b0c005b37..c686cbbd7453 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -802,14 +802,14 @@ static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
 };
 
-static void cs35l56_system_reset(struct cs35l56_private *cs35l56, bool is_soundwire)
+static void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
 {
 	/*
 	 * Must enter cache-only first so there can't be any more register
 	 * accesses other than the controlled system reset sequence below.
 	 */
-	regcache_cache_only(cs35l56->base.regmap, true);
-	regmap_multi_reg_write_bypassed(cs35l56->base.regmap,
+	regcache_cache_only(cs35l56_base->regmap, true);
+	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
 					cs35l56_system_reset_seq,
 					ARRAY_SIZE(cs35l56_system_reset_seq));
 
@@ -818,7 +818,7 @@ static void cs35l56_system_reset(struct cs35l56_private *cs35l56, bool is_soundw
 		return;
 
 	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
-	regcache_cache_only(cs35l56->base.regmap, false);
+	regcache_cache_only(cs35l56_base->regmap, false);
 }
 
 static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
@@ -882,7 +882,7 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 	init_completion(&cs35l56->init_completion);
 
 	cs35l56->soft_resetting = true;
-	cs35l56_system_reset(cs35l56, !!cs35l56->sdw_peripheral);
+	cs35l56_system_reset(&cs35l56->base, !!cs35l56->sdw_peripheral);
 
 	if (cs35l56->sdw_peripheral) {
 		/*
@@ -1137,20 +1137,20 @@ int cs35l56_runtime_resume_common(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_runtime_resume_common, SND_SOC_CS35L56_CORE);
 
-static int cs35l56_is_fw_reload_needed(struct cs35l56_private *cs35l56)
+static int cs35l56_is_fw_reload_needed(struct cs35l56_base *cs35l56_base)
 {
 	unsigned int val;
 	int ret;
 
 	/* Nothing to re-patch if we haven't done any patching yet. */
-	if (!cs35l56->base.fw_patched)
+	if (!cs35l56_base->fw_patched)
 		return false;
 
 	/*
 	 * If we have control of RESET we will have asserted it so the firmware
 	 * will need re-patching.
 	 */
-	if (cs35l56->base.reset_gpio)
+	if (cs35l56_base->reset_gpio)
 		return true;
 
 	/*
@@ -1158,22 +1158,22 @@ static int cs35l56_is_fw_reload_needed(struct cs35l56_private *cs35l56)
 	 * can't be used here to test for memory retention.
 	 * Assume that tuning must be re-loaded.
 	 */
-	if (cs35l56->base.secured)
+	if (cs35l56_base->secured)
 		return true;
 
-	ret = pm_runtime_resume_and_get(cs35l56->base.dev);
+	ret = pm_runtime_resume_and_get(cs35l56_base->dev);
 	if (ret) {
-		dev_err(cs35l56->base.dev, "Failed to runtime_get: %d\n", ret);
+		dev_err(cs35l56_base->dev, "Failed to runtime_get: %d\n", ret);
 		return ret;
 	}
 
-	ret = regmap_read(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS, &val);
+	ret = regmap_read(cs35l56_base->regmap, CS35L56_PROTECTION_STATUS, &val);
 	if (ret)
-		dev_err(cs35l56->base.dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
+		dev_err(cs35l56_base->dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
 	else
 		ret = !!(val & CS35L56_FIRMWARE_MISSING);
 
-	pm_runtime_put_autosuspend(cs35l56->base.dev);
+	pm_runtime_put_autosuspend(cs35l56_base->dev);
 
 	return ret;
 }
@@ -1302,7 +1302,7 @@ int cs35l56_system_resume(struct device *dev)
 	if (!cs35l56->component)
 		return 0;
 
-	ret = cs35l56_is_fw_reload_needed(cs35l56);
+	ret = cs35l56_is_fw_reload_needed(&cs35l56->base);
 	dev_dbg(cs35l56->base.dev, "fw_reload_needed: %d\n", ret);
 	if (ret < 1)
 		return ret;
@@ -1547,7 +1547,7 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
 		cs35l56->soft_resetting = true;
-		cs35l56_system_reset(cs35l56, !!cs35l56->sdw_peripheral);
+		cs35l56_system_reset(&cs35l56->base, !!cs35l56->sdw_peripheral);
 		if (cs35l56->sdw_peripheral) {
 			/* Keep alive while we wait for re-enumeration */
 			pm_runtime_get_noresume(cs35l56->base.dev);
-- 
2.30.2

