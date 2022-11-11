Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C208862500A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiKKCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiKKCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:14:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450695F869
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668132888; x=1699668888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sFoTlN5v6r79HUZxzN2vBniRQPFO0vULAV0J7b3pGgI=;
  b=HgCujtDRi1KASZ39QOgVbhkssjADeA/a46bwfFgtv8vGnugFMAuBJPEB
   /IV5rDOJQWjBJAxlc8z0Ym020BkoshXk61iHB9v7J4Ak+2edWLObLikdi
   N60qe1DJAtvQxonxE9V7znZNnJ1y5ho0A/PnB/NjMPXDbBR3MqSjnfsva
   pokOl8LNn7jaB3jcWALXt1xFZzCixZwiAW2ScCtMLXxv4D0EEx82k/ogB
   sA2yNqdSb67yU7PHSzQjo5NqpwVg9LsUuKkorMGRYbkUzAV+htLlO9QF4
   tQuRfHh0IaUSSK1IrKmIfqmvmGSeQyHCFBlE+AiX3PJsvnwdfUTHVDCYP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="299007579"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="299007579"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 18:14:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615335551"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="615335551"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 18:14:46 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: enable optional clock registers for SoundWire 1.2 devices
Date:   Fri, 11 Nov 2022 10:16:33 +0800
Message-Id: <20221111021633.39908-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111021633.39908-1-yung-chuan.liao@linux.intel.com>
References: <20221111021633.39908-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The bus supports the mandatory clock registers for SDCA devices, these
registers can also be optionally supported by SoundWire 1.2 devices
that don't follow the SDCA class specification.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 7 ++++---
 include/linux/soundwire/sdw.h | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index c23275b443ac..55d393247a0f 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1233,10 +1233,11 @@ static int sdw_slave_set_frequency(struct sdw_slave *slave)
 
 	/*
 	 * frequency base and scale registers are required for SDCA
-	 * devices. They may also be used for 1.2+/non-SDCA devices,
-	 * but we will need a DisCo property to cover this case
+	 * devices. They may also be used for 1.2+/non-SDCA devices.
+	 * Driver can set the property, we will need a DisCo property
+	 * to discover this case from platform firmware.
 	 */
-	if (!slave->id.class_id)
+	if (!slave->id.class_id && !slave->prop.clock_reg_supported)
 		return 0;
 
 	if (!mclk_freq) {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 8fb458931772..9a49263c53cf 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -365,6 +365,9 @@ struct sdw_dpn_prop {
  * @sink_dpn_prop: Sink Data Port N properties
  * @scp_int1_mask: SCP_INT1_MASK desired settings
  * @quirks: bitmask identifying deltas from the MIPI specification
+ * @clock_reg_supported: the Peripheral implements the clock base and scale
+ * registers introduced with the SoundWire 1.2 specification. SDCA devices
+ * do not need to set this boolean property as the registers are required.
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -388,6 +391,7 @@ struct sdw_slave_prop {
 	struct sdw_dpn_prop *sink_dpn_prop;
 	u8 scp_int1_mask;
 	u32 quirks;
+	bool clock_reg_supported;
 };
 
 #define SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY	BIT(0)
-- 
2.25.1

