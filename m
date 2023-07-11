Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC8D74F257
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjGKOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjGKOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:34:34 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020871704
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:34:12 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-987e47d2e81so385572966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086051; x=1691678051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5KQ14CSTc8NpsFet5DkO7+Eg5yvGp+eL0uzYXahxFI=;
        b=REFxOLn3yTkHXXbW63Pv3TKvhHmLym4lK7n4qAg1HhVqYHBz6Eygyf+ukgS+aoF7Ay
         FGPGtEGLPHN3UAOhSKs6RZPcuuvEvi3REVbiotM0gtXOI4psD1ewYPMkTsWifRHxEE7c
         ODSabgC3mrfJSuUFgXHqu28gWbpXZmRd0VSc++qeUL82LRuFMQBDVt39YY+Hl+YTOYS+
         9QImRBBwUfs4WhOyiSWe4jiBSOWjIjNvkytOGISZzdlVGzE2tNXPd6Mo5mGt/BYMG89V
         Fcpdqdueo74cUDPF7zBL3ajHYrFrGfxDwkUSszPa1TaF6xJtXn/ye+EZCfyEs3ocegWN
         xPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086051; x=1691678051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5KQ14CSTc8NpsFet5DkO7+Eg5yvGp+eL0uzYXahxFI=;
        b=DGX9adL+i7Id7Ye6aroBcJhJWIuRRvvXZ4iF+AI1XjrLO+q25Mztnwi4l8E2CHVbCv
         IGlJZDaAgp53sk/Q6YkceQz+/HYIwRfwnfCNe4tp9w76U7/SmS5M2D1ZMKc+OJ7Z3xjx
         zWVaFwoFlCdFjKNM2t2SAhmAzs2B4QkrEvR2JChElZEtrhbWI3UMziguy7e+DZFfkkm+
         PikPGrS9Ff+CX3fevr+b9+RzMWVtHLNHDwckID3waFgkq0nnsrfyR1pumjeR0mrxl0cw
         rBasAL0FICuVHFxkX6p5NGtafeBCk8fClhGQvxCJSFRC/46ClhBo2JQU/L6jB6uKtAAh
         KVrQ==
X-Gm-Message-State: ABy/qLaMZVfS0hB0NW8TkyTcI64IftDS2J0/zXOr77uVy6Kf1ZQv573E
        ZOE5El3gpYfl165kfThRkrqJTRwftpA=
X-Google-Smtp-Source: APBJJlEi0PgFIXfK3AJUMGBPN3szAfnwqAYopCk5Kg2fx0N0vfhegd6f9ZdvG0eTHAXWV2Nl1A9/xQ+VzWE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a17:907:2c6a:b0:98e:2178:9b8f with SMTP id
 ib10-20020a1709072c6a00b0098e21789b8fmr53698ejc.2.1689086051116; Tue, 11 Jul
 2023 07:34:11 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:33:36 +0200
In-Reply-To: <20230711143337.3086664-1-glider@google.com>
Mime-Version: 1.0
References: <20230711143337.3086664-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711143337.3086664-10-glider@google.com>
Subject: [PATCH 5/5] arm64: mte: add compression support to mteswap.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the internal mteswap.h interface:
 - _mte_alloc_and_save_tags()
 - _mte_free_saved_tags()
 - _mte_restore_tags()

, that encapsulates saving tags for a struct page (together with memory
allocation), restoring tags, and deleting the storage allocated for them.

These functions accept opaque pointers, which may point to 128-byte
tag buffers, as well as smaller buffers containing compressed tags, or
have compressed tags stored directly in them.

The existing code from mteswap.c operating with uncompressed tags is split
away into mteswap_nocomp.c, and the newly introduced mteswap_comp.c
provides compression with the EA0 algorithm. The latter implementation
is picked if CONFIG_ARM64_MTE_COMP=y.

Soon after booting Android, tag compression saves ~2.5x memory previously
spent by mteswap.c on tag allocations. With the growing uptime, the
savings reach 20x and even more.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/arm64/mm/Makefile         |  5 ++++
 arch/arm64/mm/mteswap.c        | 20 ++++++--------
 arch/arm64/mm/mteswap.h        | 12 ++++++++
 arch/arm64/mm/mteswap_comp.c   | 50 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap_nocomp.c | 37 +++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/mm/mteswap.h
 create mode 100644 arch/arm64/mm/mteswap_comp.c
 create mode 100644 arch/arm64/mm/mteswap_nocomp.c

diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 170dc62b010b9..46a798e2b67cb 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -11,6 +11,11 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
 obj-$(CONFIG_ARM64_MTE_COMP)	+= mtecomp.o
+ifdef CONFIG_ARM64_MTE_COMP
+obj-$(CONFIG_ARM64_MTE)		+= mteswap_comp.o
+else
+obj-$(CONFIG_ARM64_MTE)		+= mteswap_nocomp.o
+endif
 obj-$(CONFIG_ARM64_MTE_COMP_KUNIT_TEST) += test_mtecomp.o
 KASAN_SANITIZE_physaddr.o	+= n
 
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index cd508ba80ab1b..7e8ee43e0d389 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -7,6 +7,8 @@
 #include <linux/swapops.h>
 #include <asm/mte.h>
 
+#include "mteswap.h"
+
 static DEFINE_XARRAY(mte_pages);
 
 void *mte_allocate_tag_storage(void)
