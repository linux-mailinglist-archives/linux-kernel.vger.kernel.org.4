Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB06C5CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCWChV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCWChT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:37:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA782CC48
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679539038; x=1711075038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hnhElbRld4txs7kDuoW94BJGsXBT6ijbvQTXWGdEXpY=;
  b=NsF/i0NkVDpsh1+LO3xx0AQMiUvMPSpHII5aULxGWteGoFIXs5WDrIei
   u53ojEhcOye5vOsE4ZNc/9EANPAJSTCQ5zQTJw2ABEZJ9i523kCOyR/Xa
   NU3QYOe19KCPYRuuuivd5+01N2FJkipSO0t0tZxzO9LujpyIQLrlrnxa3
   wysJm3d+Upk4UfckaHTShRKxvS8zRXV3hmuN29BZuwD20palK4RlFQmiV
   UTujKVoqGc9o9iPj6M3yLlmoEfXsCrAjBq4ceiVfafaZMx6TApWCPtv3Q
   vFRQ8yHKx6oDGROXq4maUtTZ2JGuxrtpEMXhttxBBALDwgjlxz/Bh9uIH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="340919162"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="340919162"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 19:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="928061809"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="928061809"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 19:37:16 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH] soundwire: intel_auxdevice: improve pm_prepare step
Date:   Thu, 23 Mar 2023 10:52:28 +0800
Message-Id: <20230323025228.1537107-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

In the case where multiple peripherals are attached on the same link,
it's possible that they are in different pm_runtime states.

The device_for_each_child() loop to resume all devices before a system
suspend would not work if one peripheral was active and others
suspended. pm_runtime_resume() returns 1 in the former case, which is
taken as a error. As a result, a pm_runtime suspended device might be
skipped if the first device was active.

This patch changes the behavior of the helper function to only return
zero or a negative error. A Fixes tag is not provided since there are
no existing configurations on Intel platforms with different types of
devices on the same link. Amplifiers may be used on the same link, but
they are used by the same dailink so their pm_runtime state is always
matching. This assumption may not be true in the future, so we should
improve the behavior and align with AMD.

Reported-by: Mukunda,Vijendar <vijendar.mukunda@amd.com>
Link: https://lore.kernel.org/lkml/4cbbff8a-c596-e9cc-a6cf-6f8b66607505@amd.com/
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 5021be0f4158..b21e86084f7b 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -358,10 +358,12 @@ static int intel_resume_child_device(struct device *dev, void *data)
 	}
 
 	ret = pm_request_resume(dev);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "%s: pm_request_resume failed: %d\n", __func__, ret);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int __maybe_unused intel_pm_prepare(struct device *dev)
-- 
2.25.1

