Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B846DBB68
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDHODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDHOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842C1FF01
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D9EB615A7
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B03C4339C;
        Sat,  8 Apr 2023 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962550;
        bh=sZRplt/lMcAukd6t3lKV858Ua+TaEabv3t/I3yOFmVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKf7mAmJJD/vTvASkaS7x4T3zKeHCXwQglDpQHxkPN+FIa2fO7m29njShZXeeW9Xw
         Vd8unuLC4jemEBX7WWfTGvF8ORjyoK/SCl61XoxhlKmyy9TTxFo4FsOF8Sn8bd46nU
         2NcTP4B0q/UvDxLnoTNAHzR9UsULOcNAP4lB8HupQmauTkeS3OaeLE7hN0ZH9I2eWG
         xu0iWADr3JYdj0GHpaDqxbOog05ftD9D+pEPkDmGzEaenmB8uQmhHZLnepBCJe6wSO
         2hhFmKvdkEC6g47lwhpVnQrQc7MWhRAXlR5SRKgA7EutYnZugdHCkHsoh/vDDTeFky
         HZE/S2p8d9RDg==
Received: by pali.im (Postfix)
        id 18FE3233A; Sat,  8 Apr 2023 16:02:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/13] powerpc/85xx: mpc85xx_ds: Move i8259 code into own file
Date:   Sat,  8 Apr 2023 16:01:18 +0200
Message-Id: <20230408140122.25293-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408140122.25293-1-pali@kernel.org>
References: <20230408140122.25293-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to share mpc85xx i8259 code between DS and P2020.
Prefix i8259 debug and error messages by i8259 word.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

---
Changes in v5:
* Add prefix for err/dbg messages
* Fix commit message
* Reduce includes
---
 arch/powerpc/platforms/85xx/Makefile       |  3 +-
 arch/powerpc/platforms/85xx/mpc85xx.h      |  6 +++
 arch/powerpc/platforms/85xx/mpc85xx_8259.c | 63 ++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   | 46 ----------------
 4 files changed, 71 insertions(+), 47 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_8259.c

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 93451850ed83..0a0011e8c63c 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -16,7 +16,8 @@ obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
 obj-$(CONFIG_MPC8536_DS)  += mpc8536_ds.o
-obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o p2020.o
+obj8259-$(CONFIG_PPC_I8259)   += mpc85xx_8259.o
+obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o p2020.o $(obj8259-y)
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
 obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o p2020.o
 obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 8f7b37c1de87..e792907ee3d5 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -15,6 +15,12 @@ extern void mpc85xx_qe_par_io_init(void);
 static inline void __init mpc85xx_qe_par_io_init(void) {}
 #endif
 
+#ifdef CONFIG_PPC_I8259
+void __init mpc85xx_8259_init(void);
+#else
+static inline void __init mpc85xx_8259_init(void) {}
+#endif
+
 void __init mpc85xx_ds_pic_init(void);
 void __init mpc85xx_ds_setup_arch(void);
 void __init mpc85xx_rdb_setup_arch(void);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_8259.c b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
new file mode 100644
index 000000000000..82e881606049
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx_8259.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MPC85xx 8259 functions for DS Board Setup
+ *
+ * Author Xianghua Xiao (x.xiao@freescale.com)
+ * Roy Zang <tie-fei.zang@freescale.com>
+ * 	- Add PCI/PCI Exprees support
+ * Copyright 2007 Freescale Semiconductor Inc.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/mpic.h>
+#include <asm/i8259.h>
+
+#include "mpc85xx.h"
+
+static void mpc85xx_8259_cascade(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int cascade_irq = i8259_irq();
+
+	if (cascade_irq) {
+		generic_handle_irq(cascade_irq);
+	}
+	chip->irq_eoi(&desc->irq_data);
+}
+
+void __init mpc85xx_8259_init(void)
+{
+	struct device_node *np;
+	struct device_node *cascade_node = NULL;
+	int cascade_irq;
+
+	/* Initialize the i8259 controller */
+	for_each_node_by_type(np, "interrupt-controller")
+	    if (of_device_is_compatible(np, "chrp,iic")) {
+		cascade_node = np;
+		break;
+	}
+
+	if (cascade_node == NULL) {
+		pr_debug("i8259: Could not find i8259 PIC\n");
+		return;
+	}
+
+	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
+	if (!cascade_irq) {
+		pr_err("i8259: Failed to map cascade interrupt\n");
+		return;
+	}
+
+	pr_debug("i8259: cascade mapped to irq %d\n", cascade_irq);
+
+	i8259_init(cascade_node, 0);
+	of_node_put(cascade_node);
+
+	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
+}
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index af2cafec4f0a..db4cf76c0fd1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -34,52 +34,6 @@
 
 #include "mpc85xx.h"
 
-static void mpc85xx_8259_cascade(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned int cascade_irq = i8259_irq();
-
-	if (cascade_irq) {
-		generic_handle_irq(cascade_irq);
-	}
-	chip->irq_eoi(&desc->irq_data);
-}
-
-static void __init mpc85xx_8259_init(void)
-{
-	struct device_node *np;
-	struct device_node *cascade_node = NULL;
-	int cascade_irq;
-
-	if (!IS_ENABLED(CONFIG_PPC_I8259))
-		return;
-
-	/* Initialize the i8259 controller */
-	for_each_node_by_type(np, "interrupt-controller")
-	    if (of_device_is_compatible(np, "chrp,iic")) {
-		cascade_node = np;
-		break;
-	}
-
-	if (cascade_node == NULL) {
-		pr_debug("Could not find i8259 PIC\n");
-		return;
-	}
-
-	cascade_irq = irq_of_parse_and_map(cascade_node, 0);
-	if (!cascade_irq) {
-		pr_err("Failed to map cascade interrupt\n");
-		return;
-	}
-
-	pr_debug("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
-
-	i8259_init(cascade_node, 0);
-	of_node_put(cascade_node);
-
-	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
-}
-
 void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
-- 
2.20.1

