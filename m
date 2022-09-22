Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4E5E65B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiIVOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIVOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:32:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE219F50AD;
        Thu, 22 Sep 2022 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663857157; x=1695393157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OKjHW1dMKm5D2qAz3WSwiiU+cflw8eIq6V9TO1jHvJQ=;
  b=Tj8cEzgf73yjS9oJQB3iJHZnhvuTB5OeuyLnEIua5E9uqB0Qd7CTnLxr
   8bXgPkdyzs1SFmJbVaRJmC7c8NzfkaP7WytYtERM2JG5pJKaIvm5SnPb+
   IfSntTy1w3ShsPH2U3jDrcaZXy7nmflksPJxZL7/qTfkK5zuZc8tBIk4T
   U0g8OKE4atq38pS3lvhW1XOgSUtRkA19aoBfnkE9E9bt37pc3BnzvjdPL
   iJi9ndC8+h35q0V9yiiJDgBmJr6s48VSV+NYdUYz3qMtj37VxjF7YNwMd
   tqPHDP/BRkV9QgwvrKrfAkPGpTSzfs93NnFmsDEWFen/YAuIaw7ebLPrH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283364527"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="283364527"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 07:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="745401463"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Sep 2022 07:32:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5BD21238; Thu, 22 Sep 2022 17:32:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Szuying Chen <Chloe_Chen@asmedia.com.tw>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v1 2/2] thunderbolt: Use dev_err_probe()
Date:   Thu, 22 Sep 2022 17:32:40 +0300
Message-Id: <20220922143240.36878-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922143240.36878-1-andriy.shevchenko@linux.intel.com>
References: <20220922143240.36878-1-andriy.shevchenko@linux.intel.com>
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

Unify error message format by using dev_err_probe().
While at it, use temporary variable for device in
the rest of the messaging calls.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/nhi.c | 48 +++++++++++++++------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index caca9f164beb..4dce2edd86ea 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1184,6 +1184,7 @@ static void nhi_check_iommu(struct tb_nhi *nhi)
 static int nhi_init_msi(struct tb_nhi *nhi)
 {
 	struct pci_dev *pdev = nhi->pdev;
+	struct device *dev = &pdev->dev;
 	int res, irq, nvec;
 
 	/* In case someone left them on. */
@@ -1214,10 +1215,8 @@ static int nhi_init_msi(struct tb_nhi *nhi)
 
 		res = devm_request_irq(&pdev->dev, irq, nhi_msi,
 				       IRQF_NO_SUSPEND, "thunderbolt", nhi);
-		if (res) {
-			dev_err(&pdev->dev, "request_irq failed, aborting\n");
-			return res;
-		}
+		if (res)
+			return dev_err_probe(dev, res, "request_irq failed, aborting\n");
 	}
 
 	return 0;
@@ -1258,26 +1257,21 @@ static struct tb *nhi_select_cm(struct tb_nhi *nhi)
 
 static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct device *dev = &pdev->dev;
 	struct tb_nhi *nhi;
 	struct tb *tb;
 	int res;
 
-	if (!nhi_imr_valid(pdev)) {
-		dev_warn(&pdev->dev, "firmware image not valid, aborting\n");
-		return -ENODEV;
-	}
+	if (!nhi_imr_valid(pdev))
+		return dev_err_probe(dev, -ENODEV, "firmware image not valid, aborting\n");
 
 	res = pcim_enable_device(pdev);
-	if (res) {
-		dev_err(&pdev->dev, "cannot enable PCI device, aborting\n");
-		return res;
-	}
+	if (res)
+		return dev_err_probe(dev, res, "cannot enable PCI device, aborting\n");
 
 	res = pcim_iomap_regions(pdev, 1 << 0, "thunderbolt");
-	if (res) {
-		dev_err(&pdev->dev, "cannot obtain PCI resources, aborting\n");
-		return res;
-	}
+	if (res)
+		return dev_err_probe(dev, res, "cannot obtain PCI resources, aborting\n");
 
 	nhi = devm_kzalloc(&pdev->dev, sizeof(*nhi), GFP_KERNEL);
 	if (!nhi)
@@ -1288,7 +1282,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* cannot fail - table is allocated in pcim_iomap_regions */
 	nhi->iobase = pcim_iomap_table(pdev)[0];
 	nhi->hop_count = ioread32(nhi->iobase + REG_HOP_COUNT) & 0x3ff;
-	dev_dbg(&pdev->dev, "total paths: %d\n", nhi->hop_count);
+	dev_dbg(dev, "total paths: %d\n", nhi->hop_count);
 
 	nhi->tx_rings = devm_kcalloc(&pdev->dev, nhi->hop_count,
 				     sizeof(*nhi->tx_rings), GFP_KERNEL);
@@ -1301,18 +1295,14 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nhi_check_iommu(nhi);
 
 	res = nhi_init_msi(nhi);
-	if (res) {
-		dev_err(&pdev->dev, "cannot enable MSI, aborting\n");
-		return res;
-	}
+	if (res)
+		return dev_err_probe(dev, res, "cannot enable MSI, aborting\n");
 
 	spin_lock_init(&nhi->lock);
 
 	res = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (res) {
-		dev_err(&pdev->dev, "failed to set DMA mask\n");
-		return res;
-	}
+	if (res)
+		return dev_err_probe(dev, res, "failed to set DMA mask\n");
 
 	pci_set_master(pdev);
 
@@ -1323,13 +1313,11 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	tb = nhi_select_cm(nhi);
-	if (!tb) {
-		dev_err(&nhi->pdev->dev,
+	if (!tb)
+		return dev_err_probe(dev, -ENODEV,
 			"failed to determine connection manager, aborting\n");
-		return -ENODEV;
-	}
 
-	dev_dbg(&nhi->pdev->dev, "NHI initialized, starting thunderbolt\n");
+	dev_dbg(dev, "NHI initialized, starting thunderbolt\n");
 
 	res = tb_domain_add(tb);
 	if (res) {
-- 
2.35.1

