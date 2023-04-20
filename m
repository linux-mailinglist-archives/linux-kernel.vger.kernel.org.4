Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2036E9E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjDTWHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDTWG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:06:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB523C1B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028410; x=1713564410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RoRP+ak75xtj8epEFOITeTaJ3nELbWFyH3TBq416Xuw=;
  b=BBz6ORoP2MZoNfI7gXrvJJL0s/dyk1tc1HB6TtbWXm+pVn2sKY4Hu/aA
   pQsypLzc4FnWQylhJwpkM1DhlM/eMHS7b0yZKeci6UhOSVnvoF4ROj0rA
   DoPTEvmWcnwOa0oaxPQDsu9NoqJ5rg7EWMuy99id6j72Nr1IiMiASV+lW
   9WvNx+s94zHm3Gcy/uQMvMhSMA3iV8FGkvrWkI2zUzIErBy6PMjPMaNvN
   ONx13eMiKEB5G3EOYfR/MLtqweVtU9yhk+O3P1IIH2ffeR9OvaoNQ4EJq
   4pGe3jlwdd5o1M47YwCYNt1j17/TEzRXSvAlvKFgxwef6CHyJCssxt3o4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348650958"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348650958"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724583774"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724583774"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:06:46 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 7/7] x86/resctrl: Example resctrl driver
Date:   Thu, 20 Apr 2023 15:06:36 -0700
Message-Id: <20230420220636.53527-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420220636.53527-1-tony.luck@intel.com>
References: <20230420220636.53527-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply add two files to each ctrlmon directory that show the closid and
rmid respectively.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../cpu/resctrl/drivers/resctrl_example.c     | 77 +++++++++++++++++++
 arch/x86/Kconfig                              | 11 +++
 arch/x86/kernel/cpu/resctrl/Makefile          |  1 +
 arch/x86/kernel/cpu/resctrl/drivers/Makefile  |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/resctrl/drivers/resctrl_example.c
 create mode 100644 arch/x86/kernel/cpu/resctrl/drivers/Makefile

diff --git a/arch/x86/kernel/cpu/resctrl/drivers/resctrl_example.c b/arch/x86/kernel/cpu/resctrl/drivers/resctrl_example.c
new file mode 100644
index 000000000000..24998e0dc3c2
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/drivers/resctrl_example.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. */
+
+/*
+ *  Example resctrl driver
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/resctrl.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "exampleresctrl: " fmt
+
+static int closid_show(struct seq_file *sf, void *arg)
+{
+	struct kernfs_open_file *of = sf->private;
+	unsigned long priv = (unsigned long)of->kn->priv;
+	u32 closid = priv >> 16;
+
+	seq_printf(sf, "%d\n", closid);
+
+	return 0;
+}
+
+static int rmid_show(struct seq_file *sf, void *arg)
+{
+	struct kernfs_open_file *of = sf->private;
+	unsigned long priv = (unsigned long)of->kn->priv;
+	u32 rmid = priv & 0xffff;
+
+	seq_printf(sf, "%d\n", rmid);
+
+	return 0;
+}
+
+static struct kernfs_ops closid_ops = {
+	.seq_show	= closid_show,
+};
+
+static struct kernfs_ops rmid_ops = {
+	.seq_show	= rmid_show,
+};
+
+static struct resctrl_fileinfo files[] = {
+	{
+		.name = "closid", .ops = &closid_ops
+	},
+	{
+		.name = "rmid", .ops = &rmid_ops
+	},
+	{
+	}
+};
+
+static struct resctrl_driver ops = {
+	.ctrlfiles	= files,
+};
+
+static int __init init_example(void)
+{
+	resctrl_register_driver(&ops);
+
+	return 0;
+}
+
+static void __exit cleanup_example(void)
+{
+	resctrl_unregister_driver(&ops);
+}
+
+module_init(init_example);
+module_exit(cleanup_example);
+
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..7f2faec17365 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -500,6 +500,17 @@ config X86_CPU_RESCTRL
 
 	  Say N if unsure.
 
+config X86_CPU_RESCTRL_DRIVERS
+	bool "resctrl driver"
+
+config X86_CPU_RESCTRL_EXAMPLE_DRIVER
+	tristate "example x86 resctrl driver"
+	depends on X86_CPU_RESCTRL
+	select X86_CPU_RESCTRL_DRIVERS
+	help
+	  Example driver to show one possible use case for
+	  resctrl driver registration.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 4a06c37b9cf1..7db4d729afbc 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
 obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
+obj-$(CONFIG_X86_CPU_RESCTRL_DRIVERS) += drivers/
 CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/arch/x86/kernel/cpu/resctrl/drivers/Makefile b/arch/x86/kernel/cpu/resctrl/drivers/Makefile
new file mode 100644
index 000000000000..27db936eb947
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/drivers/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_X86_CPU_RESCTRL_EXAMPLE_DRIVER) += resctrl_example.o
-- 
2.39.2

