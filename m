Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490A77049B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjEPJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjEPJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:51:06 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3503240C0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:51:03 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7F0595FD17;
        Tue, 16 May 2023 12:51:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684230661;
        bh=MGvRlhAiObQPWXRtPHw4CKUcfUp8JzuszDoiiJD8eE8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=OD7Zty2XuQfsR9a6HP/3ZZHoa1+LpDY5Y9SWEsO1Z2iZ4ibCfq/6MsLmvCmvzsClG
         hQSn0KD4TS5wXg2mL+eck/mhqxmA9Z5kZZZXtBIb3K9zN5fXYcR0mQSbz0YuqUg+t5
         vKciLSvC/trEZI0SfhKy3vCv5cnnXvUCk3/PpX4ug2ZTSHQmeAPq8x+2LFvyaVhLE2
         cp1+oJdBchnPx27W/gb+H7LmM2yePWx9SiIbq/Jq090ONC2vI7TcQcH7e+KIwZ5FMZ
         Dkth+ja8/oa0zPKXl8oSuH+3iw3zMD5tu1lg/u3E1SKQZwdFuWxHlsuCoZLjbUEYhK
         p4wgYgs65mztg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 16 May 2023 12:51:01 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 2/2] mm/zsmalloc: get rid of PAGE_MASK
Date:   Tue, 16 May 2023 12:50:29 +0300
Message-ID: <20230516095029.49036-2-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230516095029.49036-1-avromanov@sberdevices.ru>
References: <20230516095029.49036-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/16 05:57:00 #21317490
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
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

