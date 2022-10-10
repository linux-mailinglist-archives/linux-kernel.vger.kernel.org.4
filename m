Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711EA5F96EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 04:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiJJChF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 22:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiJJCgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 22:36:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C00E449B50;
        Sun,  9 Oct 2022 19:36:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC5F71480;
        Sun,  9 Oct 2022 19:36:48 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BCCB3F67D;
        Sun,  9 Oct 2022 19:36:35 -0700 (PDT)
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
Subject: [PATCH v8 4/7] EDAC/ghes: Make ghes_edac a proper module to remove the dependency on ghes
Date:   Mon, 10 Oct 2022 02:35:56 +0000
Message-Id: <20221010023559.69655-5-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010023559.69655-1-justin.he@arm.com>
References: <20221010023559.69655-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
apci_init()") introduced a bug that ghes_edac_register() would be invoked
before edac_init(). Because at that time, the bus "edac" hadn't been even
registered, this created sysfs /devices/mc0 instead of
/sys/devices/system/edac/mc/mc0 on an Ampere eMag server.

To remove the dependency of ghes_edac on ghes, make it a proper module. Use
a list to save the probing devices in ghes_probe(), and defer the
ghes_edac_register() to module_init() of the new ghes_edac module by
iterating over the devices list.

Co-developed-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jia He <justin.he@arm.com>
Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c |  4 ----
 drivers/edac/Kconfig     |  4 ++--
 drivers/edac/ghes_edac.c | 40 ++++++++++++++++++++++++++++++++++++++--
 include/acpi/ghes.h      | 22 ++--------------------
 4 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6a0dcb8c0901..27c72b175e4b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1388,8 +1388,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	platform_set_drvdata(ghes_dev, ghes);
 
-	ghes_edac_register(ghes, &ghes_dev->dev);
-
 	ghes->dev = &ghes_dev->dev;
 
 	mutex_lock(&ghes_devs_mutex);
@@ -1458,8 +1456,6 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	ghes_fini(ghes);
 
-	ghes_edac_unregister(ghes);
-
 	mutex_lock(&ghes_devs_mutex);
 	list_del(&ghes->elist);
 	mutex_unlock(&ghes_devs_mutex);
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 17562cf1fe97..df45db81858b 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -53,8 +53,8 @@ config EDAC_DECODE_MCE
 	  has been initialized.
 
 config EDAC_GHES
-	bool "Output ACPI APEI/GHES BIOS detected errors via EDAC"
-	depends on ACPI_APEI_GHES && (EDAC=y)
+	tristate "Output ACPI APEI/GHES BIOS detected errors via EDAC"
+	depends on ACPI_APEI_GHES
 	select UEFI_CPER
 	help
 	  Not all machines support hardware-driven error report. Some of those
diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index b85a545d1cb0..dec1bb96e4b3 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -56,6 +56,8 @@ static DEFINE_SPINLOCK(ghes_lock);
 
 static bool system_scanned;
 
+static struct list_head *ghes_devs;
+
 /* Memory Device - Type 17 of SMBIOS spec */
 struct memdev_dmi_entry {
 	u8 type;
@@ -383,7 +385,7 @@ static struct notifier_block ghes_edac_mem_err_nb = {
 	.priority	= 0,
 };
 
-int ghes_edac_register(struct ghes *ghes, struct device *dev)
+static int ghes_edac_register(struct device *dev)
 {
 	bool fake = false;
 	struct mem_ctl_info *mci;
@@ -502,7 +504,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	return rc;
 }
 
-void ghes_edac_unregister(struct ghes *ghes)
+static void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
 	unsigned long flags;
@@ -535,3 +537,37 @@ void ghes_edac_unregister(struct ghes *ghes)
 unlock:
 	mutex_unlock(&ghes_reg_mutex);
 }
+
+static int __init ghes_edac_init(void)
+{
+	struct ghes *g, *g_tmp;
+
+	ghes_devs = ghes_get_devices();
+	if (!ghes_devs)
+		return -ENODEV;
+
+	if (list_empty(ghes_devs)) {
+		pr_info("GHES probing device list is empty");
+		return -ENODEV;
+	}
+
+	list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
+		ghes_edac_register(g->dev);
+	}
+
+	return 0;
+}
+module_init(ghes_edac_init);
+
+static void __exit ghes_edac_exit(void)
+{
+	struct ghes *g, *g_tmp;
+
+	list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
+		ghes_edac_unregister(g);
+	}
+}
+module_exit(ghes_edac_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Output ACPI APEI/GHES BIOS detected errors module via EDAC");
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index ce693e9f07a0..2e785d3554d8 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -71,32 +71,14 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
  * @nb: pointer to the notifier_block structure of the vendor record handler.
  */
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
-#endif
-
-int ghes_estatus_pool_init(int num_ghes);
-
-/* From drivers/edac/ghes_edac.c */
-
-#ifdef CONFIG_EDAC_GHES
-int ghes_edac_register(struct ghes *ghes, struct device *dev);
-
-void ghes_edac_unregister(struct ghes *ghes);
 
 struct list_head *ghes_get_devices(void);
-
 #else
-static inline int ghes_edac_register(struct ghes *ghes, struct device *dev)
-{
-	return -ENODEV;
-}
-
-static inline void ghes_edac_unregister(struct ghes *ghes)
-{
-}
-
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
 #endif
 
+int ghes_estatus_pool_init(int num_ghes);
+
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
 {
 	return gdata->revision >> 8;
-- 
2.25.1

