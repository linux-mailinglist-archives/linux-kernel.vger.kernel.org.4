Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A02690CCE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBIPVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjBIPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:21:45 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9B460E5C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:21:43 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so3638314lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2RnjvYdTi1EW+HUEp1YLLp7LpHmutN7MJEWL7l9roU=;
        b=lVKy0zHGwXGVsGQuqnbkoaoY8z+lSceCvkvf9yTYfdXf6OpcpHPaoJ6ca6wh6ElEUI
         A0hLu1X3Nbv/rc1uY1S1WjYVItnKKsBzFtbd6wgivVGICoLez29334f1WD6wuvf51ILX
         +lOCjSMsBc0YOfwe7c4HQGrGdPRoa+Z+OjLl8ch1EedtiSQFZSXcJWcYtOrXQUYbPJnA
         +34KarEo+QCq9GoOim6l1WnVHAq005jiRWNKYhcJfC/sdY3RQC2n3t3EDD66cjA4/Gaj
         /3b+eaJX+dik+N77NSx3ht8Pf0qLs6d954PYs10zAshpinuoTVKPSJ3o4QaQgMeZwjsM
         h1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2RnjvYdTi1EW+HUEp1YLLp7LpHmutN7MJEWL7l9roU=;
        b=RzXIUFwtLBJvho8IPVSQgldCQtOW73orNdPXKhUcy1VZv2CeftqhGNM6a4u+TjzBCx
         Hj/verApdlj95kiRP8QrvIc/sktk3c9KX1oKONDWJ8mhRmV08tiY7UXsNJMeifObw/20
         Dc0QP9tOMbn7Ee8yXlKf/84H3K22wcYfQOIs/Dhf3bSikTVNWT+LnzQH8yaH2aPeGlHo
         fhmy41ypEigwHhH5Qm+SfLS80swZmuv2P4/RpmyJ24ccVMhSluGMuDDE0sPvPNbP+K0m
         OFswZWmRtJph+tfvGPU5NcZt6Jlgqb80O0UkBMaeuSn4jjLvvo15j6BlmMgNRH7cKqdp
         40wQ==
X-Gm-Message-State: AO0yUKWvJFUwSnSLnaoIc8OrlHQyzDH8QqkOfbFogdDBAkzbMDh2wnID
        1jt+CIujryaD9J4/0vqGVJV1hxCgTloMvWn6QJo=
X-Google-Smtp-Source: AK7set8Z+Vd1ZrHRCsbzn88fRuvrKws5CVA4obTneVl3zrPjGeRG+3Pq1r7UyPY4M/nTGgfKsQT3Qg==
X-Received: by 2002:ac2:5d4e:0:b0:4cf:e904:bba5 with SMTP id w14-20020ac25d4e000000b004cfe904bba5mr3258645lfd.29.1675956102296;
        Thu, 09 Feb 2023 07:21:42 -0800 (PST)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id l7-20020ac25547000000b004d40e22c1eesm145037lfk.252.2023.02.09.07.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:21:41 -0800 (PST)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, hdegoede@redhat.com, markgross@kernel.org,
        dtor@google.com, mario.limonciello@amd.com,
        linux-pm@vger.kernel.org, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used for S2Idle
Date:   Thu,  9 Feb 2023 15:21:23 +0000
Message-Id: <20230209152123.3186930-2-jaz@semihalf.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230209152123.3186930-1-jaz@semihalf.com>
References: <20230209152123.3186930-1-jaz@semihalf.com>
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

