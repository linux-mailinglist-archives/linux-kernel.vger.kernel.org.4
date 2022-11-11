Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D6625271
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiKKEZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiKKEZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F36682B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140712; x=1699676712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jQVaKECLBwC0Ma03GPKt8XL3ZiTN4gAh61cT+UBkClk=;
  b=PQjuOb4xrQr3EdPW7K2qMa5jmkYl0dpfLUbnXl683tYGFV8hZeU75zDb
   Afqzzl7zafYN25iNNnGa1uwzQ6jnWMsoSOFJZlGZvqn5PCmBCl5CxatGy
   qtfjUMm+/ZqEh3aGYlTdhUK2DaN/4HZtFYNjdyua6v+a2CcYc6LyClqo7
   WeAR+bmf6siLuDLhoxf3tyFXmzdbTcO4jMTqYKqeVIS+aO2SlIPVNy5ZD
   FhqQIGswNAlSt1cFWCdNGqw5JZ3wp9qJRVa2jGtvja/opYL7yryBEcfwj
   jN61ZOxRW4vmWFMPoAC3pPul7Jthad8FV9E8H6KaRLOGN1Ddkcy/SVZin
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816286"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816286"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440713"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440713"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:09 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 3/8] ASoC: SOF: Intel: mtl: factor interrupt enable/disable interrupt functions
Date:   Fri, 11 Nov 2022 12:26:48 +0800
Message-Id: <20221111042653.45520-4-yung-chuan.liao@linux.intel.com>
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

The offsets and sequences are identical for interrupt enabling and
disabling, we can refactor the code with a single routine and a
boolean.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/mtl.c | 120 +++++++++++++-------------------------
 1 file changed, 40 insertions(+), 80 deletions(-)

diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 7452a7dbb0e4..43ffcccec0be 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -134,112 +134,72 @@ static void mtl_disable_ipc_interrupts(struct snd_sof_dev *sdev)
 				MTL_DSP_REG_HFIPCXCTL_BUSY | MTL_DSP_REG_HFIPCXCTL_DONE, 0);
 }
 
-static int mtl_enable_interrupts(struct snd_sof_dev *sdev)
+static int mtl_enable_interrupts(struct snd_sof_dev *sdev, bool enable)
 {
 	u32 hfintipptr;
 	u32 irqinten;
-	u32 host_ipc;
 	u32 hipcie;
+	u32 mask;
+	u32 val;
 	int ret;
 
 	/* read Interrupt IP Pointer */
 	hfintipptr = snd_sof_dsp_read(sdev, HDA_DSP_BAR, MTL_HFINTIPPTR) & MTL_HFINTIPPTR_PTR_MASK;
 
-	/* Enable Host IPC and SOUNDWIRE */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, hfintipptr,
-				MTL_IRQ_INTEN_L_HOST_IPC_MASK | MTL_IRQ_INTEN_L_SOUNDWIRE_MASK,
-				MTL_IRQ_INTEN_L_HOST_IPC_MASK | MTL_IRQ_INTEN_L_SOUNDWIRE_MASK);
+	/* Enable/Disable Host IPC and SOUNDWIRE */
+	mask = MTL_IRQ_INTEN_L_HOST_IPC_MASK | MTL_IRQ_INTEN_L_SOUNDWIRE_MASK;
+	if (enable)
+		val = mask;
+	else
+		val = 0;
+
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, hfintipptr, mask, val);
 
 	/* check if operation was successful */
-	host_ipc = MTL_IRQ_INTEN_L_HOST_IPC_MASK | MTL_IRQ_INTEN_L_SOUNDWIRE_MASK;
 	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, hfintipptr, irqinten,
-					    (irqinten & host_ipc) == host_ipc,
+					    (irqinten & mask) == val,
 					    HDA_DSP_REG_POLL_INTERVAL_US, HDA_DSP_RESET_TIMEOUT_US);
 	if (ret < 0) {
-		dev_err(sdev->dev, "failed to enable Host IPC and/or SOUNDWIRE\n");
+		dev_err(sdev->dev, "failed to %s Host IPC and/or SOUNDWIRE\n",
+			enable ? "enable" : "disable");
 		return ret;
 	}
 
-	/* Set Host IPC interrupt enable */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfHIPCIE,
-				MTL_DSP_REG_HfHIPCIE_IE_MASK, MTL_DSP_REG_HfHIPCIE_IE_MASK);
+	/* Enable/Disable Host IPC interrupt*/
+	mask = MTL_DSP_REG_HfHIPCIE_IE_MASK;
+	if (enable)
+		val = mask;
+	else
+		val = 0;
+
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfHIPCIE, mask, val);
 
 	/* check if operation was successful */
-	host_ipc = MTL_DSP_REG_HfHIPCIE_IE_MASK;
 	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfHIPCIE, hipcie,
