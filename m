Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8995BD411
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiISRvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiISRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:50:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC995422D1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609850; x=1695145850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysMlpOvB+Aq5Jze0gGbEnYMmySseBub88xxP7dnnXTo=;
  b=ZR6zPfM1GJJ0XoMEnFi9zgopQm6mBsgW41lilxk+eVEQJSPoIFzdminR
   CltkHIGKxkobTIGNHYqgSJN1NMBA+egFP8wBEMcyMLNUwOxi659eS3meN
   IBO9fFqf/Cu5tBPUqaYPWsmNCrZS2f5eSa6c5v+yFPVrXHudKoMOwqN5V
   1tsApRFMIJxzrsbC2iHL+LSxgn/e/Tx/KBGaY5w0jete/2T/GB6ClMFdb
   hA89tYrsIDXZae5NfyiUJ1zCIfbHhblJUQtuIVQkwoPH0c1wNrP2D5rlF
   oaenYJBMEbPlymZzQC4RLMBbh1DhbxkR3O8cXkedEzT6oYIIXgRYAs8L6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429233"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429233"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658427"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:48 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 05/11] soundwire: intel: remove clock_stop parameter in intel_shim_init()
Date:   Tue, 20 Sep 2022 01:57:15 +0800
Message-Id: <20220919175721.354679-6-yung-chuan.liao@linux.intel.com>
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

Simplify signature before further code reshuffling.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 676de04c5070..2d828d98e153 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -391,7 +391,7 @@ static void intel_shim_master_ip_to_glue(struct sdw_intel *sdw)
 	/* at this point Integration Glue has full control of the I/Os */
 }
 
-static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
+static int intel_shim_init(struct sdw_intel *sdw)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
@@ -1277,14 +1277,10 @@ static struct sdw_master_ops sdw_intel_ops = {
 
 static int intel_init(struct sdw_intel *sdw)
 {
-	bool clock_stop;
-
 	/* Initialize shim and controller */
 	intel_link_power_up(sdw);
 
-	clock_stop = sdw_cdns_is_clock_stop(&sdw->cdns);
-
-	intel_shim_init(sdw, clock_stop);
+	intel_shim_init(sdw);
 
 	return 0;
 }
-- 
2.25.1

