Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9E5F4DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJECkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJECkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:40:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8855004B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:40:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b15so6405373pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+8HyA4g1G7SzaN6nxygfOgRk8GE0piuM7BVZrp+fZZ0=;
        b=iJZoZ988DbLfqFyS85LiqYK0iD0Jl5QFkdRZH/o20Tn4yzm1XYNlW1NvR8vRf6IVWb
         pRjXWrj+frDOYasSYToNs0l/W03Wt0QpzcH/Ya0mtEBpV4j42YFvVLcLyWZpMf9YkFJ7
         Zs6v0x3YQ6L/TCAVKMbkXph43Miyvc2knSfbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+8HyA4g1G7SzaN6nxygfOgRk8GE0piuM7BVZrp+fZZ0=;
        b=jH2sHrT4G6QLkkcj7/VBcqiQxg3UUyLHGnm8idAND0faO1FS/Xo0xNEK1Pt02W+Pmi
         XbteRU5T5Lr0ajsEjjbZOeFqQvYu1593nBYcs9DHpuOswtutg2yGI8meOltTtJ08MviR
         rgLFbA4lbmUT1/wF2WCeSWOkdIsDVEFBPqJYeA9Qu/kk7mat1JH3atJXxocUkEFFk9bt
         WnKUEOFt5kle442YpTCuVNeJObQMtfgnjz0/8OqnrTrutRKYsaREF9EewR7doaSliAl/
         5jkL/wa77LnqgUVPKDgdI47TYNQDhssZKYPi5aT3dBw5LHnjjOL1109UGkIIE8gtjplm
         KRSA==
X-Gm-Message-State: ACrzQf1t6vGNniPG90KC4MKfLTrSR2FWrtvCzyqBTn7OJ6owISVm+8n5
        JyycMMjjMUgQEBAq5ha2LdF5Tw==
X-Google-Smtp-Source: AMsMyM5PtNm+kNj458oT3nacLJb/Pc90yrx3l6fXrSCv72h7b3aeffHIBEIPGYclwk6h6GPHs0r6AA==
X-Received: by 2002:a17:902:8541:b0:17f:6b27:7a75 with SMTP id d1-20020a170902854100b0017f6b277a75mr8912286plo.65.1664937629863;
        Tue, 04 Oct 2022 19:40:29 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:a9d9:6396:ee12:8be8])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b00561e010a309sm1673579pfl.19.2022.10.04.19.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 19:40:29 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 3/8] zram: Factor out WB and non-WB zram read functions
Date:   Wed,  5 Oct 2022 11:40:09 +0900
Message-Id: <20221005024014.22914-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221005024014.22914-1-senozhatsky@chromium.org>
References: <20221005024014.22914-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 70 ++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a8ef3c0c3dae..9ec60deeb186 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1314,8 +1314,34 @@ static void zram_free_page(struct zram *zram, size_t index)
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
+	/* A null bio means rw_page was used, we must fallback to bio */
+	if (!bio)
+		return -EOPNOTSUPP;
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
@@ -1323,23 +1349,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
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
@@ -1349,7 +1358,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		mem = kmap_atomic(page);
 		zram_fill_page(mem, PAGE_SIZE, value);
 		kunmap_atomic(mem);
-		zram_slot_unlock(zram, index);
 		return 0;
 	}
 
@@ -1371,7 +1379,25 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
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
+		ret = zram_read_from_writeback(zram, page, index, bio,
+					       partial_io);
+	}
 
 	/* Should NEVER happen. Return bio error if it does. */
 	if (WARN_ON(ret))
@@ -1381,7 +1407,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 }
 
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
-				u32 index, int offset, struct bio *bio)
+			  u32 index, int offset, struct bio *bio)
 {
 	int ret;
 	struct page *page;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

