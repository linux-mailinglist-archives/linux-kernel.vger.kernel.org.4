Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA66E656B45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiL0NKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiL0NKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:10:41 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11561F0;
        Tue, 27 Dec 2022 05:10:38 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NhFNd18Wvz16LrY;
        Tue, 27 Dec 2022 21:09:21 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 27 Dec 2022 21:10:35 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <jiwei.sun@windriver.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf record: Fix coredump with --overwrite and --max-size
Date:   Tue, 27 Dec 2022 13:07:01 +0000
Message-ID: <20221227130701.124278-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When --overwrite and --max-size options of perf record are used together,
a segmentation fault occurs. The following is an example:

 # perf record -e sched:sched* --overwrite --max-size 1M -a -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  perf: Segmentation fault
  Obtained 1 stack frames.
  [0xc4c67f]
  Segmentation fault (core dumped)

backtrace of the core file is as follows:

  #0  0x0000000000417990 in process_locked_synthesized_event (tool=0x0, event=0x15, sample=0x1de0, machine=0xf8) at builtin-record.c:630
  #1  0x000000000057ee53 in perf_event__synthesize_threads (nr_threads_synthesize=21, mmap_data=<optimized out>, needs_mmap=<optimized out>, machine=0x17ad9b0, process=<optimized out>, tool=0x0) at util/synthetic-events.c:1950
  #2  __machine__synthesize_threads (nr_threads_synthesize=0, data_mmap=<optimized out>, needs_mmap=<optimized out>, process=<optimized out>, threads=0x8, target=0x8, tool=0x0, machine=0x17ad9b0) at util/synthetic-events.c:1936
  #3  machine__synthesize_threads (machine=0x17ad9b0, target=0x8, threads=0x8, needs_mmap=<optimized out>, data_mmap=<optimized out>, nr_threads_synthesize=0) at util/synthetic-events.c:1947
  #4  0x000000000040165d in record__synthesize (tail=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2010
  #5  0x0000000000403989 in __cmd_record (argc=<optimized out>, argv=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2810
  #6  0x00000000004196ba in record__init_thread_user_masks (rec=0xbe2520 <record>, cpus=0x17a65f0) at builtin-record.c:3837
  #7  record__init_thread_masks (rec=0xbe2520 <record>) at builtin-record.c:3938
  #8  cmd_record (argc=1, argv=0x7ffdd692dc60) at builtin-record.c:4241
  #9  0x00000000004b701d in pager_command_config (var=0x0, value=0x15 <error: Cannot access memory at address 0x15>, data=0x1de0) at perf.c:117
  #10 0x00000000004b732b in get_leaf_frame_caller_aarch64 (sample=0xfffffffb, thread=0x0, usr_idx=<optimized out>) at util/arm64-frame-pointer-unwind-support.c:56
  #11 0x0000000000406331 in execv_dashed_external (argv=0x7ffdd692d9e8) at perf.c:410
  #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:431
  #13 main (argc=<optimized out>, argv=0x7ffdd692d9e8) at perf.c:562

The reason is that record__bytes_written accesses the freed memory rec->thread_data,
The process is as follows:
  __cmd_record
    -> record__free_thread_data
      -> zfree(&rec->thread_data)         // free rec->thread_data
    -> record__synthesize
      -> perf_event__synthesize_id_index
        -> process_synthesized_event
          -> record__write
            -> record__bytes_written     // access rec->thread_data

In the overwrite scenario, to synthesize non-sample events,
we do not need to check perf size limit.

Fixes: 6d57581659f7 ("perf record: Add support for limit perf output file size")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 29dcd454b8e2..c5f169150d63 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -260,7 +260,7 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 	else
 		rec->bytes_written += size;
 
-	if (record__output_max_size_exceeded(rec) && !done) {
+	if (!rec->opts.tail_synthesize && record__output_max_size_exceeded(rec) && !done) {
 		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
 				" stopping session ]\n",
 				record__bytes_written(rec) >> 10);
-- 
2.17.1

