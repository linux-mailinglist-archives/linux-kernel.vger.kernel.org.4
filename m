Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843C36A121C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBWVeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBWVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:34:43 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D858B75;
        Thu, 23 Feb 2023 13:34:41 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1720887dfcdso17222611fac.6;
        Thu, 23 Feb 2023 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sr4E/lNj2zE6IHIJzVZN2IPz7FoASvSZqxFSt8+h6eM=;
        b=f2F+FCFNTYiiT1h4c7YJZL2iuvLpnnKADnN8ASHVwMkObga2N2cS2wM/Rh+6uB0Sg6
         hvLbpyxgBnnNfqI499LAFSGP0YkKQydHCi33OZT35P9mrby08Ms+VM6yMVrEIALmYPIk
         Yq4b5M8LNdBabDdEEFrrrHXxJ6lywnckyV6qTlGCw4qroq5PNm4nieKXsAqScf3Wqm9T
         MwNOeo41wqljf/8MYoxWDdppHLR2k2TXhLRMTr4XYuhMcJQX8l2bo4w/0unAd9gE7GOM
         Ssc4PAysCaKGQ3qphOgSR6MjY4HyDT5xCjzFxig0zRISkeD3boGCCq3C8FI6lzUCugo5
         u7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr4E/lNj2zE6IHIJzVZN2IPz7FoASvSZqxFSt8+h6eM=;
        b=IJwG53Ng/EIvZYozZWqH2Jtwn6ePPwz77QcL6B6gA4Mukx9NS4gs8zf8mCWWemhLwH
         owDMnJhuc5w5bj/42gR/oeQ119WvufPMXiCU1cPKqByGkmzRGeTsMORwptmLV7bPSJT2
         L6r3zApKjfpKDWdLPHv9/AnQa0VMdubzwd3Oe91cAi30uf4svBT+xz8kYRoZql0lwbJT
         Edx87xgB4pDQmyNdkVdPU2SvSFNQx/XaaWxQtDzwrsPiVS0c75lTU4I6TK1w4LwIILBv
         lLPn+RJJB/6Qkq9BsOouNkLzw2bZMtVilQ8W2jFmyg7ZLpJ7vYWaKi5iRaN1ntpvjsBW
         uZMQ==
X-Gm-Message-State: AO0yUKUMwIbmGKxQtMjtBFNDP9Zb1dMNobVsPxk5HXROKctN16yM65DJ
        H8aqSzpLBYg3aanI4oFObjw=
X-Google-Smtp-Source: AK7set84EQpvpgt+B6tMwCGc9ka9JNTP67E57DVQAsT3bWgJ0axLAp53BCC5ROYDX9ZwFy8Y45mioA==
X-Received: by 2002:a05:6870:2155:b0:16d:e1a2:259 with SMTP id g21-20020a056870215500b0016de1a20259mr12755200oae.34.1677188081096;
        Thu, 23 Feb 2023 13:34:41 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:e42b:73d3:ba1a:1b32])
        by smtp.gmail.com with ESMTPSA id r1-20020a4ae501000000b00524fe20aee5sm2903976oot.34.2023.02.23.13.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 13:34:40 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 1/2] of: create of_root if no dtb provided
Date:   Thu, 23 Feb 2023 15:34:17 -0600
Message-Id: <20230223213418.891942-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223213418.891942-1-frowand.list@gmail.com>
References: <20230223213418.891942-1-frowand.list@gmail.com>
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
unflattened via setup_arch().  Otherwise, setup_of() which is called
immediately after setup_arch(), and will create the default root node
if it does not exist.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---

Please wait for test results from Clement before accepting.

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
 drivers/of/fdt.c          | 27 ++++++++++++++++++++++++++-
 include/linux/of_fdt.h    |  2 ++
 init/main.c               |  2 ++
 6 files changed, 43 insertions(+), 3 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..591cfe386727 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -42,9 +42,14 @@ config OF_FLATTREE
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
index b2272bccf85c..eccc2d2107af 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -33,6 +33,13 @@
 
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
@@ -1326,8 +1333,19 @@ bool __init early_init_dt_scan(void *params)
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
+		unflatten_and_copy_device_tree();
+	} else {
+		__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch, false);
+	}
 
 	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
 	of_alias_scan(early_init_dt_alloc_memory_arch);
@@ -1367,6 +1385,13 @@ void __init unflatten_and_copy_device_tree(void)
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
index e1c3911d7c70..31e0931b5134 100644
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

