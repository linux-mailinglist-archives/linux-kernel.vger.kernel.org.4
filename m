Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786825F5986
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiJESEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiJESEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:04:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA3A74B99;
        Wed,  5 Oct 2022 11:04:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gf8so13648748pjb.5;
        Wed, 05 Oct 2022 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8tNeWv+0nv7FXmMat9FJ50mQ7l5yun8pgPApcsh1yw=;
        b=iGiCtwUJuErnNlAIo4FT/4bcJD5Wks2spXOcIZtRA/WUiXPtpwF/DU5z9tyTsk5CB/
         39szPETZHXlAC1SqY0naRLLzzPFCToSvDBN0mO1i3PJR2Lru373sQYYQ7KEVita4fbjM
         nA0YLO/oHE/71/iwUn4rZQerJ29H/Vsm8cHA0UEn9iejDGqhX3xB6P/DeCSkzPKF+zn4
         pEwnsbWbJU/i0oRUD/bAECH7khbJqtfJCz0eDaR6Aujbd+xpWbhz0Dw4DdVAin2UKOry
         61e05LpZ/BuZaQ6F8fIfNKl1RhxSoQ7g6KwE1485jwEeXgwCsh95cFW0KlPwrBJ0xhbf
         QUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8tNeWv+0nv7FXmMat9FJ50mQ7l5yun8pgPApcsh1yw=;
        b=VRO8pWuTbYBoFBqI/qWhlOoxTpTuCaHG/wE5YfD78ectCppPAhrXrIWYQ8Ug0/3uaw
         0/bde1/059D4tyUhRGzQyA36g2ZilgW1bpHTlSK/jaodvjL5MwIgaUbwI+h3Dxbo5xei
         3rZ7l+E/m2Zy6zYdwxn24chlA9t3WMZrrKRZgCXVlaUTW55RCeN7WKYxEAYndgSYBiyu
         wH1ddr3xRBDTZbv3yh53ArVny7GwWuvNLNi+Dh4Rp5XPMdZJOoCrI92oYimu7uulz8NF
         aPIMJexA/+0Abx2OYDXcXHiW1DE6FhWPuuRNa0r1ORRT8qrLIcP9rOFUWVoS5cLqF+GQ
         MJMw==
X-Gm-Message-State: ACrzQf0KkaWpP+J5XD93lOO+tSjtXUSEK3XKvJTrJSdEwN76S8pz3Z5/
        t2RSUZw5l/6QAnQTDAH/GKM=
X-Google-Smtp-Source: AMsMyM6dffG6twubdAg50b0ZfzNL/4dO6jBfiQTtKARmAZ1J5Sjn4eFIdDTcXNZxz+o/OJWGLmOG5g==
X-Received: by 2002:a17:902:d2d2:b0:177:4940:cc0f with SMTP id n18-20020a170902d2d200b001774940cc0fmr907820plc.4.1664993039312;
        Wed, 05 Oct 2022 11:03:59 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b001788494b764sm10674639plc.231.2022.10.05.11.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:03:58 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] md: dm-crypt: use mempool page bulk allocator
Date:   Wed,  5 Oct 2022 11:03:41 -0700
Message-Id: <20221005180341.1738796-5-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221005180341.1738796-1-shy828301@gmail.com>
References: <20221005180341.1738796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using dm-crypt for full disk encryption, dm-crypt would allocate
an out bio and allocate the same amount of pages as in bio for
encryption.  It currently allocates one page at a time in a loop.  This
is not efficient.  So using mempool page bulk allocator instead of
allocating one page at a time.

The mempool page bulk allocator would improve the IOPS with 1M I/O
by approxiamately 6%.  The test is done on a VM with 80 vCPU and
64GB memory with an encrypted ram device (the impact from storage
hardware could be minimized so that we could benchmark the dm-crypt
layer more accurately).

