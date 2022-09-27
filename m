Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC935EC95B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiI0QYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiI0QYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:24:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280E6188BE5;
        Tue, 27 Sep 2022 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664295847; x=1695831847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkJ7r9qIGFbqcyFndSrUSN7w20yIgGyauGNBmBcaZzY=;
  b=LlzF3wUNEVgdG/ZNd836EwCKc3KJ5eOm5Xw55ObFwbdzTQb+KNjDaSWe
   NKVsiTdQJYTzceon58jy94POT69BKrGWm0PksC8XBAoAlsnHXn9aiTGOX
   FoAncwXhI5liTWEKWwruBDl0OgpwuqF8Y+0LOlsjeEiwz2OUBnf8v7dk1
   vNwyktinZMg0ICBjlkiDB6lI5Z27M0xir7o4Fr9Pj+TOi7WnwOzrQB6vM
   V1TeFDxL38m4GTnzmjwakMLpKHGmTNJ6fwe27EqN2aGwxk8012ohpunFk
   FAl4fkCwDqKIbbOKAn6CewWZyVL2aJOar5KhrqRW1Zoqp5AyStjr7LSuO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327719507"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="327719507"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 09:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684047849"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="684047849"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 09:24:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6CD6C41; Tue, 27 Sep 2022 19:24:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v4 1/7] pwm: lpss: Deduplicate board info data structures
Date:   Tue, 27 Sep 2022 19:24:15 +0300
Message-Id: <20220927162421.11052-2-andriy.shevchenko@linux.intel.com>
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

