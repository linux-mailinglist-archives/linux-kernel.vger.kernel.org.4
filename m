Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8E624F90
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiKKBaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiKKB3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:29:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A4C6174F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130192; x=1699666192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R36o+T2mIWGk1g7hDAP87b/H+omxQnT6D5n2NJUDimE=;
  b=HIzqz8m1nI5DGyWn5rYarJox1hlWmH5f71viKWFX8pNWn4Rxg1UBTtQU
   Gk4OFkN396QrunwFDNeJ8MrNNf1EshcUoQIP2QPPPG7QIINI3F+STGY96
   TV+njVbRQgAXNajtlcQn6VHuetyrgVQZjI9NP8gLMJVlM1BP4H3tXQY6f
   3BiayHKFCNnsZIZYDA+xtWHE98t3G/0Bi+YGp1i7/qDrntNBs+88BSuoi
   BaqsZBu5ZWbzMu0ue7baKO70pYEf9/U7TifZPTzAvw5/vCSW1Exj2jBiq
   WJgg7CpeTpZAGdOCYI6JPMQqsSFXmBTbsv5ljG4Coatn0ZRBHD9M4ZldB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294847812"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294847812"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="780003235"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="780003235"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:29:50 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 3/7] soundwire: intel: add register_dai callback in hw_ops
Date:   Fri, 11 Nov 2022 09:31:30 +0800
Message-Id: <20221111013135.38289-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
References: <20221111013135.38289-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

No functionality change, only add indirection for DAI registration
helper.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 4 +++-
 drivers/soundwire/intel.h           | 7 +++++++
 include/linux/soundwire/sdw_intel.h | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 914f2fb43721..0496eb0d6084 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1426,6 +1426,8 @@ const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 	.debugfs_init = intel_debugfs_init,
 	.debugfs_exit = intel_debugfs_exit,
 
+	.register_dai = intel_register_dai,
+
 	.pre_bank_switch = intel_pre_bank_switch,
 	.post_bank_switch = intel_post_bank_switch,
 };
@@ -1611,7 +1613,7 @@ int intel_link_startup(struct auxiliary_device *auxdev)
 		goto err_init;
 
 	/* Register DAIs */
-	ret = intel_register_dai(sdw);
+	ret = sdw_intel_register_dai(sdw);
 	if (ret) {
 		dev_err(dev, "DAI registration failed: %d\n", ret);
 		goto err_power_up;
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 5548b8451d01..0521cab311a3 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -77,4 +77,11 @@ static inline void sdw_intel_debugfs_exit(struct sdw_intel *sdw)
 		SDW_INTEL_OPS(sdw, debugfs_exit)(sdw);
 }
 
+static inline int sdw_intel_register_dai(struct sdw_intel *sdw)
+{
+	if (SDW_INTEL_CHECK_OPS(sdw, register_dai))
+		return SDW_INTEL_OPS(sdw, register_dai)(sdw);
+	return -ENOTSUPP;
+}
+
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 211924e4ebf2..5be63d4fe62e 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -299,6 +299,7 @@ struct sdw_intel;
 /* struct intel_sdw_hw_ops - SoundWire ops for Intel platforms.
  * @debugfs_init: initialize all debugfs capabilities
  * @debugfs_exit: close and cleanup debugfs capabilities
+ * @register_dai: read all PDI information and register DAIs
  * @pre_bank_switch: helper for bus management
  * @post_bank_switch: helper for bus management
  */
@@ -306,6 +307,8 @@ struct sdw_intel_hw_ops {
 	void (*debugfs_init)(struct sdw_intel *sdw);
 	void (*debugfs_exit)(struct sdw_intel *sdw);
 
+	int (*register_dai)(struct sdw_intel *sdw);
+
 	int (*pre_bank_switch)(struct sdw_intel *sdw);
 	int (*post_bank_switch)(struct sdw_intel *sdw);
 };
-- 
2.25.1

