Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A814866930E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbjAMJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241284AbjAMJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:32:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122C413DD0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673602063; x=1705138063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9EfKDqwT5iUG/3vSHRo63HrB7tHmjW3+OTAvgNE6xiU=;
  b=n7G1N+tS+3lXujxLMwvBETmK3jc2vYdAvCqCxbJLKl7yJZ0y4bBL0a2q
   Z7Kuwng71E5qisgyoJEvHwOtMR4UBxhMRi97Rj74vNTWTLOxmDozZhOlv
   s8Ar9TrpXoJO6V90SKDnXIZkeOPQ06NAq2yqbD/i1IeUIbcZu6M0TaSsp
   IxEisixhNXUPfpbW2vxpmVFFHjHGt8wzuTWgQfoirf7B4Ne66hYgvksRL
   MAFYmYguU3/qU5JvmBeGykOPyRWLp8LbNbGpZhkHESZGYcQOQ58aCEEZ9
   nnjg/iMGioSYHPe1pkN664yzQP35TRzTuODp+r7ZGhl6ZvYSXlRiEYTBH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351189461"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="351189461"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608116112"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="608116112"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:25 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 4/5] soundwire: cadence: use directly bus sdw_defer structure
Date:   Fri, 13 Jan 2023 17:35:31 +0800
Message-Id: <20230113093532.3872113-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
References: <20230113093532.3872113-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
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

Copying the bus sdw_defer structure into the Cadence internals leads
to using stale pointers and kernel oopses on errors. It's just simpler
and safer to use the bus sdw_defer structure directly.

Link: https://github.com/thesofproject/linux/issues/4056
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c            |  2 +-
 drivers/soundwire/cadence_master.c | 17 ++++++++---------
 drivers/soundwire/cadence_master.h |  5 +----
 include/linux/soundwire/sdw.h      |  3 +--
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 572cc9a9af41..fc192d0c61e7 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -237,7 +237,7 @@ static inline int do_transfer_defer(struct sdw_bus *bus,
 	init_completion(&defer->complete);
 
 	for (i = 0; i <= retry; i++) {
-		resp = bus->ops->xfer_msg_defer(bus, msg, defer);
+		resp = bus->ops->xfer_msg_defer(bus, msg);
 		ret = find_response_code(resp);
 		/* if cmd is ok or ignored return */
 		if (ret == 0 || ret == -ENODATA)
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 521387322145..2365395cb181 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -750,7 +750,7 @@ EXPORT_SYMBOL(cdns_xfer_msg);
 
 enum sdw_command_response
 cdns_xfer_msg_defer(struct sdw_bus *bus,
-		    struct sdw_msg *msg, struct sdw_defer *defer)
+		    struct sdw_msg *msg)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int cmd = 0, ret;
@@ -763,9 +763,6 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
 	if (ret)
 		return SDW_CMD_FAIL_OTHER;
 
-	cdns->defer = defer;
-	cdns->defer->length = msg->len;
-
 	return _cdns_xfer_msg(cdns, msg, cmd, 0, msg->len, true);
 }
 EXPORT_SYMBOL(cdns_xfer_msg_defer);
@@ -893,13 +890,15 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	if (int_status & CDNS_MCP_INT_RX_WL) {
+		struct sdw_bus *bus = &cdns->bus;
+		struct sdw_defer *defer = &bus->defer_msg;
+
 		cdns_read_response(cdns);
 
-		if (cdns->defer) {
-			cdns_fill_msg_resp(cdns, cdns->defer->msg,
-					   cdns->defer->length, 0);
-			complete(&cdns->defer->complete);
-			cdns->defer = NULL;
+		if (defer && defer->msg) {
+			cdns_fill_msg_resp(cdns, defer->msg,
+					   defer->length, 0);
+			complete(&defer->complete);
 		} else {
 			complete(&cdns->tx_complete);
 		}
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index fa9dc38264a4..53029d22822d 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -109,7 +109,6 @@ struct sdw_cdns_dai_runtime {
  * @instance: instance number
  * @response_buf: SoundWire response buffer
  * @tx_complete: Tx completion
- * @defer: Defer pointer
  * @ports: Data ports
  * @num_ports: Total number of data ports
  * @pcm: PCM streams
@@ -130,7 +129,6 @@ struct sdw_cdns {
 	u32 response_buf[CDNS_MCP_IP_MAX_CMD_LEN + 2];
 
 	struct completion tx_complete;
-	struct sdw_defer *defer;
 
 	struct sdw_cdns_port *ports;
 	int num_ports;
@@ -189,8 +187,7 @@ enum sdw_command_response
 cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg);
 
 enum sdw_command_response
-cdns_xfer_msg_defer(struct sdw_bus *bus,
-		    struct sdw_msg *msg, struct sdw_defer *defer);
+cdns_xfer_msg_defer(struct sdw_bus *bus, struct sdw_msg *msg);
 
 u32 cdns_read_ping_status(struct sdw_bus *bus);
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3cd2a761911f..fb2bd1524a26 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -852,8 +852,7 @@ struct sdw_master_ops {
 	enum sdw_command_response (*xfer_msg)
 			(struct sdw_bus *bus, struct sdw_msg *msg);
 	enum sdw_command_response (*xfer_msg_defer)
-			(struct sdw_bus *bus, struct sdw_msg *msg,
-			struct sdw_defer *defer);
+			(struct sdw_bus *bus, struct sdw_msg *msg);
 	enum sdw_command_response (*reset_page_addr)
 			(struct sdw_bus *bus, unsigned int dev_num);
 	int (*set_bus_conf)(struct sdw_bus *bus,
-- 
2.25.1

