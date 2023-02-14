Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78056967FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjBNPZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBNPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:25:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A242A15E;
        Tue, 14 Feb 2023 07:25:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BAF0B81E18;
        Tue, 14 Feb 2023 15:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E31EC4339B;
        Tue, 14 Feb 2023 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676388316;
        bh=aHEU8l3TY9eCnoyAHAq8KH6ROVHrcCBF9T9biGdZLgk=;
        h=From:To:Cc:Subject:Date:From;
        b=SIGEShSfkdXDNx39Ew5ZNpNSMq+sW1C/lnWO0lsueXBW/eDm+zFzp3380O9AdonW7
         0/Ki3cP8h+iECaQDfR986UdJoNEDzKrBhHB0kGHVtewNzEibpFBHllUhjXX2Hk/9tP
         yiMJRrqVdjbJfastey10GIIvsKWyPyB8LUxLTF6KZMzeK2JfyqLVSQD1ZZFS1smg4U
         QKCfQtiBydLIUipGDgOHs80Yo+MQFgG3sIVGkd1PohH9yvoIADzyZGSnu5sXdXsJ7G
         8k7w/2gMGB2pyiUg9cxqlenU91BjLJGcafKCpLsTeh+LTFDpUKjcN+vY+zGDSye2aH
         eJTebZ5toBU8g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd: pmc: remove CONFIG_SUSPEND checks
Date:   Tue, 14 Feb 2023 16:25:07 +0100
Message-Id: <20230214152512.806188-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The amd_pmc_write_stb() function was previously hidden in an
ifdef to avoid a warning when CONFIG_SUSPEND is disabled, but
now there is an additional caller:

drivers/platform/x86/amd/pmc.c: In function 'amd_pmc_stb_debugfs_open_v2':
drivers/platform/x86/amd/pmc.c:256:8: error: implicit declaration of function 'amd_pmc_write_stb'; did you mean 'amd_pmc_read_stb'? [-Werror=implicit-function-declaration]
  256 |  ret = amd_pmc_write_stb(dev, AMD_PMC_STB_DUMMY_PC);
      |        ^~~~~~~~~~~~~~~~~
      |        amd_pmc_read_stb

There is now an easier way to handle this by using DEFINE_SIMPLE_DEV_PM_OPS()
to replace all the #ifdefs, letting gcc drop any of the unused functions
silently.

Fixes: b0d4bb973539 ("platform/x86/amd: pmc: Write dummy postcode into the STB DRAM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/amd/pmc.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index ab05b9ee6655..641085906baf 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -171,9 +171,7 @@ MODULE_PARM_DESC(disable_workarounds, "Disable workarounds for platform bugs");
 static struct amd_pmc_dev pmc;
 static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret);
 static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
-#ifdef CONFIG_SUSPEND
 static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
-#endif
 
 static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
 {
@@ -386,7 +384,6 @@ static int get_metrics_table(struct amd_pmc_dev *pdev, struct smu_metrics *table
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
 static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 {
 	struct smu_metrics table;
@@ -400,7 +397,6 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 		dev_dbg(pdev->dev, "Last suspend in deepest state for %lluus\n",
 			 table.timein_s0i3_lastcapture);
 }
-#endif
 
 static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
 {
@@ -673,7 +669,6 @@ static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg,
 	return rc;
 }
 
-#ifdef CONFIG_SUSPEND
 static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 {
 	switch (dev->cpu_id) {
@@ -861,9 +856,7 @@ static int __maybe_unused amd_pmc_suspend_handler(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler, NULL);
-
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler, NULL);
 
 static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_PS) },
@@ -905,7 +898,6 @@ static int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
 static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
 {
 	int err;
@@ -926,7 +918,6 @@ static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
 
 	return 0;
 }
-#endif
 
 static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
 {
@@ -1017,11 +1008,10 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, dev);
-#ifdef CONFIG_SUSPEND
-	err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	if (IS_ENABLED(CONFIG_SUSPEND))
+		err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
 	if (err)
 		dev_warn(dev->dev, "failed to register LPS0 sleep handler, expect increased power consumption\n");
-#endif
 
 	amd_pmc_dbgfs_register(dev);
 	return 0;
@@ -1035,9 +1025,8 @@ static int amd_pmc_remove(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
 
-#ifdef CONFIG_SUSPEND
-	acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
-#endif
+	if (IS_ENABLED(CONFIG_SUSPEND))
+		acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
@@ -1061,9 +1050,7 @@ static struct platform_driver amd_pmc_driver = {
 		.name = "amd_pmc",
 		.acpi_match_table = amd_pmc_acpi_ids,
 		.dev_groups = pmc_groups,
-#ifdef CONFIG_SUSPEND
-		.pm = &amd_pmc_pm,
-#endif
+		.pm = pm_sleep_ptr(&amd_pmc_pm),
 	},
 	.probe = amd_pmc_probe,
 	.remove = amd_pmc_remove,
-- 
2.39.1

