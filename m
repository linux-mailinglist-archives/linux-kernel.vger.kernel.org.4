Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B551F5FEED5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJNNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJNNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:44:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1881CFC48;
        Fri, 14 Oct 2022 06:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 098E461B29;
        Fri, 14 Oct 2022 13:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CB2C433D6;
        Fri, 14 Oct 2022 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665755049;
        bh=6a1/9gmhcWI09EU5dgUgzkIaJdUpLf7dykv/IBOnfZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgzWrH0f5oaL5rc8lVyfETNm3gzMRqGQ/DJXspgiqPLqZAZCrwuV1k5QCAmMEWEvA
         RbcpOQGfxCNb75TMUz15QXPE8axAmTgR/mt4jZW3374/scjl35v3QYxyRrIzhb7Nh8
         XSVHjVIONpjK7FytE3YwvwxPyoyTC+g/FH/bKftzKiKCuXNVbekQQZW+ezLDAMQ0EE
         XD5sv9aQ0yx7bqYwGLaTXp5o5iicr5H2m5ucJ8GeOIm5RN5I1uPdczPxk2cfm/5FDI
         ZBZilV5XxZmdKMPCN+GtIxQ9BMiHlGfD+Vl1rlfPKb2Z+6BkkfnwxW+v5GHHaOhinQ
         YEWFyY8Fy50Qg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6CBF54062C; Fri, 14 Oct 2022 10:44:06 -0300 (-03)
Date:   Fri, 14 Oct 2022 10:44:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv@altlinux.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] libperf: Remove reference to non-uapi header
Message-ID: <Y0lnpl2Ix7VljVDc@kernel.org>
References: <20221006162919.2231389-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006162919.2231389-1-vt@altlinux.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 06, 2022 at 07:29:19PM +0300, Vitaly Chikunov escreveu:
> Fix build with libperf:
> 
>   $ gcc ./tools/lib/perf/Documentation/examples/counting.c -lperf
>   In file included from ./tools/lib/perf/Documentation/examples/counting.c:8:
>   /usr/include/perf/event.h:9:10: fatal error: linux/compiler.h: No such file or directory
>       9 | #include <linux/compiler.h>
>         |          ^~~~~~~~~~~~~~~~~~
>   compilation terminated.
> 
> Fixes: b2f10cd4e805 ("perf cpumap: Fix alignment for masks in event encoding")
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

So I'm applying this one instead after re-reading the thread:

From 49b4ee0b20274812198b1ee7840055740d7981a4 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 14 Oct 2022 10:39:21 -0300
Subject: [PATCH 1/1] libperf: Do not include non-UAPI linux/compiler.h header

Its just for that __packed define, so use it expanded as __attribute__((packed)),
like the other files in /usr/include do.

This was problem was preventing building the libperf examples on ALT
Linux and Fedora 35, fix it.

Reported-by: Vitaly Chikunov <vt@altlinux.org>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dmitry Levin <ldv@altlinux.org
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/include/perf/event.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index e282faf8fd75b6a8..ad47d7b31046c7c9 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 #include <linux/limits.h>
 #include <linux/bpf.h>
-#include <linux/compiler.h>
 #include <sys/types.h> /* pid_t */
 
 #define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
@@ -207,7 +206,7 @@ struct perf_record_range_cpu_map {
 	__u16 end_cpu;
 };
 
-struct __packed perf_record_cpu_map_data {
+struct perf_record_cpu_map_data {
 	__u16			 type;
 	union {
 		/* Used when type == PERF_CPU_MAP__CPUS. */
@@ -219,7 +218,7 @@ struct __packed perf_record_cpu_map_data {
 		/* Used when type == PERF_CPU_MAP__RANGE_CPUS. */
 		struct perf_record_range_cpu_map range_cpu_data;
 	};
-};
+} __attribute__((packed));
 
 #pragma GCC diagnostic pop
 
-- 
2.37.3

