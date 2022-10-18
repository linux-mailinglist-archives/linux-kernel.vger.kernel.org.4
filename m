Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781D460238D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJRE4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJREzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:55:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E416C6525F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:55:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so16252218pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 21:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPOwozwW566MrhSDQ5Hik/2oBaG/MJdP0TGgYtIKPis=;
        b=YnRifkaNMN9xeU3dP05q8Ea3BFeTmAimQBXUIgaGkiE2mSiMswcN01xw+OrW2yPYCF
         OvIXJvFjayfS/j734H+93oHgzpWOVPR33IaJNC/+srLLlOZGNDfcMf0kZlVFSBcKh4MV
         dADJd8226DEIE85679/r2I8nGKw2AK68/UaEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPOwozwW566MrhSDQ5Hik/2oBaG/MJdP0TGgYtIKPis=;
        b=3wecTXYPpgSKFeUuItCY7ZprOFecyn/IKah4f7Gay0xQrtP7LlvqgqEqvSVfY0VVh9
         UmvgP5lYa5yXFqtyn2OssjlN75eYN6aIN9w1mFtiQLZD4xxNBsSidQ6NdAit8MPxKRLH
         j7vKTWRjaRmw08ZdWkLwiXZmHPSvFoTNL819bXEqPn58NdtnSuzqTmhVKyaVkdGtNL/w
         2P3u2AS4WUl+pZJmTf4Pptc0M6uqKo3inB/GoZmrRuUOSbKyL9b47PRakAtWaYQ1X5DR
         dExIAtCcX0JRqHMdr/hY/tkHdjXwasHKL2vcyBEp+xT8GGBiGdMvJfq2ZjY9gmTKORG6
         owVw==
X-Gm-Message-State: ACrzQf3BLra82wJMCNy8WE8ngToogRmKp9HuZpQYWzx1GKrnybKk9vuG
        gP1Tdo4HaDeChvZA7dGsetIf4g==
X-Google-Smtp-Source: AMsMyM68b3LFlOFKZ5ZmhuvTT7t7kmp/l6V3wTu+yDELsOlS3kOPAXwmAmfP+TaiyKDtir3UTdwQrA==
X-Received: by 2002:a17:902:c405:b0:181:83e4:490e with SMTP id k5-20020a170902c40500b0018183e4490emr1173860plk.4.1666068949191;
        Mon, 17 Oct 2022 21:55:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:17a9:73b0:c262:eccd])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0017b69f99321sm7549220plf.219.2022.10.17.21.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:55:48 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 3/9] zram: Factor out WB and non-WB zram read functions
Date:   Tue, 18 Oct 2022 13:55:27 +0900
Message-Id: <20221018045533.2396670-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018045533.2396670-1-senozhatsky@chromium.org>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/block/zram/zram_drv.c | 73 ++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a8ef3c0c3dae..94c62d7ea818 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1314,8 +1314,30 @@ static void zram_free_page(struct zram *zram, size_t index)
 		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
 }
 
-static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
-				struct bio *bio, bool partial_io)
+/*
+ * Reads a page from the writeback devices. Corresponding ZRAM slot
+ * should be unlocked.
+ */
+static int zram_read_from_writeback(struct zram *zram, struct page *page,
+				    u32 index, struct bio *bio,
+				    bool partial_io)
+{
+	struct bio_vec bvec;
+
+	bvec.bv_page = page;
+	bvec.bv_len = PAGE_SIZE;
+	bvec.bv_offset = 0;
+	return read_from_bdev(zram, &bvec,
+			      zram_get_element(zram, index),
+			      bio, partial_io);
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
@@ -1323,23 +1345,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
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
@@ -1349,7 +1354,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		mem = kmap_atomic(page);
 		zram_fill_page(mem, PAGE_SIZE, value);
 		kunmap_atomic(mem);
-		zram_slot_unlock(zram, index);
 		return 0;
 	}
 
@@ -1371,17 +1375,40 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_ZCOMP]);
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
+		ret = zram_read_from_writeback(zram, page, index, bio,
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
2.38.0.413.g74048e4d9e-goog

