Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E43B6D64D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjDDOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjDDOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B219AE;
        Tue,  4 Apr 2023 07:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5173C6316E;
        Tue,  4 Apr 2023 14:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B28DC4339B;
        Tue,  4 Apr 2023 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680617446;
        bh=iSUrnQZaTWpAsPyP1ToiK9VLwAFedGHXJSWMqN81fOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQQn/99t/7NoGILbPCUwdDk3mm0kbhtHqhI6QeW71IHT50dbWnZCvzJpILXYguVdZ
         QFB3stN+E2ku9saCUVJRuW/cTKdhP9U37PkbI6ScSYUSANy0ZgcRpwhYnlfaD217GT
         XLRNCWAfziP+HXYQgLqXbZwA52dr/ZRFdFLrzlRYVHqM02XoePini9/DY1Bv9Z2XRP
         +o4MMm6bRU+nWfdIIe/mgzp/IC6fdImReV9NHoYmrvbqV3gcYw10iO2sMnrHOp7Ig/
         00xc/CbHnrEIzCQ3+mNwvK+Biu+Nqs12R97eblJuR3YQNQUMpeqEwnLLFxFwy63vJY
         KzOpjWzrzaP0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5DCC4052D; Tue,  4 Apr 2023 11:10:43 -0300 (-03)
Date:   Tue, 4 Apr 2023 11:10:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/9] perf list: Use relative path for tracepoint scan
Message-ID: <ZCwv4z5Dh/dHUMG6@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
 <20230331202949.810326-2-namhyung@kernel.org>
 <ZCtMLkNL80EkPvB1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCtMLkNL80EkPvB1@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 03, 2023 at 06:59:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 31, 2023 at 01:29:41PM -0700, Namhyung Kim escreveu:
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/print-events.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> Add to add this to fix on Alma Linux 8, and scandirat isn't being found
> on musl libc (Alpine Linux), probably we'll need some scaffolding...

About scandirat I'm adding the feature test below and this patch to the
patch that starts using scandirat():

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 28aa0b9300253d0a..386b1ab0b60e1d93 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -58,11 +58,9 @@ static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
 /*
  * Print the events from <debugfs_mount_point>/tracing/events
  */
-void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state)
+void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unused, void *print_state __maybe_unused)
 {
-	struct dirent **sys_namelist = NULL;
 	char *events_path = get_tracing_file("events");
-	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
 	int events_fd = open(events_path, O_PATH);
 
 	put_tracing_file(events_path);
@@ -71,6 +69,11 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
 		return;
 	}
 
+#ifdef HAVE_SCANDIRAT_SUPPORT
+{
+	struct dirent **sys_namelist = NULL;
+	int sys_items = tracing_events__scandir_alphasort(&sys_namelist);
+
 	for (int i = 0; i < sys_items; i++) {
 		struct dirent *sys_dirent = sys_namelist[i];
 		struct dirent **evt_namelist = NULL;
@@ -120,7 +123,13 @@ void print_tracepoint_events(const struct print_callbacks *print_cb, void *print
 		close(dir_fd);
 		free(evt_namelist);
 	}
+
 	free(sys_namelist);
+}
+#else
+	printf("\nWARNING: Your libc doesn't have the scandir function, please ask its maintainers to implement it.\n"
+	       "         As a rough fallback, please do 'ls %s' to see the available tracepoint events.\n", events_path);
+#endif
 	close(events_fd);
 }
 

From b25f9de2f944a550b063322b7210f4392e622a5e Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 4 Apr 2023 11:05:57 -0300
Subject: [PATCH 1/1] tools build: Add a feature test for scandirat(), that is
 not implemented so far in musl and uclibc

We use it just when listing tracepoint events, and for root, so just
emit a warning about it to get users to ask the library maintainers to
implement it, as suggested in this systemd ticket:

 https://github.com/systemd/casync/issues/129

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature   | 1 +
 tools/build/feature/Makefile   | 4 ++++
 tools/build/feature/test-all.c | 5 +++++
 tools/perf/Makefile.config     | 4 ++++
 4 files changed, 14 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 214622d7537cc56b..934e2777a2dbcd90 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -64,6 +64,7 @@ FEATURE_TESTS_BASIC :=                  \
         lzma                            \
         get_cpuid                       \
         bpf                             \
+        scandirat			\
         sched_getcpu			\
         sdt				\
         setns				\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0a3b9281f8b08000..0f0aa9b7d7b5e43c 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -65,6 +65,7 @@ FILES=                                          \
          test-gettid.bin			\
          test-jvmti.bin				\
          test-jvmti-cmlr.bin			\
+         test-scandirat.bin			\
          test-sched_getcpu.bin			\
          test-setns.bin				\
          test-libopencsd.bin			\
@@ -129,6 +130,9 @@ $(OUTPUT)test-get_current_dir_name.bin:
 $(OUTPUT)test-glibc.bin:
 	$(BUILD)
 
+$(OUTPUT)test-scandirat.bin:
+	$(BUILD)
+
 $(OUTPUT)test-sched_getcpu.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 957c02c7b163b579..6f4bf386a3b5c4b0 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -114,6 +114,10 @@
 # include "test-pthread-barrier.c"
 #undef main
 
+#define main main_test_scandirat
+# include "test-scandirat.c"
+#undef main
+
 #define main main_test_sched_getcpu
 # include "test-sched_getcpu.c"
 #undef main
@@ -206,6 +210,7 @@ int main(int argc, char *argv[])
 	main_test_get_cpuid();
 	main_test_bpf();
 	main_test_libcrypto();
+	main_test_scandirat();
 	main_test_sched_getcpu();
 	main_test_sdt();
 	main_test_setns();
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index dd203f0a2b7e64e1..16bea51f0bcd95ea 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -478,6 +478,10 @@ ifdef NO_DWARF
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
+ifeq ($(feature-scandirat), 1)
+  CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
+endif
+
 ifeq ($(feature-sched_getcpu), 1)
   CFLAGS += -DHAVE_SCHED_GETCPU_SUPPORT
 endif
-- 
2.39.2

