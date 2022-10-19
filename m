Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3068860498D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiJSOnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJSOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:42:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DFB6C117;
        Wed, 19 Oct 2022 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666189718; x=1697725718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oPd1b2RsFB8U0bOOTZPBrhSFDVyoHn3BOYgBQmWBVSY=;
  b=fpO6aG8lN/uHpowz8FSkAkr141oOoNXlQqYobyqkl9sqpQ1m8ZPvVska
   l65Xgxdbn1iLBfhQJWewyxoSvWh1YX0ox5RIBLPWI5TydCL9eb2VKAtrj
   WwY/B1FG53QhPkOGhcuISYaIFhpUsK6TO+3+YARMjhqjqK5eVw3Idj47p
   WJAbQKqGyRRnzn400AblO5xyPCIvg6MsnyihTBWYjz12oF8uISaOHik8v
   0EPoUbtRq3dro9E4PxS4CQQ3XJEnMrhvAeGMnzY6iAn9ORvYDbLtryQwm
   Crck394TyPyOTCvGxY+v//lIV9FI4hs04p4d3WdCc2mmlWddhgikf8imi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="304040483"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="304040483"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 07:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="771810982"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="771810982"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Oct 2022 07:28:32 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: ACPI: Use the helper fwnode_find_reference()
Date:   Wed, 19 Oct 2022 17:28:54 +0300
Message-Id: <20221019142854.27364-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
 drivers/thunderbolt/acpi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 7a8adf5ad5a09..48ac227e6d8a0 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -15,24 +15,17 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
 				    void **return_value)
 {
 	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
-	struct fwnode_reference_args args;
 	struct fwnode_handle *fwnode;
 	struct tb_nhi *nhi = data;
 	struct pci_dev *pdev;
 	struct device *dev;
-	int ret;
-
-	if (!adev)
-		return AE_OK;
 
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
@@ -100,7 +93,7 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
 	}
 
 out_put:
-	fwnode_handle_put(args.fwnode);
+	fwnode_handle_put(fwnode);
 	return AE_OK;
 }
 
-- 
2.35.1

