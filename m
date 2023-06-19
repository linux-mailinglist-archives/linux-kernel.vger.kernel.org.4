Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9357359B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjFSOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:35:24 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC547E76
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:35:21 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 3F04F5FD2A;
        Mon, 19 Jun 2023 17:35:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687185320;
        bh=yyJFbEiRHCma+uvofoZbZvm1fPuV2gLaYZpyW0jnz8Q=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Kx0Y2IWD//KCWUqHs31kllelCYkzawNTLoFolOJ7WtBIBaE8DqUSOB/P56564TZCF
         8wHNaQcpS0AVi1fqBHPqXLECjUBexiVLjDkZ5UdwkYp1XGCgYp/0B0c3mrALy9vibg
         rFrlXFmHizU4e85qqg4LuyznALDrWT5bILn/SP5GOjJlfezNjEJqwTzTgl6KrtexYm
         tK0rqzSGYboERdOMW0HqAtqyogAl/3fYtBrstj2z++mPdW9xVfZjCwFl5ywnksS9Jc
         z0AJeymCexXYTe04JqBI0f9SoFpOE726nKIfOwYtI5nXkrleuAxli5DTU//5vUt5S+
         wOPWWE+e+QW+A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 19 Jun 2023 17:35:20 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 1/2] zsmalloc: add allocated objects counter for subpage
Date:   Mon, 19 Jun 2023 17:35:05 +0300
Message-ID: <20230619143506.45253-2-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230619143506.45253-1-avromanov@sberdevices.ru>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/19 10:56:00 #21523989
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use a variable of type unsigned int to store the offset
of the first object at the subpage In turn, the offset cannot
exceed the size of PAGE_SIZE, which is usually 4096. Thus,
12 bits are enough to store the offset.

We can use the remaining bytes to store, for example, the
count of allocated objects on a subpage. If the page size is
4Kb, then no more than 128 (4096 / 32) objects can be allocated
on the subpage, which means that one byte is enough to store
the counter of allocated objects.

This patch adds support for counting the number of allocated
objects on a subpage in the first byte of the page_type field.
The offset of the first object is now stored in the remaining
bytes of this field.

The sum of allocated counter for all subpages is zspage->inuse.
We only count objects that have been tagged (I'm talking about
OBJ_ALLOCATED_TAG) on a subpage.

So, for example, in the situation:

            subpage 1                   subpage 2
[obj1_s - obj1_e, obj2_s - ] -> [obj2_e, obj3_s - obj3_e, free space]

Allocated counter for subpage 1 will be 2, and 1 for subpage 2.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c0d433541636..dd6e2c3429e0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -20,7 +20,10 @@
  *	page->index: links together all component pages of a zspage
  *		For the huge page, this is always 0, so we use this field
  *		to store handle.
- *	page->page_type: first object offset in a subpage of zspage
+ *	page->page_type:
+ *		First byte: count of allocated objects (OBJ_ALLOCATED_TAG)
+ *		in a subpage of zspage.
+ *		Other bytes: first object offset in a subpage of zspage.
  *
  * Usage of struct page flags:
  *	PG_private: identifies the first component page
@@ -126,6 +129,9 @@
 #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
 
+#define OBJ_ALLOCATED_BITS	(sizeof(u8) * BITS_PER_BYTE)
+#define OBJ_ALLOCATED_MASK	((1UL << OBJ_ALLOCATED_BITS) - 1)
+
 #define HUGE_BITS	1
 #define FULLNESS_BITS	4
 #define CLASS_BITS	8
@@ -520,14 +526,37 @@ static inline struct page *get_first_page(struct zspage *zspage)
 	return first_page;
 }
 
+static inline u8 get_obj_allocated(struct page *page)
+{
+	return page->page_type & OBJ_ALLOCATED_MASK;
+}
+
+static inline void set_obj_allocated(struct page *page, u8 value)
+{
+	page->page_type = (page->page_type & ~OBJ_ALLOCATED_MASK) | value;
+}
+
+static inline void mod_obj_allocated(struct page *page, s8 value)
+{
+	u8 inuse = get_obj_allocated(page);
+	/*
+	 * Overflow is not possible:
+	 * 1. Maximum number of objects allocated on a subpage is 128.
+	 * 2. We use this function only with value = 1 or -1.
+	 */
+	inuse += value;
+	set_obj_allocated(page, inuse);
+}
+
 static inline unsigned int get_first_obj_offset(struct page *page)
 {
-	return page->page_type;
+	return page->page_type >> OBJ_ALLOCATED_BITS;
 }
 
 static inline void set_first_obj_offset(struct page *page, unsigned int offset)
 {
-	page->page_type = offset;
+	page->page_type = (page->page_type & OBJ_ALLOCATED_MASK) |
+			  (offset << OBJ_ALLOCATED_BITS);
 }
 
 static inline unsigned int get_freeobj(struct zspage *zspage)
@@ -1126,6 +1155,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		}
 
 		inc_zone_page_state(page, NR_ZSPAGES);
+		set_obj_allocated(page, 0);
 		pages[i] = page;
 	}
 
@@ -1456,6 +1486,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, 1);
+	mod_obj_allocated(m_page, 1);
 
 	obj = location_to_obj(m_page, obj);
 
@@ -1576,6 +1607,7 @@ static void obj_free(int class_size, unsigned long obj, unsigned long *handle)
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, -1);
+	mod_obj_allocated(f_page, -1);
 }
 
 void zs_free(struct zs_pool *pool, unsigned long handle)
-- 
2.38.1

