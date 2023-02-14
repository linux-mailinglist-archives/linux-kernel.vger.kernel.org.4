Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4520696D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjBNTCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjBNTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:02:37 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92503FC;
        Tue, 14 Feb 2023 11:02:36 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i26so265363ila.11;
        Tue, 14 Feb 2023 11:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNEAe1B6QgPjY6KaGYE9TiQHnNZykCg1bt+o/OnSHKg=;
        b=OGLrK81J+2LjfQNVnutus7Q4J7/1zgWBOqe0VSpoa3V1bpzMWIY+GMehuO5fx2unow
         cGmcHW2gSSr1M362yrY368fhH559sjPkV6wGLL4O5mAQwnUfAqj9yF2lnHitiQOUPiJ8
         OTEGLUtBgC4XFw68OgS9Io93dPWJK4yrEd1KeeTMhXcwJ5/fQRhSVLqJ4KmjtIoQYL49
         aAj+/Xe8pO27ieMO8T0RLEDDf8UWdcSvPoFrsGk7i7bjJkbewlqHUeJ1q2IrM1XohIh5
         tHTeoMYjzuLwDF1cH22PpdsO36vCYsbOOm8k2NsKOWidsVwXgEcn2IJGpNjgScvgkb2U
         6oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNEAe1B6QgPjY6KaGYE9TiQHnNZykCg1bt+o/OnSHKg=;
        b=K3ZnyqxojOs3b3FLErIeDGODpq874IA9Y4tgA7YrZt8huQYnpP0G0DXOMyeFsvsDN1
         SzMk9OS2nSc15LYVdx20AqxItLJbveg9x3FYMOoASuJ4yAXZ2Tzts+wizgel40V7TrL8
         olLqtZ2gRRUO946dY1f5lG4m7l3KaBFt7RdsoFbv1OJaB1KAUX9u7dQL/s0rqe0fp4FI
         86SlGSsXXkNkjjg0cKnwJrGSV1nfenI1J93N7B0NQJIhSuCGuTlu0oEJWyVBnBy+81+B
         bq7Tj5euxnAH6I2dWu1MitDOaF8z698QvkthfWkjehMr/4PI0yvhWXJL6k8Z4fHUBWFS
         nU4g==
X-Gm-Message-State: AO0yUKVJTsGxKtsdE0p9XalheAF0949hCA39DEvswGDcHgbNqk2YnfoB
        u99Z7I0MU4zhFjGnhxnbAcsrd7AFNuHg5Q==
X-Google-Smtp-Source: AK7set/zW0EPl9LzsbivR8TPrW170enXOL+jrEbHAwLfuAFAOh0JpMeGXUm427Nk8n+1LDAQTKlEnw==
X-Received: by 2002:a05:6e02:1d19:b0:315:2992:8049 with SMTP id i25-20020a056e021d1900b0031529928049mr3487297ila.27.1676401355789;
        Tue, 14 Feb 2023 11:02:35 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id r11-20020a056e0219cb00b0030c27c9eea4sm3608770ill.33.2023.02.14.11.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:02:35 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 0/5] Introduce mempool pages bulk allocator and use it in dm-crypt
Date:   Tue, 14 Feb 2023 11:02:16 -0800
Message-Id: <20230214190221.1156876-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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


Changelog:
RFC -> v2:
  * Added callback variant for page bulk allocator and mempool bulk allocator
    per Mel Gorman.
  * Used the callback version in dm-crypt driver.
  * Some code cleanup and refactor to reduce duplicate code.

rfc: https://lore.kernel.org/linux-mm/20221005180341.1738796-1-shy828301@gmail.com/


We have full disk encryption enabled, profiling shows page allocations may
incur a noticeable overhead when writing.  The dm-crypt creates an "out"
bio for writing.  And fill the "out" bio with the same amount of pages
as "in" bio.  But the driver allocates one page at a time in a loop.  For
1M bio it means the driver has to call page allocator 256 times.  It seems
not that efficient.

Since v5.13 we have page bulk allocator supported, so dm-crypt could use
it to do page allocations more efficiently.

I could just call the page bulk allocator in dm-crypt driver before the
mempool allocator, but it seems ad-hoc and the quick search shows some
others do the similar thing, for example, f2fs compress, block bounce,
g2fs, ufs, etc.  So it seems more neat to implement a general bulk allocation
API for mempool.

Currently the bulk allocator just supported list and array to consume the
pages.  But neither is the best fit to dm-crypt ussecase.  So introduce
a new bulk allocator API, callback, per the suggestion from Mel Gorman.
It consumes the pages by calling a callback with a parameter.

So introduce the mempool page bulk allocator.
The below APIs are introduced:
    - mempool_init_pages_bulk()
    - mempool_create_pages_bulk()
    They initialize the mempool for page bulk allocator.  The pool is filled
    by alloc_page() in a loop.
    
    - mempool_alloc_pages_bulk_cb()
    - mempool_alloc_pages_bulk_array()
    They do bulk allocation from mempool.  The list version is not implemented
    since there is no user for list version bulk allocator so far and it may
    be gong soon.

    They do the below conceptually:
      1. Call bulk page allocator
      2. If the allocation is fulfilled then return otherwise try to
         allocate the remaining pages from the mempool
      3. If it is fulfilled then return otherwise retry from #1 with sleepable
         gfp
      4. If it is still failed, sleep for a while to wait for the mempool is
         refilled, then retry from #1
    The populated pages will stay on array until the callers consume them or
    free them, or will be consumed by the callback.
    Since mempool allocator is guaranteed to success in the sleepable context,
    so the two APIs return true for success or false for fail.  It is the
    caller's responsibility to handle failure case (partial allocation), just
    like the page bulk allocator.
    
The mempool typically is an object agnostic allocator, but bulk allocation
is only supported by pages, so the mempool bulk allocator is for page
allocation only as well.

With the mempool bulk allocator the IOPS of dm-crypt with 1M I/O would get
improved by approxiamately 6%.  The test is done on a machine with 80 CPU and
128GB memory with an encrypted ram device (the impact from storage hardware
could be minimized so that we could benchmark the dm-crypt layer more
accurately).

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

And the benchmark with 4K size I/O doesn't show measurable regression.


Yang Shi (5):
      mm: page_alloc: add API for bulk allocator with callback
      mm: mempool: extract the common initialization and alloc code
      mm: mempool: introduce page bulk allocator
      md: dm-crypt: move crypt_free_buffer_pages ahead
      md: dm-crypt: use mempool page bulk allocator

 drivers/md/dm-crypt.c   |  95 ++++++++++++++++++++++++++++++---------------------
 include/linux/gfp.h     |  21 +++++++++---
 include/linux/mempool.h |  21 ++++++++++++
 mm/mempolicy.c          |  12 ++++---
 mm/mempool.c            | 248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 mm/page_alloc.c         |  21 ++++++++----
 6 files changed, 323 insertions(+), 95 deletions(-)


