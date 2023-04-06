Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2326DA410
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbjDFUtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239649AbjDFUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:49:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633EF9768;
        Thu,  6 Apr 2023 13:48:35 -0700 (PDT)
Date:   Thu, 06 Apr 2023 20:48:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680814114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fbL2+aKE7uWxGvp96AkCTTIcstJSjZVPvRpLsq3o3LI=;
        b=1GiO0WK8UY95oCMJ4h6lyJbyCu3JyOcFZ/ymaaWAoSlXeAgkPsz9H6UYQDtgtu2doMkAYj
        OA7Yg+SJwlNf0Pe6sjuuSSDJUqMb6G43kFsg2+ZD3V25cjICioqv2qKO4Mtc5JRor3N77v
        tLtJxsTaWDscWLeI74CdU3BtiAYvwR7IOmWUCu7V50VuhRkIgp0yqHDs2mbb1kMrmm8Mv5
        kPYiZPIF+9OkC777e0SzHx/DQPuMpFZQbYt9J2XT7hieQXoYx5BM2PSwyawOg0QEoU3kgQ
        xfHu7ls0PFCbL0ML756dAqKrCesuCB6eLC7PkQIDEi9rJpR8rQI96WnFFbg6Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680814114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fbL2+aKE7uWxGvp96AkCTTIcstJSjZVPvRpLsq3o3LI=;
        b=vxFNZhFfxknS1vNGn4gu6R7xC8aGhqUPL6TuOKomX8ukxH37XLEkcw3gS9NhwgYFZygHRD
        jqXaKPDMexuklaBw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot: Centralize __pa()/__va() definitions
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168081411330.404.15815077102640119254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     5462ade6871e96646502cc95e7e05f0ab4fc84de
Gitweb:        https://git.kernel.org/tip/5462ade6871e96646502cc95e7e05f0ab4fc84de
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Thu, 30 Mar 2023 14:49:43 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 04 Apr 2023 13:42:37 -07:00

x86/boot: Centralize __pa()/__va() definitions

Replace multiple __pa()/__va() definitions with a single one in misc.h.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230330114956.20342-2-kirill.shutemov%40linux.intel.com
---
 arch/x86/boot/compressed/ident_map_64.c |  8 --------
 arch/x86/boot/compressed/misc.h         |  9 +++++++++
 arch/x86/boot/compressed/sev.c          |  2 --
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 321a501..bcc956c 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -8,14 +8,6 @@
  * Copyright (C)      2016  Kees Cook
  */
 
-/*
- * Since we're dealing with identity mappings, physical and virtual
- * addresses are the same, so override these defines which are ultimately
- * used by the headers in misc.h.
- */
-#define __pa(x)  ((unsigned long)(x))
-#define __va(x)  ((void *)((unsigned long)(x)))
-
 /* No PAGE_TABLE_ISOLATION support needed either: */
 #undef CONFIG_PAGE_TABLE_ISOLATION
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 20118fb..2f155a0 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -19,6 +19,15 @@
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
 
+/*
+ * Boot stub deals with identity mappings, physical and virtual addresses are
+ * the same, so override these defines.
+ *
+ * <asm/page.h> will not define them if they are already defined.
+ */
+#define __pa(x)  ((unsigned long)(x))
+#define __va(x)  ((void *)((unsigned long)(x)))
+
 #include <linux/linkage.h>
 #include <linux/screen_info.h>
 #include <linux/elf.h>
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index d63ad8f..014b89c 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -104,9 +104,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 }
 
 #undef __init
-#undef __pa
 #define __init
-#define __pa(x)	((unsigned long)(x))
 
 #define __BOOT_COMPRESSED
 
