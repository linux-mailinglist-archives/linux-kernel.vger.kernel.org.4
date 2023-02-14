Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0333696D87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjBNTC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjBNTCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:02:46 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A4126CDF;
        Tue, 14 Feb 2023 11:02:42 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i26so265512ila.11;
        Tue, 14 Feb 2023 11:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adXFc2bAE5N2Ax60+7xcwGTH5KneoPqPES/UhE90xOw=;
        b=MdRoFbtDdjDktt43Tl7ma1gEq45TyJ9GZrVi0bN312z/k6DkErJ75noKidLixwJ8AK
         ATrDw9nEf0YS/1j64xu7oxhF8oAf91RGwTaeYBgkgJoong5DASQHrwepoju3D1HSvHKV
         tYeylvvoxUG4y48XbDBOWtpm0MNpoyMI6t6izegp37E2hEdE2HEHB3HHpiuQ7mJoVd5j
         6I14up127L40XGG8IlaJrd6EHG+3foQXQCtJE3GoZr24iekZTofq1Vant0J2b92EHByi
         OAORaS9DQT4UxbLW1dhEO07k/MQXkZ55K5nHJdWD/MXBxr6z5CIvsqUvvERbdbVs9ic1
         lSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adXFc2bAE5N2Ax60+7xcwGTH5KneoPqPES/UhE90xOw=;
        b=D7M3RWIHH9cmPYNVxn+mL1JbOjoa2AMoxy+9sg5vKm6juR9oF04vEgNH3ct0o0AuIF
         o/mWI3z9PNuioPCJ01kqiQOakE7fGWRWRzvBrtRwIU9/SFz1Y38B0Zh0bG3A8/oNhCJl
         JE1o34wYYAM4AJWJKQdQ+dKFe97BDit4gPnn69pqTf3a4v/y2/McyE+25S0LPbA7sDmS
         YUvFqYIBciyJdHCYIbRQd2ORoxmzZ2pdWCnm+uq6Xn1wXsZa6pHtNfuuxU50wahb3FTS
         /FLCLbTy7078lhgk2J3zuy7zfXPOLWl4dzABVkueDm1PT4GOvCclqjJZGncGqRPPcM9W
         dYLw==
X-Gm-Message-State: AO0yUKWHHgcZpYgQfN/ZtQ9CS7TT/J5A9djH9roZ0QKbhtFY5YeZWqgs
        VYjApH6SDijW5nSL+pPqVGI=
X-Google-Smtp-Source: AK7set8iFAYLcyI+QfN4YO8vq9jpVvyppFH1CxRcIdDBG4+l1xKvf1nsBaCarjrOf2vHopjy3DPMbA==
X-Received: by 2002:a05:6e02:1a66:b0:313:bab3:2f3a with SMTP id w6-20020a056e021a6600b00313bab32f3amr3292517ilv.22.1676401361981;
        Tue, 14 Feb 2023 11:02:41 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id r11-20020a056e0219cb00b0030c27c9eea4sm3608770ill.33.2023.02.14.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:02:41 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 5/5] md: dm-crypt: use mempool page bulk allocator
Date:   Tue, 14 Feb 2023 11:02:21 -0800
Message-Id: <20230214190221.1156876-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214190221.1156876-1-shy828301@gmail.com>
References: <20230214190221.1156876-1-shy828301@gmail.com>
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
by approxiamately 6%.  The test is done on a machine with 80 vCPU and
128GB memory with an encrypted ram device (the impact from storage
hardware could be minimized so that we could benchmark the dm-crypt
layer more accurately).

