Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7696BE0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCQFef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCQFea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:34:30 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE6768C;
        Thu, 16 Mar 2023 22:34:29 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ek9so4536161qtb.10;
        Thu, 16 Mar 2023 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679031268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9REZkhiENtutm2XWIH1dQvVKSfKRddJL/3DZpRuUkWI=;
        b=lClEe3QYl0olxODsxeRKQ/9GrkyopZPsCQqWIyLKjYRQhbVfBjYsQDR5awxURhaUqh
         GddUuaBNVSfZ+aHbSHQIMUavS4pU1Dcbt+07bCChTKjQwX9JhzmMCGCrXkUEsDl+xZ2u
         NwsXvtUnreREItuVepUKiCFJzcVQxMrlypG5/sgo9xn3RVHrQbUJuIqNkhMPdMQalTnl
         r9RKwPkWJbz5ZvkWLaEp4bICNDi3lzaOVb1raG90vQQ08874pcHgcOfuvpdYeXoZPQ3V
         T0fTpw1V9NPFbGheceYDO4v1VkXwf8TZiRkhvWB9HClruc/hzjvtg2nQcC/154leZpG/
         H6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679031268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9REZkhiENtutm2XWIH1dQvVKSfKRddJL/3DZpRuUkWI=;
        b=BUVuV+OXr2dh2nez/Y7uUQFu0zaKE1eicS+m04KVYLaSkbDgNa1XCh9RVWQaFIBs+V
         Gc8aQSKIMHPsiGMBaz5wfxsPLhnDlltkUpeQI24aZsgCGglxAZCkL2BqYDlkes+VB7Fs
         bY9QBPIXBihX2zOBHxGYmWkXAsLrP1nidPnXUBmZNYRkG4MNZzIfFprSmBYkyT5qKdkt
         tgGfdn+qbhmHeiBI0U2MvmGVyzn1hYhHQcvXYLad4eh6MBllVgyftxNU0mfbXeK7tbH8
         a8NDefAU+u9dXt5YVi8I6XJklPkq4qX8A85yOilaUUWg2rnjQ3ahWbrJgL7GBSHYfCoh
         wSqA==
X-Gm-Message-State: AO0yUKUcBSf5ll73Jm4W/mT9ItHA+MnLcdBJSvFSuVfQarpc5mC29EBU
        I9HLt+n0KUFfWkvp7Z2YugE=
X-Google-Smtp-Source: AK7set/QjykVkuB9Jdo4F6gAlGJrQ/I1CSk8jsX3OLlo+TKwa2Bp242eSspo6/ZrMBlYd9Xw8pA7Rw==
X-Received: by 2002:ac8:7f8c:0:b0:3bf:b1d0:ab88 with SMTP id z12-20020ac87f8c000000b003bfb1d0ab88mr9894988qtj.5.1679031268305;
        Thu, 16 Mar 2023 22:34:28 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:557c:9772:415e:adc7])
        by smtp.gmail.com with ESMTPSA id i5-20020ac860c5000000b003b34650039bsm737649qtm.76.2023.03.16.22.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:34:27 -0700 (PDT)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 1/2] of: create of_root if no dtb provided
Date:   Fri, 17 Mar 2023 00:34:14 -0500
Message-Id: <20230317053415.2254616-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317053415.2254616-1-frowand.list@gmail.com>
References: <20230317053415.2254616-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling CONFIG_OF on a platform where of_root is not populated by
firmware, we end up without a root node. In order to apply overlays and
create subnodes of the root node, we need one. Create this root node
by unflattening an empty builtin dtb.

If firmware provides a flattened device tree (FDT) then the FDT is
unflattened via setup_arch().  Otherwise setup_of(), which is called
immediately after setup_arch(), will create the default root node
if it does not exist.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---

Please wait for test results from Clement before accepting.

Changes since version 3:
  - refresh for 6.3-rc1
  - unflatten_device_tree() - calculate of_fdt_crc32 if setting
    initial_boot_params to __dtb_empty_root_begin so CRC check
    in of_fdt_raw_init() will not fail

Changes since version 2:
  - change of __dtb_empty_root_* from "void *" to "uint8_t []"

