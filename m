Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E95EEBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiI2CiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiI2CiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:38:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6B9811E0C8;
        Wed, 28 Sep 2022 19:38:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FEE622EE;
        Wed, 28 Sep 2022 19:38:10 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 350C83F73B;
        Wed, 28 Sep 2022 19:37:56 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Jia He <justin.he@arm.com>
Subject: [PATCH v7 3/8] EDAC:ghes: Move ghes_edac.force_load to ghes module parameter
Date:   Thu, 29 Sep 2022 02:37:21 +0000
Message-Id: <20220929023726.73727-4-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929023726.73727-1-justin.he@arm.com>
References: <20220929023726.73727-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ghes_edac_register() is too late to set this module flag ghes_edac.force_load.
Also, other edac drivers should not be able to control this flag.

Move this flag to the module parameter in ghes instead.

Suggested-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Jia He <justin.he@arm.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
---
 drivers/acpi/apei/ghes.c |  8 ++++++++
 drivers/edac/ghes_edac.c | 10 +++-------
 include/acpi/apei.h      |  2 ++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8cb65f757d06..b0a6445c6da2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -109,6 +109,14 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 bool ghes_disable;
 module_param_named(disable, ghes_disable, bool, 0);
 
+/*
+ * "ghes.edac_force_enable" forcibly enables ghes_edac and skips the platform
+ * check.
+ */
+bool ghes_edac_force_enable;
+EXPORT_SYMBOL(ghes_edac_force_enable);
+module_param_named(edac_force_enable, ghes_edac_force_enable, bool, 0);
+
 /*
  * All error sources notified with HED (Hardware Error Device) share a
  * single notifier callback, so they need to be linked and checked one
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7b8d56a769f6..11a1b5e7e484 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -54,10 +54,6 @@ static DEFINE_MUTEX(ghes_reg_mutex);
  */
 static DEFINE_SPINLOCK(ghes_lock);
 
-/* "ghes_edac.force_load=1" skips the platform check */
-static bool __read_mostly force_load;
-module_param(force_load, bool, 0);
-
 static bool system_scanned;
 
 /* Memory Device - Type 17 of SMBIOS spec */
@@ -408,10 +404,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	if (IS_ENABLED(CONFIG_X86)) {
 		/* Check if safe to enable on this system */
 		idx = acpi_match_platform_list(plat_list);
-		if (!force_load && idx < 0)
+		if (!ghes_edac_force_enable && idx < 0)
 			return -ENODEV;
 	} else {
-		force_load = true;
+		ghes_edac_force_enable = true;
 		idx = 0;
 	}
 
@@ -535,7 +531,7 @@ void ghes_edac_unregister(struct ghes *ghes)
 	struct mem_ctl_info *mci;
 	unsigned long flags;
 
-	if (!force_load)
+	if (!ghes_edac_force_enable)
 		return;
 
 	mutex_lock(&ghes_reg_mutex);
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524..ab310393766e 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -27,9 +27,11 @@ extern int hest_disable;
 extern int erst_disable;
 #ifdef CONFIG_ACPI_APEI_GHES
 extern bool ghes_disable;
+extern bool ghes_edac_force_enable;
 void __init acpi_ghes_init(void);
 #else
 #define ghes_disable 1
+#define ghes_edac_force_enable 0
 static inline void acpi_ghes_init(void) { }
 #endif
 
-- 
2.25.1

