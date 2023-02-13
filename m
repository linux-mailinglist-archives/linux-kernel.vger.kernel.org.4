Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745169426C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBMKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjBMKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:11:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4567EB6E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:11:39 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so18075892lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiRAvYfruz2LwVkJecvV8bOL6r0255EKOkvzv5hr740=;
        b=TiK8XnATOnj70Vd48zegfPwLdxp9VAHHam3Q5OPSfn6GOAaaXMvF+oRT7Hih1o6TDO
         8TPizkNDh0X++hSjXcQ99cBOtbcBLrsSvztSvxu8j0dZO2KaPaRhNAEhtLd3M/6o8lkl
         ytDaRdIJgcFQ4DePsZCAB5ojlht3JWscXJ6cU3XSv72PY0oa/NcxYCYZzJiXl0yEkRgV
         5a2me/VyI88/8MM/Yciu6mmrWahP5+NPXnWUEvhBT7EsTczKm4XvMJn3EMNS1oi0yqgB
         qfIZmnY/BVZCjfWZ8j5CtCJ247Peu/xLosA/+ol79EIa8k0D4jucZXwKLFP1Q3+vCJmx
         UEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiRAvYfruz2LwVkJecvV8bOL6r0255EKOkvzv5hr740=;
        b=Th4Dct0f80wwvv55X0s93Q0oG3OtDMQT6qdjdHn1lC+F4w+yPLvdNQlfqUkq6jGBHb
         h30V5MC8H3wGHBTzWqiTkbnj4Z+GLbZo0uKa75pQCcjMd3LSam8K/RyBoVeAEJtGa4r8
         UrSOBVTWqaspiyD/Gy95yU4pABpH0XKXCsanY0KKuDpHbKQM0butIjEYsKs3CcoEGvxu
         WvJAjAjk4nlgH7Zs+E1PFqJ2P2UQQ5bYnM8KCBkSf9/vHns/zFVeusytA7cKIhnVMnEp
         Lvq7BpANJoB/kTGKKsu1X/xke+f8fJgcGIfndcde/2By/1bW/6aDSzi8FtVkCqwsu+lF
         +bLg==
X-Gm-Message-State: AO0yUKXNFlqZ3471a1FpicXB3ZahZSP6duA/GV7cpRXRV6SYjAgs+2wu
        SArYVsEBC+UtYFholcS2fTo6BP8/J8SmwfnapyE=
X-Google-Smtp-Source: AK7set9/jBHFXSbATRj6t/69h0znHJ7EalDvMZumXrTdcY+nIWuLh0rni3xqTLIOVrqvieMqOiewFA==
X-Received: by 2002:ac2:5319:0:b0:4db:964:51b5 with SMTP id c25-20020ac25319000000b004db096451b5mr5015516lfh.41.1676283097810;
        Mon, 13 Feb 2023 02:11:37 -0800 (PST)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b004b55da14ba8sm834416lfc.291.2023.02.13.02.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 02:11:37 -0800 (PST)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, hdegoede@redhat.com, markgross@kernel.org,
        dtor@google.com, mario.limonciello@amd.com,
        linux-pm@vger.kernel.org, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [RFCv3 1/1] platform/x86: Add virtual PMC driver used for S2Idle
Date:   Mon, 13 Feb 2023 10:09:21 +0000
Message-Id: <20230213100921.268770-2-jaz@semihalf.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
In-Reply-To: <20230213100921.268770-1-jaz@semihalf.com>
References: <20230213100921.268770-1-jaz@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual PMC driver is meant for the guest VMs for the S2Idle
notification. Its purpose is to register S2Idle dev ops check handler,
which will evaluate ACPI _DSM just before the guest enters S2Idle power
state.

This allows to trap on MMIO access done as a consequence of _DSM
evaluation and therefore notify the VMM about the guest entering S2Idle
state.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
Changelog v1..v2:
- Take advantage of acpi_s2idle_dev_ops's check() instead of notify()

Changelog v2..v3:
- Add MODULE_LICENSE
- Remove "amd" prefixes
- Be more verbose in VIRT_PMC config description and make it
  HYPERVISOR_GUEST dependent
