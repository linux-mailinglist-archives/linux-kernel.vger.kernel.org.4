Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00EC6B8DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCNIwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCNIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:52:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8015FEBC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678783931; x=1710319931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Yj0GSMmOs2YYXqr06EInVLu8RfOxE3KaMBdDBlgZbk=;
  b=bocXX4i8aGiVCRVfSSACWMzDrtQOsk35N/EnGi91tKXrPP/ReGi72oWH
   OeZ7VdYprp7r6njn6s5GMhoU+dIWuiQPGh0+Ggf9HgdjNVjGLr7MuYYwW
   dbAAnEAV0GX9mPcv4BNlck81s1CPZQ9ixCfm2i9wJXcZOuYZWfULw7J1z
   TJ5HquvVy8/m2QbeZyb/JBq8CdsNZ53XZ+NTuA01k0ywOnnaemXpbrbjG
   SZSGENwelzoChhvepktTbpNeq9qA8Dc5MwOOvVLP66eM8irvHdpF39ccH
   YkxU8Z/XBMe9dN+JAYuQUZm/mzaMaKlcqHwSCLPrwxXRKXZd5xCGfm5ZK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="399956499"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="399956499"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 01:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="768011941"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="768011941"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 01:52:08 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        broonie@kernel.org, peter.ujfalusi@linux.intel.com
Subject: [PATCH] soundwire: dmi-quirks: add remapping for Intel 'Rooks County' NUC M15
Date:   Tue, 14 Mar 2023 17:06:18 +0800
Message-Id: <20230314090618.498716-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Huang <eugene.huang99@gmail.com>

Same DSDT problem as the HP Omen 16-k0005TX, except rt1316 amp is on
link2.

Link: https://github.com/thesofproject/linux/issues/4088
Signed-off-by: Eugene Huang <eugene.huang99@gmail.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
To support 'Rooks County', we also need the
"ASOC: Intel: add quirk for Intel 'Rooks County' NUC M15" series.

---
 drivers/soundwire/dmi-quirks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 7969881f126d..58ea013fa918 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -73,6 +73,23 @@ static const struct adr_remap hp_omen_16[] = {
 	{}
 };
 
+/*
+ * Intel NUC M15 LAPRC510 and LAPRC710
+ */
+static const struct adr_remap intel_rooks_county[] = {
+	/* rt711-sdca on link0 */
+	{
+		0x000020025d071100ull,
+		0x000030025d071101ull
+	},
+	/* rt1316-sdca on link2 */
+	{
+		0x000120025d071100ull,
+		0x000230025d131601ull
+	},
+	{}
+};
+
 static const struct dmi_system_id adr_remap_quirk_table[] = {
 	/* TGL devices */
 	{
@@ -98,6 +115,14 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		/* quirk used for NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel(R) Client Systems"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LAPRC"),
+		},
+		.driver_data = (void *)intel_rooks_county,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
-- 
2.25.1

