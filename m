Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11FD6D7B17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbjDELUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbjDELUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:20:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4061A2D4B;
        Wed,  5 Apr 2023 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680693604; x=1712229604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/D+KMtNUyjC0eIuiIv2CPWd8+/+69Ohr6yJ5US8lLIo=;
  b=ifSLdRKR427iCB6r81rf6hbH8VwjrBTvk38Iypb7D84yLmPipP8lT6L4
   GR97icsiezloLiWlvXH5XmqbXcDCxKcxICg1MigrfN/WSKNFxjAn5EnHU
   V0DCNVzlZeohIn3b3GjZM8ZqNZnAWJ+ft7uAv1AhO3GqHFBudORzU9+2S
   wq9NhTf4GmUHUY+e00B0pso6j9daf9EAL462NqM6ZowI1F77RyH2lVytt
   4a1UHO+uv0q71g0CljssGy15gJhhjeOjqRYB5r5znjyeKrwiZEbrJBSVw
   0DF1N4H8fZauK/dzJFsZSQEmkRnHdlQTrQU6GU0zr4QDiwX7XY59jZIF8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="370252803"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="370252803"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 04:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="810598555"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="810598555"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 05 Apr 2023 04:20:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 224721D5; Wed,  5 Apr 2023 14:20:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v1 1/1] usb: dwc3: pci: Change PCI device macros
Date:   Wed,  5 Apr 2023 14:20:01 +0300
Message-Id: <20230405112001.39695-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

Use PCI_DEVICE_DATA() macro. No functional changes are expected.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 132 ++++++++++--------------------------
 1 file changed, 34 insertions(+), 98 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index a23ddbb81979..a97a6d346665 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -387,104 +387,40 @@ static void dwc3_pci_remove(struct pci_dev *pci)
 }
 
 static const struct pci_device_id dwc3_pci_id_table[] = {
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BSW),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BYT),
-	  (kernel_ulong_t) &dwc3_pci_intel_byt_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MRFLD),
-	  (kernel_ulong_t) &dwc3_pci_intel_mrfld_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CMLLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CMLH),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SPTLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_SPTH),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BXT),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BXT_M),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_APL),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_KBP),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_GLK),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CNPLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CNPH),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CNPV),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICLLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_EHL),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGPLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGPH),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_JSP),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL_PCH),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLN),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLN_PCH),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLS),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_RPL),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_RPLS),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MTLM),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MTLP),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MTL),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGL),
-	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
-
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NL_USB),
-	  (kernel_ulong_t) &dwc3_pci_amd_swnode, },
-
-	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_MR),
-	  (kernel_ulong_t)&dwc3_pci_amd_mr_swnode, },
+	{ PCI_DEVICE_DATA(INTEL, BSW, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, BYT, &dwc3_pci_intel_byt_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, MRFLD, &dwc3_pci_intel_mrfld_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, CMLLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, CMLH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, SPTLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, SPTH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, BXT, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, BXT_M, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, APL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, KBP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, GLK, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, CNPLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, CNPH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, CNPV, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ICLLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, EHL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, TGPLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, TGPH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, JSP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ADL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ADL_PCH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ADLN, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ADLN_PCH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ADLS, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, RPL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, RPLS, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, MTLM, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, MTLP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, MTL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, TGL, &dwc3_pci_intel_swnode) },
+
+	{ PCI_DEVICE_DATA(AMD, NL_USB, &dwc3_pci_amd_swnode) },
+	{ PCI_DEVICE_DATA(AMD, MR, &dwc3_pci_amd_mr_swnode) },
 
 	{  }	/* Terminating Entry */
 };
-- 
2.40.0.1.gaa8946217a0b

