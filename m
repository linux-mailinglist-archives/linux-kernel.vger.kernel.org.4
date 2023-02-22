Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4B69EDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjBVDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBVDz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:55:27 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE5F31E2C;
        Tue, 21 Feb 2023 19:55:25 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id e18-20020a0568301e5200b00690e6abbf3fso1490095otj.13;
        Tue, 21 Feb 2023 19:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl7cNlq6eol+0bH4dQvHPF1M13TBElOJT4S6JzbFEnE=;
        b=IkuNEjhaZ1PliD2souixHHwtTrSoR5WGyijs3MJtI9lJq1LNy+Nx3s7KrddRG47is5
         At8xhnJy3a5RZmCurWUZk58LX5QFfQwHzh7ulG1DKATiHw3Z9bgtb0+k2eDnR1gZpQMS
         K31c1ifrAiCOjTXZLjKeJB8YUPIMf9huqqyDLm1GecnjAOILwZlj5RYhb/YpSyD8wfPQ
         qgTWIQJP2hiuKCHw3jY7M9PWMrIWTAek7kKbCsdmPEEv7PZmPUfsvJziV0tFJT3SJV/R
         p/YVa1RjegYanaOCbGbJEZzQop/SFMxG5vd9VPCmv9PRMMVAkFsQrRxRtL9F/XJf2RH3
         DCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl7cNlq6eol+0bH4dQvHPF1M13TBElOJT4S6JzbFEnE=;
        b=YIFR6SnsVtSQmfkP4a824GdCz913nW9pgf6EYqDR0o0ej4MA7BlitJC0n+Bz4GoI+c
         qDeo3bwJdd+5hbBdXLETlC1ACSCRRdrP7BV/SbJVAUDWlkqDNHRuSm1zk7bsh3MRlzeA
         FZAlD9U+uZvWK898kUzTLXwZVPncYvC85MZHpBKNVNXDUfTIZX2irVCtMpGFI8IkyWUr
         xrSvaiU50GSQtQzly4o+eMTLzWFJ3zfzU2BcInCRnasOq4QaVROTzdbeMwPtKsoY7YEf
         EOjVn92/uqSlVkIMNHTPp9MudSIDgrHKVwRohgx76UiPNE5s97twq39LVXbBuKJyy4Pl
         hFvw==
X-Gm-Message-State: AO0yUKVmIEbRwbfMUsMCo1quHnZnJT66bUYh7TQvjv30zo+YfznJ7oz9
        BLIHwWrPYbyEf2523BRzFAU=
X-Google-Smtp-Source: AK7set+hUnto35eVTUEKD/JVcmjmh8dIpMF92aNLHATt1MUoQIyRfe8kB6ZIeOExvJMedVQqtPkU2Q==
X-Received: by 2002:a05:6830:448b:b0:690:e27f:3200 with SMTP id r11-20020a056830448b00b00690e27f3200mr4176729otv.12.1677038124818;
        Tue, 21 Feb 2023 19:55:24 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:70ac:b1e4:53db:3994])
        by smtp.gmail.com with ESMTPSA id y6-20020a056830070600b00684cbd8dd49sm533404ots.79.2023.02.21.19.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 19:55:24 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/2] of: create of_root if no dtb provided
Date:   Tue, 21 Feb 2023 21:54:51 -0600
Message-Id: <20230222035452.803375-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222035452.803375-1-frowand.list@gmail.com>
References: <20230222035452.803375-1-frowand.list@gmail.com>
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

There are checkpatch warnings.  I have reviewed them and feel
they can be ignored.

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
index b2272bccf85c..0d2f6d016b7e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -33,6 +33,13 @@
 
 #include "of_private.h"
 
+/*
+ * __dtb_empty_root_begin[] and __dtb_empty_root_end[] magically created by
+ * cmd_dt_S_dtb in scripts/Makefile.lib
+ */
+extern void *__dtb_empty_root_begin;
+extern void *__dtb_empty_root_end;
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