Before the patch:
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=402MiB/s][r=0,w=402 IOPS][eta 00m:00s]
crypt: (groupid=0, jobs=1): err= 0: pid=233950: Thu Sep 15 16:23:10 2022
  write: IOPS=402, BW=403MiB/s (423MB/s)(23.6GiB/60002msec)
    slat (usec): min=2425, max=3819, avg=2480.84, stdev=34.00
    clat (usec): min=7, max=165751, avg=156398.72, stdev=4691.03
     lat (msec): min=2, max=168, avg=158.88, stdev= 4.69
    clat percentiles (msec):
     |  1.00th=[  157],  5.00th=[  157], 10.00th=[  157], 20.00th=[  157],
     | 30.00th=[  157], 40.00th=[  157], 50.00th=[  157], 60.00th=[  157],
     | 70.00th=[  157], 80.00th=[  157], 90.00th=[  157], 95.00th=[  157],
     | 99.00th=[  159], 99.50th=[  159], 99.90th=[  165], 99.95th=[  165],
     | 99.99th=[  167]
   bw (  KiB/s): min=405504, max=413696, per=99.71%, avg=411845.53, stdev=1155.04, samples=120
   iops        : min=  396, max=  404, avg=402.17, stdev= 1.15, samples=120
  lat (usec)   : 10=0.01%
  lat (msec)   : 4=0.01%, 10=0.01%, 20=0.02%, 50=0.05%, 100=0.08%
  lat (msec)   : 250=100.09%
  cpu          : usr=3.74%, sys=95.66%, ctx=27, majf=0, minf=4
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=103.1%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,24138,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=403MiB/s (423MB/s), 403MiB/s-403MiB/s (423MB/s-423MB/s), io=23.6GiB (25.4GB), run=60002-60002msec

After the patch:
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=430MiB/s][r=0,w=430 IOPS][eta 00m:00s]
crypt: (groupid=0, jobs=1): err= 0: pid=288730: Thu Sep 15 16:25:39 2022
  write: IOPS=430, BW=431MiB/s (452MB/s)(25.3GiB/60002msec)
    slat (usec): min=2253, max=3213, avg=2319.49, stdev=34.29
    clat (usec): min=6, max=149337, avg=146257.68, stdev=4239.52
     lat (msec): min=2, max=151, avg=148.58, stdev= 4.24
    clat percentiles (msec):
     |  1.00th=[  146],  5.00th=[  146], 10.00th=[  146], 20.00th=[  146],
     | 30.00th=[  146], 40.00th=[  146], 50.00th=[  146], 60.00th=[  146],
     | 70.00th=[  146], 80.00th=[  146], 90.00th=[  148], 95.00th=[  148],
     | 99.00th=[  148], 99.50th=[  148], 99.90th=[  150], 99.95th=[  150],
     | 99.99th=[  150]
   bw (  KiB/s): min=438272, max=442368, per=99.73%, avg=440463.57, stdev=1305.60, samples=120
   iops        : min=  428, max=  432, avg=430.12, stdev= 1.28, samples=120
  lat (usec)   : 10=0.01%
  lat (msec)   : 4=0.01%, 10=0.01%, 20=0.02%, 50=0.05%, 100=0.09%
  lat (msec)   : 250=100.07%
  cpu          : usr=3.78%, sys=95.37%, ctx=12778, majf=0, minf=4
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=103.1%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=0,25814,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
  WRITE: bw=431MiB/s (452MB/s), 431MiB/s-431MiB/s (452MB/s-452MB/s), io=25.3GiB (27.1GB), run=60002-60002msec

The function tracing also shows the time consumed by page allocations is
reduced significantly.  The test allocated 1M (256 pages) bio in the same
environment.

Before the patch:
It took approximately 600us by excluding the bio_add_page() calls.
2720.630754 |   56)  xfs_io-38859  |   2.571 us    |    mempool_alloc();
2720.630757 |   56)  xfs_io-38859  |   0.937 us    |    bio_add_page();
 2720.630758 |   56)  xfs_io-38859  |   1.772 us    |    mempool_alloc();
 2720.630760 |   56)  xfs_io-38859  |   0.852 us    |    bio_add_page();
….
2720.631559 |   56)  xfs_io-38859  |   2.058 us    |    mempool_alloc();
 2720.631561 |   56)  xfs_io-38859  |   0.717 us    |    bio_add_page();
 2720.631562 |   56)  xfs_io-38859  |   2.014 us    |    mempool_alloc();
 2720.631564 |   56)  xfs_io-38859  |   0.620 us    |    bio_add_page();

After the patch:
It took approxiamately 30us.
11564.266385 |   22) xfs_io-136183  | + 30.551 us   |    __alloc_pages_bulk();

Page allocations overhead is around 6% (600us/9853us) in dm-crypt layer shown by
function trace.  The data also matches the IOPS data shown by fio.

And the benchmark with 4K size I/O doesn't show measurable regression.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 drivers/md/dm-crypt.c | 70 +++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 85ac1f9b37ae..c86bd4af4d75 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1673,34 +1673,37 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
 	struct bio *clone;
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
-	unsigned i, len, remaining_size;
+	unsigned len;
 	struct page *page;
