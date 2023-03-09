Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26E6B1AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCIFhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCIFgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:36:45 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DDA2D45
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 21:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678340127; x=1709876127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h4Z7o2fU92HDfcLA/HWUmcnZgpdErsjzQ5HEffu/E6A=;
  b=TPhNpZwZXcIU/UqZgGjDsPb8AEFIGkTMthkV7Ynwy4e/PTW9j6BQzMIY
   JAdZGMYeaTNns4O2VwFOGEerHOiOF22LE2vnS7LV+m2pMeWSKp/I3ez7T
   EK4/ym2r6BDt2huaC8dQfnyE1G4Ze/3vi+SPfH+RnXNV9TcBJR6rQGoS3
   V1GqGi+0dpyU/XIRMiDn5iln/alL0sBf0S720YMO444NLPKPSv36oriSL
   zDPJS3Yw+wwo6SdrXCGdyv96iq8ha8DDlA8AoJkBkhVx9pcmT1RgSuoPn
   iOSkfzarznmqBVPHKkPoqmq4ZwcShtHPzWJkK5PyTC6rDTqcI1oUWAZSF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="335061912"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="335061912"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 21:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746177909"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746177909"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 21:35:19 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: stream: uniquify dev_err() logs
Date:   Thu,  9 Mar 2023 13:49:05 +0800
Message-Id: <20230309054905.21507-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

There are a couple of duplicate logs which makes harder than needed to
follow the error flows. Add __func__ or make the log unique.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 2e39587ed1de..dd09855caac9 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
-		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
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
-		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
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

