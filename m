Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85D669306
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbjAMJeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbjAMJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:32:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDEE10AC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673602061; x=1705138061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7vfmYiwRnIv7Am96c9Qj/RTB4F0doxF2OEQMmfScbOc=;
  b=TfF+qpQqcLbIKZKlahkWop7ICQyduXmyTc0PgWxJMF4CjDKwiBUM13Uz
   Z6jBnRUfYZWJljfJo0lgk+d0Nrd5vM4X4H1Gf4ved/Irh71MrB+wu405F
   NCACY7kZ3h+3v4zPqlsNwerOUM1Fpce6ZGx4lx8rw9FrhzVx8ZsdAp14m
   3FCusMgkMGjSce0/JyuXccLLCa+ntvtsyFTCxRccVmr60V2eZHjuDd43u
   rOXtv1WL2o47slBL7w3WG3W4rfkG4peHxaX/oOoM+Dr7ez/Y0po73Wc1F
   wZGosXMQkJG6i89nJkyrUtPriMBUHeE5xOHZ8Rhnaf4QD9NPX/rYPrIzp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351189449"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="351189449"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608116104"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="608116104"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:23 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 3/5] soundwire: bus: remove sdw_defer argument in sdw_transfer_defer()
Date:   Fri, 13 Jan 2023 17:35:30 +0800
Message-Id: <20230113093532.3872113-4-yung-chuan.liao@linux.intel.com>
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

There's no point in passing an argument that is a pointer to a bus
member. We can directly get the member and do an indirection when
needed.

This is a first step before simplifying the hardware-specific
callbacks further.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c    | 10 ++++------
 drivers/soundwire/bus.h    |  3 +--
 drivers/soundwire/stream.c |  4 +---
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 633d411b64f3..572cc9a9af41 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -225,9 +225,9 @@ static inline int do_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
 }
 
 static inline int do_transfer_defer(struct sdw_bus *bus,
-				    struct sdw_msg *msg,
-				    struct sdw_defer *defer)
+				    struct sdw_msg *msg)
 {
+	struct sdw_defer *defer = &bus->defer_msg;
 	int retry = bus->prop.err_threshold;
 	enum sdw_command_response resp;
 	int ret = 0, i;
@@ -335,19 +335,17 @@ EXPORT_SYMBOL(sdw_show_ping_status);
  * sdw_transfer_defer() - Asynchronously transfer message to a SDW Slave device
  * @bus: SDW bus
  * @msg: SDW message to be xfered
- * @defer: Defer block for signal completion
  *
  * Caller needs to hold the msg_lock lock while calling this
  */
-int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
-		       struct sdw_defer *defer)
+int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg)
 {
 	int ret;
 
 	if (!bus->ops->xfer_msg_defer)
 		return -ENOTSUPP;
 
-	ret = do_transfer_defer(bus, msg, defer);
+	ret = do_transfer_defer(bus, msg);
 	if (ret != 0 && ret != -ENODATA)
 		dev_err(bus->dev, "Defer trf on Slave %d failed:%d\n",
 			msg->dev_num, ret);
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 7631ef5e71fb..96927a143796 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -151,8 +151,7 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave, int port,
 			   bool enable, int mask);
 
 int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg);
-int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
-		       struct sdw_defer *defer);
+int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg);
 
 #define SDW_READ_INTR_CLEAR_RETRY	10
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index f27bd37b154d..e0b0c63fc55c 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -684,8 +684,6 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 	if (!wr_msg)
 		return -ENOMEM;
 
-	bus->defer_msg.msg = wr_msg;
-
 	wbuf = kzalloc(sizeof(*wbuf), GFP_KERNEL);
 	if (!wbuf) {
 		ret = -ENOMEM;
@@ -713,7 +711,7 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 	multi_link = bus->multi_link && (m_rt_count >= bus->hw_sync_min_links);
 
 	if (multi_link)
-		ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
+		ret = sdw_transfer_defer(bus, wr_msg);
 	else
 		ret = sdw_transfer(bus, wr_msg);
 
-- 
2.25.1

