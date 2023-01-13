Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF78E669308
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbjAMJeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbjAMJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:32:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794C11A805
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673602063; x=1705138063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vexI4bXkLQNgnzQp46b1BOfBvYLiQ1hk43f3ShONtl8=;
  b=CbIe5JZc4pCeAGbiD9qWOPmmq3FJ+HjYqcP2YHhCk9D8ZJ/vfIyQLpHf
   li9J7We9lrwsrSKHoIevR7/jE9bs7auVLl9x/PBnHe8HXT5Bleq41LjPl
   u1dhD95RWP8oJJYm4wteqNt1gjOl0ghBjpkMh9kFL+Uf8fQPbH83x48Bf
   A00MM5ikyWj5ktNWHDUvLycwHTZTHGawH0OHfsq3j7/68qwubtkQPqfVc
   5EDD9gPobhNkJ15VUK3IdkV+kk/MewGzugrZ52K8xrm8d0LYYNK12JW28
   dBUQ+m9u7JCvWJaQ04jVhE2JpChG4SRb7h25i3eM/+517EKTh1MOHfxVG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351189473"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="351189473"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608116119"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="608116119"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:27 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 5/5] soundwire: cadence: further simplify low-level xfer_msg_defer() callback
Date:   Fri, 13 Jan 2023 17:35:32 +0800
Message-Id: <20230113093532.3872113-6-yung-chuan.liao@linux.intel.com>
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

The message pointer is already stored in the bus->defer structure, not
need to pass it as an argument.

Suggested-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c            | 2 +-
 drivers/soundwire/cadence_master.c | 5 +++--
 drivers/soundwire/cadence_master.h | 2 +-
 include/linux/soundwire/sdw.h      | 5 +++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index fc192d0c61e7..ed94c92bc575 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -237,7 +237,7 @@ static inline int do_transfer_defer(struct sdw_bus *bus,
 	init_completion(&defer->complete);
 
 	for (i = 0; i <= retry; i++) {
-		resp = bus->ops->xfer_msg_defer(bus, msg);
+		resp = bus->ops->xfer_msg_defer(bus);
 		ret = find_response_code(resp);
 		/* if cmd is ok or ignored return */
 		if (ret == 0 || ret == -ENODATA)
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 2365395cb181..ece0ad89746f 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -749,10 +749,11 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 EXPORT_SYMBOL(cdns_xfer_msg);
 
 enum sdw_command_response
-cdns_xfer_msg_defer(struct sdw_bus *bus,
-		    struct sdw_msg *msg)
+cdns_xfer_msg_defer(struct sdw_bus *bus)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
+	struct sdw_defer *defer = &bus->defer_msg;
+	struct sdw_msg *msg = defer->msg;
 	int cmd = 0, ret;
 
 	/* for defer only 1 message is supported */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 53029d22822d..63c58b9b1f59 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -187,7 +187,7 @@ enum sdw_command_response
 cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg);
 
 enum sdw_command_response
-cdns_xfer_msg_defer(struct sdw_bus *bus, struct sdw_msg *msg);
+cdns_xfer_msg_defer(struct sdw_bus *bus);
 
 u32 cdns_read_ping_status(struct sdw_bus *bus);
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index fb2bd1524a26..86e320cf27b1 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -837,7 +837,8 @@ struct sdw_defer {
  * @read_prop: Read Master properties
  * @override_adr: Override value read from firmware (quirk for buggy firmware)
  * @xfer_msg: Transfer message callback
- * @xfer_msg_defer: Defer version of transfer message callback
+ * @xfer_msg_defer: Defer version of transfer message callback. The message is handled with the
+ * bus struct @sdw_defer
  * @reset_page_addr: Reset the SCP page address registers
  * @set_bus_conf: Set the bus configuration
  * @pre_bank_switch: Callback for pre bank switch
@@ -852,7 +853,7 @@ struct sdw_master_ops {
 	enum sdw_command_response (*xfer_msg)
 			(struct sdw_bus *bus, struct sdw_msg *msg);
 	enum sdw_command_response (*xfer_msg_defer)
-			(struct sdw_bus *bus, struct sdw_msg *msg);
+			(struct sdw_bus *bus);
 	enum sdw_command_response (*reset_page_addr)
 			(struct sdw_bus *bus, unsigned int dev_num);
 	int (*set_bus_conf)(struct sdw_bus *bus,
-- 
2.25.1

