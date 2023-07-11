Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5357874F287
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGKOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjGKOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:42:56 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421610EB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:53 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51e0fc38f16so3884144a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689086572; x=1691678572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOfdDj4t/4l0qN/MzMyGSYQ+xos/zeOUfaRubiCXYXI=;
        b=DMvTp3qIbqi7R3+/TZONux6wmipAvaKknq9XHWA5Bpl3yvkgTAI5dh1LhA7YDXuRY9
         MBhaUq9j++dF0ggq/1dRPVbv32IsNOyfZ6wx/Ztv7qjkLdBfq+LhfD6NJ7HPlBgJ+jQf
         G9MMBv/VE5c2FC8Q+VXzk6vyc9cIZT6T+VnXriGKfR/CYs6WsAIzhG1wB2P/OeGgGEoa
         QWoUpITIhPV2Ts8Foy6Ls/ezi25JDzj3oQJI5AdjnV7e/ePklycQwcfsZU0nFft6+5Bf
         jDgJ0dOPddWEIriLN6XNuN73ZgOVoBlVeNiEyj9NBxcyM4Xf2OtYkeiRHVLmTYkPrk9P
         ZA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086572; x=1691678572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOfdDj4t/4l0qN/MzMyGSYQ+xos/zeOUfaRubiCXYXI=;
        b=TThvB0jEateuTDyELEjb/A1lJ0MuxOvKU+jN05A/KM+jcJgP/mkwPxvnWR5GiIpP0w
         ZfdX6lPYtviiPpjCyziMnwIiyedLwTUwilVoSPd7rZgtoyUD49+EqL2GqFOSrCM5eiUF
         iCTQzFnn7Aw/RjVRiv7oOQEwZp921c4viDuMdEfqauA479OniT0OZs5wbsU3iM2BL28r
         D5cALRtU4ctyyzapOkh4mbEwxHWGlDsNR+cIlHKpeYxvTiZmuhinjpcdEKDoLC5qYGr4
         YdoFa1ott0sGS9Xsw8qIokgEFizARLE/vyTsET1EkwuV5y6btZziLJoaA1xvczPkGpvD
         Q4Lw==
X-Gm-Message-State: ABy/qLb5i6kP5SPJKq893nW92T22NmcglHPLrxDbO76XZa0KT/J0q7Y1
        BkuPjsyRJgs2hcIIgAC+woJjNYFvdls=
X-Google-Smtp-Source: APBJJlFpIs5sw5B7QP1mFku8Tft4MX3pcfZcG8QM3mao/bJkQkOcHnv3FzJItPRogLjru11af5AuwM2GT8Y=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:564d:3aaa:6b5f:4419])
 (user=glider job=sendgmr) by 2002:a50:d55e:0:b0:51b:fd0f:a4ec with SMTP id
 f30-20020a50d55e000000b0051bfd0fa4ecmr79323edj.7.1689086572014; Tue, 11 Jul
 2023 07:42:52 -0700 (PDT)
Date:   Tue, 11 Jul 2023 16:42:33 +0200
In-Reply-To: <20230711144233.3129207-1-glider@google.com>
Mime-Version: 1.0
References: <20230711144233.3129207-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711144233.3129207-6-glider@google.com>
Subject: [Resend v1 5/5] arm64: mte: add compression support to mteswap.c
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/mm/mteswap.c        | 19 ++++++-------
 arch/arm64/mm/mteswap.h        | 12 ++++++++
 arch/arm64/mm/mteswap_comp.c   | 50 ++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mteswap_nocomp.c | 37 +++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 11 deletions(-)
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
index cd508ba80ab1b..e072c1209fbb6 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -7,6 +7,8 @@
 #include <linux/swapops.h>
 #include <asm/mte.h>
 
+#include "mteswap.h"
+
 static DEFINE_XARRAY(mte_pages);
 
 void *mte_allocate_tag_storage(void)
@@ -27,20 +29,18 @@ int mte_save_tags(struct page *page)
 	if (!page_mte_tagged(page))
 		return 0;
 
-	tag_storage = mte_allocate_tag_storage();
+	tag_storage = _mte_alloc_and_save_tags(page);
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
@@ -53,10 +53,7 @@ void mte_restore_tags(swp_entry_t entry, struct page *page)
 	if (!tags)
 		return;
 
-	if (try_page_mte_tagging(page)) {
-		mte_restore_page_tags(page_address(page), tags);
-		set_page_mte_tagged(page);
-	}
+	_mte_restore_tags(tags, page);
 }
 
 void mte_invalidate_tags(int type, pgoff_t offset)
@@ -64,7 +61,7 @@ void mte_invalidate_tags(int type, pgoff_t offset)
 	swp_entry_t entry = swp_entry(type, offset);
 	void *tags = xa_erase(&mte_pages, entry.val);
 
-	mte_free_tag_storage(tags);
+	_mte_free_saved_tags(tags);
 }
 
 void mte_invalidate_tags_area(int type)
@@ -78,7 +75,7 @@ void mte_invalidate_tags_area(int type)
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