@@ -27,20 +29,19 @@ int mte_save_tags(struct page *page)
 	if (!page_mte_tagged(page))
 		return 0;
 
-	tag_storage = mte_allocate_tag_storage();
+	tag_storage = _mte_alloc_and_save_tags(page);
+	pr_err("HERE: %s:%d\n", __FILE__, __LINE__); // TODO
 	if (!tag_storage)
 		return -ENOMEM;
 
-	mte_save_page_tags(page_address(page), tag_storage);
-
 	/* page_private contains the swap entry.val set in do_swap_page */
 	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);
 	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
-		mte_free_tag_storage(tag_storage);
+		_mte_free_saved_tags(tag_storage);
 		return xa_err(ret);
 	} else if (ret) {
 		/* Entry is being replaced, free the old entry */
-		mte_free_tag_storage(ret);
+		_mte_free_saved_tags(ret);
 	}
 
 	return 0;
@@ -53,10 +54,7 @@ void mte_restore_tags(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return;
 
-	if (try_page_mte_tagging(page)) {
-		mte_restore_page_tags(page_address(page), tags);
-		set_page_mte_tagged(page);
-	}
+	_mte_restore_tags(tags, page);
 }
 
 void mte_invalidate_tags(int type, pgoff_t offset)
@@ -64,7 +62,7 @@ void mte_invalidate_tags(int type, pgoff_t offset)
 	swp_entry_t entry = swp_entry(type, offset);
 	void *tags = xa_erase(&mte_pages, entry.val);
 
-	mte_free_tag_storage(tags);
+	_mte_free_saved_tags(tags);
 }
 
 void mte_invalidate_tags_area(int type)
@@ -78,7 +76,7 @@ void mte_invalidate_tags_area(int type)
 	xa_lock(&mte_pages);
 	xas_for_each(&xa_state, tags, last_entry.val - 1) {
 		__xa_erase(&mte_pages, xa_state.xa_index);
-		mte_free_tag_storage(tags);
+		_mte_free_saved_tags(tags);
 	}
 	xa_unlock(&mte_pages);
 }
diff --git a/arch/arm64/mm/mteswap.h b/arch/arm64/mm/mteswap.h
new file mode 100644
index 0000000000000..bf25f2b3e75a4
--- /dev/null
+++ b/arch/arm64/mm/mteswap.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ARCH_ARM64_MM_MTESWAP_H_
+#define ARCH_ARM64_MM_MTESWAP_H_
+
+#include <linux/mm_types.h>
+
+void *_mte_alloc_and_save_tags(struct page *page);
+void _mte_free_saved_tags(void *tags);
+void _mte_restore_tags(void *tags, struct page *page);
+
+#endif // ARCH_ARM64_MM_MTESWAP_H_
diff --git a/arch/arm64/mm/mteswap_comp.c b/arch/arm64/mm/mteswap_comp.c
new file mode 100644
index 0000000000000..bc2591f8d4f35
--- /dev/null
+++ b/arch/arm64/mm/mteswap_comp.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* MTE tag storage management with EA0 compression. */
+
+#include <asm/mte.h>
+#include <asm/mtecomp.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/xarray.h>
+
+#include "mteswap.h"
+
+void *_mte_alloc_and_save_tags(struct page *page)
+{
+	u8 tags[128];
+	u64 handle;
+
+	mte_save_page_tags(page_address(page), tags);
+	handle = ea0_compress(tags);
+	return xa_mk_value(handle);
+}
+
+void _mte_free_saved_tags(void *storage)
+{
+	unsigned long handle = xa_to_value(storage);
+	int size;
+
+	if (!handle)
+		return;
+	size = ea0_storage_size(handle);
+	ea0_release_handle(handle);
+}
+
+void _mte_restore_tags(void *tags, struct page *page)
+{
+	u64 handle = xa_to_value(tags);
+	u8 tags_decomp[128];
+
+	if (!handle)
+		return;
+
+	if (try_page_mte_tagging(page)) {
+		if (!ea0_decompress(handle, tags_decomp))
+			return;
+		mte_restore_page_tags(page_address(page), tags_decomp);
+		set_page_mte_tagged(page);
+	}
+}
diff --git a/arch/arm64/mm/mteswap_nocomp.c b/arch/arm64/mm/mteswap_nocomp.c
new file mode 100644
index 0000000000000..efcdac88b342d
--- /dev/null
+++ b/arch/arm64/mm/mteswap_nocomp.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* MTE tag storage management without compression support. */
+
+#include <asm/mte.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/xarray.h>
+
+#include "mteswap.h"
+
+void *_mte_alloc_and_save_tags(struct page *page)
+{
+	void *storage;
+
+	storage = mte_allocate_tag_storage();
+	if (!storage)
+		return NULL;
+
+	mte_save_page_tags(page_address(page), storage);
+	return storage;
+}
+
+void _mte_free_saved_tags(void *storage)
+{
+	mte_free_tag_storage(storage);
+}
+
+void _mte_restore_tags(void *tags, struct page *page)
+{
+	if (try_page_mte_tagging(page)) {
+		mte_restore_page_tags(page_address(page), tags);
+		set_page_mte_tagged(page);
+	}
+}
-- 
2.41.0.255.g8b1d071c50-goog

