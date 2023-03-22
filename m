Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2286C412C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCVDkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCVDk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:40:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960626C22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679456428; x=1710992428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJz7FcUe9hColoZIPnIl1BZwjUCTD5+hSuVxXnTu59g=;
  b=V16y0XYkL+0UFOsMfIm7ZzHFQBOCfR1KsBq5a+U7Mrm0DNY5iBrhBTN6
   TeQYkJL0Sl5Il1W0p87iIGMZ0e59woBYL2VPgicgDJMBJpZqdq1csgKLu
   bkhkdwgZVG9qm9IUMmgMxs7ZHQzZ7o7VtRqoi9wJWeVhMwWlYZA3Y4wrj
   Leca9X43mrZwKlEgteJsFZZxfi5Hzeu8lbX2xPpot0b2BgmPpoNgqelnw
   yXWgDq9er1/7tjq0fuTSi6nX1e8GbY0xBoqtJzf2lhtrJaYByjJe/Wo+B
   qHsO3MbscMJujiL3VJ39KpYT7gYU383DOxSSQva2oY0aedunIu0nANA/h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="404002936"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="404002936"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 20:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="792377967"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="792377967"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 20:40:25 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 1/2] soundwire: stream: remove bus->dev from logs on multiple buses
Date:   Wed, 22 Mar 2023 11:55:23 +0800
Message-Id: <20230322035524.1509029-2-yung-chuan.liao@linux.intel.com>
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

A stream may depend on multiple managers/buses, e.g. for the multiple
amplifier case. It's incorrect to use bus->dev in this case.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 136b6850a3f0..f903394ff2cf 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
-		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
+		pr_err("Bank switch failed: %d\n", ret);
 		goto restore_params;
 	}
 
@@ -1497,7 +1497,7 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 
 	ret = do_bank_switch(stream);
 	if (ret < 0) {
-		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
+		pr_err("Bank switch failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.25.1

