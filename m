Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65657375F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjFTUTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjFTUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:18:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139351BD1;
        Tue, 20 Jun 2023 13:18:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-25edb50c3acso2853412a91.1;
        Tue, 20 Jun 2023 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687292301; x=1689884301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pqVZ+yJ0tuR0/Xa4/mt71IlpN1AZgNtJ4C3nrUuBuoc=;
        b=QwlgXK20+sNDmTiVystCzoccyU/n8dUHDNtuFGDLv2rdPzZFL0Go6eVyLb7pV9BBKp
         vzJ9BAgsyXlXd6SX5FL288SJoXin2fzISWH1j3xXt8Ul89zhxzoPzHtcfwzCRox5DXwF
         6n6Q/orn88LCpdezK2vckhKAYTQwjZo+Oktfxzoh65WlCRIueLMsib0UvwSGGUAXgLQp
         /wGWvFQUHlOUrZF0/zpY/tjnvqfnQ2GzNhQm4y266w25SmWTPdrRFqQ2MCfpI8PZZhtI
         6KVOjo+lQDY9ue59Wht0u9Zo0v9kD+VvAQFOHdO9QcXnDbaalld5f3CrhfJONkBxJvX3
         WcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292301; x=1689884301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqVZ+yJ0tuR0/Xa4/mt71IlpN1AZgNtJ4C3nrUuBuoc=;
        b=DI+MhgPVBvtN4MwY9EeQCMEkdndN50HsIK6vnFlxArtvR96KwRurLXyII0ZUuMraZA
         hOlWRNsa+xNF+79Y4RQX875utf16DgwGxiI06nk2KsQP3yjwR6XOZIkcQn6bdk2rXQRw
         68pX5pHG/8Nr33XzkzJ3BgUTp0S7Z0fHjxtU7RbkQvYGNwf2BBZE4icLofEgjdQebzUe
         ghiA7vWaQ/c8imRniFUoOUBcK/AL5/dmTnCM5z8r0vQZizRsEjI1idIvmbnN1TqSykhT
         Ey8GqCykTpvnEXXX5JrPNltZppoprGg7a8wPw/VKxyE4cEul9X6c5XjusQZLj3rTx7RO
         uNbw==
X-Gm-Message-State: AC+VfDzAGGPCDQT6hmxwgPmewrLrXG+WLVcHUc4I19kSSCkaevN1zsYt
        k7UPOSodv3USEfPHdGRMYS8=
X-Google-Smtp-Source: ACHHUZ6fBJSQ8Q1Q4C+YKoJwU9MWhh0/r5U6XGQghQ4ps2sKzIjL+PDnshWFK7HVCSU8hdDtesM8Ag==
X-Received: by 2002:a17:90b:a46:b0:25c:2a5d:e06b with SMTP id gw6-20020a17090b0a4600b0025c2a5de06bmr13736156pjb.2.1687292301105;
        Tue, 20 Jun 2023 13:18:21 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:2824:dc1c:af73:dbd8])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090a01db00b0025c23bb7fdasm8191774pjd.16.2023.06.20.13.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:18:20 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf machine: Add machine->has_data_mmap field
Date:   Tue, 20 Jun 2023 13:18:16 -0700
Message-ID: <20230620201818.1670753-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that it can indicate the it needs to collect data mappings.  This is
needed especially for kernel maps.

At first, I just wanted to add it to struct machines only and to use the
machine->machines to check the value.  But it turned out that some of
machine didn't belong to any machines (eg. some test codes), so I just
copied the value to individual struct machine.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c         |  2 +-
 tools/perf/builtin-record.c         |  2 +-
 tools/perf/tests/vmlinux-kallsyms.c |  4 ++--
 tools/perf/util/machine.c           | 12 +++++++-----
 tools/perf/util/machine.h           | 10 ++++++++--
 tools/perf/util/session.c           |  4 ++--
 tools/perf/util/session.h           |  4 ++--
 7 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index c8cf2fdd9cff..481adaa97a68 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2325,7 +2325,7 @@ int cmd_inject(int argc, const char **argv)
 	}
 
 	inject.session = __perf_session__new(&data, repipe,
-					     output_fd(&inject),
+					     output_fd(&inject), false,
 					     &inject.tool);
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index aec18db7ff23..b4d0154dcb18 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2373,7 +2373,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		signal(SIGUSR2, SIG_IGN);
 	}
 
-	session = perf_session__new(data, tool);
+	session = __perf_session__new(data, false, -1, rec->opts.sample_address, tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
 		return PTR_ERR(session);
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 1078a93b01aa..1f1ba3ae88aa 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -131,8 +131,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 	 * Init the machines that will hold kernel, modules obtained from
 	 * both vmlinux + .ko files and from /proc/kallsyms split by modules.
 	 */
-	machine__init(&kallsyms, "", HOST_KERNEL_ID);
-	machine__init(&vmlinux, "", HOST_KERNEL_ID);
+	machine__init(&kallsyms, "", HOST_KERNEL_ID, false);
+	machine__init(&vmlinux, "", HOST_KERNEL_ID, false);
 
 	maps = machine__kernel_maps(&vmlinux);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 4e62843d51b7..ddc0a2130caf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -110,7 +110,7 @@ static void thread__set_guest_comm(struct thread *thread, pid_t pid)
 	thread__set_comm(thread, comm, 0);
 }
 
