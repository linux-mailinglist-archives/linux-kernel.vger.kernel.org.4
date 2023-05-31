Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE16D717441
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjEaDQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjEaDPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:15:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88442135
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685502940; x=1717038940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1MyuBzg/rXNODw6gij/Uy3ks1qAp9FzmB1Vw7BzGHV8=;
  b=eMakHMCkV6tDdX1jjWm16NlAR9qO2bmFt8xtKDzY205VSjITpZRG1SJv
   Er4zufSt493VKQpxDyGEcfm4r9a8qYT0M5tmnpV70hJtxoqmJ2GFbRNjA
   Z/zW73Zu2dmWa4nLXxFI/1iMTeUx/OdNMN87XD2KPaHkl8Dq6iQJ5ywYu
   SUjOh5NUb/EnRv8b48AoE1oO7j9PcKrMkSvHPh+skCRjzW3QS4XMblMqv
   BTngtcXr2KwUQbnyZNUz6TDhy+vsTYB7OVX2nmqhhLjcC4fjojdwMZExX
   y7SF2IlGxdPP0Dd+HNmVcri9E3HVWOpkAgE3QQEGFEUemli+2fy/okwyU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357507674"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357507674"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="739769528"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="739769528"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:38 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 3/4] soundwire: extend parameters of new_peripheral_assigned() callback
Date:   Wed, 31 May 2023 11:37:35 +0800
Message-Id: <20230531033736.792464-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The parameters are only the bus and the device number, manager ops may
need additional details on the type of peripheral connected, such as
whether it is wake-capable or not.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c             | 2 +-
 drivers/soundwire/intel_auxdevice.c | 4 +++-
 include/linux/soundwire/sdw.h       | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 6f465cce8369..17b9a8bdf234 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -786,7 +786,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
 	slave->dev_num = slave->dev_num_sticky;
 
 	if (bus->ops && bus->ops->new_peripheral_assigned)
-		bus->ops->new_peripheral_assigned(bus, dev_num);
+		bus->ops->new_peripheral_assigned(bus, slave, dev_num);
 
 	return 0;
 }
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 30f3d2ab80fd..c1df6f014e6b 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -60,7 +60,9 @@ static int generic_post_bank_switch(struct sdw_bus *bus)
 	return sdw->link_res->hw_ops->post_bank_switch(sdw);
 }
 
-static void generic_new_peripheral_assigned(struct sdw_bus *bus, int dev_num)
+static void generic_new_peripheral_assigned(struct sdw_bus *bus,
+					    struct sdw_slave *slave,
+					    int dev_num)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 8a7541ac735e..41a856bedf1e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -861,7 +861,9 @@ struct sdw_master_ops {
 	int (*pre_bank_switch)(struct sdw_bus *bus);
 	int (*post_bank_switch)(struct sdw_bus *bus);
 	u32 (*read_ping_status)(struct sdw_bus *bus);
-	void (*new_peripheral_assigned)(struct sdw_bus *bus, int dev_num);
+	void (*new_peripheral_assigned)(struct sdw_bus *bus,
+					struct sdw_slave *slave,
+					int dev_num);
 };
 
 /**
-- 
2.25.1

