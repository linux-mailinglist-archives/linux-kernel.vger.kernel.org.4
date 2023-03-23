Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F26C5EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCWFbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCWFbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:31:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226F12FCDD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549457; x=1711085457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kjKTx32w9YdnZJ7K83qEoOALY8hrbkCtcZcfoAY0U2Q=;
  b=k9obHCSBJGVTlbzQTWH+z6BQ9SfmfuOtE7sODlUer8Z2DdgGMWg+VXJg
   ijJUK2D9n9CUNiQ1590qmuHTnvDZe84z6VHMdNUfbaeNHDRg/NWIEAHTL
   sQmWtF2F2iGskjt4UICebzY/lmfrQox80bK1e5rUGbs2xtrTFYBLNZ4yt
   VSy8Kvm2Rlq0luPLR9cdFBdl049Ns43TVXw0+da8lerU+Bjdh/5dphQzs
   D4zJ0Q33UyEltxEAPBvpb53EhsKImkoJIvvAJ1ylCOMzcnbBDD/pVjIsk
   dECT0NtYGPJ5zb0locTRtTiC/78FQ7mPF7qpa5mECQHZtFGLO8q4ukmp4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779434"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779434"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567149"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567149"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:21 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 13/20] soundwire: intel_ace2x: configure link PHY
Date:   Thu, 23 Mar 2023 13:44:45 +0800
Message-Id: <20230323054452.1543233-14-yung-chuan.liao@linux.intel.com>
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

