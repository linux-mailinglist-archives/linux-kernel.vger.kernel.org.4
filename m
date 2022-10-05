Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4FD5F597D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJESD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJESDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:03:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0467172C;
        Wed,  5 Oct 2022 11:03:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so5981125pls.9;
        Wed, 05 Oct 2022 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKwMLpWApD5aFrIIIf8CGQFhqbcknhmLeA7p0rloKo4=;
        b=Bwp7bfmZ1+hu0hFa/fB0IIO8XiNYixDa7F4lA7Ku5KKsFe4yZEnhoaC0IiYBALR/S9
         VHpRXAsh6hEn503lfK2AHF/xg8J5NAPm6i8Wy1bnOOHSuemBlO8avg84TjA6Ay1x9Trf
         cDdM8d1WsFHfnANAErN36C9iV114dmiUYuwAMY8tXlfORHN1BB9UC6qghagMbdW4JxsQ
         bMBX2YdBPly1w0IrNXhOZTCYj8Ld/BKXFLdJAhJeFvHsc8n6pwrPXbXAu9axmpeIvY8V
         nH56dx1bZCoVBLRY0JaDurn7GXEIHkFCnUvxOwrM793x57vII6870emCiGVnDw5gz0eN
         sboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKwMLpWApD5aFrIIIf8CGQFhqbcknhmLeA7p0rloKo4=;
        b=J1TBHj/VkRoLHDD2r1RqgPMV4bScMV1Q8aQCT53/CeLeo5mz2K50MBIbhVZ44NlUp7
         x3kCQHSwGAkgo+LsohC8Pi8rBIgputNt38qrZphYhldEZTZXCtS2VmdojVt6IkiNLmyy
         S2oNZfXioCpi9wlhsq5gkRp1sNg3AC+tz26xkUrUj7im5JC5w3LoPAPl1S0ude96F27N
         u5bAxxLYxgh+f4MzCFqX0soTizzNi6L032TIFWe8By84riCpP5hU8FRkBLcfJ6onr9zq
         2WmjSCFE+IO0QfuvXNKSReY9dFhJkXlvq0oGHVEY5bZhDeQbHXYTjJyl1qQqZtcmUIUA
         Reqg==
X-Gm-Message-State: ACrzQf1Sti5ArGorD/vWntlqyNHhlS3LQVqkVgrL6wAT9VLzrG8TuZdr
        UMcZDLx7fq2tHJy/NOqO+PI=
X-Google-Smtp-Source: AMsMyM53gfS50h/TX2/GWR7BIW/H3B+J8W4P92wIc0AYeapZJ8wWdOf6715h39n5ZlkC6HAcQe53Tg==
X-Received: by 2002:a17:90b:188b:b0:20a:8fc8:60b8 with SMTP id mn11-20020a17090b188b00b0020a8fc860b8mr6326296pjb.37.1664993032035;
        Wed, 05 Oct 2022 11:03:52 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b001788494b764sm10674639plc.231.2022.10.05.11.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:03:51 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Introduce mempool pages bulk allocator the use it in dm-crypt
Date:   Wed,  5 Oct 2022 11:03:37 -0700
Message-Id: <20221005180341.1738796-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
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
g2fs, ufs, etc.  So it seems more neat to implement a bulk allocation
API for mempool.

So introduce the mempool page bulk allocator.
The below APIs are introduced:
    - mempool_init_pages_bulk()
    - mempool_create_pages_bulk()
    They initialize the mempool for page bulk allocator.  The pool is filled
    by alloc_page() in a loop.
    
    - mempool_alloc_pages_bulk_list()
    - mempool_alloc_pages_bulk_array()
    They do bulk allocation from mempool.
    They do the below conceptually:
      1. Call bulk page allocator
      2. If the allocation is fulfilled then return otherwise try to
         allocate the remaining pages from the mempool
      3. If it is fulfilled then return otherwise retry from #1 with sleepable
         gfp
      4. If it is still failed, sleep for a while to wait for the mempool is
         refilled, then retry from #1
    The populated pages will stay on the list or array until the callers
    consume them or free them.
    Since mempool allocator is guaranteed to success in the sleepable context,
    so the two APIs return true for success or false for fail.  It is the
    caller's responsibility to handle failure case (partial allocation), just
    like the page bulk allocator.
    
The mempool typically is an object agnostic allocator, but bulk allocation
is only supported by pages, so the mempool bulk allocator is for page
allocation only as well.

With the mempool bulk allocator the IOPS of dm-crypt with 1M I/O would get
improved by approxiamately 6%.  The test is done on a VM with 80 vCPU and
64GB memory with an encrypted ram device (the impact from storage hardware
could be minimized so that we could benchmark the dm-crypt layer more
accurately).

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


Yang Shi (4):
      mm: mempool: extract common initialization code
      mm: mempool: introduce page bulk allocator
      md: dm-crypt: move crypt_free_buffer_pages ahead
      md: dm-crypt: use mempool page bulk allocator

 drivers/md/dm-crypt.c   |  92 ++++++++++++++++-------------
 include/linux/mempool.h |  19 ++++++
 mm/mempool.c            | 227 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 276 insertions(+), 62 deletions(-)


