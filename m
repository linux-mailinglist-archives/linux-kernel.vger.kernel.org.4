Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8E62EC32
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbiKRC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240815AbiKRCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:55:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5BC8F3C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668740148; x=1700276148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZsbjKmI8r3wmxokls6Yj3fJektnJREEilC4V+S5EGkY=;
  b=Wobzqc/jyiDO6BP/gtVvcPK8iwh40W829Vzn3jenNyT4eNrdEthV8bsC
   a671MQneNiK8f0ETX0kkpl5aCvDDGKYtGDaH2IoxuoquwNxQogLhNCw4l
   mINS6Ua8MUwthPkrXMmJnfgbhoGwPx9aEa7SHVN3C7fxFhYTloQA3XTDt
   y0832dYVVJm9rjQq6dq4kaOYLkvVIEdZTH0TLH/3+c9NQ2aW46CDgWZwY
   SMRZ6SZF51XcR43y06mt1fmqiItufXjxcFDF195i4+jHocbz28Hy4RBEX
   Obqu9XzGtBkHQDb9+RIeTDeZpU7/hlnQfJfzDtJFza4x7RM3ckerlNNi8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296400628"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="296400628"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 18:55:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642347884"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="642347884"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 18:55:45 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org, bard.liao@intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC/soundwire: remove is_sdca boolean property
Date:   Fri, 18 Nov 2022 10:58:06 +0800
Message-Id: <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
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
 sound/soc/codecs/rt1318-sdw.c     | 1 -
 sound/soc/codecs/rt711-sdca-sdw.c | 1 -
 5 files changed, 2 insertions(+), 7 deletions(-)

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
index 2db7ee6c6d33..fbc7e9c0254d 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -203,7 +203,6 @@ static int rt1316_read_prop(struct sdw_slave *slave)
 
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
-	prop->is_sdca = true;
 
 	prop->paging_support = true;
 
diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index f85f5ab2c6d0..8bc379215c34 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -353,7 +353,6 @@ static int rt1318_read_prop(struct sdw_slave *slave)
 
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
-	prop->is_sdca = true;
 
 	prop->paging_support = true;
 
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 88a8392a58ed..693e11ed8d08 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -186,7 +186,6 @@ static int rt711_sdca_read_prop(struct sdw_slave *slave)
 
 	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
-	prop->is_sdca = true;
 
 	prop->paging_support = true;
 
-- 
2.25.1

