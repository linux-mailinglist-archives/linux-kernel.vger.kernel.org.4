Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DB85BD418
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiISRvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiISRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:51:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB65343E7A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609856; x=1695145856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OKogfO4K6IMOMgoifEN6M6CT/AXHoyqz1X/Mml5qstY=;
  b=QvyNn1DSZBhA3/FEEA7XKqWQyKIPfJBfR4U3IxitQ9tFB2cZ270pRXPC
   BpIPJUzoxMU21uvgHfsWKi1qQPts4hGnpg9DgXtJqq0yJXx8NlLwz6bMU
   wmpeN7sgUEtnu+Dh9b2Fwuh2h9AAMUszC9aWneKBBgj7xhHClMz+tPB/5
   41HsGfxJMsG1/132bg2yq4yw2agiQyIN2A6307dTVDa6w3RF6WpiZNxWl
   v7eMHnDxkTXCgytYgcbvkm/bYKvffSaXXTJ7nIhlu4sV/pNqGUCebi0hr
   Ws2ZYK0OzlOJ6ESCDKjSoM63HKSpHahy81P4M3raZBC1nUuqc/x3w23uW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429295"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429295"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658499"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:54 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 08/11] soundwire: intel: simplify read ops assignment
Date:   Tue, 20 Sep 2022 01:57:18 +0800
Message-Id: <20220919175721.354679-9-yung-chuan.liao@linux.intel.com>
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

We can assign the right callback directly in the ops structure. No
functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 4eeb2b5c1594..66aab02b9323 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1261,7 +1261,7 @@ static int intel_prop_read(struct sdw_bus *bus)
 }
 
 static struct sdw_master_ops sdw_intel_ops = {
-	.read_prop = sdw_master_read_prop,
+	.read_prop = intel_prop_read,
 	.override_adr = sdw_dmi_override_adr,
 	.xfer_msg = cdns_xfer_msg,
 	.xfer_msg_defer = cdns_xfer_msg_defer,
@@ -1304,8 +1304,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 
 	sdw_cdns_probe(cdns);
 
-	/* Set property read ops */
-	sdw_intel_ops.read_prop = intel_prop_read;
+	/* Set ops */
 	bus->ops = &sdw_intel_ops;
 
 	/* set driver data, accessed by snd_soc_dai_get_drvdata() */
-- 
2.25.1

