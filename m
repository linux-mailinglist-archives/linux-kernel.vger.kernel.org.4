Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA05EC6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiI0OuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiI0Ot0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:49:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6EB491C7;
        Tue, 27 Sep 2022 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664290032; x=1695826032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkJ7r9qIGFbqcyFndSrUSN7w20yIgGyauGNBmBcaZzY=;
  b=blwyBofWqNOIFH21AY7o9HNwic2YXA2WwGcM9pDnRSkoQa3wD5E27r86
   K5tLx5wmK+OWsQiqLO0x1+RjA6lcTTp5LIl0pp3zxH19d7/aAZG2Grspn
   046N+TWZE2Cbl9IBOpOSDA4f2y/GCaYbz0pPcgFinCIAtnn4m7ToTOA43
   nHEoZMD+Gnvl0aw+pQBZ1LbKca80rxB98hsVNK2XZwp8vIWTsF4HpxvAO
   ZGdmbmYZ8mXE+w3OV3XgrqCGaUREupnLcvke9qQWkpKbDp11FVcRsF1+N
   TWV1XcIEkhekaqmDetufQaS2nP0amqCLD39/N5pDxcJHxUnrTMvwcMfsO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="387621583"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="387621583"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684015493"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="684015493"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 07:47:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8BD4541; Tue, 27 Sep 2022 17:47:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 1/8] pwm: lpss: Deduplicate board info data structures
Date:   Tue, 27 Sep 2022 17:47:16 +0300
Message-Id: <20220927144723.9655-2-andriy.shevchenko@linux.intel.com>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Move the board info structures from the glue drivers to the
common library and hence deduplicate configuration data.

For the Intel Braswell case the ACPI version should be used.
Because switch to ACPI/PCI is done in BIOS while quite likely
the rest of AML code is the same, meaning similar issue might
be observed. There is no bug report due to no PCI enabled device
in the wild, Andy thinks, and only reference boards can be tested,
so nobody really cares about Intel Braswell PCI case.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 29 ----------------------------
 drivers/pwm/pwm-lpss-platform.c | 22 ---------------------
 drivers/pwm/pwm-lpss.c          | 34 +++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-lpss.h          |  5 +++++
 4 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index c893ec3d2fb4..75b778e839b3 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -14,35 +14,6 @@
 
 #include "pwm-lpss.h"
 
-/* BayTrail */
-static const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
-	.clk_rate = 25000000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-};
-
-/* Braswell */
-static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
-	.clk_rate = 19200000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-};
-
-/* Broxton */
-static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
-	.clk_rate = 19200000,
-	.npwm = 4,
-	.base_unit_bits = 22,
-	.bypass = true,
-};
-
-/* Tangier */
-static const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
-	.clk_rate = 19200000,
-	.npwm = 4,
-	.base_unit_bits = 22,
-};
-
 static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 928570430cef..834423c34f48 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -15,28 +15,6 @@
 
 #include "pwm-lpss.h"
 
-/* BayTrail */
-static const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
-	.clk_rate = 25000000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-};
-
-/* Braswell */
-static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
-	.clk_rate = 19200000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-	.other_devices_aml_touches_pwm_regs = true,
-};
-
-/* Broxton */
-static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
-	.clk_rate = 19200000,
-	.npwm = 4,
-	.base_unit_bits = 22,
-	.bypass = true,
-};
 
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 36d4e83e6b79..9537aefd254a 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -29,6 +29,40 @@
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
 
+/* BayTrail */
+const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
+	.clk_rate = 25000000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
+
+/* Braswell */
+const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
+	.clk_rate = 19200000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+	.other_devices_aml_touches_pwm_regs = true,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
+
+/* Broxton */
+const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+	.base_unit_bits = 22,
+	.bypass = true,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
+
+/* Tangier */
+const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+	.base_unit_bits = 22,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_tng_info);
+
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct pwm_lpss_chip, chip);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 8b3476f25e06..9ea5b145a353 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -33,6 +33,11 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
+extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
+
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
 
-- 
2.35.1

