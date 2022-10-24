Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1818A609BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJXHsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJXHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:48:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFC8F7C;
        Mon, 24 Oct 2022 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666597706; x=1698133706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n3t3hqdfKpJj89QtAfnOaDaNMLDzwcJ5D4O56CW6xdA=;
  b=H52ta4TBlhkawcB5ikFVBAgHBYShyqTjM8B+CEWyd76/C7MJV2rOz7J8
   EI3tuqewT8jBn4WxWyuJD0BVIxN5ZlZEYJ0ruP1zpnQ4ZUG9E3Y0dO3Xk
   nKtDfSHycbaYAJiC8RVwHyYChqJwf4p19C/10NWJy6vsDGQjzwW2ujvY4
   sUAFl2FfWprfCtVYEuZgbZ1lvZvhNrPrGIZzWROED/JNWe9hR/scNaoBG
   hB4wqVe5XuKI6wOJOPJDoFZQ/pBaTOX7YMM1zKMEjTM5gNhDGUugDrs0c
   ccexhUIjA8udpHsMmyK0oIM3rOSm2kohogecBxZADxUkAUAQ9Hvxte33G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="369427942"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="369427942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 00:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="773733876"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="773733876"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2022 00:48:23 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] thunderbolt: ACPI: Use the helper fwnode_find_reference()
Date:   Mon, 24 Oct 2022 10:48:46 +0300
Message-Id: <20221024074846.84805-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing the direct fwnode_property_get_reference_args()
call will this wrapper function.

No functional changes intended.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v1:
- Leaving the adev check untouched.
---
 drivers/thunderbolt/acpi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 7a8adf5ad5a09..317e4f5fdb979 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -15,24 +15,20 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
 				    void **return_value)
 {
 	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
-	struct fwnode_reference_args args;
 	struct fwnode_handle *fwnode;
 	struct tb_nhi *nhi = data;
 	struct pci_dev *pdev;
 	struct device *dev;
-	int ret;
 
 	if (!adev)
 		return AE_OK;
 
-	fwnode = acpi_fwnode_handle(adev);
-	ret = fwnode_property_get_reference_args(fwnode, "usb4-host-interface",
-						 NULL, 0, 0, &args);
-	if (ret)
+	fwnode = fwnode_find_reference(acpi_fwnode_handle(adev), "usb4-host-interface", 0);
+	if (IS_ERR(fwnode))
 		return AE_OK;
 
 	/* It needs to reference this NHI */
-	if (dev_fwnode(&nhi->pdev->dev) != args.fwnode)
+	if (dev_fwnode(&nhi->pdev->dev) != fwnode)
 		goto out_put;
 
 	/*
@@ -100,7 +96,7 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
 	}
 
 out_put:
-	fwnode_handle_put(args.fwnode);
+	fwnode_handle_put(fwnode);
 	return AE_OK;
 }
 
-- 
2.35.1