Before the patch:
Jobs: 1 (f=1): [w(1)][100.0%][w=1301MiB/s][w=1301 IOPS][eta 00m:00s]
crypt: (groupid=0, jobs=1): err= 0: pid=48512: Wed Feb  1 18:11:30 2023
  write: IOPS=1300, BW=1301MiB/s (1364MB/s)(76.2GiB/60001msec); 0 zone resets
    slat (usec): min=724, max=867, avg=765.71, stdev=19.27
    clat (usec): min=4, max=196297, avg=195688.86, stdev=6450.50
     lat (usec): min=801, max=197064, avg=196454.90, stdev=6450.35
    clat percentiles (msec):
     |  1.00th=[  197],  5.00th=[  197], 10.00th=[  197], 20.00th=[  197],
     | 30.00th=[  197], 40.00th=[  197], 50.00th=[  197], 60.00th=[  197],
     | 70.00th=[  197], 80.00th=[  197], 90.00th=[  197], 95.00th=[  197],
     | 99.00th=[  197], 99.50th=[  197], 99.90th=[  197], 99.95th=[  197],
     | 99.99th=[  197]
   bw (  MiB/s): min=  800, max= 1308, per=99.69%, avg=1296.94, stdev=46.02, samples=119
   iops        : min=  800, max= 1308, avg=1296.94, stdev=46.02, samples=119
  lat (usec)   : 10=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.02%, 50=0.05%
  lat (msec)   : 100=0.08%, 250=99.83%
  cpu          : usr=3.88%, sys=96.02%, ctx=69, majf=1, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=0,78060,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
  WRITE: bw=1301MiB/s (1364MB/s), 1301MiB/s-1301MiB/s (1364MB/s-1364MB/s), io=76.2GiB (81.9GB), run=60001-60001msec

After the patch:
Jobs: 1 (f=1): [w(1)][100.0%][w=1401MiB/s][w=1401 IOPS][eta 00m:00s]
crypt: (groupid=0, jobs=1): err= 0: pid=2171: Wed Feb  1 21:08:16 2023
  write: IOPS=1401, BW=1402MiB/s (1470MB/s)(82.1GiB/60001msec); 0 zone resets
    slat (usec): min=685, max=815, avg=710.77, stdev=13.24
    clat (usec): min=4, max=182206, avg=181658.31, stdev=5810.58
     lat (usec): min=709, max=182913, avg=182369.36, stdev=5810.67
    clat percentiles (msec):
     |  1.00th=[  182],  5.00th=[  182], 10.00th=[  182], 20.00th=[  182],
     | 30.00th=[  182], 40.00th=[  182], 50.00th=[  182], 60.00th=[  182],
     | 70.00th=[  182], 80.00th=[  182], 90.00th=[  182], 95.00th=[  182],
     | 99.00th=[  182], 99.50th=[  182], 99.90th=[  182], 99.95th=[  182],
     | 99.99th=[  182]
   bw (  MiB/s): min=  900, max= 1408, per=99.71%, avg=1397.60, stdev=46.04, samples=119
   iops        : min=  900, max= 1408, avg=1397.60, stdev=46.04, samples=119
  lat (usec)   : 10=0.01%, 750=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.02%, 50=0.05%
  lat (msec)   : 100=0.08%, 250=99.83%
  cpu          : usr=3.66%, sys=96.23%, ctx=76, majf=1, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwts: total=0,84098,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
  WRITE: bw=1402MiB/s (1470MB/s), 1402MiB/s-1402MiB/s (1470MB/s-1470MB/s), io=82.1GiB (88.2GB), run=60001-60001msec

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
 drivers/md/dm-crypt.c | 72 +++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 73069f200cc5..30268ba07fd6 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1651,6 +1651,21 @@ static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
 	}
 }
 
