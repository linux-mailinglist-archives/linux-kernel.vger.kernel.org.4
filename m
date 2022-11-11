Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E372625009
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiKKCOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiKKCOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:14:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515E81057C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668132886; x=1699668886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aszcFf1expwwBBUpdvSSxdjfZppq0RpVWeHal7GmSks=;
  b=kf6nWZSrATcmSecIdeQqyy8Koza9bZc1JgTeLfnQ60dP/5iPsEPLjOz4
   Z4iXJp6LI6l9N0ikhx+TRfhfpVvVOe2dBG5/6YMtljL6upUZJfoPG7dhc
   xfAkq9VOJyWSP+gPmqa1UacCx2BG20vhbZeYs8YEWkXe09+VMkQu+YZgZ
   7QwbinIHUweqcXmALFaC69BRqOvLRvB2ykOCdUMOQ8FFveasIe6JDA1aB
   H/+JijV9P74a7QSYpyXjAecVJL5/rRdRzCdyS4QOHHYwK3JH4+JnA4RCZ
   MItV79ZJz2JH+00Szqx6WqpC7dKfB3RAnsNVAJKw2CqgQaHWjCMhJKSfh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="299007575"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="299007575"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 18:14:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615335547"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="615335547"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 18:14:44 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: remove is_sdca boolean property
Date:   Fri, 11 Nov 2022 10:16:32 +0800
Message-Id: <20221111021633.39908-2-yung-chuan.liao@linux.intel.com>
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

The Device_ID registers already tell us if a device supports the SDCA
specification or not, in hindsight we never needed a property when the
information is reported by both hardware and ACPI.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c           | 4 ++--
 include/linux/soundwire/sdw.h     | 2 --
 sound/soc/codecs/rt1316-sdw.c     | 1 -
 sound/soc/codecs/rt711-sdca-sdw.c | 1 -
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 76515c33e639..c23275b443ac 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1587,7 +1587,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		goto io_err;
 	}
 
-	if (slave->prop.is_sdca) {
+	if (slave->id.class_id) {
 		ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 		if (ret < 0) {
 			dev_err(&slave->dev,
@@ -1724,7 +1724,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			goto io_err;
 		}
 
-		if (slave->prop.is_sdca) {
+		if (slave->id.class_id) {
 			ret = sdw_read_no_pm(slave, SDW_DP0_INT);
 			if (ret < 0) {
 				dev_err(&slave->dev,
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 9e4537f409c2..8fb458931772 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -365,7 +365,6 @@ struct sdw_dpn_prop {
  * @sink_dpn_prop: Sink Data Port N properties
  * @scp_int1_mask: SCP_INT1_MASK desired settings
  * @quirks: bitmask identifying deltas from the MIPI specification
- * @is_sdca: the Slave supports the SDCA specification
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -389,7 +388,6 @@ struct sdw_slave_prop {
 	struct sdw_dpn_prop *sink_dpn_prop;
 	u8 scp_int1_mask;
 	u32 quirks;
-	bool is_sdca;
 };
 
 #define SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY	BIT(0)
diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index ed0a11436362..8b27401237f7 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -203,7 +203,6 @@ static int rt1316_read_prop(struct sdw_slave *slave)
 
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
-	prop->is_sdca = true;
 
 	prop->paging_support = true;
 
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 4120842fe699..6ca8795eed68 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -186,7 +186,6 @@ static int rt711_sdca_read_prop(struct sdw_slave *slave)
 
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
-	prop->is_sdca = true;
 
 	prop->paging_support = true;
 
-- 
2.25.1

