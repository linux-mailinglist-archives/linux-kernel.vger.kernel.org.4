Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1A60EEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJ0E1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiJ0E1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:27:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093F3E08B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5108532pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57/g83Q1A5B+7wYv3+Gd1tLG4FTDJnhj+xIMySGShWo=;
        b=LZs2JMXZj7KI645ET3ePzlYTovXfQcMuYjwdrOg5BaYkxa+fijxsky6kZpjuSMeQBJ
         BGkN2zAjC2aEEU+sHnEyYaqBqEMT2fIAi2bNnzs5itLbkhK39LWk6qQJg3L+YKJT1DY1
         q0wrekK8aRmyK+zz13YXy8QchBMVywGgfKGjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57/g83Q1A5B+7wYv3+Gd1tLG4FTDJnhj+xIMySGShWo=;
        b=K5/Jogr32L0yDFOlh6YuSv0X2LALC6pacLTyu4/KEqm9sW80eb4T0qY1+F1mkUTNEx
         7ddA2q03/Hn10a5aaIEdy6IxmGG3ZnYJ251ekJJzmLj1WH2PmuFo4G6FS8E3aJx2h7Kr
         Zrr/7ew5XY6aVgRlx+u3r3gwS/EN27izcbXlmlnhMNc7XmEbeNZ19KRcxfasykwF7VOy
         zvySd3FQsZakwvwNSbS25C4wbvfkiXSac+iWUnIGQAfsdnmDSG74awvc8n0EfIlGYcN2
         z6EG6pwPfF0iHcWrxPCuOmyK9mU2Ka3BPSxz+qoAJkMS8X4YGxRhZhDPZ5R+3+nRl9gQ
         llHQ==
X-Gm-Message-State: ACrzQf0COdsYcNiCwkLykOWp1DnLDfOt8DjV96LcV/+OQyqe9KO23pm2
        37vt9wCC4Y4GvSzHpEaK80Y64g==
X-Google-Smtp-Source: AMsMyM5PObH8+UVD6/TXg62DaefgWJnjzeH/HC6fFf1zxc0vCIYe8Ts+HBK8eTrV8813vgGH6x6wAg==
X-Received: by 2002:a17:90a:bf11:b0:211:84c5:42d7 with SMTP id c17-20020a17090abf1100b0021184c542d7mr7800117pjs.122.1666844819541;
        Wed, 26 Oct 2022 21:26:59 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:26:59 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCHv3 1/9] zram: add size class equals check into recompression
Date:   Thu, 27 Oct 2022 13:26:43 +0900
Message-Id: <20221027042651.234524-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027042651.234524-1-senozhatsky@chromium.org>
References: <20221027042651.234524-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Romanov <avromanov@sberdevices.ru>

It makes no sense for us to recompress the object if it will
be in the same size class. We anyway don't get any memory gain.
But, at the same time, we get a CPU time overhead when inserting
this object into zspage and decompressing it afterwards.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/block/zram/zram_drv.c |  5 +++++
 include/linux/zsmalloc.h      |  2 ++
 mm/zsmalloc.c                 | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 364323713393..fd31beb6491a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1632,6 +1632,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	unsigned long handle_next;
 	unsigned int comp_len_next;
 	unsigned int comp_len_prev;
+	unsigned int class_index_prev;
+	unsigned int class_index_next;
 	struct zcomp_strm *zstrm;
 	void *src, *dst;
 	int ret;
@@ -1656,6 +1658,8 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	ret = zcomp_compress(zstrm, src, &comp_len_next);
 	kunmap_atomic(src);
 
+	class_index_prev = zs_lookup_class_index(zram->mem_pool, comp_len_prev);
+	class_index_next = zs_lookup_class_index(zram->mem_pool, comp_len_next);
 	/*
 	 * Either a compression error or we failed to compressed the object
 	 * in a way that will save us memory. Mark the object so that we
@@ -1663,6 +1667,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	 */
 	if (comp_len_next >= huge_class_size ||
 	    comp_len_next >= comp_len_prev ||
+	    class_index_next >= class_index_prev ||
 	    ret) {
 		zram_set_flag(zram, index, ZRAM_RECOMP_SKIP);
 		zram_clear_flag(zram, index, ZRAM_IDLE);
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 2a430e713ce5..a48cd0ffe57d 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -55,5 +55,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle);
 unsigned long zs_get_total_pages(struct zs_pool *pool);
 unsigned long zs_compact(struct zs_pool *pool);
 
+unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size);
+
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
 #endif
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d03941cace2c..065744b7e9d8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1205,6 +1205,27 @@ static bool zspage_full(struct size_class *class, struct zspage *zspage)
 	return get_zspage_inuse(zspage) == class->objs_per_zspage;
 }
 
+/**
+ * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
+ * that hold objects of the provided size.
+ * @pool: zsmalloc pool to use
+ * @size: object size
+ *
+ * Context: Any context.
+ *
+ * Return: the index of the zsmalloc &size_class that hold objects of the
+ * provided size.
+ */
+unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
+{
+	struct size_class *class;
+
+	class = pool->size_class[get_size_class_index(size)];
+
+	return class->index;
+}
+EXPORT_SYMBOL_GPL(zs_lookup_class_index);
+
 unsigned long zs_get_total_pages(struct zs_pool *pool)
 {
 	return atomic_long_read(&pool->pages_allocated);
-- 
2.38.0.135.g90850a2211-goog

