Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D06D1BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCaJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCaJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:16:14 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69655C173;
        Fri, 31 Mar 2023 02:16:04 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxUOXTpCZkv+QUAA--.32142S3;
        Fri, 31 Mar 2023 17:16:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxC77OpCZkVfMRAA--.14538S4;
        Fri, 31 Mar 2023 17:16:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH 2/3] module: Move is_arm_mapping_symbol() to module_symbol.h
Date:   Fri, 31 Mar 2023 17:15:52 +0800
Message-Id: <1680254153-14582-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1680254153-14582-1-git-send-email-yangtiezhu@loongson.cn>
References: <1680254153-14582-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxC77OpCZkVfMRAA--.14538S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr18Gr1UWw1DCF47ArWfGrg_yoW5Cr1xpF
        n8Cw4rJr4rAr1UGa4fuw1vyr13uw4vgr4jyr9xKryxZrnIqF1vqrZrKr1Yvw1xXrZrGF40
        9r4fZFW3CFWfZaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8QJ57UUUUU==
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid duplicated code, move is_arm_mapping_symbol() to
include/linux/module_symbol.h, then remove is_arm_mapping_symbol()
in the other places.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/module_symbol.h | 15 +++++++++++++++
 kernel/module/kallsyms.c      | 14 +-------------
 scripts/mod/modpost.c         | 10 +---------
 3 files changed, 17 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/module_symbol.h

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
new file mode 100644
index 0000000..9fa4173
--- /dev/null
+++ b/include/linux/module_symbol.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _LINUX_MODULE_SYMBOL_H
+#define _LINUX_MODULE_SYMBOL_H
+
+/* This ignores the intensely annoying "mapping symbols" found in ELF files. */
+static inline int is_arm_mapping_symbol(const char *str)
+{
+	if (str[0] == '.' && str[1] == 'L')
+		return true;
+	return str[0] == '$' &&
+	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
+	       && (str[2] == '\0' || str[2] == '.');
+}
+
+#endif /* _LINUX_MODULE_SYMBOL_H */
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index a9045fe..5de3207 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/module_symbol.h>
 #include <linux/kallsyms.h>
 #include <linux/buildid.h>
 #include <linux/bsearch.h>
@@ -243,19 +244,6 @@ void init_build_id(struct module *mod, const struct load_info *info)
 }
 #endif
 
-/*
- * This ignores the intensely annoying "mapping symbols" found
- * in ARM ELF files: $a, $t and $d.
- */
-static inline int is_arm_mapping_symbol(const char *str)
-{
-	if (str[0] == '.' && str[1] == 'L')
-		return true;
-	return str[0] == '$' &&
-	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
-	       && (str[2] == '\0' || str[2] == '.');
-}
-
 static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned int symnum)
 {
 	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 79a27cc..7241db8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -22,6 +22,7 @@
 #include <errno.h>
 #include "modpost.h"
 #include "../../include/linux/license.h"
+#include "../../include/linux/module_symbol.h"
 
 /* Are we using CONFIG_MODVERSIONS? */
 static bool modversions;
@@ -1112,15 +1113,6 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
 	return 1;
 }
 
-static inline int is_arm_mapping_symbol(const char *str)
-{
-	if (str[0] == '.' && str[1] == 'L')
-		return true;
-	return str[0] == '$' &&
-	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
-	       && (str[2] == '\0' || str[2] == '.');
-}
-
 /*
  * If there's no name there, ignore it; likewise, ignore it if it's
  * one of the magic symbols emitted used by current ARM tools.
-- 
2.1.0

