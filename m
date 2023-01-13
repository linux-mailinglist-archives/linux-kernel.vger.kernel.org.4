Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A95669310
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbjAMJe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbjAMJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:31:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE618E3E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 01:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673602042; x=1705138042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Msf7Ux2UBgkRWznDZIyNsLYT/We1sSSckwpIyVPyhL0=;
  b=k24CFPF0XV7d/QY7jk9Y7m/SwipZm4ZoGDLF2LWB2V0XA5kxz86fNYT0
   NXb7Qxh1ruAOLJrYuAMK8uX/9IeFxb8wcmyyN3qbQclBzqe6EJxEmNMx2
   TJf3utOcIOH9GIEdIhPBXO8RCetvyp1Ig/ulnpPLk/koXetjfxOZvRVtI
   Ovr2PnXjEagTEbajO0jUEnt/JUWlFDba6YMkEQ3Knrw/DCyhUbLV1u+xA
   qrcgzHInxJx5vydO9kRDF0OSULqwhksyYyN5GhxL+fiL/jzKJxza1EyQH
   5BOYeukBWBhWDSZlRu2a54Oiy1/Oe4ap/QJ5kw0v/NmYHIKBPyF0TmIal
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351189434"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="351189434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="608116087"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="608116087"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 01:27:20 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/5] soundwire: stream: uniquify dev_err() logs
Date:   Fri, 13 Jan 2023 17:35:28 +0800
Message-Id: <20230113093532.3872113-2-yung-chuan.liao@linux.intel.com>
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

There are a couple of duplicate logs which makes harder than needed to
follow the error flows. Add __func__ or make the log unique.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index df3b36670df4..e0eae0b98267 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
-		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
+		dev_err(bus->dev, "do_bank_switch failed: %d\n", ret);
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
 
@@ -1567,7 +1567,7 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
 		/* Program params */
 		ret = sdw_program_params(bus, false);
 		if (ret < 0) {
-			dev_err(bus->dev, "Program params failed: %d\n", ret);
+			dev_err(bus->dev, "%s: Program params failed: %d\n", __func__, ret);
 			return ret;
 		}
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

