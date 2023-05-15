Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C370255E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbjEOGwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjEOGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:51:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D05826A0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133479; x=1715669479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kjKTx32w9YdnZJ7K83qEoOALY8hrbkCtcZcfoAY0U2Q=;
  b=XOoAOqhASP1RI3fzose7GyGXWxHigv1+KNYVl6Q8/c7BR7ePF2dnbJHl
   ySW1+Y8++rLTUsudUdTj8xRj6PmboT+KuDOZS6Swq0arFv8kJD5j/uewC
   IBDdYMv1/REb69pLfjqOMeiG2K42Of94xvqMGsJHMqRHAXWe+HV81gYoB
   QrZtK3S4xXCchER7OK/bJ2l8eR6y44djpt+Q3LdfX6bUdLehHMiwqN4zo
   eI/Cf1vMXzlBiUqa/3KEXuWYnO8WSxeuAIfMujymvMcLkoH2nOOKIPa4u
   Utt/EUkNDFFnD7vNjgtFOyGXX7bnS4f4AUMK0kpKCWBgQanyueOi+JkTU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966408"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908716"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908716"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:49 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 13/26] soundwire: intel_ace2x: configure link PHY
Date:   Mon, 15 May 2023 15:10:29 +0800
Message-Id: <20230515071042.2038-14-yung-chuan.liao@linux.intel.com>
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

Unlike previous hardware generations, the glue-to-master transition is
not managed by software, instead the transitions are managed as part
of the power-up/down sequences controlled by SPA/CPA bits.

The only thing that's required is to configure the link PHY for
'normal' operation instead of the PHY test mode.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 01668246b7ba..5deff32976f1 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -15,6 +15,22 @@
 #include "bus.h"
 #include "intel.h"
 
+/*
+ * shim vendor-specific (vs) ops
+ */
+
+static void intel_shim_vs_init(struct sdw_intel *sdw)
+{
+	void __iomem *shim_vs = sdw->link_res->shim_vs;
+	u16 act = 0;
+
+	u16p_replace_bits(&act, 0x1, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
+	act |= SDW_SHIM2_INTEL_VS_ACTMCTL_DACTQE;
+	act |=  SDW_SHIM2_INTEL_VS_ACTMCTL_DODS;
+	intel_writew(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL, act);
+	usleep_range(10, 15);
+}
+
 static int intel_link_power_up(struct sdw_intel *sdw)
 {
 	struct sdw_bus *bus = &sdw->cdns.bus;
@@ -63,6 +79,9 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	*shim_mask |= BIT(link_id);
 
 	sdw->cdns.link_up = true;
+
+	intel_shim_vs_init(sdw);
+
 out:
 	mutex_unlock(sdw->link_res->shim_lock);
 
-- 
2.25.1

