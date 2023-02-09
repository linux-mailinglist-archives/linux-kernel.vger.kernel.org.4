Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6143C690B27
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjBIN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBIN6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:58:49 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA265D3D3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:58:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x40so3213730lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2RnjvYdTi1EW+HUEp1YLLp7LpHmutN7MJEWL7l9roU=;
        b=G1EMNLNQwY1Ro09z8REpHrrtt82Vq7To2CSloUpidKbHJ6GxZcSGqZ2ub6KnF13fiE
         3AIfucgTMhhE6FJT6Fy6FGQvzJXXy1eqkjYr2zjTB0jvOv1/OCU4WfI4sJ08qv4YuroK
         MRiIkEJ5APTxoYso1PutWyhaDMZtq1wFqbv1VecsCT+l+w3zSdxGPCBhPBVgUKDgP+vt
         obB35LV4vvQV3zDOrWQck3ylDfpxQvlT50gvD3Ip+2a9DF4HJy+4ifkqZUjz9tWUJxp+
         f4eHcy2BfA++zzP7krH9mCZl5lwKGxZJ5jS36sJPExJ9+kEHjqPGBJlndRXrnk496puw
         KQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2RnjvYdTi1EW+HUEp1YLLp7LpHmutN7MJEWL7l9roU=;
        b=384u/9RN6krI+RZ+vTYQN1lzVvtzCHgA+GYWETCePbYIGAlbHWDdf6auGpL1aPtGWa
         DgaP2HGj6Y1jLLZaNdFlOLcFw16i+VGB4moF1T8p4pThMGC+/K4HAOdzn6BfegGAlj89
         2kNMfZJGkKfvKDuCTeaVl/V9QBq4RxnHA+G+u/N/i/YfJmcuPNoWI1lMTp02/v0NZOAI
         CsABFz5v3KR7iBnCD8DbcnS3bZSBhzdWOqeTCoVv5I33pv3jCIEyL/45aPbjDBVis6bh
         4uUIuaa11UOZdzwFt3lisDtWoxhGtGGd6VfinROiSw34RaF2zPu7N6NNq4fCXhPJmA8Z
         TI+g==
X-Gm-Message-State: AO0yUKXnQdpHXWN8fa/AmyU1XHuH6btu/FH/2yhC4xQwddnKhmj4eb2w
        0ag1csPUOARCxA7oNdT1ksI2TZmZo1zQnlCgRdI=
X-Google-Smtp-Source: AK7set/fii1b9tG+5Em/PsjLk1HxOisYq3z7GztAL1XwGRzHTafLJoR0NlyQwPTejD2LtfTnab1L6Q==
X-Received: by 2002:a05:6512:11c1:b0:4b5:b87a:3262 with SMTP id h1-20020a05651211c100b004b5b87a3262mr2990794lfr.28.1675951115654;
        Thu, 09 Feb 2023 05:58:35 -0800 (PST)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id m9-20020a056512014900b004d5786b7299sm137785lfo.5.2023.02.09.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:58:35 -0800 (PST)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, hdegoede@redhat.com, markgross@kernel.org,
        dtor@google.com, Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [RFCv2 1/1] platform/x86: Add virtual PMC driver used for S2Idle
Date:   Thu,  9 Feb 2023 13:56:46 +0000
Message-Id: <20230209135646.3179418-2-jaz@semihalf.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230209135646.3179418-1-jaz@semihalf.com>
References: <20230209135646.3179418-1-jaz@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/platform/x86/Kconfig    |  7 ++++
 drivers/platform/x86/Makefile   |  3 ++
 drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 drivers/platform/x86/virt_pmc.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5692385e2d26..b7c3f98031d7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
 	  buttons below the display. This module adds an input device
 	  that delivers key events when these buttons are pressed.
 
+config VIRT_PMC
+	tristate "Virt PMC"
+	depends on ACPI && SUSPEND
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
index 000000000000..daf9c9ed86e5
--- /dev/null
+++ b/drivers/platform/x86/virt_pmc.c
@@ -0,0 +1,73 @@
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
+	static guid_t dsm_guid;
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
+static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
+	.check = virt_pmc_s2idle_notify,
+};
+
+static int virt_pmc_probe(struct platform_device *pdev)
+{
+	int err = 0;
+
+	virt_pmc_handle = ACPI_HANDLE(&pdev->dev);
+
+	err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	if (err)
+		dev_warn(&pdev->dev, "failed to register LPS0 sleep handler\n");
+
+	return err;
+}
+
+static int virt_pmc_remove(struct platform_device *pdev)
+{
+	acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
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
+MODULE_DESCRIPTION("Virtual PMC Driver");
-- 
2.39.1.519.gcb327c4b5f-goog

