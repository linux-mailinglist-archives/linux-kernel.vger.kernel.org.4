Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1460BE33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJXXH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJXXHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:07:20 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A21412B358
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:28:51 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B59195FD16;
        Mon, 24 Oct 2022 15:09:56 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1666613396;
        bh=nc6jhUQNsZdri2+Q1s+EIKAfnFCelaJvCH3sqTAEXGY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Iv4g2AL99+N/fY4E0QQ+qSvkSe/nM1P7XxD3e29zAJBA+K6CdlMdtXSf+dUAs0WEU
         U4mzdAYVxlqWFg4JNDQMlVJQvSVa0CP9ALDCZpOzd8AcJDpCgqUEZpDhgce9KEiAlA
         28wWnyNgiwbJ4xX6NZtVrnQDa8e4yxoPkjGAbT5aqoYOXP241eoNxGX7b7l3kjBh6K
         OrCoMfxgrndrc48Y+k4ECcx24HJA8Fo+49Ro6et6DFYaOPdYFPU2wsLt21ILNlY8p+
         5+QfB6LJeO1/5hEHEs/QJL31qkq1MBd7/samW3WYr6dqoZbh9EjriYNW97QqelXE6n
         9vaEIfmJybFYw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 24 Oct 2022 15:09:54 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1] zram: add size class equals check into recompression
Date:   Mon, 24 Oct 2022 15:09:42 +0300
Message-ID: <20221024120942.13885-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/24 07:24:00 #20510762
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes no sense for us to recompress the object if it will
be in the same size class. We anyway don't get any memory gain.
But, at the same time, we get a CPU time overhead when inserting
this object into zspage and decompressing it afterwards.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/block/zram/zram_drv.c |  5 +++++
 include/linux/zsmalloc.h      |  2 ++
 mm/zsmalloc.c                 | 20 ++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 364323713393..bf610cf6a09c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1632,6 +1632,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	unsigned long handle_next;
 	unsigned int comp_len_next;
 	unsigned int comp_len_prev;
+	unsigned int class_size_next;
+	unsigned int class_size_prev;
 	struct zcomp_strm *zstrm;
 	void *src, *dst;
 	int ret;
@@ -1656,6 +1658,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	ret = zcomp_compress(zstrm, src, &comp_len_next);
 	kunmap_atomic(src);
 
+	class_size_prev = zs_get_class_size(zram->mem_pool, comp_len_prev);
+	class_size_next = zs_get_class_size(zram->mem_pool, comp_len_next);
 	/*
 	 * Either a compression error or we failed to compressed the object
 	 * in a way that will save us memory. Mark the object so that we
@@ -1663,6 +1667,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	 */
 	if (comp_len_next >= huge_class_size ||
 	    comp_len_next >= comp_len_prev ||
+	    class_size_next == class_size_prev ||
 	    ret) {
 		zram_set_flag(zram, index, ZRAM_RECOMP_SKIP);
 		zram_clear_flag(zram, index, ZRAM_IDLE);
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 2a430e713ce5..75dcbafd5f36 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -56,4 +56,6 @@ unsigned long zs_get_total_pages(struct zs_pool *pool);
 unsigned long zs_compact(struct zs_pool *pool);
 
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
+
+unsigned int zs_get_class_size(struct zs_pool *pool, unsigned int size);
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d03941cace2c..148451385445 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1205,6 +1205,26 @@ static bool zspage_full(struct size_class *class, struct zspage *zspage)
 	return get_zspage_inuse(zspage) == class->objs_per_zspage;
 }
 
+/**
+ * zs_get_class_size() - Returns the size (in bytes) of the
+ * zsmalloc &size_class into which the object with specified
+ * size will be inserted or already inserted.
+ *
+ * @pool: zsmalloc pool to use
+ *
+ * Context: Any context.
+ *
+ * Return: the size (in bytes) of the zsmalloc &size_class into which
+ * the object with specified size will be inserted.
+ */
+unsigned int zs_get_class_size(struct zs_pool *pool, unsigned int size)
+{
+	struct size_class *class = pool->size_class[get_size_class_index(size)];
+
+	return class->size;
+}
+EXPORT_SYMBOL_GPL(zs_get_class_size);
+
 unsigned long zs_get_total_pages(struct zs_pool *pool)
 {
 	return atomic_long_read(&pool->pages_allocated);
-- 
2.25.1