+struct crypt_bulk_cb_data {
+	struct bio *bio;
+	unsigned int size;
+};
+
+static void crypt_bulk_alloc_cb(struct page *page, void *data)
+{
+	unsigned int len;
+	struct crypt_bulk_cb_data *b_data = (struct crypt_bulk_cb_data *)data;
+
+	len = (b_data->size > PAGE_SIZE) ? PAGE_SIZE : b_data->size;
+	bio_add_page(b_data->bio, page, len, 0);
+	b_data->size -= len;
+}
+
 /*
  * Generate a new unfragmented bio with the given size
  * This should never violate the device limitations (but only because
@@ -1674,8 +1689,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
 	struct bio *clone;
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
-	unsigned i, len, remaining_size;
-	struct page *page;
+	struct crypt_bulk_cb_data data;
 
 retry:
 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
@@ -1686,22 +1700,17 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
 	clone->bi_private = io;
 	clone->bi_end_io = crypt_endio;
 
-	remaining_size = size;
-
-	for (i = 0; i < nr_iovecs; i++) {
-		page = mempool_alloc(&cc->page_pool, gfp_mask);
-		if (!page) {
-			crypt_free_buffer_pages(cc, clone);
-			bio_put(clone);
-			gfp_mask |= __GFP_DIRECT_RECLAIM;
-			goto retry;
-		}
-
-		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
-
-		bio_add_page(clone, page, len, 0);
+	data.bio = clone;
+	data.size = size;
 
-		remaining_size -= len;
+	if (!mempool_alloc_pages_bulk_cb(&cc->page_pool, gfp_mask, nr_iovecs,
+					crypt_bulk_alloc_cb, &data)) {
+		crypt_free_buffer_pages(cc, clone);
+		bio_put(clone);
+		data.bio = NULL;
+		data.size = 0;
+		gfp_mask |= __GFP_DIRECT_RECLAIM;
+		goto retry;
 	}
 
 	/* Allocate space for integrity tags */
@@ -2655,10 +2664,14 @@ static void crypt_calculate_pages_per_client(void)
 	dm_crypt_pages_per_client = pages;
 }
 
-static void *crypt_page_alloc(gfp_t gfp_mask, void *pool_data)
+static unsigned int crypt_alloc_pages_bulk(gfp_t gfp_mask, unsigned int nr,
+					   void *pool_data,
+					   struct page **page_array,
+					   void (*cb)(struct page *, void *),
+					   void *data)
 {
 	struct crypt_config *cc = pool_data;
-	struct page *page;
+	unsigned int ret;
 
 	/*
 	 * Note, percpu_counter_read_positive() may over (and under) estimate
@@ -2667,13 +2680,13 @@ static void *crypt_page_alloc(gfp_t gfp_mask, void *pool_data)
 	 */
 	if (unlikely(percpu_counter_read_positive(&cc->n_allocated_pages) >= dm_crypt_pages_per_client) &&
 	    likely(gfp_mask & __GFP_NORETRY))
-		return NULL;
+		return 0;
 
-	page = alloc_page(gfp_mask);
-	if (likely(page != NULL))
-		percpu_counter_add(&cc->n_allocated_pages, 1);
+	ret = alloc_pages_bulk_cb(gfp_mask, nr, cb, data);
 
-	return page;
+	percpu_counter_add(&cc->n_allocated_pages, ret);
+
+	return ret;
 }
 
 static void crypt_page_free(void *page, void *pool_data)
@@ -2705,11 +2718,16 @@ static void crypt_dtr(struct dm_target *ti)
 
 	bioset_exit(&cc->bs);
 
+	/*
+	 * With mempool bulk allocator the pages in the pool are not
+	 * counted in n_allocated_pages.
+	 */
+	WARN_ON(percpu_counter_sum(&cc->n_allocated_pages) != 0);
+
 	mempool_exit(&cc->page_pool);
 	mempool_exit(&cc->req_pool);
 	mempool_exit(&cc->tag_pool);
 
-	WARN_ON(percpu_counter_sum(&cc->n_allocated_pages) != 0);
 	percpu_counter_destroy(&cc->n_allocated_pages);
 
 	if (cc->iv_gen_ops && cc->iv_gen_ops->dtr)
@@ -3251,7 +3269,9 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
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
2.39.0

