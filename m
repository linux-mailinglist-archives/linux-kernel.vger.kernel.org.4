Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699A619C12
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiKDPtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiKDPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:49:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D932B94;
        Fri,  4 Nov 2022 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667576939; x=1699112939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/AB2CHEBXiegxBIF8aHHp24X7v0gPew71riyKr6BBow=;
  b=Lqqdn+91EyWDR5E0nXLCahK5xnUvLFVzr/44jqZYUbenDs4J6OMP7oEw
   bM8GF9ydEBvfskJ9PY7zs8Lmzsye+d/xUkgSoTvxzABpuWVCiVmla49uZ
   +1PqCDNHctF72Zmyh6mRfJORurYMJhBlvsyUNFC/WgP8Xqy2oLyyoAvBh
   bsU9p5P88PGwimQYuV0n9HLLd4eZTJIrwCm2WhxP/vX1HkO+Jbp8y6QN3
   hu3O35rP4yamKyILVDFIRNqtgZJOWXiOMmetFLpQHRfhd5U6oUFg13e/w
   PdkwC1MITW7BgjNenwj/yqBssYF7228sVCBTode9rNCiTHUeKpZVuuGK3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="289714974"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="289714974"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 08:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="724394278"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="724394278"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2022 08:48:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB251F7; Fri,  4 Nov 2022 17:49:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: p2sb: Don't fail if unknown CPU is found
Date:   Fri,  4 Nov 2022 17:49:16 +0200
Message-Id: <20221104154916.35231-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have accessing P2SB from a very few places for quite known hardware.

When a new SoC appears in intel-family.h it's not obvious that it needs
to be added to p2sb.c as well. Instead, provide default BDF and refactor
p2sb_get_devfn() to always succeed. If in the future we would need to
exclude something, we may add a list of unsupported IDs.

Without this change the iTCO on Intel Commet Lake SoCs became unavailable:

  i801_smbus 0000:00:1f.4: failed to create iTCO device

Fixes: 5c7b9167ddf8 ("i2c: i801: convert to use common P2SB accessor")
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/p2sb.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 384d0962ae93..1cf2471d54dd 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -19,26 +19,23 @@
 #define P2SBC			0xe0
 #define P2SBC_HIDE		BIT(8)
 
+#define P2SB_DEVFN_DEFAULT	PCI_DEVFN(31, 1)
+
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	PCI_DEVFN(13, 0)),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	PCI_DEVFN(31, 1)),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	PCI_DEVFN(31, 1)),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		PCI_DEVFN(31, 1)),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		PCI_DEVFN(31, 1)),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		PCI_DEVFN(31, 1)),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		PCI_DEVFN(31, 1)),
 	{}
 };
 
 static int p2sb_get_devfn(unsigned int *devfn)
 {
+	unsigned int fn = P2SB_DEVFN_DEFAULT;
 	const struct x86_cpu_id *id;
 
 	id = x86_match_cpu(p2sb_cpu_ids);
-	if (!id)
-		return -ENODEV;
+	if (id)
+		fn = (unsigned int)id->driver_data;
 
-	*devfn = (unsigned int)id->driver_data;
+	*devfn = fn;
 	return 0;
 }
 
-- 
2.35.1

