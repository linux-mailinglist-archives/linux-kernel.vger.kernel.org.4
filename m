Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BD625279
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiKKE0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiKKEZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:25:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DCF69DFD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668140724; x=1699676724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0rMVWGRMLBg4bFMV6J3jYFGlZ2aidsgYINzFQt3VnEY=;
  b=EHFg45A/reSh2vcmlC14SWfKui11xwqqFx4I/V0OjwUngSD76ntQV5T3
   UA+28OR6wtipZHwF4CdAhoRFFDrGNdLHp7SxvmburRTbmS2ttZ9Aepy+g
   Yp07qWDyp8M18uahwwArP0LSOIXG69+g8dqQZ+cK9FmH9DD6cKkt4PMjv
   u8Sqlazyppne1NsS9xSBTugbHRvJ733VSDa+x41XSz23XSFuiaUqWd5vv
   aPnK/ygGUqfee/Ox2VSRd5TOcWURzhKjW3tYn9Q1NaDfSnY0aXtnbgAwB
   y+rXmi58KiSTy2m5M7JwopJHGNDsbQ9m04tAO76KX3RVlrB0e/0bpePSt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397816327"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397816327"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="588440803"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="588440803"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 20:25:21 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 8/8] ASoC: SOF: Intel: hda: read multi-link capabilities earlier
Date:   Fri, 11 Nov 2022 12:26:53 +0800
Message-Id: <20221111042653.45520-9-yung-chuan.liao@linux.intel.com>
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

There's no reason to delay the multi-link parsing, this can be done
earlier before checking the SoundWire capabilities.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 2f9d69e64091..14a2f8701350 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -944,6 +944,8 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
+	hda_bus_ml_get_capabilities(bus);
+
 	/* scan SoundWire capabilities exposed by DSDT */
 	ret = hda_sdw_acpi_scan(sdev);
 	if (ret < 0) {
@@ -972,8 +974,6 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 
 skip_soundwire:
 
-	hda_bus_ml_get_capabilities(bus);
-
 	/* create codec instances */
 	hda_codec_probe_bus(sdev);
 
-- 
2.25.1

