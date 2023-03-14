Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1436B87BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCNBlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCNBlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290E7D0BE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758090; x=1710294090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NA2gNysK23O2yyiWZ9WhH+HonzPAPVODm9Os9DBHBa4=;
  b=h5gH+6+Df/g2dFh9FvFSxbKXtiiu6y0srHw6TpGvw1IbUpktUaN+rEXG
   D7YiqrN315ciwDfH/xGGtxAgyqrf++fqh3yKL5zNw9eWZqoianqauDmXJ
   YkU5GRmOHPBF1hdLV9haFoAp+CWVe8/OhEskg8XLyT8r+ZqZbMK9WiEc1
   sdWDv4/nxSTsKG0w8K6Tk1g7i4UjC+gmm3GPNZHgKk4U48eCec/s9ypkZ
   ZkeARtu/Fw2+GBfA4HkHISnxHf/J/8eG1qrPQkQ4Y2flzkGMz2l8FetdM
   9rJT9sw+VowfhjzS1e4d8Cu2GKh9OyIa+MX9QzsMipfNv28eCFDyFUDSh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949293"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949293"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327521"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327521"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:28 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 12/16] soundwire: cadence: add helpers to access IP_MCP registers
Date:   Tue, 14 Mar 2023 09:54:06 +0800
Message-Id: <20230314015410.487311-13-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The latest Cadence IP splits some of the existing registers into two,
separated by a fixed offset. The bitfields themselves remain at the
same position, so we can use new helpers to dynamically add the fixed
offset.

For example, the existing MCP_CONFIG is now split in two with
MCP_CONFIG and IP_MCP_CONFIG (the naming comes directly from the
design document).

This patch adds helpers to access registers with the IP_ prefix. The
addition of the 'ip' prefix for helpers, registers and bitfields is
intentional to help reviewers spot any mistake.

For existing solutions, the offset is exactly zero so there's no
functional change - the MCP_CONFIG and IP_MCP_CONFIG are aliased to
the same address.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 16 ++++++++++++++++
 drivers/soundwire/cadence_master.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4f34fc72dbd5..4461a7fa4124 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -205,6 +205,16 @@ static inline void cdns_writel(struct sdw_cdns *cdns, int offset, u32 value)
 	writel(value, cdns->registers + offset);
 }
 
+static inline u32 cdns_ip_readl(struct sdw_cdns *cdns, int offset)
+{
+	return cdns_readl(cdns, cdns->ip_offset + offset);
+}
+
+static inline void cdns_ip_writel(struct sdw_cdns *cdns, int offset, u32 value)
+{
+	return cdns_writel(cdns, cdns->ip_offset + offset, value);
+}
+
 static inline void cdns_updatel(struct sdw_cdns *cdns,
 				int offset, u32 mask, u32 val)
 {
@@ -215,6 +225,12 @@ static inline void cdns_updatel(struct sdw_cdns *cdns,
 	cdns_writel(cdns, offset, tmp);
 }
 
+static inline void cdns_ip_updatel(struct sdw_cdns *cdns,
+				   int offset, u32 mask, u32 val)
+{
+	cdns_updatel(cdns, cdns->ip_offset + offset, mask, val);
+}
+
 static int cdns_set_wait(struct sdw_cdns *cdns, int offset, u32 mask, u32 value)
 {
 	int timeout = 10;
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index dec0b4f993c1..b653734085d9 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -107,6 +107,7 @@ struct sdw_cdns_dai_runtime {
  * @dev: Linux device
  * @bus: Bus handle
  * @instance: instance number
+ * @ip_offset: version-dependent offset to access IP_MCP registers and fields
  * @response_buf: SoundWire response buffer
  * @tx_complete: Tx completion
  * @ports: Data ports
@@ -122,6 +123,8 @@ struct sdw_cdns {
 	struct sdw_bus bus;
 	unsigned int instance;
 
+	u32 ip_offset;
+
 	/*
 	 * The datasheet says the RX FIFO AVAIL can be 2 entries more
 	 * than the FIFO capacity, so allow for this.
-- 
2.25.1

