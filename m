Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257375F3224
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJCOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJCOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:48:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4723134A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 07:48:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t6-20020a25b706000000b006b38040b6f7so10345297ybj.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=xHoaRWCVhWSSlLD1f56pL29VfpfXkJDAYHp4BlcCVvQ=;
        b=A1C9Ngay3y/4idr53uP9zykzmTt9XNNZHUzy5kSuis0btdWXbX4qzvrMj062/Kkpfb
         ZP+sRmymNVzKBNYSOreArTFi0di1vQ3euG+p1RxThVHcsJq8GeuvLK+aq7moaQs9ouE3
         T+XHKOL4/h265Vc4RECPOC2f6OprsSoRgMwa4VJ55zlciE5akmNXtKPaVfYPrvilGgyl
         WYwUSz7XaG15IyxbInLYkRANzgGwyZy5mlWmrSfXhqWX0hNL51eKfqtVOnbv9Hd+ikQh
         pFH80F2EEHjsRYW9r8lM0PdHOwCd05jC6a1tfPTg+lXRNRLeorJnHbzJax75H2wC9hPr
         w2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=xHoaRWCVhWSSlLD1f56pL29VfpfXkJDAYHp4BlcCVvQ=;
        b=EIzgqWPURZJRJV5TgmkNJn7Pz1vtcvymMaVYlSflYCO93JcJA0QKV8f6IGU0DRceLM
         v2c8xsWCTXyRdBii4lqvWJZobXji5QLZFIPSnrkSqMj07FKmHklLFUrYQavG/I9Ov55g
         bqZzOuDGJpYHKyp2M+8/c0pL26/qLslkxqJj5t6kFqWGynMpZZWIvQ3AdLuGJyeoOX36
         yw0av7b82Xn069GWgwu1kIXIlt3EUVOdtx4OtPguesElNlD9j1eBXG/LLLhtnZfNiHAg
         ytTTw37FAMvBcUnzpthRpEDfGU6ktNt0RJBUXrMYet08uP9uAvFnhJtFGnz4k6X9FGAb
         7b+A==
X-Gm-Message-State: ACrzQf0Erw9ujnjTklM5GBQ7aCv1dXX1UpFs4shgsCSbTmNyuPaChYHL
        rJUkiOCdQwdrVAdxtN98jjo0GPH1iKy+
X-Google-Smtp-Source: AMsMyM6zRu3lqQ+w4swR2VVfhJ4iJQIP0XYpK5naXC0AP6LKbr6+n0z7pWLhLPZGHJ/5f2sLi2zRx0I30gRD
X-Received: from bg.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b4])
 (user=bgeffon job=sendgmr) by 2002:a81:5357:0:b0:352:2e42:eace with SMTP id
 h84-20020a815357000000b003522e42eacemr20464524ywb.256.1664808514817; Mon, 03
 Oct 2022 07:48:34 -0700 (PDT)
Date:   Mon,  3 Oct 2022 10:48:32 -0400
In-Reply-To: <Yy4JkpZ/SnXtrVRf@google.com>
Mime-Version: 1.0
References: <Yy4JkpZ/SnXtrVRf@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003144832.2906610-1-bgeffon@google.com>
Subject: [PATCH v2] zram: Always expose rw_page
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently zram will adjust its fops to a version which does not
contain rw_page when a backing device has been assigned. This is
done to prevent upper layers from assuming a synchronous operation
when a page may have been written back. This forces every operation
through bio which has overhead associated with bio_alloc/frees.

The code can be simplified to always expose a rw_page method and
only in the rare event that a page is written back we instead will
return -EOPNOTSUPP forcing the upper layer to fallback to bio.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 226ea76cc819..fcde1d7fdaf2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -52,9 +52,6 @@ static unsigned int num_devices = 1;
 static size_t huge_class_size;
 
 static const struct block_device_operations zram_devops;
-#ifdef CONFIG_ZRAM_WRITEBACK
-static const struct block_device_operations zram_wb_devops;
-#endif
 
 static void zram_free_page(struct zram *zram, size_t index);
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
@@ -543,17 +540,6 @@ static ssize_t backing_dev_store(struct device *dev,
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
-	/*
-	 * With writeback feature, zram does asynchronous IO so it's no longer
-	 * synchronous device so let's remove synchronous io flag. Othewise,
-	 * upper layer(e.g., swap) could wait IO completion rather than
-	 * (submit and return), which will cause system sluggish.
-	 * Furthermore, when the IO function returns(e.g., swap_readpage),
-	 * upper layer expects IO was done so it could deallocate the page
-	 * freely but in fact, IO is going on so finally could cause
-	 * use-after-free when the IO is really done.
-	 */
-	zram->disk->fops = &zram_wb_devops;
 	up_write(&zram->init_lock);
 
 	pr_info("setup backing device %s\n", file_name);
@@ -1267,6 +1253,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		struct bio_vec bvec;
 
 		zram_slot_unlock(zram, index);
+		/* A null bio means rw_page was used, we must fallback to bio */
+		if (!bio)
+			return -EOPNOTSUPP;
 
 		bvec.bv_page = page;
 		bvec.bv_len = PAGE_SIZE;
@@ -1848,15 +1837,6 @@ static const struct block_device_operations zram_devops = {
 	.owner = THIS_MODULE
 };
 
-#ifdef CONFIG_ZRAM_WRITEBACK
-static const struct block_device_operations zram_wb_devops = {
-	.open = zram_open,
-	.submit_bio = zram_submit_bio,
-	.swap_slot_free_notify = zram_slot_free_notify,
-	.owner = THIS_MODULE
-};
-#endif
-
 static DEVICE_ATTR_WO(compact);
 static DEVICE_ATTR_RW(disksize);
 static DEVICE_ATTR_RO(initstate);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

