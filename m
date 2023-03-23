Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E906C5EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjCWFbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjCWFaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:30:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF1D22119
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549448; x=1711085448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZ+6Ux/vWHTp7+2fBxz2s/j5BxjCv70QKxkw1tIhFkw=;
  b=GHsjtBTOxfMgiFv8Yf0JjqlDtNlK4smNm1ct+KsC38fJe0Rv9mcUF8eT
   8qQsV8U9S83HqHqswh29bZPzPrmkdXBEaEMcMCz6La4J/ueT6lvF/gMCe
   +DJQXRRrMoqgjKT8q4x0eoi6Do3SikrRi5l3TY0qtMyXhgUtd6bfOWw1j
   hvLSTIJVnjWY3JN8i9ugu7hrOrIq6nhGnBwWzqoVt9ARfBZIA6dyvv9gl
   GptjFWg1e/hR2Bkl6Fm8uN3rpslnTfOZ/X5pNooaGlOirwJDt9RLBKFdi
   FSYPPlo4b1K5v/cfRJsHQe22MscKHT8alckOmB6VC4bYr1qmt1Xyesszr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779370"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779370"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567055"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567055"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:08 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 08/20] ASoC: SOF: Intel: hda: retrieve SoundWire eml_lock and pass pointer
Date:   Thu, 23 Mar 2023 13:44:40 +0800
Message-Id: <20230323054452.1543233-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
---
 sound/soc/sof/intel/hda.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 22eba57bb3e6..f8cd5a9ebad1 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -215,6 +215,15 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
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

