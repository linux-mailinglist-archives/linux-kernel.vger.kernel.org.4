Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EBC6C27E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCUCLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCUCLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:11:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E923608D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679364708; x=1710900708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gC9u9R+eER52MkKmLB/PDhyl14IPCemBeV7g5a5ZfwY=;
  b=QfydbEeaNTJf09fbnIi5s0OK15v5n2lAY9yRNgCTVK+tqJl+DsXNIjed
   E1QX9dOLlO3+tCA26ocAfF5qrFno294VBx0Vr8puHZKhzAzXfJduXG37x
   wgRavE28q5ShrxeqleLrkKx8JZLo79FtSIq6I0QOhxuHM6Wkh1QT776gQ
   CDac+Y+gOSrjNe/fovq50QyqLjKa5uZS19x2a4TaMMIQGGl4MUEQnVtFm
   noQnY1PeTVvhwVsmNJISoNyoSRxSEOiBgETKjXYjDaUDwOvfLV+noj4J+
   YZiW5GlSMjcHM4CFKbeffV5alKOC8D+6DuWtmxQ2h3j8KA6qmGrtSHsBc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="319224682"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="319224682"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 19:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674648777"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="674648777"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 19:11:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: intel: don't save hw_params for use in prepare
Date:   Tue, 21 Mar 2023 10:26:42 +0800
Message-Id: <20230321022642.1426611-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing code copies the hw_params pointer and reuses it later in
.prepare, specifically to re-initialize the ALH DMA channel
information that's lost in suspend-resume cycles.

This is not needed, we can directly access the information from the
substream/rtd - as done for the HDAudio DAIs in
sound/soc/sof/intel/hda-dai.c

In addition, using the saved pointer causes the suspend-resume test
cases to fail on specific platforms, depending on which version of GCC
is used. Péter Ujfalusi and I have spent long hours to root-cause this
problem that was reported by the Intel CI first with 6.2-rc1 and again
v6.3-rc1. In the latter case we were lucky that the problem was 100%
reproducible on local test devices, and found out that adding a
dev_dbg() or adding a call to usleep_range() just before accessing the
saved pointer "fixed" the issue. With errors appearing just by
changing the compiler version or minor changes in the code generated,
clearly we have a memory management Heisenbug.

The root-cause seems to be that the hw_params pointer is not
persistent. The soc-pcm code allocates the hw_params structure on the
stack, and passes it to the BE dailink hw_params and DAIs
hw_params. Saving such a pointer and reusing it later during the
.prepare stage cannot possibly work reliably, it's broken-by-design
since v5.10. It's astonishing that the problem was not seen earlier.

This simple fix will have to be back-ported to -stable, due to changes
to avoid the use of the get/set_dmadata routines this patch will only
apply on kernels older than v6.1.

Fixes: a5a0239c27fe ("soundwire: intel: reinitialize IP+DSP in .prepare(), but only when resuming")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.h |  2 --
 drivers/soundwire/intel.c          | 11 +++++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index b653734085d9..27c56274217f 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -84,7 +84,6 @@ struct sdw_cdns_stream_config {
  * @bus: Bus handle
  * @stream_type: Stream type
  * @link_id: Master link id
- * @hw_params: hw_params to be applied in .prepare step
  * @suspended: status set when suspended, to be used in .prepare
  * @paused: status set in .trigger, to be used in suspend
  * @direction: stream direction
@@ -96,7 +95,6 @@ struct sdw_cdns_dai_runtime {
 	struct sdw_bus *bus;
 	enum sdw_stream_type stream_type;
 	int link_id;
-	struct snd_pcm_hw_params *hw_params;
 	bool suspended;
 	bool paused;
 	int direction;
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 046c67a2a39b..238acf5c97a9 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -725,7 +725,6 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	dai_runtime->paused = false;
 	dai_runtime->suspended = false;
 	dai_runtime->pdi = pdi;
-	dai_runtime->hw_params = params;
 
 	/* Inform DSP about PDI stream number */
 	ret = intel_params_stream(sdw, substream->stream, dai, params,
@@ -778,6 +777,11 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 	}
 
 	if (dai_runtime->suspended) {
+		struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+		struct snd_pcm_hw_params *hw_params;
+
+		hw_params = &rtd->dpcm[substream->stream].hw_params;
+
 		dai_runtime->suspended = false;
 
 		/*
@@ -789,7 +793,7 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		 */
 
 		/* configure stream */
-		ch = params_channels(dai_runtime->hw_params);
+		ch = params_channels(hw_params);
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			dir = SDW_DATA_DIR_RX;
 		else
@@ -801,7 +805,7 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 
 		/* Inform DSP about PDI stream number */
 		ret = intel_params_stream(sdw, substream->stream, dai,
-					  dai_runtime->hw_params,
+					  hw_params,
 					  sdw->instance,
 					  dai_runtime->pdi->intel_alh_id);
 	}
@@ -840,7 +844,6 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
-	dai_runtime->hw_params = NULL;
 	dai_runtime->pdi = NULL;
 
 	return 0;
-- 
2.25.1

