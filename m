Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E25B31F0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiIIIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIIIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:37:39 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23510D708
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:37:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 357BD5FD1C;
        Fri,  9 Sep 2022 11:37:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1662712652;
        bh=xVWmjfrAOZn0OTmtrVSeejUA6QDBwT/l648aSc855Dk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=k177lyVLUgFzM5tTv7P409zm4A+XTfRasHNqz5MsNfDlgit5eAOXFvnXbjAnqA+a2
         lBxeF8Xkfd2RmHLw3WbyFhkonWbA9UJSdMleFo8amGgwb8G83Mi8rnNrlrje8X67ew
         /LDab0zqJn41GFCbkO9WDcWdzgaJ2dw2iYB7tnouzC5Ug/vU/nAubGzMY4wx1OuL8L
         SviPpHAOC7sBGPFXnQroVJGnygm7xXMAYh5mG220VQrptgdDvEWkdL0kRqkt2YmKbW
         gp4st2Yp/z11gXIZ2C3NDMXpGZzIAQ6f3eUmfqe8XGaGwNIf+w2QljkvJYcmhZKtxP
         3SP96R3qsIG4Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri,  9 Sep 2022 11:37:30 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1] zsmalloc: use correct types in _first_obj_offset functions
Date:   Fri, 9 Sep 2022 11:37:22 +0300
Message-ID: <20220909083722.85024-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/09/09 06:34:00 #20273214
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ffedd09fa9b0
("zsmalloc: Stop using slab fields in struct page") we are using
page->page_type (unsigned int) field instead of page->units (int)
as first object offset in a subpage of zspage. So get_first_obj_offset()
and set_first_obj_offset() functions should work with unsigned int type.

Fixes: ffedd09fa9b0 ("zsmalloc: Stop using slab fields in struct page")
Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7f833556e059..13c2a28521e8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -472,12 +472,12 @@ static inline struct page *get_first_page(struct zspage *zspage)
 	return first_page;
 }
 
-static inline int get_first_obj_offset(struct page *page)
+static inline unsigned int get_first_obj_offset(struct page *page)
 {
 	return page->page_type;
 }
 
-static inline void set_first_obj_offset(struct page *page, int offset)
+static inline void set_first_obj_offset(struct page *page, unsigned int offset)
 {
 	page->page_type = offset;
 }
@@ -1592,7 +1592,7 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 static unsigned long find_alloced_obj(struct size_class *class,
 					struct page *page, int *obj_idx)
 {
-	int offset = 0;
+	unsigned int offset;
 	int index = *obj_idx;
 	unsigned long handle = 0;
 	void *addr = kmap_atomic(page);
@@ -1846,7 +1846,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	struct zspage *zspage;
 	struct page *dummy;
 	void *s_addr, *d_addr, *addr;
-	int offset;
+	unsigned int offset;
 	unsigned long handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
-- 
2.25.1

