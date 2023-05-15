Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7B702569
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbjEOGwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbjEOGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:52:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C7CF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133522; x=1715669522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tzzjYf0orwaeoCq1YKwuJr6YmoUY5TgIK1ZLlpL2MUE=;
  b=eVbEupJDGvAFj9nZGf29U+K8mEsbKo3LQAdB5o3NKexwNHwuk6cYcGR0
   1w74edPsabg7jitGmDqpZ/RVHZ/Biztw4B+MrHJf/x/JwX6JVzW215Mpw
   YuiY6T3HmUM6DEY4qHBgNCdWDckOg3/wNt/69D/IgsauNtdrAm/fKebT3
   +RDkyBs1omgV2BNhV8emy6MBdMySndqxycw+IVIaN44/6MyU4Etyuh/rR
   BMZoa9nh9q6Pp2kzfBzjt4lTxQrFNdnIxLzEgbA+T4rCzZ4VcfJiT6Fhz
   wX/dBSADbJEWqHYsAGyUVYQifIa40iZANgW7QaqbNXnzcZaeSdxzKEbdQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966503"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966503"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908767"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908767"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:04 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 19/26] soundwire: bus: add new manager callback to deal with peripheral enumeration
Date:   Mon, 15 May 2023 15:10:35 +0800
Message-Id: <20230515071042.2038-20-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 338f4f0b5d0c..b44f8d0affa6 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -769,6 +769,9 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
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

