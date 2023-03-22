Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE06C412E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjCVDkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCVDkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:40:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9C85A6D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679456430; x=1710992430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7oltbiDa+C99YUXbLVwjWGGyIggLLejPqDsKsg5dlbo=;
  b=XjKViDN4CdOWF+50GVOpI8p4alll0Rn6ChntFs3dH2wfEwf/VZc8SSk9
   F+T/2A3VpZlvU3MzYQCLUoTxNXqmlk0hKPJwm5zT2m4gHtBwzpyqhVsdj
   0bsWn5jsYQK0Vi+fChskXeaSPTX4StGpfLDLBoQJzV0YoBUpOQ1Nnme5x
   m6XHM5b0pkdjJuDi+G2AR+ApmpwE7AHXz0IfVjRUizqfNgGncXT73Nv51
   arEyYilq9jzGXtKVqaWSnlJWqRPU9XEB5bfbiZJ7Q+e5kuInDeY2uvjAC
   dKCq9XTfvM0iZP3z4gMdHPVzQks4xOgLNMDgxgXU+VJHicURj3Qn60K1f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="404002940"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="404002940"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 20:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="792377975"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="792377975"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 20:40:27 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 2/2] soundwire: stream: uniquify dev_err() logs
Date:   Wed, 22 Mar 2023 11:55:24 +0800
Message-Id: <20230322035524.1509029-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322035524.1509029-1-yung-chuan.liao@linux.intel.com>
References: <20230322035524.1509029-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

There are a couple of duplicate logs which makes harder than needed to
follow the error flows. Add __func__ or make the log unique.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index f903394ff2cf..c2191c07442b 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
-		pr_err("Bank switch failed: %d\n", ret);
+		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
 		goto restore_params;
 	}
 
@@ -1477,7 +1477,7 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 		/* Program params */
 		ret = sdw_program_params(bus, false);
 		if (ret < 0) {
-			dev_err(bus->dev, "Program params failed: %d\n", ret);
+			dev_err(bus->dev, "%s: Program params failed: %d\n", __func__, ret);
 			return ret;
 		}
 
@@ -1497,7 +1497,7 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
-		pr_err("Bank switch failed: %d\n", ret);
+		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
 		return ret;
 	}
 
@@ -1567,14 +1567,14 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
 		/* Program params */
 		ret = sdw_program_params(bus, false);
 		if (ret < 0) {
-			dev_err(bus->dev, "Program params failed: %d\n", ret);
+			dev_err(bus->dev, "%s: Program params failed: %d\n", __func__, ret);
 			return ret;
 		}
 	}
 
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
-		pr_err("Bank switch failed: %d\n", ret);
+		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
 		return ret;
 	}
 
@@ -1664,7 +1664,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 		/* Program params */
 		ret = sdw_program_params(bus, false);
 		if (ret < 0) {
-			dev_err(bus->dev, "Program params failed: %d\n", ret);
+			dev_err(bus->dev, "%s: Program params failed: %d\n", __func__, ret);
 			return ret;
 		}
 	}
@@ -1893,7 +1893,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 
 	m_rt = sdw_master_rt_alloc(bus, stream);
 	if (!m_rt) {
-		dev_err(bus->dev, "Master runtime alloc failed for stream:%s\n", stream->name);
+		dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
+			__func__, stream->name);
 		ret = -ENOMEM;
 		goto unlock;
 	}
@@ -2012,7 +2013,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	 */
 	m_rt = sdw_master_rt_alloc(slave->bus, stream);
 	if (!m_rt) {
-		dev_err(&slave->dev, "Master runtime alloc failed for stream:%s\n", stream->name);
+		dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
+			__func__, stream->name);
 		ret = -ENOMEM;
 		goto unlock;
 	}
-- 
2.25.1

