Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E447B6DDF92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjDKPZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjDKPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:25:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614849D9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:25:36 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B5cuXG012801;
        Tue, 11 Apr 2023 10:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=T8BVSKckGSd2SY73ZmiypxT7jbER0HYHV1vJLiq4DUI=;
 b=BJ/NG0t538sx9JwGhvu/pnvZPy+x6C55fwIg+Fq2rh+riD50LfFcThKKgMLnxfaH5FY1
 IFPOaie4njQDVVJUwrw6TxRztS20fOQ0Eycdn5UhjXLF6aN9IcbsT5Z3yXpurtw/DsQ1
 z4+5utB0tllIZGmjmLCLy0qjpUhTtfM3rz8AZeHt23zYW2B5RUkg32ogLJ+0P7HwdxV0
 T1bFmUhAFFN7kmD/xj+hrmzK+h5yRFeLCgU1ahZB5cWLDn9u0FhYTZVJpwhj/QPw4Nez
 iEHU8ER3Mr8wJUzH6iCe9HzOp60nvAHdD57woCKPieKHeqtoapVoQT0bfXhpFGwA5WtW Gg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq54a3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:25:30 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 11 Apr
 2023 10:25:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 11 Apr 2023 10:25:28 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4FDCA11D4;
        Tue, 11 Apr 2023 15:25:28 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/6] ASoC: cs35l56: Remove quick-cancelling of dsp_work()
Date:   Tue, 11 Apr 2023 16:25:23 +0100
Message-ID: <20230411152528.329803-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230411152528.329803-1-rf@opensource.cirrus.com>
References: <20230411152528.329803-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6S6RnWsp7emdfxw5wLA202O-f7qRP2uu
X-Proofpoint-ORIG-GUID: 6S6RnWsp7emdfxw5wLA202O-f7qRP2uu
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the 'removing' flag and don't kick init_completion to make a
quick cancel of dsp_work(). Just let it timeout on the wait for the
completion.

Simplify the code to standard cancelling or flushing of the work.
This avoids introducing corner cases from a layer of custom signalling.
It also avoids potential race conditions when system-suspend handling
is added.

Unless the hardware is broken, the dsp_work() will already have started
and passed the completion before the driver would want to cancel it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 8 +-------
 sound/soc/codecs/cs35l56.h | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index d97b465f0d3c..675aad8e909f 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -867,7 +867,7 @@ static void cs35l56_dsp_work(struct work_struct *work)
 		goto complete;
 	}
 
-	if (!cs35l56->init_done || cs35l56->removing)
+	if (!cs35l56->init_done)
 		goto complete;
 
 	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
@@ -917,9 +917,6 @@ static void cs35l56_dsp_work(struct work_struct *work)
 		goto err;
 	}
 
-	if (cs35l56->removing)
-		goto err;
-
 	mutex_lock(&cs35l56->irq_lock);
 
 	init_completion(&cs35l56->init_completion);
@@ -967,7 +964,6 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 
 	BUILD_BUG_ON(ARRAY_SIZE(cs35l56_tx_input_texts) != ARRAY_SIZE(cs35l56_tx_input_values));
 
-	cs35l56->removing = false;
 	cs35l56->component = component;
 	wm_adsp2_component_probe(&cs35l56->dsp, component);
 
@@ -984,8 +980,6 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 {
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
 
-	cs35l56->removing = true;
-	complete(&cs35l56->init_completion);
 	cancel_work_sync(&cs35l56->dsp_work);
 }
 
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index efc4b99180f9..dc91cd7d877f 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -49,7 +49,6 @@ struct cs35l56_private {
 	bool soft_resetting;
 	bool init_done;
 	bool sdw_attached;
-	bool removing;
 	bool fw_patched;
 	bool can_hibernate;
 	struct completion init_completion;
-- 
2.30.2

