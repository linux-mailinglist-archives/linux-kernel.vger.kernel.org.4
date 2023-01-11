Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DAD665517
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjAKHWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjAKHWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:22:48 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B0B63C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673421760; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mspABjZ/6BnU7Re05YT75tkDPGR7PdpYWJRIpIQ/ZrbkiQJ2iH+FUtrg2sQjfzrEyORD+hYD7DHa6deLAbAw1r5uLDoq15lr4nf6BV/a6bfdP9R1x0R/yUDiZ7Djyx5MK7llMYMPQ3zhBDsEUU1I9uuUiFHrxUv7k5fjUebBcVA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1673421760; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=l3IhQjA23IOVq/9VuPj6c/xH2k/jNURCOgUNUZ43pkU=; 
        b=VnxgWrsYRs5ogv4gVy5PEM++QUz6vTvSTmLgnp7iJHMKovZ0XS0AI9NafkPX/cc7kEj6OKPvPiqlTdCHBJ9agXgbMlFLOvEbm4UQXgRk70pfDIrP09cYxj0BKKcqvI1Iz/sPE49TTqiqneUprLtvvs1SuXS5yZqFMK6T5T9KVP4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673421760;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=l3IhQjA23IOVq/9VuPj6c/xH2k/jNURCOgUNUZ43pkU=;
        b=j2yOJh1NtPzxRB0Vh9VZrvAy3C5SYAnCtVI6SgMRQtGD+NYuPrkAQUxTjjOw9syP
        d39iB/utz9zD7M7L4fWx+Fp4icmpQczLzCPIdXE4wnpBJEHCMyQByT/vAwCzG5v5Z7T
        Zsw1Skl9pvQ1QFnW0RWPo7PO86IiAuGWX//f19sw=
Received: from shbuild9.ambarella.net (116.246.37.178 [116.246.37.178]) by mx.zohomail.com
        with SMTPS id 16734217593541004.5197615793295; Tue, 10 Jan 2023 23:22:39 -0800 (PST)
From:   Li Chen <me@linux.beauty>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Li Chen <lchen@ambarella.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] debugfs: allow to use regmap for print regs
Date:   Wed, 11 Jan 2023 15:21:29 +0800
Message-Id: <20230111072130.3885460-1-me@linux.beauty>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

Currently, debugfs_regset32 only contains void __iomem *base,
and it is not friendly to regmap user.

Let's add regmap to debugfs_regset32, and add debugfs_print_regmap_reg32
to allow debugfs_regset32_show handle regmap.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
Changelog:

v1 -> v2:

Suggested by Greg, provide a new function for regmap instead of trying to overload old function.
---
 fs/debugfs/file.c       | 46 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/debugfs.h | 10 +++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index b54f470e0d03..f204b27f757f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1137,14 +1137,58 @@ void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
 }
 EXPORT_SYMBOL_GPL(debugfs_print_regs32);
 
+/**
+ * debugfs_print_regmap_regs32 - use seq_print to describe a set of registers
+ * @s: the seq_file structure being used to generate output
+ * @regs: an array if struct debugfs_reg32 structures
+ * @nregs: the length of the above array
+ * @regmap: regmap to be used in reading the registers
+ * @prefix: a string to be prefixed to every output line
+ *
+ * This function outputs a text block describing the current values of
+ * some 32-bit hardware registers. It is meant to be used within debugfs
+ * files based on seq_file that need to show registers, intermixed with other
+ * information. The prefix argument may be used to specify a leading string,
+ * because some peripherals have several blocks of identical registers,
+ * for example configuration of dma channels
+ */
+void debugfs_print_regmap_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
+			  int nregs, struct regmap *regmap, char *prefix)
+{
+	int i;
+	u32 val;
+
+	for (i = 0; i < nregs; i++, regs++) {
+		if (prefix)
+			seq_printf(s, "%s", prefix);
+		regmap_read(regmap, regs->offset, &val);
+		seq_printf(s, "%s = 0x%08x\n", regs->name, val);
+		if (seq_has_overflowed(s))
+			break;
+	}
+}
+EXPORT_SYMBOL_GPL(debugfs_print_regmap_regs32);
+
 static int debugfs_regset32_show(struct seq_file *s, void *data)
 {
 	struct debugfs_regset32 *regset = s->private;
+	void __iomem *base = regset->base;
+	struct regmap *regmap = regset->regmap;
+
+	if ((regmap && base) || (!regmap && !base)) {
+		seq_puts(
+			s,
+			"You should provide one and only one between base and regmap!\n");
+		return -EINVAL;
+	}
 
 	if (regset->dev)
 		pm_runtime_get_sync(regset->dev);
 
-	debugfs_print_regs32(s, regset->regs, regset->nregs, regset->base, "");
+	if (base)
+		debugfs_print_regs32(s, regset->regs, regset->nregs, base, "");
+	if (regmap)
+		debugfs_print_regmap_regs32(s, regset->regs, regset->nregs, regmap, "");
 
 	if (regset->dev)
 		pm_runtime_put(regset->dev);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index ea2d919fd9c7..04bc2bb70b79 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/regmap.h>
 
 struct device;
 struct file_operations;
@@ -35,6 +36,7 @@ struct debugfs_regset32 {
 	const struct debugfs_reg32 *regs;
 	int nregs;
 	void __iomem *base;
+	struct regmap *regmap;
 	struct device *dev;	/* Optional device for Runtime PM */
 };
 
@@ -152,6 +154,9 @@ void debugfs_create_regset32(const char *name, umode_t mode,
 void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
 			  int nregs, void __iomem *base, char *prefix);
 
+void debugfs_print_regmap_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
+			  int nregs, struct regmap *regmap, char *prefix);
+
 void debugfs_create_u32_array(const char *name, umode_t mode,
 			      struct dentry *parent,
 			      struct debugfs_u32_array *array);
@@ -338,6 +343,11 @@ static inline void debugfs_print_regs32(struct seq_file *s, const struct debugfs
 {
 }
 
+static inline void debugfs_print_regmap_regs32(struct seq_file *s,
+					       const struct debugfs_reg32 *regs,
+					       int nregs, struct regmap *regmap,
+					       char *prefix);
+
 static inline bool debugfs_initialized(void)
 {
 	return false;
-- 
2.34.1