-
-retry:
-	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
-		mutex_lock(&cc->bio_alloc_lock);
+	LIST_HEAD(page_list);
 
 	clone = bio_alloc_bioset(cc->dev->bdev, nr_iovecs, io->base_bio->bi_opf,
 				 GFP_NOIO, &cc->bs);
 	clone->bi_private = io;
 	clone->bi_end_io = crypt_endio;
 
-	remaining_size = size;
+retry:
+	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
+		mutex_lock(&cc->bio_alloc_lock);
 
-	for (i = 0; i < nr_iovecs; i++) {
-		page = mempool_alloc(&cc->page_pool, gfp_mask);
-		if (!page) {
-			crypt_free_buffer_pages(cc, clone);
-			bio_put(clone);
-			gfp_mask |= __GFP_DIRECT_RECLAIM;
-			goto retry;
+	if (mempool_alloc_pages_bulk_list(&cc->page_pool, gfp_mask, nr_iovecs,
+					  &page_list)) {
+		while (!list_empty(&page_list)) {
+			page = lru_to_page(&page_list);
+			list_del_init(&page->lru);
+			len = (size > PAGE_SIZE) ? PAGE_SIZE : size;
+			bio_add_page(clone, page, len, 0);
+			size -= len;
+		}
+	} else {
+		while (!list_empty(&page_list)) {
+			page = lru_to_page(&page_list);
+			list_del_init(&page->lru);
+			mempool_free(page, &cc->page_pool);
 		}
 
-		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
-
-		bio_add_page(clone, page, len, 0);
-
-		remaining_size -= len;
+		gfp_mask |= __GFP_DIRECT_RECLAIM;
+		goto retry;
 	}
 
 	/* Allocate space for integrity tags */
@@ -2654,10 +2657,13 @@ static void crypt_calculate_pages_per_client(void)
 	dm_crypt_pages_per_client = pages;
 }
 
-static void *crypt_page_alloc(gfp_t gfp_mask, void *pool_data)
+static unsigned int crypt_alloc_pages_bulk(gfp_t gfp_mask, unsigned int nr,
+					   void *pool_data,
+					   struct list_head *page_list,
+					   struct page **page_array)
 {
 	struct crypt_config *cc = pool_data;
-	struct page *page;
+	unsigned int ret;
 
 	/*
 	 * Note, percpu_counter_read_positive() may over (and under) estimate
@@ -2666,13 +2672,13 @@ static void *crypt_page_alloc(gfp_t gfp_mask, void *pool_data)
 	 */
 	if (unlikely(percpu_counter_read_positive(&cc->n_allocated_pages) >= dm_crypt_pages_per_client) &&
 	    likely(gfp_mask & __GFP_NORETRY))
-		return NULL;
+		return 0;
+
+	ret = alloc_pages_bulk_list(gfp_mask, nr, page_list);
 
-	page = alloc_page(gfp_mask);
-	if (likely(page != NULL))
-		percpu_counter_add(&cc->n_allocated_pages, 1);
+	percpu_counter_add(&cc->n_allocated_pages, ret);
 
-	return page;
+	return ret;
 }
 
 static void crypt_page_free(void *page, void *pool_data)
@@ -2704,13 +2710,17 @@ static void crypt_dtr(struct dm_target *ti)
 
 	bioset_exit(&cc->bs);
 
+	/*
+	 * With mempool bulk allocator the pages in the pool are not
+	 * counted in n_allocated_pages.
+	 */
+	WARN_ON(percpu_counter_sum(&cc->n_allocated_pages) != 0);
+	percpu_counter_destroy(&cc->n_allocated_pages);
+
 	mempool_exit(&cc->page_pool);
 	mempool_exit(&cc->req_pool);
 	mempool_exit(&cc->tag_pool);
 
-	WARN_ON(percpu_counter_sum(&cc->n_allocated_pages) != 0);
-	percpu_counter_destroy(&cc->n_allocated_pages);
-
 	if (cc->iv_gen_ops && cc->iv_gen_ops->dtr)
 		cc->iv_gen_ops->dtr(cc);
 
@@ -3250,7 +3260,9 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ALIGN(sizeof(struct dm_crypt_io) + cc->dmreq_start + additional_req_size,
 		      ARCH_KMALLOC_MINALIGN);
 
-	ret = mempool_init(&cc->page_pool, BIO_MAX_VECS, crypt_page_alloc, crypt_page_free, cc);
+	ret = mempool_init_pages_bulk(&cc->page_pool, BIO_MAX_VECS,
+				      crypt_alloc_pages_bulk, crypt_page_free,
+				      cc);
 	if (ret) {
 		ti->error = "Cannot allocate page mempool";
 		goto bad;
-- 
2.26.3

