Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5A57377C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjFTXCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjFTXB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:01:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6019B;
        Tue, 20 Jun 2023 16:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687302115; x=1718838115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEYJChC6OvSO8x/YfH7LNbtmj//EuKold9s1r0acTp8=;
  b=fVVErAIbLReqPQ/oFsaLqwL1e5WAIv5rVSLyuZCADy2T4ZiPw4e+XIxk
   wGvAfpJ+O3IhBYIgIKuZhPT9szxjq96QRV+i0gGMcyRZ5d0HagGFyg5XN
   CvNmTvR0SFH1Lcz82LT0is5jlqsXnlKwExutbF74scopB9/u4V4pp0QpZ
   ZfFQhEH7Y9NHVyb0aGVusalNG5UqtXQMtebF3PWAaDLERwsh9g1rwLcfC
   Y/Tw7EyQwz6WQ16E3Au0ejKHsRvPW/eFoNabwN4Nf8q6EoFnjmii3njbA
   hqAMl1sJPpqBzvBSyGH6imCmJySn72BApjniRP+pe8Tel8XVZsqLkpCIa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340347281"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340347281"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="1044465323"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="1044465323"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jun 2023 16:01:53 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/7] thermal: int340x: processor_thermal: Use non MSI interrupts
Date:   Tue, 20 Jun 2023 16:01:46 -0700
Message-Id: <20230620230150.3068704-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are issues in using MSI interrupts for processor thermal device.
The support is not consistent, across generations. Even in the same
generation, there are issue in getting interrupts via MSI.

Hence always use legacy PCI interrupts by default, instead of MSI.
Add a module param to use of MSI, so that MSI can be still used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../processor_thermal_device_pci.c            | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 5a2bcfff0a68..057778f7bece 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -15,6 +15,11 @@
 
 #define DRV_NAME "proc_thermal_pci"
 
+static int msi_enabled;
+module_param(msi_enabled, int, 0644);
+MODULE_PARM_DESC(msi_enabled,
+	"Use PCI MSI based interrupts for processor thermal device.");
+
 struct proc_thermal_pci {
 	struct pci_dev *pdev;
 	struct proc_thermal_device *proc_priv;
@@ -219,8 +224,6 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		return ret;
 	}
 
-	pci_set_master(pdev);
-
 	INIT_DELAYED_WORK(&pci_info->work, proc_thermal_threshold_work_fn);
 
 	ret = proc_thermal_add(&pdev->dev, proc_priv);
@@ -248,16 +251,23 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 		goto err_ret_mmio;
 	}
 
-	/* request and enable interrupt */
-	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to allocate vectors!\n");
-		goto err_ret_tzone;
-	}
-	if (!pdev->msi_enabled && !pdev->msix_enabled)
+	if (msi_enabled) {
+		pci_set_master(pdev);
+		/* request and enable interrupt */
+		ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to allocate vectors!\n");
+			goto err_ret_tzone;
+		}
+		if (!pdev->msi_enabled && !pdev->msix_enabled)
+			irq_flag = IRQF_SHARED;
+
+		irq =  pci_irq_vector(pdev, 0);
+	} else {
 		irq_flag = IRQF_SHARED;
+		irq = pdev->irq;
+	}
 
-	irq =  pci_irq_vector(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					proc_thermal_irq_handler, NULL,
 					irq_flag, KBUILD_MODNAME, pci_info);
@@ -273,7 +283,8 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 	return 0;
 
 err_free_vectors:
-	pci_free_irq_vectors(pdev);
+	if (msi_enabled)
+		pci_free_irq_vectors(pdev);
 err_ret_tzone:
 	thermal_zone_device_unregister(pci_info->tzone);
 err_ret_mmio:
-- 
2.38.1

