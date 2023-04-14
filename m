Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66E66E2460
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDNNiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDNNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:38:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C077F974A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:38:09 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDVEAN030487;
        Fri, 14 Apr 2023 08:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=7gWw1wI279l2ZxLB9kgWhkWGYVSRpnbe3cKYUZSpoXU=;
 b=hwflGKFoKgBBQnGgM9Prz1091tFcItqpYJNYZ+ZgbE8EjI5XSBB4sXlk/H71nE8a6XbU
 fdSLLXBzM+SH9Vn5+QNqEUIM9sYFo38kWyuKacjb5uKCVtZOrLNoDlAwOWxLAAQyO2KZ
 u+VUBsHsqyAituB49wtvkSyvnPC6nM7Jk+98bfvyOPZqE6vk1QoV/x3OpyjrOg/gg3wO
 kxwciLPb3doRKPbMlC73x3I+b2QHqVGS5sa/0q5d+k0N5lgBzSjwcJQ0aaC8oU/srojh
 IZwJRC6q1PvQ0TOvSin8SXJemRZycwST3uaffT9ZsPa+sycAn4OoUOz3RJVp+VaEFdaW rw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pu5p3sey0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:37:56 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 14 Apr
 2023 08:37:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 14 Apr 2023 08:37:54 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2351215B7;
        Fri, 14 Apr 2023 13:37:54 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/5] ASoC: cs35l56: Wait for init_complete in cs35l56_component_probe()
Date:   Fri, 14 Apr 2023 14:37:51 +0100
Message-ID: <20230414133753.653139-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230414133753.653139-1-rf@opensource.cirrus.com>
References: <20230414133753.653139-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 00VgaRfa195lReYP9EswcAtyWOtyZPYG
X-Proofpoint-GUID: 00VgaRfa195lReYP9EswcAtyWOtyZPYG
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

Moving the wait from the beginning of the cs35l56_dsp_work() into
cs35l56_component_probe() will prevent the limbo situation that is an
artifact of the two stage SoundWire driver probe and initialisation
where the card is all registered and shows in ALSA but doesn't actually
work because the hardware didn't enumerate.

The other bus drivers perform the probe and init sequentially and are
not susceptible to this issue.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index d60095162bfa..ab2e663af6c2 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -875,13 +875,6 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	unsigned int val;
 	int ret = 0;
 
-	if (!cs35l56->init_done &&
-	    !wait_for_completion_timeout(&cs35l56->init_completion,
-					 msecs_to_jiffies(5000))) {
-		dev_err(cs35l56->dev, "%s: init_completion timed out\n", __func__);
-		goto complete;
-	}
-
 	if (!cs35l56->init_done)
 		goto complete;
 
@@ -980,6 +973,12 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 
 	BUILD_BUG_ON(ARRAY_SIZE(cs35l56_tx_input_texts) != ARRAY_SIZE(cs35l56_tx_input_values));
 
+	if (!wait_for_completion_timeout(&cs35l56->init_completion,
+					 msecs_to_jiffies(5000))) {
+		dev_err(cs35l56->dev, "%s: init_completion timed out\n", __func__);
+		return -ENODEV;
+	}
+
 	cs35l56->component = component;
 	wm_adsp2_component_probe(&cs35l56->dsp, component);
 
-- 
2.30.2

