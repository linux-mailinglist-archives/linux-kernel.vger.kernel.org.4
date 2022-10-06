Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C406C5F6BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJFQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiJFQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:29:32 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13F9124084;
        Thu,  6 Oct 2022 09:29:30 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2863172C97D;
        Thu,  6 Oct 2022 19:29:30 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 01DB34A4800;
        Thu,  6 Oct 2022 19:29:30 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ldv@altlinux.org, Vitaly Chikunov <vt@altlinux.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] libperf: Remove reference to non-uapi header
Date:   Thu,  6 Oct 2022 19:29:19 +0300
Message-Id: <20221006162919.2231389-1-vt@altlinux.org>
X-Mailer: git-send-email 2.33.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build with libperf:

  $ gcc ./tools/lib/perf/Documentation/examples/counting.c -lperf
  In file included from ./tools/lib/perf/Documentation/examples/counting.c:8:
  /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No such file or directory
      9 | #include <linux/compiler.h>
        |          ^~~~~~~~~~~~~~~~~~
  compilation terminated.

Fixes: b2f10cd4e805 ("perf cpumap: Fix alignment for masks in event encoding")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 tools/lib/perf/include/perf/event.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 93bf93a59c99..4f6d658bf27c 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 #include <linux/limits.h>
 #include <linux/bpf.h>
-#include <linux/compiler.h>
 #include <sys/types.h> /* pid_t */
 
 #define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
@@ -195,7 +194,7 @@ struct perf_record_mask_cpu_map64 {
 #pragma GCC diagnostic ignored "-Wpacked"
 #pragma GCC diagnostic ignored "-Wattributes"
 
-struct __packed perf_record_cpu_map_data {
+struct perf_record_cpu_map_data {
 	__u16			 type;
 	union {
 		/* Used when type == PERF_CPU_MAP__CPUS. */
@@ -205,7 +204,7 @@ struct __packed perf_record_cpu_map_data {
 		/* Used when type == PERF_CPU_MAP__MASK and long_size == 8. */
 		struct perf_record_mask_cpu_map64 mask64_data;
 	};
-};
+} __attribute__ ((__packed__));
 
 #pragma GCC diagnostic pop
 
-- 
2.33.4