-					    (hipcie & host_ipc) == host_ipc,
+					    (hipcie & mask) == val,
 					    HDA_DSP_REG_POLL_INTERVAL_US, HDA_DSP_RESET_TIMEOUT_US);
 	if (ret < 0) {
-		dev_err(sdev->dev, "failed to set Host IPC interrupt enable\n");
+		dev_err(sdev->dev, "failed to set Host IPC interrupt %s\n",
+			enable ? "enable" : "disable");
 		return ret;
 	}
 
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfSNDWIE,
-				MTL_DSP_REG_HfSNDWIE_IE_MASK, MTL_DSP_REG_HfSNDWIE_IE_MASK);
-	host_ipc = MTL_DSP_REG_HfSNDWIE_IE_MASK;
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
 	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfSNDWIE, hipcie,
-					    (hipcie & host_ipc) == host_ipc,
+					    (hipcie & mask) == val,
 					    HDA_DSP_REG_POLL_INTERVAL_US, HDA_DSP_RESET_TIMEOUT_US);
 	if (ret < 0)
-		dev_err(sdev->dev, "failed to set SoundWire IPC interrupt enable\n");
-
-	return ret;
-}
-
-static int mtl_disable_interrupts(struct snd_sof_dev *sdev)
-{
-	u32 hfintipptr;
-	u32 irqinten;
-	u32 host_ipc;
-	u32 hipcie;
-	int ret1;
-	int ret;
-
-	/* read Interrupt IP Pointer */
-	hfintipptr = snd_sof_dsp_read(sdev, HDA_DSP_BAR, MTL_HFINTIPPTR) & MTL_HFINTIPPTR_PTR_MASK;
-
-	/* Disable Host IPC and SOUNDWIRE */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, hfintipptr,
-				MTL_IRQ_INTEN_L_HOST_IPC_MASK | MTL_IRQ_INTEN_L_SOUNDWIRE_MASK, 0);
-
-	/* check if operation was successful */
-	host_ipc = MTL_IRQ_INTEN_L_HOST_IPC_MASK | MTL_IRQ_INTEN_L_SOUNDWIRE_MASK;
-	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, hfintipptr, irqinten,
-					    (irqinten & host_ipc) == 0,
-					    HDA_DSP_REG_POLL_INTERVAL_US, HDA_DSP_RESET_TIMEOUT_US);
-	/* Continue to disable other interrupts when error happens */
-	if (ret < 0)
-		dev_err(sdev->dev, "failed to disable Host IPC and SoundWire\n");
-
-	/* Set Host IPC interrupt disable */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfHIPCIE,
-				MTL_DSP_REG_HfHIPCIE_IE_MASK, 0);
-
-	/* check if operation was successful */
-	host_ipc = MTL_DSP_REG_HfHIPCIE_IE_MASK;
-	ret1 = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfHIPCIE, hipcie,
-					     (hipcie & host_ipc) == 0,
-					     HDA_DSP_REG_POLL_INTERVAL_US,
-					     HDA_DSP_RESET_TIMEOUT_US);
-	if (ret1 < 0) {
-		dev_err(sdev->dev, "failed to set Host IPC interrupt disable\n");
-		if (!ret)
-			ret = ret1;
-	}
-
-	/* Set SoundWire IPC interrupt disable */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfSNDWIE,
-				MTL_DSP_REG_HfSNDWIE_IE_MASK, 0);
-	host_ipc = MTL_DSP_REG_HfSNDWIE_IE_MASK;
-	ret1 = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, MTL_DSP_REG_HfSNDWIE, hipcie,
-					     (hipcie & host_ipc) == 0,
-					     HDA_DSP_REG_POLL_INTERVAL_US,
-					     HDA_DSP_RESET_TIMEOUT_US);
-	if (ret1 < 0) {
-		dev_err(sdev->dev, "failed to set SoundWire IPC interrupt disable\n");
-		if (!ret)
-			ret = ret1;
-	}
+		dev_err(sdev->dev, "failed to set SoundWire IPC interrupt %s\n",
+			enable ? "enable" : "disable");
 
 	return ret;
 }
@@ -473,7 +433,7 @@ static int mtl_dsp_cl_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_bo
 				       chip->ipc_ack_mask);
 
 	/* step 4: enable interrupts */
-	ret = mtl_enable_interrupts(sdev);
+	ret = mtl_enable_interrupts(sdev, true);
 	if (ret < 0) {
 		if (hda->boot_iteration == HDA_FW_BOOT_ATTEMPTS)
 			dev_err(sdev->dev, "%s: failed to enable interrupts\n", __func__);
@@ -609,7 +569,7 @@ static void mtl_ipc_dump(struct snd_sof_dev *sdev)
 static int mtl_dsp_disable_interrupts(struct snd_sof_dev *sdev)
 {
 	mtl_disable_ipc_interrupts(sdev);
-	return mtl_disable_interrupts(sdev);
+	return mtl_enable_interrupts(sdev, false);
 }
 
 /* Meteorlake ops */
-- 
2.25.1