-int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
+int machine__init(struct machine *machine, const char *root_dir, pid_t pid, bool has_data_mmap)
 {
 	int err = -ENOMEM;
 
@@ -128,6 +128,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	machine->env = NULL;
 
 	machine->pid = pid;
+	machine->has_data_mmap = has_data_mmap;
 
 	machine->id_hdr_size = 0;
 	machine->kptr_restrict_warned = false;
@@ -170,7 +171,7 @@ struct machine *machine__new_host(void)
 	struct machine *machine = malloc(sizeof(*machine));
 
 	if (machine != NULL) {
-		machine__init(machine, "", HOST_KERNEL_ID);
+		machine__init(machine, "", HOST_KERNEL_ID, false);
 
 		if (machine__create_kernel_maps(machine) < 0)
 			goto out_delete;
@@ -272,10 +273,11 @@ void machine__delete(struct machine *machine)
 	}
 }
 
-void machines__init(struct machines *machines)
+void __machines__init(struct machines *machines, bool have_data_mmap)
 {
-	machine__init(&machines->host, "", HOST_KERNEL_ID);
+	machine__init(&machines->host, "", HOST_KERNEL_ID, have_data_mmap);
 	machines->guests = RB_ROOT_CACHED;
+	machines->have_data_mmaps = have_data_mmap;
 }
 
 void machines__exit(struct machines *machines)
@@ -295,7 +297,7 @@ struct machine *machines__add(struct machines *machines, pid_t pid,
 	if (machine == NULL)
 		return NULL;
 
-	if (machine__init(machine, root_dir, pid) != 0) {
+	if (machine__init(machine, root_dir, pid, machines->have_data_mmaps) != 0) {
 		free(machine);
 		return NULL;
 	}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d034ecaf89c1..f54e5c888a99 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -46,6 +46,7 @@ struct machine {
 	bool		  comm_exec;
 	bool		  kptr_restrict_warned;
 	bool		  single_address_space;
+	bool		  has_data_mmap;
 	char		  *root_dir;
 	char		  *mmap_name;
 	char		  *kallsyms_filename;
@@ -160,9 +161,14 @@ typedef void (*machine__process_t)(struct machine *machine, void *data);
 struct machines {
 	struct machine host;
 	struct rb_root_cached guests;
+	bool have_data_mmaps;
 };
 
-void machines__init(struct machines *machines);
+void __machines__init(struct machines *machines, bool data_mmap);
+static inline void machines__init(struct machines *machines)
+{
+	__machines__init(machines, false);
+}
 void machines__exit(struct machines *machines);
 
 void machines__process_guests(struct machines *machines,
@@ -181,7 +187,7 @@ void machines__set_comm_exec(struct machines *machines, bool comm_exec);
 
 struct machine *machine__new_host(void);
 struct machine *machine__new_kallsyms(void);
-int machine__init(struct machine *machine, const char *root_dir, pid_t pid);
+int machine__init(struct machine *machine, const char *root_dir, pid_t pid, bool has_data_mmap);
 void machine__exit(struct machine *machine);
 void machine__delete_threads(struct machine *machine);
 void machine__delete(struct machine *machine);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 00d18c74c090..e09a02ec8f28 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -191,7 +191,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 }
 
 struct perf_session *__perf_session__new(struct perf_data *data,
-					 bool repipe, int repipe_fd,
+					 bool repipe, int repipe_fd, bool data_mmap,
 					 struct perf_tool *tool)
 {
 	int ret = -ENOMEM;
@@ -205,7 +205,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 	session->decomp_data.zstd_decomp = &session->zstd_data;
 	session->active_decomp = &session->decomp_data;
 	INIT_LIST_HEAD(&session->auxtrace_index);
-	machines__init(&session->machines);
+	__machines__init(&session->machines, data_mmap);
 	ordered_events__init(&session->ordered_events,
 			     ordered_events__deliver_event, NULL);
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index ee3715e8563b..465610e81e95 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -64,13 +64,13 @@ struct decomp {
 struct perf_tool;
 
 struct perf_session *__perf_session__new(struct perf_data *data,
-					 bool repipe, int repipe_fd,
+					 bool repipe, int repipe_fd, bool data_mmap,
 					 struct perf_tool *tool);
 
 static inline struct perf_session *perf_session__new(struct perf_data *data,
 						     struct perf_tool *tool)
 {
-	return __perf_session__new(data, false, -1, tool);
+	return __perf_session__new(data, false, -1, false, tool);
 }
 
 void perf_session__delete(struct perf_session *session);
-- 
2.41.0.185.g7c58973941-goog

