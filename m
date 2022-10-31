Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41D612FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJaFlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJaFlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:41:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3255FAE6F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k15so1727404pfg.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v+j7YIhXu2E5hbe6+G2o2cWhQoPLQTweQOnVfkUv2E=;
        b=HHA2qvPEXFBXVL0y35D/gKbkMA3J8JE7u+qse7jccRNYRVFeZl1ZI8qGbNMOVHXSHf
         v40uZihi/8P1v4QSHUvJCAjLlzOeQ9qeN0ngXzT5Xo41WcZ2vMNTKZiUV4bOmY+SSXQ3
         Byk0Lm156jYYKOSKcsI020PV+WW+rdYOEU3jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9v+j7YIhXu2E5hbe6+G2o2cWhQoPLQTweQOnVfkUv2E=;
        b=lyO1tFrDitDsQhK3O5IxaDSTg8jmc3SdqxlA6t9tly3QA0nFrxAfB8ZkSLYcs0MIAZ
         fyYIYhvnFU0MQmzYOi6BNAPfRyOg+pu7Ka4qroyeFE+mQOTmhVidtc2zRBJFzxi1CK9g
         0vuVwGtP7QySbgaKy2b+AtKrbAK6Hev5j5jAlFqmgS89A0GvRiB5szxculJyN2O9OGyy
         qG+bXhPIRlbBOjp56jL9rG2ubbQJjAXUNRtfp3fPZGcHndWbk8Mk10LfME1c/l9IvfJe
         jvM5ROE7TezL2f2ijfXWMd1hmDpmGEffFrjO3yHrj89hGOcOFThRCXGGYQhFIRPYFubU
         /eew==
X-Gm-Message-State: ACrzQf0gmoA5RDUqJoz74THhK7jjVGYa619sDD1zYXfk2pGr6Filidv+
        Jw9uAmPEqGw2zkkKD7Y7XDyLaQ==
X-Google-Smtp-Source: AMsMyM729ihr9fgmUqPg4KMVep0S/XyIpWy1ij2ONm3nVQwOjuSAsnZN6ZOCyx8QyEgYr7CDgaOUiA==
X-Received: by 2002:a62:e40e:0:b0:56b:add7:fc22 with SMTP id r14-20020a62e40e000000b0056badd7fc22mr12547815pfh.63.1667194879706;
        Sun, 30 Oct 2022 22:41:19 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:19 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexey Romanov <avromanov@sberdevices.ru>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 1/9] zram: add size class equals check into recompression
Date:   Mon, 31 Oct 2022 14:41:00 +0900
Message-Id: <20221031054108.541190-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221031054108.541190-1-senozhatsky@chromium.org>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
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
2.38.1.273.g43a17bfeac-goog

