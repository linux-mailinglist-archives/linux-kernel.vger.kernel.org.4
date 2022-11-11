Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1848625274
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbiKKEZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiKKEZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A8F68AE6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140714; x=1699676714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3/b94c2awslnDKSnAllz+db/ARNE7nM/0mor8r2krA=;
  b=SE42oj66MIIEDHQRRSvopxA5yG1SjN/nWEQjLzTCahK3NZoLpbtt+yZA
   TyGiuj9FRyLXh3w13hDwytrntfq5uzBaJzEshwvHxTNpUuH2YdUk2Jfl7
   Fdm0G6fizIQbDjnqPkE1X3x3YkzVC97lHwmy+8g5gJOgujSnvUQNSEa/4
   6qg8nzL7e474O2y/4SJttRdmZcN4R7HLQahK7bpeEKnAcvcVY8k6U+D+G
   g7PCgItGZdn6zQa6SyAZJ9fmC7K7xUj+q1eoYC+X/kd53pNRHdFrfreCr
   hfyhWaExkkQUWyYR9w3Fe78QSMN7hatmP4XR5VOUPxaQyB5lSLmmjsIAs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816297"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440731"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440731"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:12 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 4/8] ASoC: SOF: Intel: mtl: move SoundWire interrupt enabling to callback
Date:   Fri, 11 Nov 2022 12:26:49 +0800
Message-Id: <20221111042653.45520-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
References: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

There's no real rationale for enabling the SoundWire interrupt in the
init, this can be done from the enable_sdw_irq() callback.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/mtl.c | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 43ffcccec0be..a0839804a6da 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -134,6 +134,31 @@ static void mtl_disable_ipc_interrupts(struct snd_sof_dev *sdev)
 				MTL_DSP_REG_HFIPCXCTL_BUSY | MTL_DSP_REG_HFIPCXCTL_DONE, 0);
 }
 
+static void mtl_enable_sdw_irq(struct snd_sof_dev *sdev, bool enable)
+{
+	u32 hipcie;
+	u32 mask;
+	u32 val;
+	int ret;
+
+	/* Enable/Disable SoundWire interrupt */
+	mask = MTL_DSP_REG_HfSNDWIE_IE_MASK;
+	if (enable)
+		val = mask;
+	else
+		val = 0;
+
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfSNDWIE, mask, val);
+
+	/* check if operation was successful */
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfSNDWIE, hipcie,
+					    (hipcie & mask) == val,
+					    HDA_DSP_REG_POLL_INTERVAL_US, HDA_DSP_RESET_TIMEOUT_US);
+	if (ret < 0)
+		dev_err(sdev->dev, "failed to set SoundWire IPC interrupt %s\n",
+			enable ? "enable" : "disable");
+}
+
 static int mtl_enable_interrupts(struct snd_sof_dev *sdev, bool enable)
 {
 	u32 hfintipptr;
@@ -184,23 +209,6 @@ static int mtl_enable_interrupts(struct snd_sof_dev *sdev, bool enable)
 		return ret;
 	}
 
-	/* Enable/Disable SoundWire interrupt */
-	mask = MTL_DSP_REG_HfSNDWIE_IE_MASK;
-	if (enable)
-		val = mask;
-	else
-		val = 0;
-
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfSNDWIE, mask, val);
-
-	/* check if operation was successful */
-	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfSNDWIE, hipcie,
-					    (hipcie & mask) == val,
-					    HDA_DSP_REG_POLL_INTERVAL_US, HDA_DSP_RESET_TIMEOUT_US);
-	if (ret < 0)
-		dev_err(sdev->dev, "failed to set SoundWire IPC interrupt %s\n",
-			enable ? "enable" : "disable");
-
 	return ret;
 }
 
@@ -568,6 +576,7 @@ static void mtl_ipc_dump(struct snd_sof_dev *sdev)
 
 static int mtl_dsp_disable_interrupts(struct snd_sof_dev *sdev)
 {
+	mtl_enable_sdw_irq(sdev, false);
 	mtl_disable_ipc_interrupts(sdev);
 	return mtl_enable_interrupts(sdev, false);
 }
@@ -645,6 +654,7 @@ const struct sof_intel_dsp_desc mtl_chip_info = {
 	.sdw_shim_base = SDW_SHIM_BASE_ACE,
 	.sdw_alh_base = SDW_ALH_BASE_ACE,
 	.d0i3_offset = MTL_HDA_VS_D0I3C,
+	.enable_sdw_irq = mtl_enable_sdw_irq,
 	.check_sdw_irq = mtl_dsp_check_sdw_irq,
 	.check_ipc_irq = mtl_dsp_check_ipc_irq,
 	.cl_init = mtl_dsp_cl_init,
-- 
2.25.1

