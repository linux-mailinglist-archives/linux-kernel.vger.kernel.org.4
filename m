Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1275B64D801
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLOIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLOItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:49:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DCB2C679
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671094161; x=1702630161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xb6HAMTOE8XGB+he/8crvLmIoKFamiSOnJ54h1Bx0Vg=;
  b=kqsGuQJhe/RQNhgnTxLn1446RoK2TMLkvc7D1CBJkh2SVmY+rRxPHxB6
   OgfSBbfkAljnn324yvdpekD+AaJiFj305NCtxzcZW2Idw3Ij9NXEzxcLq
   BfctbE92Kn8sOGUG5NwKzY19e8Akd7WpSBVqqYfP2ayydPsPxCFehL1WJ
   8fzi+2WM4ZmgDhB0k+2TljsLKaf8U0HM9FsF951/I9yTdp23UHKRYi8Rk
   paAFMFhfStO4dAu8ZzpEwxWp4b25mvhYsqvtcZdUgElRmZVARIEUf2k7h
   /KP+BGVDoAH9O/TL6g79WxjqZr5M9qvQvcmAwvCk3WxQ5S3kjqkLuQjvM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="345712034"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="345712034"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 00:49:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="627091306"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="627091306"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 00:49:18 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: intel: remove DAI startup/shutdown
Date:   Thu, 15 Dec 2022 16:54:36 +0800
Message-Id: <20221215085436.2001568-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The only thing these DAI startup/shutdown callbacks do is play with
pm_runtime reference counts.

This is not wrong, but it's not necessary at all. At the ASoC core level,
only the component matters for pm_runtime. The ASoC core already calls
pm_runtime_get_sync() in snd_soc_pcm_component_pm_runtime_get(),
before the DAI startup callback is invoked.

None of the SoundWire codec drivers rely on pm_runtime helpers in
their DAI startup/shutdown either. This adds to the evidence that only
the component, or more precisely the device specified when registering
a component, should deal with pm_runtime transitions.

Beyond the code cleanup, this move prepares for the addition of link
power management in the auxiliary device startup/resume/suspend
callbacks. The DAI callbacks can by-design assume that the device is
already pm_runtime active.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index bc9c50bacc49..2651767272c7 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -778,22 +778,6 @@ static int intel_post_bank_switch(struct sdw_intel *sdw)
  * DAI routines
  */
 
-static int intel_startup(struct snd_pcm_substream *substream,
-			 struct snd_soc_dai *dai)
-{
-	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	ret = pm_runtime_resume_and_get(cdns->dev);
-	if (ret < 0 && ret != -EACCES) {
-		dev_err_ratelimited(cdns->dev,
-				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
-				    __func__, ret);
-		return ret;
-	}
-	return 0;
-}
-
 static int intel_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -954,15 +938,6 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	return 0;
 }
 
-static void intel_shutdown(struct snd_pcm_substream *substream,
-			   struct snd_soc_dai *dai)
-{
-	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
-
-	pm_runtime_mark_last_busy(cdns->dev);
-	pm_runtime_put_autosuspend(cdns->dev);
-}
-
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 				    void *stream, int direction)
 {
@@ -1088,12 +1063,10 @@ static int intel_component_dais_suspend(struct snd_soc_component *component)
 }
 
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
-	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
 	.trigger = intel_trigger,
-	.shutdown = intel_shutdown,
 	.set_stream = intel_pcm_set_sdw_stream,
 	.get_stream = intel_get_sdw_stream,
 };
-- 
2.25.1

