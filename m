Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD38E671998
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjARKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjARKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:48:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED10422787;
        Wed, 18 Jan 2023 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674035654; x=1705571654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BOTxY6LIKS8Qfh9o8JMIxVAK68ueeJgY2bTbXYW+tmI=;
  b=OKTD+y9m1RzFBaqlzhZMwAXZKR0yIWzcWs/ssk8iNnnQd7XZ3P8Quit8
   VlVUB7uzEjRqGKDjq3Ptzqk8z7p2nmKnOgNEdGtoIZDCfanoRzj6vxq0O
   jUrrkj5eqkHzR+n3WIV841yTDQq8ettXCrOfpazwSaOLLIZCQMznIAsXn
   2iZ3CjeIvdT5PtT+J6pw6hKTLxXQeYeMdxfXW3yXOgjMBXItellcxeGM8
   7KxiO5ch/58W5ku0PqtdPBSrS/qnRWj/VwJHTwgcNVWvDbmP1FpEyGx1m
   QA2SIPuAPTa22+F8PgOEEHsS+57pn6ct4fRObmSc4CNa7/7BY+1ghzap/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="352191259"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="352191259"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 01:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="988475708"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="988475708"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2023 01:54:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2066E368; Wed, 18 Jan 2023 11:54:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 1/1] platform/x86: intel/pmc: Switch to use acpi_evaluate_dsm_typed()
Date:   Wed, 18 Jan 2023 11:54:40 +0200
Message-Id: <20230118095440.41634-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/tgl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index e3e50538465d..c245ada849d0 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -221,9 +221,9 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 
 	guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
 
-	out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
-				    ACPI_GET_LOW_MODE_REGISTERS, NULL);
-	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
+	out_obj = acpi_evaluate_dsm_typed(adev->handle, &s0ix_dsm_guid, 0,
+					  ACPI_GET_LOW_MODE_REGISTERS, NULL, ACPI_TYPE_BUFFER);
+	if (out_obj) {
 		u32 size = out_obj->buffer.length;
 
 		if (size != lpm_size) {
-- 
2.39.0

