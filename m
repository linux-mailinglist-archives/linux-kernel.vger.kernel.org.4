Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56B6C5EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCWFcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCWFcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAB631BE4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549489; x=1711085489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gtkWDGGprYUCa/NujUo+nrfpqYowlmMRMlh2EJAtBoc=;
  b=F/vVsqcsOIYBCZKC6fYc8SSuRNavVLDZn3teRJJo0U/O33x9Zy5wUys8
   8wuJw5krE2kzNjKp/Zwq1h/ple0yW27Uo2LnNvtlJivK3tRrZqSemXi6u
   09SoSDW89ifsN6xMNfzaYwIa1Mg85ZL4V9CdFj66Qw/SNaJhzGkpM+4Hc
   +lrPxkdPn+cq+0W76XeMR3lVYIOCFSbaZ3dMGozCa4Ol0SrXHBkqGjCKy
   ggpYXoalXngkuh12PIOev4FR2chefy5BP6QxU8xDgR1vnsy8M2uo7Puy6
   DwxFXStkxI1cd1SreB7zOTCGPWd/70gu23Fvc4bPB7ztsOjfjMaoBcWFQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779505"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779505"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675567269"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675567269"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 19/20] soundwire: bus: add new manager callback to deal with peripheral enumeration
Date:   Thu, 23 Mar 2023 13:44:51 +0800
Message-Id: <20230323054452.1543233-20-yung-chuan.liao@linux.intel.com>
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

When a peripheral reports as ATTACHED, the manager may need to follow
a programming sequence, e.g. to assign DMA resources and/or assign a
command queue for that peripheral.

This patch adds an optional callback, which will be invoked every time
the peripheral attaches. This might be overkill in some scenarios, and
one could argue that this should be invoked only on the first
attachment. The bus does not however track this first attachment with
any existing state-mirroring variable, and using dev_num_sticky would
not work across suspend-resume cycles.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 3 +++
 include/linux/soundwire/sdw.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index b6aca59c3130..35f49bcc53e5 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -716,6 +716,9 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 	/* After xfer of msg, restore dev_num */
 	slave->dev_num = slave->dev_num_sticky;
 
+	if (bus->ops && bus->ops->new_peripheral_assigned)
+		bus->ops->new_peripheral_assigned(bus, dev_num);
+
 	return 0;
 }
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index ef645de13ae9..c076a3f879b3 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -846,6 +846,7 @@ struct sdw_defer {
  * @post_bank_switch: Callback for post bank switch
  * @read_ping_status: Read status from PING frames, reported with two bits per Device.
  * Bits 31:24 are reserved.
+ * @new_peripheral_assigned: Callback to handle enumeration of new peripheral.
  */
 struct sdw_master_ops {
 	int (*read_prop)(struct sdw_bus *bus);
@@ -860,7 +861,7 @@ struct sdw_master_ops {
 	int (*pre_bank_switch)(struct sdw_bus *bus);
 	int (*post_bank_switch)(struct sdw_bus *bus);
 	u32 (*read_ping_status)(struct sdw_bus *bus);
-
+	void (*new_peripheral_assigned)(struct sdw_bus *bus, int dev_num);
 };
 
 /**
-- 
2.25.1

