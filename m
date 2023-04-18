Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E736E5960
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjDRGZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjDRGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:25:17 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C579119
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:25:15 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6C3205FD2D;
        Tue, 18 Apr 2023 09:25:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681799113;
        bh=MGvRlhAiObQPWXRtPHw4CKUcfUp8JzuszDoiiJD8eE8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=lgpZqY25RozH1jFqiti1K04fN66yH6C56ItLxROTuYVlC8RR+yVL0miskYjLbh8J9
         pG5WMadPjAxMS34iDMd7GLEctQbqysJ3+1dpLUccPM8SjLh33xmUkDU2N1j7N1nVOj
         bfAs24rkvSwvk1ts1qKmzBty+3BS5DN/klj61TxD3Qfqp5++YDTdWTn8WHp5K5WTUU
         TRbSGBe4Eo7IgfZYvRuX4/xw+6BK0qNukM77rPYZwEWdBhLHCwC54LS9cE5yTYZm+e
         wfhJfiSDMi6HS8sdqw6KK1gZzPFj2VgG+V28ZiSK93hX4plnZFwEj5nlGoQUw67YUY
         YfKRNUXii1Tzw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:25:13 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 2/5] mm/zsmalloc: get rid of PAGE_MASK
Date:   Tue, 18 Apr 2023 09:25:00 +0300
Message-ID: <20230418062503.62121-3-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230418062503.62121-1-avromanov@sberdevices.ru>
References: <20230418062503.62121-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/18 02:02:00 #21122658
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use offset_in_page() macro instead of 'val & ~PAGE_MASK'

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index f23c2da55368..0a3b11aa07a9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1425,7 +1425,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	spin_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
-	off = (class->size * obj_idx) & ~PAGE_MASK;
+	off = offset_in_page(class->size * obj_idx);
 
 	local_lock(&zs_map_area.lock);
 	area = this_cpu_ptr(&zs_map_area);
@@ -1465,7 +1465,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
 	class = zspage_class(pool, zspage);
-	off = (class->size * obj_idx) & ~PAGE_MASK;
+	off = offset_in_page(class->size * obj_idx);
 
 	area = this_cpu_ptr(&zs_map_area);
 	if (off + class->size <= PAGE_SIZE)
@@ -1522,7 +1522,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 
 	offset = obj * class->size;
 	nr_page = offset >> PAGE_SHIFT;
-	m_offset = offset & ~PAGE_MASK;
+	m_offset = offset_in_page(offset);
 	m_page = get_first_page(zspage);
 
 	for (i = 0; i < nr_page; i++)
@@ -1626,7 +1626,7 @@ static void obj_free(int class_size, unsigned long obj, unsigned long *handle)
 	void *vaddr;
 
 	obj_to_location(obj, &f_page, &f_objidx);
-	f_offset = (class_size * f_objidx) & ~PAGE_MASK;
+	f_offset = offset_in_page(class_size * f_objidx);
 	zspage = get_zspage(f_page);
 
 	vaddr = kmap_atomic(f_page);
@@ -1718,8 +1718,8 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	obj_to_location(src, &s_page, &s_objidx);
 	obj_to_location(dst, &d_page, &d_objidx);
 
-	s_off = (class->size * s_objidx) & ~PAGE_MASK;
-	d_off = (class->size * d_objidx) & ~PAGE_MASK;
+	s_off = offset_in_page(class->size * s_objidx);
+	d_off = offset_in_page(class->size * d_objidx);
 
 	if (s_off + class->size > PAGE_SIZE)
 		s_size = PAGE_SIZE - s_off;
-- 
2.38.1

