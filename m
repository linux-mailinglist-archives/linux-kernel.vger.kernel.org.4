Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98326E2462
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDNNiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:38:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0059754
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:38:09 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDVEAQ030487;
        Fri, 14 Apr 2023 08:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=t8u5z/+Hl7usp2Usp0dfJ/iSy8mzPELkY06njsmrUxQ=;
 b=Db4OBZORU3ZR0royBcyWFIGhQLKEG81mDsRJwWv3lAY5ciq60QepA9SugYEQwP3bWXae
 dZ1Q68Mue5t5TT7sg9z8D3bYYdwDnWhFpKtq3OpCCqRJUwhK1QY562Oo6oUfaBIir7Kk
 OXCn8bKuO6UErFqCNJqQ0SqTd5r4QRKGSpydyBQ1eb+UQ9LCRG3TqLV4+nizEMIskj4c
 NUwbK+98nguR5nCP7wEyMyUF37aHCI8Zvt58AeSFrSnOz50IY519sci7YIAH2KnApncJ
 zdZzdNa83w3tncU4BcbDBDURT4Ikvtpp3pSnP0150YS0qrHlXoOfl3ZYXdQCwClCABkF LQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pu5p3sexy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:37:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 14 Apr
 2023 08:37:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 14 Apr 2023 08:37:54 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1553545D;
        Fri, 14 Apr 2023 13:37:54 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: cs35l56: Allow a wider range for reset pulse width
Date:   Fri, 14 Apr 2023 14:37:50 +0100
Message-ID: <20230414133753.653139-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230414133753.653139-1-rf@opensource.cirrus.com>
References: <20230414133753.653139-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tVmX-Lr0LKU_2vIpGUHHfiJVPXPJntDH
X-Proofpoint-GUID: tVmX-Lr0LKU_2vIpGUHHfiJVPXPJntDH
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

There is no reason to have such a tight usleep range of 400us and it is
acceptable to allow MIN_US * 2.

Also wrap the usleep in an inline function.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 5ea7f419cda6..d60095162bfa 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -835,6 +835,12 @@ static int cs35l56_wait_for_firmware_boot(struct cs35l56_private *cs35l56)
 	return 0;
 }
 
+static inline void cs35l56_wait_min_reset_pulse(void)
+{
+	/* Satisfy minimum reset pulse width spec */
+	usleep_range(CS35L56_RESET_PULSE_MIN_US, 2 * CS35L56_RESET_PULSE_MIN_US);
+}
+
 static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
 };
@@ -1236,7 +1242,7 @@ int cs35l56_system_suspend_late(struct device *dev)
 	 */
 	if (cs35l56->reset_gpio) {
 		gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
-		usleep_range(CS35L56_RESET_PULSE_MIN_US, CS35L56_RESET_PULSE_MIN_US + 400);
+		cs35l56_wait_min_reset_pulse();
 	}
 
 	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
@@ -1289,7 +1295,7 @@ int cs35l56_system_resume_early(struct device *dev)
 	/* Ensure a spec-compliant RESET pulse. */
 	if (cs35l56->reset_gpio) {
 		gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
-		usleep_range(CS35L56_RESET_PULSE_MIN_US, CS35L56_RESET_PULSE_MIN_US + 400);
+		cs35l56_wait_min_reset_pulse();
 	}
 
 	/* Enable supplies before releasing RESET. */
@@ -1440,9 +1446,7 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 		return dev_err_probe(cs35l56->dev, ret, "Failed to enable supplies\n");
 
 	if (cs35l56->reset_gpio) {
-		/* satisfy minimum reset pulse width spec */
-		usleep_range(CS35L56_RESET_PULSE_MIN_US,
-			     CS35L56_RESET_PULSE_MIN_US + 400);
+		cs35l56_wait_min_reset_pulse();
 		gpiod_set_value_cansleep(cs35l56->reset_gpio, 1);
 	}
 
-- 
2.30.2

