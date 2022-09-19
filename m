Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCFC5BD40E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiISRux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiISRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:50:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E515A42AC8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609845; x=1695145845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EviRt9EmxI1oqeLj/2924DDSte2Z0gsI2mryQ9QkDl4=;
  b=Y7QKyuIwhFv5JfIa+78U5DgjrKTMLYSBnMO3CQ042sRGPKQeLlshrtA8
   UXDDloR/g03S917HwViM4/IOFPig9YI2yOZi2kFkSLojyY8xVZujA+SCa
   RKoa+cAJVj9lWS0SWTz7Ec5jdEJlOAKWU11+X1Z3gISlndmIDpq6LoVs1
   IBxePurWcQ92AuzgOdmhPpd7BMa/0nQbyh6q0L+sZj5ShyFJEwjv9V5od
   G4ct9XiypDyI1EYcpAFppBLbGc8GB/x9QQyNYtU2cyaYGTl5soz9QpKJ4
   bxT/Gv0oUtlEE9qQN/n08P9Rl3o7+MahUxjBxUEU8Xc5igWcwcBpk89eL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429156"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429156"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658384"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 02/11] soundwire: intel: simplify flow and use devm_ for DAI registration
Date:   Tue, 20 Sep 2022 01:57:12 +0800
Message-Id: <20220919175721.354679-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
References: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
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

We already use devm_ for memory allocation but not for component/DAI
registration. The resource management can be based on devm_ in all
cases.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3bb29bc00d5a..a6fe91f2d964 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1203,8 +1203,8 @@ static int intel_register_dai(struct sdw_intel *sdw)
 	if (ret)
 		return ret;
 
-	return snd_soc_register_component(cdns->dev, &dai_component,
-					  dais, num_dai);
+	return devm_snd_soc_register_component(cdns->dev, &dai_component,
+					       dais, num_dai);
 }
 
 static int sdw_master_read_intel_prop(struct sdw_bus *bus)
@@ -1489,7 +1489,6 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 
 static void intel_link_remove(struct auxiliary_device *auxdev)
 {
-	struct device *dev = &auxdev->dev;
 	struct sdw_cdns *cdns = auxiliary_get_drvdata(auxdev);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_bus *bus = &cdns->bus;
@@ -1502,7 +1501,6 @@ static void intel_link_remove(struct auxiliary_device *auxdev)
 	if (!bus->prop.hw_disabled) {
 		intel_debugfs_exit(sdw);
 		sdw_cdns_enable_interrupt(cdns, false);
-		snd_soc_unregister_component(dev);
 	}
 	sdw_bus_master_delete(bus);
 }
-- 
2.25.1