- Add extra check ensuring that DSM method supports ACPI_VIRT_PMC_NOTIFY function
---
 drivers/platform/x86/Kconfig    |  7 +++
 drivers/platform/x86/Makefile   |  3 ++
 drivers/platform/x86/virt_pmc.c | 83 +++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 drivers/platform/x86/virt_pmc.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5692385e2d26..837ce201b68b 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
 	  buttons below the display. This module adds an input device
 	  that delivers key events when these buttons are pressed.
 
+config VIRT_PMC
+	tristate "Virtual Power Management Controller"
+	depends on ACPI && SUSPEND && HYPERVISOR_GUEST
+	help
+	  The Virtual PMC driver is meant for the guest VMs and its main
+	  purpose is to notify about guest entering s2idle state.
+
 endif # X86_PLATFORM_DEVICES
 
 config P2SB
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 1d3d1b02541b..c4d3056cf4ea 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -129,6 +129,9 @@ obj-$(CONFIG_INTEL_SCU_WDT)		+= intel_scu_wdt.o
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
 obj-$(CONFIG_X86_INTEL_LPSS)		+= pmc_atom.o
 
+# Virtual PMC
+obj-$(CONFIG_VIRT_PMC)			+= virt_pmc.o
+
 # Siemens Simatic Industrial PCs
 obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= simatic-ipc.o
 
diff --git a/drivers/platform/x86/virt_pmc.c b/drivers/platform/x86/virt_pmc.c
new file mode 100644
index 000000000000..a5966bb9048f
--- /dev/null
+++ b/drivers/platform/x86/virt_pmc.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Virtual Power Management Controller Driver
+ *
+ * Author: Grzegorz Jaszczyk <jaz@semihalf.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+
+#define ACPI_VIRT_PMC_DSM_UUID	"9ea49ba3-434a-49a6-be30-37cc55c4d397"
+#define ACPI_VIRT_PMC_NOTIFY 1
+
+static acpi_handle virt_pmc_handle;
+
+static void virt_pmc_s2idle_notify(void)
+{
+	union acpi_object *out_obj;
+	guid_t dsm_guid;
+
+	guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
+
+	out_obj = acpi_evaluate_dsm(virt_pmc_handle, &dsm_guid,
+					0, ACPI_VIRT_PMC_NOTIFY, NULL);
+
+	acpi_handle_debug(virt_pmc_handle, "_DSM function %u evaluation %s\n",
+			  ACPI_VIRT_PMC_NOTIFY, out_obj ? "successful" : "failed");
+
+	ACPI_FREE(out_obj);
+}
+
+static struct acpi_s2idle_dev_ops pmc_s2idle_dev_ops = {
+	.check = virt_pmc_s2idle_notify,
+};
+
+static int virt_pmc_probe(struct platform_device *pdev)
+{
+	int err = 0;
+	guid_t dsm_guid;
+
+	virt_pmc_handle = ACPI_HANDLE(&pdev->dev);
+
+	guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
+
+	if (!acpi_check_dsm(virt_pmc_handle, &dsm_guid, 0,
+			    1 << ACPI_VIRT_PMC_NOTIFY)) {
+		dev_err(&pdev->dev, "DSM method doesn't support ACPI_VIRT_PMC_NOTIFY\n");
+		return -ENODEV;
+	}
+
+	err = acpi_register_lps0_dev(&pmc_s2idle_dev_ops);
+	if (err)
+		dev_err(&pdev->dev, "failed to register LPS0 sleep handler\n");
+
+	return err;
+}
+
+static int virt_pmc_remove(struct platform_device *pdev)
+{
+	acpi_unregister_lps0_dev(&pmc_s2idle_dev_ops);
+
+	return 0;
+}
+
+static const struct acpi_device_id virt_pmc_acpi_ids[] = {
+	{"HYPE0001", 0}, /* _HID for XXX Power Engine, _CID PNP0D80*/
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, virt_pmc_acpi_ids);
+
+static struct platform_driver virt_pmc_driver = {
+	.driver = {
+		.name = "virtual_pmc",
+		.acpi_match_table = ACPI_PTR(virt_pmc_acpi_ids),
+	},
+	.probe = virt_pmc_probe,
+	.remove = virt_pmc_remove,
+};
+
+module_platform_driver(virt_pmc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Virtual PMC Driver");
-- 
2.39.1.581.gbfd45094c4-goog