Changes since version 1:
  - refresh for 6.2-rc1
  - update Signed-off-by
  - fix typo in of_fdt.h: s/of_setup/setup_of
  - unflatten_device_tree(): validate size in header field dtb_empty_root
    that will be used to copy dtb_empty_root
  - add Kconfig option to manually select CONFIG_OF_EARLY_FLATTREE

 drivers/of/Kconfig        |  7 ++++++-
 drivers/of/Makefile       |  2 +-
 drivers/of/empty_root.dts |  6 ++++++
 drivers/of/fdt.c          | 29 ++++++++++++++++++++++++++++-
 include/linux/of_fdt.h    |  2 ++
 init/main.c               |  2 ++
 6 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 644386833a7b..194e090ceee8 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -54,9 +54,14 @@ config OF_FLATTREE
 	select CRC32
 
 config OF_EARLY_FLATTREE
-	bool
+	bool "Functions for accessing Flat Devicetree (FDT) early in boot"
 	select DMA_DECLARE_COHERENT if HAS_DMA
 	select OF_FLATTREE
+	help
+	  Normally selected by platforms that process an FDT that has been
+	  passed to the kernel by the bootloader.  If the bootloader does not
+	  pass an FDT to the kernel and you need an empty devicetree that
+	  contains only a root node to exist, then say Y here.
 
 config OF_PROMTREE
 	bool
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e0360a44306e..cbae92c5ed02 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -2,7 +2,7 @@
 obj-y = base.o device.o platform.o property.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
-obj-$(CONFIG_OF_FLATTREE) += fdt.o
+obj-$(CONFIG_OF_FLATTREE) += fdt.o empty_root.dtb.o
 obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
 obj-$(CONFIG_OF_PROMTREE) += pdt.o
 obj-$(CONFIG_OF_ADDRESS)  += address.o
diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
new file mode 100644
index 000000000000..cf9e97a60f48
--- /dev/null
+++ b/drivers/of/empty_root.dts
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/dts-v1/;
+
+/ {
+
+};
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1a68b6d03b3..f65016c2e79f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -32,6 +32,13 @@
 
 #include "of_private.h"
 
+/*
+ * __dtb_empty_root_begin[] and __dtb_empty_root_end[] magically created by
+ * cmd_dt_S_dtb in scripts/Makefile.lib
+ */
+extern uint8_t __dtb_empty_root_begin[];
+extern uint8_t __dtb_empty_root_end[];
+
 /*
  * of_fdt_limit_memory - limit the number of regions in the /memory node
  * @limit: maximum entries
@@ -1326,8 +1333,21 @@ bool __init early_init_dt_scan(void *params)
  */
 void __init unflatten_device_tree(void)
 {
-	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
+	if (!initial_boot_params) {
+		initial_boot_params = (void *) __dtb_empty_root_begin;
+		/* fdt_totalsize() will be used for copy size */
+		if (fdt_totalsize(initial_boot_params) >
+		    __dtb_empty_root_end - __dtb_empty_root_begin) {
+			pr_err("invalid size in dtb_empty_root\n");
+			return;
+		}
+		of_fdt_crc32 = crc32_be(~0, initial_boot_params,
+					fdt_totalsize(initial_boot_params));
+		unflatten_and_copy_device_tree();
+	} else {
+		__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch, false);
+	}
 
 	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
 	of_alias_scan(early_init_dt_alloc_memory_arch);
@@ -1367,6 +1387,13 @@ void __init unflatten_and_copy_device_tree(void)
 	unflatten_device_tree();
 }
 
+void __init setup_of(void)
+{
+	/* if architecture did not unflatten devicetree, do it now */
+	if (!of_root)
+		unflatten_device_tree();
+}
+
 #ifdef CONFIG_SYSFS
 static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr,
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d69ad5bb1eb1..f0dc46d576da 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -81,6 +81,7 @@ extern const void *of_flat_dt_match_machine(const void *default_match,
 /* Other Prototypes */
 extern void unflatten_device_tree(void);
 extern void unflatten_and_copy_device_tree(void);
+extern void setup_of(void);
 extern void early_init_devtree(void *);
 extern void early_get_first_memblock_info(void *, phys_addr_t *);
 #else /* CONFIG_OF_EARLY_FLATTREE */
@@ -91,6 +92,7 @@ static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
 static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
+static inline void setup_of(void) {}
 #endif /* CONFIG_OF_EARLY_FLATTREE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/init/main.c b/init/main.c
index 4425d1783d5c..3c443e0c5927 100644
--- a/init/main.c
+++ b/init/main.c
@@ -101,6 +101,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/of_fdt.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -961,6 +962,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	setup_of();
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
Frank Rowand <frowand.list@gmail.com>

