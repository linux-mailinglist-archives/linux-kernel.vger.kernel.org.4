Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F173E5EC6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiI0OuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiI0Ot1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:49:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A24B4A6;
        Tue, 27 Sep 2022 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664290035; x=1695826035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yIqxRHRS1triyvN1zukI7EVS4f3lxjAFUc90xkhDIu4=;
  b=SOHDNIjzgUlgc78HPG4ovVj8Qhups2Hi7g9v13i4dPItBGwkTEksDKT2
   +ECyGcmxowALDxsaOYZWzzItVppkfVUMHSLGD99dFBnV02y2+/oSg85yR
   gblCB2GzpSj2aEd0khjcUZrBNhMTw01A6gH4VLgl8af272SUoBgOykpUW
   MOp1rdqY9ZL3nrTFSkXjJmDDYy8h7xRWA4QlfLb34XFMeAFvJmr5n66vT
   eWa1+OdSiecXlvid0wojR0dx2ZwCWIIBAHlNVeL0EQs/ciNItXU5QD9up
   wOC0N+C+E056qY5q7ar1ASSGnmvsiUBLAylAEMMQI39zBEY2XN+TAjtFv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="363173004"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="363173004"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621544888"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="621544888"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Sep 2022 07:47:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C044F50D; Tue, 27 Sep 2022 17:47:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 6/8] pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Tue, 27 Sep 2022 17:47:21 +0300
Message-Id: <20220927144723.9655-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using these new macros allows the compiler to remove the unused dev_pm_ops
structure and related functions if !CONFIG_PM without the need to mark
the functions __maybe_unused.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss-pci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index f3367e844e61..98413d364338 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -48,7 +48,6 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 }
 
-#ifdef CONFIG_PM
 static int pwm_lpss_runtime_suspend_pci(struct device *dev)
 {
 	/*
@@ -62,12 +61,11 @@ static int pwm_lpss_runtime_resume_pci(struct device *dev)
 {
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops pwm_lpss_pci_pm = {
-	SET_RUNTIME_PM_OPS(pwm_lpss_runtime_suspend_pci,
-			   pwm_lpss_runtime_resume_pci, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(pwm_lpss_pci_pm,
+				 pwm_lpss_runtime_suspend_pci,
+				 pwm_lpss_runtime_resume_pci,
+				 NULL);
 
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
@@ -89,7 +87,7 @@ static struct pci_driver pwm_lpss_driver_pci = {
 	.probe = pwm_lpss_probe_pci,
 	.remove = pwm_lpss_remove_pci,
 	.driver = {
-		.pm = &pwm_lpss_pci_pm,
+		.pm = pm_ptr(&pwm_lpss_pci_pm),
 	},
 };
 module_pci_driver(pwm_lpss_driver_pci);
-- 
2.35.1

