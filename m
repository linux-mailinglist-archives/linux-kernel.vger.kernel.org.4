Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A8967325F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjASHYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjASHX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:23:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5651A61D42
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674113032; x=1705649032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NeP4OdNK8sHTuHKWYhMhhSE6AcrppUIxgnz/ptxTTv8=;
  b=EsR7SU2s35LgWC+ocpCYWiqqiJl+Vx3WL+QQf2UoYFsigs2Wz/2iiUSr
   lM93H4BC5aqWbKawJfT6UHlmu1mv/jr/I0SMQznoZMwVKzDcb9iAlAP+T
   tZbRnzP6tK89QYWDnVx5DjKmxzAJFq8c4mRhws2ArNAckX7WSXRo2yC/1
   HC2R4xpOow5BBzY6M/WyT6aMr0GM3j/27WbfFpRON7qSyuVgMZGZRyVZZ
   AQy5b6cbgPw8oeaiQdgI1XjhA11jg+PDklDp6k9aYNgpE+NDtFd2Fv65R
   34uV2MLSCoR1PHMa7OHVddSsUl9BWqv2fXj1ny6Nc7PoS0GszabjdL/3p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322902668"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="322902668"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 23:23:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="662028032"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="662028032"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 23:23:41 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 2/4] soundwire: bus: remove sdw_defer argument in sdw_transfer_defer()
Date:   Thu, 19 Jan 2023 15:32:09 +0800
Message-Id: <20230119073211.85979-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119073211.85979-1-yung-chuan.liao@linux.intel.com>
References: <20230119073211.85979-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 9c13dbd2b26e..2e39587ed1de 100644
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

