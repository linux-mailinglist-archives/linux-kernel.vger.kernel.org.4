Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3106E43CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjDQJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjDQJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:27:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F4B124;
        Mon, 17 Apr 2023 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681723637; x=1713259637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ObafpPWGOB15TTIwWlX+Llio4ED2dHIv4yF0spSxGCI=;
  b=X3/+WSonSYtMolbV8AspCn9XEiqbMCAOJUYiuumDZOLlKmDpSc++48W0
   PaHJ4TjLCEM4a5hTJjgjUVN2jzAhjursAYyjhRoAUoYing8BUAOEG/bGP
   AdgdT6YCSHLRBoqtGVxdYMv+0RcvQfy15olE1k9bHZw8G/DfY4DE39Cq0
   rwz4ccmPGmhwxmwus8nTHFapOoWLlhJ9VD5h3apujqxODRVtBCiObNaGd
   HWIRIm7gIsEfruRfoqFxjevUEMZd3829OYqC6XEjlarKzwlYtto/JdfjU
   huN6+/e6OHO68+ITIuts+gul5h8nh/cyuR92j/bTUyPOjYC6R4yVcS4zw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="344846487"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="344846487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="684094823"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="684094823"
Received: from anicosix-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.35.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 02:27:10 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/4] mfd: intel-m10-bmc: Create m10bmc_sys_update_bits()
Date:   Mon, 17 Apr 2023 12:26:51 +0300
Message-Id: <20230417092653.16487-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
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

Wrap regmap_update_bits() with m10bmc_sys_update_bits() in order to be
able to add additional checks into it.

Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 30 ++++++++++++-------------
 drivers/mfd/intel-m10-bmc-core.c        |  9 ++++++++
 include/linux/mfd/intel-m10-bmc.h       |  4 ++++
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index d7e2f9f461bc..fe0127a58eff 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -376,12 +376,11 @@ static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
 	u32 doorbell_reg, progress, status;
 	int ret, err;
 
-	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 csr_map->base + csr_map->doorbell,
-				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
-				 DRBL_RSU_REQUEST |
-				 FIELD_PREP(DRBL_HOST_STATUS,
-					    HOST_STATUS_IDLE));
+	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
+				     DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
+				     DRBL_RSU_REQUEST |
+				     FIELD_PREP(DRBL_HOST_STATUS,
+						HOST_STATUS_IDLE));
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -450,11 +449,10 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 	u32 doorbell_reg, status;
 	int ret;
 
-	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 csr_map->base + csr_map->doorbell,
-				 DRBL_HOST_STATUS,
-				 FIELD_PREP(DRBL_HOST_STATUS,
-					    HOST_STATUS_WRITE_DONE));
+	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
+				     DRBL_HOST_STATUS,
+				     FIELD_PREP(DRBL_HOST_STATUS,
+						HOST_STATUS_WRITE_DONE));
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -517,11 +515,10 @@ static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
 	if (rsu_prog(doorbell) != RSU_PROG_READY)
 		return FW_UPLOAD_ERR_BUSY;
 
-	ret = regmap_update_bits(sec->m10bmc->regmap,
-				 csr_map->base + csr_map->doorbell,
-				 DRBL_HOST_STATUS,
-				 FIELD_PREP(DRBL_HOST_STATUS,
-					    HOST_STATUS_ABORT_RSU));
+	ret = m10bmc_sys_update_bits(sec->m10bmc, csr_map->doorbell,
+				     DRBL_HOST_STATUS,
+				     FIELD_PREP(DRBL_HOST_STATUS,
+						HOST_STATUS_ABORT_RSU));
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
@@ -764,3 +761,4 @@ module_platform_driver(intel_m10bmc_sec_driver);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(INTEL_M10_BMC_CORE);
diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index c0b8209fd842..dab1bb152fd6 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -12,6 +12,15 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 
+int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
+			   unsigned int msk, unsigned int val)
+{
+	const struct m10bmc_csr_map *csr_map = m10bmc->info->csr_map;
+
+	return regmap_update_bits(m10bmc->regmap, csr_map->base + offset, msk, val);
+}
+EXPORT_SYMBOL_NS_GPL(m10bmc_sys_update_bits, INTEL_M10_BMC_CORE);
+
 static ssize_t bmc_version_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 1812ebfa11a8..5418f7279ed0 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -251,6 +251,7 @@ struct intel_m10bmc {
  *
  * m10bmc_raw_read - read m10bmc register per addr
  * m10bmc_sys_read - read m10bmc system register per offset
+ * m10bmc_sys_update_bits - update m10bmc system register per offset
  */
 static inline int
 m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
@@ -282,6 +283,9 @@ static inline int m10bmc_sys_read(struct intel_m10bmc *m10bmc, unsigned int offs
 	return m10bmc_raw_read(m10bmc, csr_map->base + offset, val);
 }
 
+int m10bmc_sys_update_bits(struct intel_m10bmc *m10bmc, unsigned int offset,
+			   unsigned int msk, unsigned int val);
+
 /*
  * MAX10 BMC Core support
  */
-- 
2.30.2

