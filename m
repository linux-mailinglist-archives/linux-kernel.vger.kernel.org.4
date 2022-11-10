Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C7B624A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKJTFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiKJTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC2157B4A;
        Thu, 10 Nov 2022 11:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107110; x=1699643110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sx3L3dmcice/SW1UlG+9QaZyvdP4rfIP1/QGaOO2PdA=;
  b=btjv4kiS0E5tf0e71YU5b0rQF41/2SSZNucwzdPSiEAIzBp7MtlzDJ/Q
   gSbuBmdRgpGDCjaNcUh7O5aLBeefTL8VXH+2dya3owQKXyQKdFJKCX3Iw
   V2Z9hCEEZ0j9p3OAnHEcQvJPiMuQzGaJRC83qV4moUM2ZVur/UGRdEspf
   nc0gUE8qxodfyW3sTyHpD7En6Ge3QgBaeCD43QM695/RjmIZoHQoDa9HU
   mGqhvpDkD6pPYEoIQzuEiVk2QC9IumZ4LciqpAran+vAFGdvJqeB3iF3O
   adLGuU60LbrTFwwHtDJYozP0hc03apoi9pjOXxT/3GB0/rAYW448WX/2q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662050"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662050"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473397"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473397"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.6.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:05 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Date:   Thu, 10 Nov 2022 10:57:48 -0800
Message-Id: <20221110185758.879472-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221110185758.879472-1-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Currently the only CXL features targeted for irq support require their
message numbers to be within the first 16 entries.  The device may
however support less than 16 entries depending on the support it
provides.

Attempt to allocate these 16 irq vectors.  If the device supports less
then the PCI infrastructure will allocate that number.  Store the number
of vectors actually allocated in the device state for later use
by individual functions.

Upon successful allocation, users can plug in their respective isr at
any point thereafter, for example, if the irq setup is not done in the
PCI driver, such as the case of the CXL-PMU.

Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

---
Changes from Ira
	Remove reviews
	Allocate up to a static 16 vectors.
	Change cover letter
---
 drivers/cxl/cxlmem.h |  3 +++
 drivers/cxl/cxlpci.h |  6 ++++++
 drivers/cxl/pci.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..b7b955ded3ac 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @doe_mbs: PCI DOE mailbox array
+ * @nr_irq_vecs: Number of MSI-X/MSI vectors available
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -247,6 +248,8 @@ struct cxl_dev_state {
 
 	struct xarray doe_mbs;
 
+	int nr_irq_vecs;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eec597dbe763..b7f4e2f417d3 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -53,6 +53,12 @@
 #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
 #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
 
+/*
+ * NOTE: Currently all the functions which are enabled for CXL require their
+ * vectors to be in the first 16.  Use this as the max.
+ */
+#define CXL_PCI_REQUIRED_VECTORS 16
+
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
 	CXL_REGLOC_RBI_EMPTY = 0,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index faeb5d9d7a7a..62e560063e50 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,6 +428,36 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+static void cxl_pci_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int nvecs;
+	int rc;
+
+	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
+				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (nvecs < 0) {
+		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
+		return;
+	}
+
+	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
+	if (rc) {
+		dev_dbg(dev, "Device managed call failed; interrupts disabled.\n");
+		/* some got allocated, clean them up */
+		cxl_pci_free_irq_vectors(pdev);
+		return;
+	}
+
+	cxlds->nr_irq_vecs = nvecs;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -494,6 +524,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	cxl_pci_alloc_irq_vectors(cxlds);
+
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.37.2

