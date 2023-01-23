Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BEE677F92
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjAWPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjAWPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:24:15 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A863129E26
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:23:47 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 13B8D20E2D13;
        Mon, 23 Jan 2023 07:23:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13B8D20E2D13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674487411;
        bh=V5U0dGe/I5fPLsT2QyvbqmymDfcu/QZWw4Mvy3gGWjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQvKbGo8cIrDOydCG3spL4AUaVeGlrBPo7p9QgofABRCjv0RC9c5sN1asuZyvuICf
         JvPB3ps3aUdLfqo27z9zFSakWyOSH4WZqvXnX/u6DmRn8XKpbsEmA9q3j1GRpA//fl
         OpKH5zmVG8UdJxXeUxnXr/PIkJlPLyoqWbgTToqU=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH v1 3/8] x86/psp: Register PSP platform device when ASP table is present
Date:   Mon, 23 Jan 2023 15:22:45 +0000
Message-Id: <20230123152250.26413-4-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASP table contains the memory location of the register window for
communication with the Platform Security Processor. The device is not
exposed as an acpi node, so it is necessary to probe for the table and
register a platform_device to represent it in the kernel.

At least conceptually, the same PSP may be exposed on the PCIe bus as
well, in which case it would be necessary to choose whether to use a PCI
BAR or the register window defined in ASPT for communication. There is
no advantage to using the ACPI and there are no known bare-metal systems
that expose the ASP table, so device registration is restricted to the
only systems known to provide an ASPT: Hyper-V VMs. Hyper-V VMs also do
not expose the PSP over PCIe.

This is a skeleton device at this point, as the ccp driver is not yet
prepared to correctly probe it. Interrupt configuration will come later
on as well.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/kernel/Makefile |  2 +-
 arch/x86/kernel/psp.c    | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/psp.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f901658d9f7c..e2e19f2d08a7 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,7 +139,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= psp.o sev.o
 
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
new file mode 100644
index 000000000000..d404df47cc04
--- /dev/null
+++ b/arch/x86/kernel/psp.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/platform_data/psp.h>
+#include <linux/platform_device.h>
+#include <asm/hypervisor.h>
+
+static struct platform_device psp_device = {
+	.name           = "psp",
+	.id             = PLATFORM_DEVID_NONE,
+};
+
+static int __init psp_init_platform_device(void)
+{
+	struct psp_platform_data pdata = {};
+	struct resource res[1];
+	int err;
+
+	/*
+	 * The ACPI PSP interface is mutually exclusive with the PCIe interface,
+	 * but there is no reason to use the ACPI interface over the PCIe one.
+	 * Restrict probing ACPI PSP to platforms known to only expose the ACPI
+	 * interface, which at this time is SNP-host capable Hyper-V VMs.
+	 */
+	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
+		return -ENODEV;
+
+	err = acpi_parse_aspt(res, &pdata);
+	if (err)
+		return err;
+	err = platform_device_add_resources(&psp_device, res, 1);
+	if (err)
+		return err;
+
+	err = platform_device_register(&psp_device);
+	if (err)
+		return err;
+	return 0;
+}
+device_initcall(psp_init_platform_device);
-- 
2.25.1

