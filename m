Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4488A702555
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbjEOGvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbjEOGu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DAB2D45
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133443; x=1715669443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQ5bs2pm3yyJqyCctssYUsybKhCJPd02FInwiNQFhys=;
  b=Ku+Jk3cpmKBW7YdsC390nU5nJxA1iLNaMF4K1Als9La6rR18PGOCJdDV
   qpGK3keqMzWf3GV2emWwhGArEy6p8mJ2vb5a5NTI/TbOdUH+jB9JlRiip
   aifLn5KFLtR0ZpkOXEmmNArxgRgOWCKt6cMcI95cABBjrDc8KZv01hjr4
   6M3wjnkY6YOx+5FviQp1GT1BaXFGCrimHD0IPpflouuIC1F9LO5zUXWsP
   j+8Cej99ncBQFO4Z9tTSILX9G39Lh/ulOQ+r+ZUQNA7C3OXnnNwp0V506
   DIuN1qsRwVeKAZw1Np7x0eNteyd9u4m2ZbFk81DFse76G5BeLst+hyoZF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966344"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966344"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908651"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908651"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:38 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 08/26] ASoC: SOF: Intel: hda: retrieve SoundWire eml_lock and pass pointer
Date:   Mon, 15 May 2023 15:10:24 +0800
Message-Id: <20230515071042.2038-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use new helper and interface to make sure the HDaudio and SoundWire
parts use the same mutex when accessing shared registers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 4d48f4018617..388e41057172 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -175,6 +175,15 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 		res.alh_base = hdev->desc->sdw_alh_base;
 		res.ext = false;
 	} else {
+		/*
+		 * retrieve eml_lock needed to protect shared registers
+		 * in the HDaudio multi-link areas
+		 */
+		res.eml_lock = hdac_bus_eml_get_mutex(sof_to_bus(sdev), true,
+						      AZX_REG_ML_LEPTR_ID_SDW);
+		if (!res.eml_lock)
+			return -ENODEV;
+
 		res.mmio_base = sdev->bar[HDA_DSP_HDA_BAR];
 		/*
 		 * the SHIM and SoundWire register offsets are link-specific
-- 
2.25.1

