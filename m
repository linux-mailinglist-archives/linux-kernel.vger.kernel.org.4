Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ED96940F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBMJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjBMJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:25:01 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17FBC7A87
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:24:58 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id E555420C8B75;
        Mon, 13 Feb 2023 01:24:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E555420C8B75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676280297;
        bh=f9Xx8zd3cC548f76QwXZyTN1kcFg1eYeHzMUDFo62GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZQQ2O7Nd5vLeG2HLnBUkGl7LSBRS1xjMlq1HBa0j8hIdNM3YXthX9ARB/RcOcfAo
         ELD9XF+kPonyECix4PmTDi4PPQtbN47LtD7zDzBIZ41D+eo63MlmbB+mEc1RJivJJc
         MwQm0SFTybhMre1t/piwmmX+FOK2oSqEKXjx7eYE=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH v2 3/8] x86/psp: Register PSP platform device when ASP table is present
Date:   Mon, 13 Feb 2023 09:24:24 +0000
Message-Id: <20230213092429.1167812-4-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
References: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
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
 arch/x86/kernel/Makefile |  1 +
 arch/x86/kernel/psp.c    | 42 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 arch/x86/kernel/psp.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f901658d9f7c..f7b71aa245e8 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,6 +139,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
+obj-$(CONFIG_KVM_AMD_SEV)		+= psp.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
new file mode 100644
index 000000000000..64f3bfc5c9ff
--- /dev/null
+++ b/arch/x86/kernel/psp.c
@@ -0,0 +1,42 @@
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
+	err = platform_device_add_data(&psp_device, &pdata, sizeof(pdata));
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

