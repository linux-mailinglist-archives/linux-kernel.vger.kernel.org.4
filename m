Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532EB622AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiKILvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiKILvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE32CCA7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:02 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c2so16841053plz.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwLhHMvq7VueCMpUkTq+C+HTS32+Lk3Kl1y4kkNY1lI=;
        b=XU5vLFwkohaoQzaV3wsD4syG9ewC5z9qtbUASnBpI7yZfx6A/26UPA/KGss1F89lzr
         bLhHgQibUdXpBvhVKkTalBkDQSjdosyCaORUHtLQtl3nxDZaeFifxXfpsE09Dx1L42Ag
         Lh43EhiVNoB8JL3gbSz6XvnAW519pupdtZBZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwLhHMvq7VueCMpUkTq+C+HTS32+Lk3Kl1y4kkNY1lI=;
        b=1Zh0k5jJd0nvbRNteAzackm72/J2rpIj9YjCA6GtJ6ERbd3g/JFCZSetK/SlDvzlwg
         CmblpujQpzth0Ry3h+jh4ZH9so+lrKQzrl/YeBjXa29hDVuIUEb6KGFFQvkyPhgOxnFU
         amKtOLYZXkRArzRuHMFZiCsUfjdO2sx+nitd6zT7oBHjSd27cxQso5IogIyX5GjHfS1W
         m2LJWoT4vX/UCogS5QPPK1yffn93NHtNrlMdF+hEfg8YDONxyfkdim6KLUjTVMqZ2GQc
         vy/BjZ8tJU5YSW0LGcbHkxobT3q7Woe2CfpkF2VV4VJ9gj+6PRgulbsjC0lVdVWp0TUU
         oRvQ==
X-Gm-Message-State: ACrzQf3hngyvu5qbculHHRsys01HK9uY8ggqFMCDRY9nUuJkOVOP4Ocj
        v1aCiq2RZeETNr2KNFgdaGRNzg==
X-Google-Smtp-Source: AMsMyM6YjoApz2cmt93xkc5aPeuhMLaP2uc6ExE39WsDWmfAadxJs9lufYlSSW28eW1IwTrpZrxuvA==
X-Received: by 2002:a17:90b:3b8d:b0:214:1066:67c7 with SMTP id pc13-20020a17090b3b8d00b00214106667c7mr45511923pjb.209.1667994662480;
        Wed, 09 Nov 2022 03:51:02 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:02 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 03/13] zram: Factor out WB and non-WB zram read functions
Date:   Wed,  9 Nov 2022 20:50:37 +0900
Message-Id: <20221109115047.2921851-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will use non-WB variant in ZRAM page recompression path.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 72 ++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 56026a6deb70..a6a5fd2474d7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1339,8 +1339,29 @@ static void zram_free_page(struct zram *zram, size_t index)
 		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
 }
 
-static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
-				struct bio *bio, bool partial_io)
+/*
+ * Reads a page from the writeback devices. Corresponding ZRAM slot
+ * should be unlocked.
+ */
+static int zram_bvec_read_from_bdev(struct zram *zram, struct page *page,
+				    u32 index, struct bio *bio, bool partial_io)
+{
+	struct bio_vec bvec = {
+		.bv_page = page,
+		.bv_len = PAGE_SIZE,
+		.bv_offset = 0,
+	};
+
+	return read_from_bdev(zram, &bvec, zram_get_element(zram, index), bio,
+			      partial_io);
+}
+
+/*
+ * Reads (decompresses if needed) a page from zspool (zsmalloc).
+ * Corresponding ZRAM slot should be locked.
+ */
+static int zram_read_from_zspool(struct zram *zram, struct page *page,
+				 u32 index)
 {
 	struct zcomp_strm *zstrm;
 	unsigned long handle;
@@ -1348,23 +1369,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 	void *src, *dst;
 	int ret;
 
-	zram_slot_lock(zram, index);
-	if (zram_test_flag(zram, index, ZRAM_WB)) {
-		struct bio_vec bvec;
-
-		zram_slot_unlock(zram, index);
-		/* A null bio means rw_page was used, we must fallback to bio */
-		if (!bio)
-			return -EOPNOTSUPP;
-
-		bvec.bv_page = page;
-		bvec.bv_len = PAGE_SIZE;
-		bvec.bv_offset = 0;
-		return read_from_bdev(zram, &bvec,
-				zram_get_element(zram, index),
-				bio, partial_io);
-	}
-
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
 		unsigned long value;
@@ -1374,7 +1378,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		mem = kmap_atomic(page);
 		zram_fill_page(mem, PAGE_SIZE, value);
 		kunmap_atomic(mem);
-		zram_slot_unlock(zram, index);
 		return 0;
 	}
 
@@ -1396,17 +1399,40 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
 	}
 	zs_unmap_object(zram->mem_pool, handle);
-	zram_slot_unlock(zram, index);
+	return ret;
+}
+
+static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
+			    struct bio *bio, bool partial_io)
+{
+	int ret;
+
+	zram_slot_lock(zram, index);
+	if (!zram_test_flag(zram, index, ZRAM_WB)) {
+		/* Slot should be locked through out the function call */
+		ret = zram_read_from_zspool(zram, page, index);
+		zram_slot_unlock(zram, index);
+	} else {
+		/* Slot should be unlocked before the function call */
+		zram_slot_unlock(zram, index);
+
+		/* A null bio means rw_page was used, we must fallback to bio */
+		if (!bio)
+			return -EOPNOTSUPP;
+
+		ret = zram_bvec_read_from_bdev(zram, page, index, bio,
+					       partial_io);
+	}
 
 	/* Should NEVER happen. Return bio error if it does. */
-	if (WARN_ON(ret))
+	if (WARN_ON(ret < 0))
 		pr_err("Decompression failed! err=%d, page=%u\n", ret, index);
 
 	return ret;
 }
 
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
-				u32 index, int offset, struct bio *bio)
+			  u32 index, int offset, struct bio *bio)
 {
 	int ret;
 	struct page *page;
-- 
2.38.1.431.g37b22c650d-goog

