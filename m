Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15B96BFF26
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 03:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCSCxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 22:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCSCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 22:53:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24CD113EF;
        Sat, 18 Mar 2023 19:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AD85B801C1;
        Sun, 19 Mar 2023 02:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417A7C433D2;
        Sun, 19 Mar 2023 02:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679194417;
        bh=saZ8wv4j3wfSLyQf7Xb0BX856GFJ9sSJfSezK1JR4UQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Y4i8SlqtvGdENnGEL3Kv5ln64l7tJgn5UyJhB+9zp6e7i1Die9V+M+2b0q6xdnTQU
         88NdG6qaPfkLP79NrP2oju4eRN/FcpulDuNCvv+m5Aq6Noux8UfAHWooSgbgTcbjL9
         vv899EeeiIfU9DKoucOQoSDFoZI1lHaBhUZOVJ06zICISG9ePpO8cd87A404bO8eGZ
         GI95CHsoitqsqkECVXPPj4HL9y1X9ay2sANcpWzPdoUBB/MIS232N5P87D7i32qSjn
         xT6jPNAwgHsofF0yQzm6Fl0/MZjIuX+xmKP/Sv5VB0eorsht70XoGgt5s40lUKRtKe
         M5LUoYF04jGZw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/ftrace: Choose target function for filter test from samples
Date:   Sun, 19 Mar 2023 11:53:32 +0900
Message-Id:  <167919441260.1922645.18355804179347364057.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the event-filter-function.tc expects the 'exit_mmap()' directly
calls 'kmem_cache_free()', this is vulnerable to code modifications.

Choose the target function for the filter test from the sample
event data so that it can keep test running correctly even if the caller
function name will be changed.

Link: https://lore.kernel.org/all/CA+G9fYtF-XEKi9YNGgR=Kf==7iRb2FrmEC7qtwAeQbfyah-UhA@mail.gmail.com/
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: 7f09d639b8c4 ("tracing/selftests: Add test for event filtering on function name")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/filter/event-filter-function.tc  |   45 ++++++++++++--------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
index e2ff3bf4df80..2de7c61d1ae3 100644
--- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
@@ -9,18 +9,33 @@ fail() { #msg
     exit_fail
 }
 
-echo "Test event filter function name"
+sample_events() {
+    echo > trace
+    echo 1 > events/kmem/kmem_cache_free/enable
+    echo 1 > tracing_on
+    ls > /dev/null
+    echo 0 > tracing_on
+    echo 0 > events/kmem/kmem_cache_free/enable
+}
+
 echo 0 > tracing_on
 echo 0 > events/enable
+
+echo "Get the most frequently calling function"
+sample_events
+
+target_func=`cut -d: -f3 trace | sed 's/call_site=\([^+]*\)+0x.*/\1/' | sort | uniq -c | sort | tail -n 1 | sed 's/^[ 0-9]*//'`
+if [ -z "$target_func" ]; then
+    exit_fail
+fi
 echo > trace
-echo 'call_site.function == exit_mmap' > events/kmem/kmem_cache_free/filter
-echo 1 > events/kmem/kmem_cache_free/enable
-echo 1 > tracing_on
-ls > /dev/null
-echo 0 > events/kmem/kmem_cache_free/enable
 
-hitcnt=`grep kmem_cache_free trace| grep exit_mmap | wc -l`
-misscnt=`grep kmem_cache_free trace| grep -v exit_mmap | wc -l`
+echo "Test event filter function name"
+echo "call_site.function == $target_func" > events/kmem/kmem_cache_free/filter
+sample_events
+
+hitcnt=`grep kmem_cache_free trace| grep $target_func | wc -l`
+misscnt=`grep kmem_cache_free trace| grep -v $target_func | wc -l`
 
 if [ $hitcnt -eq 0 ]; then
 	exit_fail
@@ -30,20 +45,14 @@ if [ $misscnt -gt 0 ]; then
 	exit_fail
 fi
 
-address=`grep ' exit_mmap$' /proc/kallsyms | cut -d' ' -f1`
+address=`grep " ${target_func}\$" /proc/kallsyms | cut -d' ' -f1`
 
 echo "Test event filter function address"
-echo 0 > tracing_on
-echo 0 > events/enable
-echo > trace
 echo "call_site.function == 0x$address" > events/kmem/kmem_cache_free/filter
-echo 1 > events/kmem/kmem_cache_free/enable
-echo 1 > tracing_on
-sleep 1
-echo 0 > events/kmem/kmem_cache_free/enable
+sample_events
 
-hitcnt=`grep kmem_cache_free trace| grep exit_mmap | wc -l`
-misscnt=`grep kmem_cache_free trace| grep -v exit_mmap | wc -l`
+hitcnt=`grep kmem_cache_free trace| grep $target_func | wc -l`
+misscnt=`grep kmem_cache_free trace| grep -v $target_func | wc -l`
 
 if [ $hitcnt -eq 0 ]; then
 	exit_fail

