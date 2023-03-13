Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC346B7C66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjCMPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCMPuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:50:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE4F763E7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:50:28 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DEPFBn004637;
        Mon, 13 Mar 2023 10:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=AhHzewF/a8Pi4XOIK3HkeTNQoW8FqMDSxy5e171h1ek=;
 b=dqkpB8X1Wo6zn1mLUTy7fLBs+6ijay8B4e+fKmG/fiwrWnIj/i3XCNTstbILjTPVMafY
 u8r6HopAG4oE09/G3f2tOrUNzAL4B5XS8TnUE8n4K4tK71N/1ObQJ4gX/fM+czwblO/s
 dFcHUgyaCdtAgrJQ0yTU9Qj0bToB2+zoHDQCC5f6kwhuPDrRCPcJb7n337kkboBwfOHT
 UKigaEL77EDOMS8TvA/Bu/jktAr93Qfzc3rHNF3GBMCzfMUcv1NZiS7zxJQs3mIX779o
 YCArcLmxH3aX1eu8lbqb5lpw2UtTXSbMsNKc2IcCsSdA01M5goqpoOd+M3yaeLCdLhXH WQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3p8qx7b4rb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 10:50:07 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 13 Mar
 2023 10:50:05 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 13 Mar 2023 10:50:05 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D1A7211D3;
        Mon, 13 Mar 2023 15:50:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/8] ASoC: wm_adsp: Use no_core_startstop to prevent creating preload control
Date:   Mon, 13 Mar 2023 15:49:49 +0000
Message-ID: <20230313154955.4268-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230313154955.4268-1-rf@opensource.cirrus.com>
References: <20230313154955.4268-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UI5cGHs6ms_EQ-X2G15xEwfmiFknDCXC
X-Proofpoint-GUID: UI5cGHs6ms_EQ-X2G15xEwfmiFknDCXC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

The no_core_startstop flag indicates a self-booting DSP - they are
considered to be always running and therefore cannot be pre-loaded.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ea0dbc634ecf..854d9366a745 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1102,8 +1102,10 @@ int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *comp
 {
 	char preload[32];
 
-	snprintf(preload, ARRAY_SIZE(preload), "%s Preload", dsp->cs_dsp.name);
-	snd_soc_component_disable_pin(component, preload);
+	if (!dsp->cs_dsp.no_core_startstop) {
+		snprintf(preload, ARRAY_SIZE(preload), "%s Preload", dsp->cs_dsp.name);
+		snd_soc_component_disable_pin(component, preload);
+	}
 
 	cs_dsp_init_debugfs(&dsp->cs_dsp, component->debugfs_root);
 
-- 
2.30.2

