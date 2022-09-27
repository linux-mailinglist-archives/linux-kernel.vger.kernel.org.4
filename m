Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0975EC963
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiI0QY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiI0QYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:24:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822AF177343;
        Tue, 27 Sep 2022 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295849; x=1695831849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yIqxRHRS1triyvN1zukI7EVS4f3lxjAFUc90xkhDIu4=;
  b=dp5BVjDqlQff+n5t2CUTcILZREXOYk035xXnqtWfYnF16gUS0i+SjJlM
   VCpknJhhusxtRTgVbPczTsTrF7tSkkJ6Vnuc69vd8SW1U5ysbOi/lbwLy
   cI/99WT5dP7YD5gmKMTkYDrUyybryQElcUcyRshsiqstDMsNZ66DSyo1I
   xCjCKTYcpQwgyNNbxyrVDPF/uG4wCdlRLknonRyrAKSa/Nb2zAiiTg7Xq
   gU+1a6LBJy2x5TFScdASsvTdx9RU0YR8tFJZgA/Pm8x5gmeAG9my36d5+
   nq58WXtLzx+csUknqpqI8ogjwuTCI1mw+r22qQGxvi12C6gH0VsWBIbdG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327719522"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="327719522"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684047856"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="684047856"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 09:24:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9CC46268; Tue, 27 Sep 2022 19:24:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v4 5/7] pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
Date:   Tue, 27 Sep 2022 19:24:19 +0300
Message-Id: <20220927162421.11052-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
References: <20220927162421.11052-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

