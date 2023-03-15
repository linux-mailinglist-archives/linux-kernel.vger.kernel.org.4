Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B46BA7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCOGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjCOGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:42:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF07460AA;
        Tue, 14 Mar 2023 23:42:21 -0700 (PDT)
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pc15m46vGzKn8P;
        Wed, 15 Mar 2023 14:42:04 +0800 (CST)
Received: from [10.174.177.30] (10.174.177.30) by
 kwepemm600006.china.huawei.com (7.193.23.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 14:42:17 +0800
Message-ID: <322bfb49-840b-f3b6-9ef1-f9ec3435b07e@huawei.com>
Date:   Wed, 15 Mar 2023 14:42:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     "acme@kernel.org >> Arnaldo Carvalho de Melo" <acme@kernel.org>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>, <brauner@kernel.org>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   "liuwenyu (D)" <liuwenyu7@huawei.com>
Subject: [PATCH v2 RESEND] perf top: Fix rare segfault in thread__comm_len()
CC:     <linfeilong@huawei.com>, "hewenliang (C)" <hewenliang4@huawei.com>,
        <yeyunfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.30]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In thread__comm_len(),strlen() is called outside of the
thread->comm_lock critical section,which may cause a UAF
problems if comm__free() is called by the process_thread
concurrently.

backtrace of the core file is as follows:

    (gdb) bt
    #0  __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
    #1  0x000055ad15d31de5 in thread__comm_len (thread=0x7f627d20e300) at util/thread.c:320
    #2  0x000055ad15d4fade in hists__calc_col_len (h=0x7f627d295940, hists=0x55ad1772bfe0)
        at util/hist.c:103
    #3  hists__calc_col_len (hists=0x55ad1772bfe0, h=0x7f627d295940) at util/hist.c:79
    #4  0x000055ad15d52c8c in output_resort (hists=hists@entry=0x55ad1772bfe0, prog=0x0,
        use_callchain=false, cb=cb@entry=0x0, cb_arg=0x0) at util/hist.c:1926
    #5  0x000055ad15d530a4 in evsel__output_resort_cb (evsel=evsel@entry=0x55ad1772bde0,
        prog=prog@entry=0x0, cb=cb@entry=0x0, cb_arg=cb_arg@entry=0x0) at util/hist.c:1945
    #6  0x000055ad15d53110 in evsel__output_resort (evsel=evsel@entry=0x55ad1772bde0,
        prog=prog@entry=0x0) at util/hist.c:1950
    #7  0x000055ad15c6ae9a in perf_top__resort_hists (t=t@entry=0x7ffcd9cbf4f0) at builtin-top.c:311
    #8  0x000055ad15c6cc6d in perf_top__print_sym_table (top=0x7ffcd9cbf4f0) at builtin-top.c:346
    #9  display_thread (arg=0x7ffcd9cbf4f0) at builtin-top.c:700
    #10 0x00007f6282fab4fa in start_thread (arg=<optimized out>) at pthread_create.c:443
    #11 0x00007f628302e200 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

The reason is that strlen() get a pointer to a memory that has been freed.

The string pointer is stored in the structure comm_str, which corresponds
to a rb_tree node,when the node is erased, the memory of the string is also freed.

In thread__comm_len(),it gets the pointer within the thread->comm_lock critical section,
but passed to strlen() outside of the thread->comm_lock critical section, and the perf
process_thread may called comm__free() concurrently, cause this segfault problem.

The process is as follows:

display_thread                                  process_thread
--------------                                  --------------

thread__comm_len
  -> thread__comm_str
       # held the comm read lock
    -> __thread__comm_str(thread)
       # release the comm read lock
                                                thread__delete
                                                     # held the comm write lock
                                                  -> comm__free
                                                    -> comm_str__put(comm->comm_str)
                                                      -> zfree(&cs->str)
                                                     # release the comm write lock
      # The memory of the string pointed
        to by comm has been free.
    -> thread->comm_len = strlen(comm);

This patch expand the critical section range of thread->comm_lock in thread__comm_len(),
to make strlen() called safe.

Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>
---
v1 -> v2
 - format the patch to be applied

 tools/perf/util/thread.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index e3e5427e1c3c..a2490a20eb56 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -311,17 +311,30 @@ const char *thread__comm_str(struct thread *thread)
 	return str;
 }
 
+static int __thread__comm_len(struct thread *thread, const char *comm)
+{
+	if (!comm)
+		return 0;
+	thread->comm_len = strlen(comm);
+
+	return thread->comm_len;
+}
+
 /* CHECKME: it should probably better return the max comm len from its comm list */
 int thread__comm_len(struct thread *thread)
 {
-	if (!thread->comm_len) {
-		const char *comm = thread__comm_str(thread);
-		if (!comm)
-			return 0;
-		thread->comm_len = strlen(comm);
+	int comm_len = thread->comm_len;
+
+	if (!comm_len) {
+		const char *comm;
+
+		down_read(&thread->comm_lock);
+		comm = __thread__comm_str(thread);
+		comm_len = __thread__comm_len(thread, comm);
+		up_read(&thread->comm_lock);
 	}
 
-	return thread->comm_len;
+	return comm_len;
 }
 
 size_t thread__fprintf(struct thread *thread, FILE *fp)
-- 
2.36.1
