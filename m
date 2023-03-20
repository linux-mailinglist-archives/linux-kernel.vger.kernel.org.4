Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73D06C0971
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCTDnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCTDm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:42:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0462234D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:41:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-541888850d4so110778817b3.21
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283671;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pn6gwqPn6dkc20Y3Eh8vm1i49cyw3lYEcOJG/9m8aKk=;
        b=NiOQcDHGuVa/g62h9FdRef0dQ+TFdAQpcESbK48/x4y4DKCLz/cCiJ7eSTW+2FaUho
         +vt8h1+pEAa2pp2dWrq2G5bLz0281bqJvwR6rNUXJJlA6ycYkWPP5GA+soVVRGYSA6oD
         ScsRhqIc5gWKoFXPFTZvlY13eBm6O1+2Ncha3+4aktqzNVczL5ztz8IAKR5MS/fuB1Xl
         BmkX7m9/u/dpqTE8S2+q9BO1TrIitG7vNm1oDCKFdhNrqkPd+NLq4BVJkOvpGveHZglC
         /5me0No4TPfL7unIzkqrwSG7WLGR1WT942+03stYpIZBYQMIhoDxDolsn5jKx5CNp5qM
         sr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283671;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pn6gwqPn6dkc20Y3Eh8vm1i49cyw3lYEcOJG/9m8aKk=;
        b=T7/phUy0nCdz2IdHiqH/XR4P0+jbKcVIA9BZtc4tmDekTDgoOwpHrPgCw6YcKU/Ss6
         GOKrCge6WYH3m/qSXW8S+8f8ibZmumV2sDnOrDxhHmvf64uGWSoPudNriNRz/b8VvP3e
         0XquBFnrIr15zfydv/ZdDcCdsLnAPoQrowAb8sL6ngqWWc1G8f6ggV7Nfu6vUAlOQY4+
         b/QzsA84ncxWOvI1qHHItmJeFZEJ4lwBc6HEjKu93b6fqu91Ozsoqxca10q4TqUn0Jjy
         DK+pgHyKY2A1ccKsOSMy/2bJsTRbc4O1d80KloZbXRu1jUum/n9MMynXvUNHWiNgmGPR
         p4hQ==
X-Gm-Message-State: AO0yUKU5fT2UDM7V2it0kOXTQHif0SsEsOtYxQXMY3BujbNYy81FBjzg
        JjwrPAJDgdxh30BEvf5pi6Oc+q0IiKfe
X-Google-Smtp-Source: AK7set/UatlbzEx6HL5P0QXXpFUhS3CcUNYUVMKS2z9YHa+UlelOdKde1lPJG336O7IKjWITD4YK34l3jTjw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a05:6902:723:b0:b6a:2590:6c63 with SMTP id
 l3-20020a056902072300b00b6a25906c63mr3764100ybt.2.1679283671647; Sun, 19 Mar
 2023 20:41:11 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:38:08 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-21-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 20/22] perf namespaces: Add reference count checking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reference count checking controlled by REFCNT_CHECKING ifdef. The
reference count checking interposes an allocated pointer between the
reference counted struct on a get and frees the pointer on a put.
Accesses after a put cause faults and use after free, missed puts are
caughts as leaks and double puts are double frees.

This checking helped resolve a memory leak and use after free:
https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c  |   2 +-
 tools/perf/util/annotate.c   |   2 +-
 tools/perf/util/dso.c        |   2 +-
 tools/perf/util/dsos.c       |   2 +-
 tools/perf/util/namespaces.c | 132 ++++++++++++++++++++---------------
 tools/perf/util/namespaces.h |   3 +-
 tools/perf/util/symbol.c     |   2 +-
 7 files changed, 83 insertions(+), 62 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index fd2b38458a5d..fe6ddcf7fb1e 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -632,7 +632,7 @@ static int dso__read_build_id(struct dso *dso)
 	else if (dso->nsinfo) {
 		char *new_name;
 
-		new_name = filename_with_chroot(dso->nsinfo->pid,
+		new_name = filename_with_chroot(RC_CHK_ACCESS(dso->nsinfo)->pid,
 						dso->long_name);
 		if (new_name && filename__read_build_id(new_name, &dso->bid) > 0)
 			dso->has_build_id = true;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e8570b7cc36f..199f6cd5ad1e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1701,7 +1701,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 		mutex_lock(&dso->lock);
 		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
-			char *new_name = filename_with_chroot(dso->nsinfo->pid,
+			char *new_name = filename_with_chroot(RC_CHK_ACCESS(dso->nsinfo)->pid,
 							      filename);
 			if (new_name) {
 				strlcpy(filename, new_name, filename_size);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e36b418df2c6..6c4129598f5d 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -515,7 +515,7 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		if (errno != ENOENT || dso->nsinfo == NULL)
 			goto out;
 
-		new_name = filename_with_chroot(dso->nsinfo->pid, name);
+		new_name = filename_with_chroot(RC_CHK_ACCESS(dso->nsinfo)->pid, name);
 		if (!new_name)
 			goto out;
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 2bd23e4cf19e..53b989072ec5 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -91,7 +91,7 @@ bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 			have_build_id	  = true;
 			pos->has_build_id = true;
 		} else if (errno == ENOENT && pos->nsinfo) {
-			char *new_name = filename_with_chroot(pos->nsinfo->pid,
+			char *new_name = filename_with_chroot(RC_CHK_ACCESS(pos->nsinfo)->pid,
 							      pos->long_name);
 
 			if (new_name && filename__read_build_id(new_name,
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index dd536220cdb9..8a3b7bd27b19 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -60,7 +60,7 @@ void namespaces__free(struct namespaces *namespaces)
 	free(namespaces);
 }
 
-static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
+static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const char *path)
 {
 	FILE *f = NULL;
 	char *statln = NULL;
@@ -74,19 +74,18 @@ static int nsinfo__get_nspid(struct nsinfo *nsi, const char *path)
 	while (getline(&statln, &linesz, f) != -1) {
 		/* Use tgid if CONFIG_PID_NS is not defined. */
 		if (strstr(statln, "Tgid:") != NULL) {
-			nsi->tgid = (pid_t)strtol(strrchr(statln, '\t'),
-						     NULL, 10);
-			nsi->nstgid = nsinfo__tgid(nsi);
+			*tgid = (pid_t)strtol(strrchr(statln, '\t'), NULL, 10);
+			*nstgid = *tgid;
 		}
 
 		if (strstr(statln, "NStgid:") != NULL) {
 			nspid = strrchr(statln, '\t');
-			nsi->nstgid = (pid_t)strtol(nspid, NULL, 10);
+			*nstgid = (pid_t)strtol(nspid, NULL, 10);
 			/*
 			 * If innermost tgid is not the first, process is in a different
 			 * PID namespace.
 			 */
-			nsi->in_pidns = (statln + sizeof("NStgid:") - 1) != nspid;
+			*in_pidns = (statln + sizeof("NStgid:") - 1) != nspid;
 			break;
 		}
 	}
@@ -121,8 +120,8 @@ int nsinfo__init(struct nsinfo *nsi)
 	 * want to switch as part of looking up dso/map data.
 	 */
 	if (old_stat.st_ino != new_stat.st_ino) {
-		nsi->need_setns = true;
-		nsi->mntns_path = newns;
+		RC_CHK_ACCESS(nsi)->need_setns = true;
+		RC_CHK_ACCESS(nsi)->mntns_path = newns;
 		newns = NULL;
 	}
 
@@ -132,13 +131,26 @@ int nsinfo__init(struct nsinfo *nsi)
 	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsinfo__pid(nsi)) >= PATH_MAX)
 		goto out;
 
-	rv = nsinfo__get_nspid(nsi, spath);
+	rv = nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)->nstgid,
+			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
 
 out:
 	free(newns);
 	return rv;
 }
 
+static struct nsinfo *nsinfo__alloc(void)
+{
+	struct nsinfo *res;
+	RC_STRUCT(nsinfo) *nsi;
+
+	nsi = calloc(1, sizeof(*nsi));
+	if (ADD_RC_CHK(res, nsi))
+		refcount_set(&nsi->refcnt, 1);
+
+	return res;
+}
+
 struct nsinfo *nsinfo__new(pid_t pid)
 {
 	struct nsinfo *nsi;
@@ -146,22 +158,21 @@ struct nsinfo *nsinfo__new(pid_t pid)
 	if (pid == 0)
 		return NULL;
 
-	nsi = calloc(1, sizeof(*nsi));
-	if (nsi != NULL) {
-		nsi->pid = pid;
-		nsi->tgid = pid;
-		nsi->nstgid = pid;
-		nsi->need_setns = false;
-		nsi->in_pidns = false;
-		/* Init may fail if the process exits while we're trying to look
-		 * at its proc information.  In that case, save the pid but
-		 * don't try to enter the namespace.
-		 */
-		if (nsinfo__init(nsi) == -1)
-			nsi->need_setns = false;
+	nsi = nsinfo__alloc();
+	if (!nsi)
+		return NULL;
 
-		refcount_set(&nsi->refcnt, 1);
-	}
+	RC_CHK_ACCESS(nsi)->pid = pid;
+	RC_CHK_ACCESS(nsi)->tgid = pid;
+	RC_CHK_ACCESS(nsi)->nstgid = pid;
+	RC_CHK_ACCESS(nsi)->need_setns = false;
+	RC_CHK_ACCESS(nsi)->in_pidns = false;
+	/* Init may fail if the process exits while we're trying to look at its
+	 * proc information. In that case, save the pid but don't try to enter
+	 * the namespace.
+	 */
+	if (nsinfo__init(nsi) == -1)
+		RC_CHK_ACCESS(nsi)->need_setns = false;
 
 	return nsi;
 }
@@ -173,21 +184,21 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	if (nsi == NULL)
 		return NULL;
 
-	nnsi = calloc(1, sizeof(*nnsi));
-	if (nnsi != NULL) {
-		nnsi->pid = nsinfo__pid(nsi);
-		nnsi->tgid = nsinfo__tgid(nsi);
-		nnsi->nstgid = nsinfo__nstgid(nsi);
-		nnsi->need_setns = nsinfo__need_setns(nsi);
-		nnsi->in_pidns = nsinfo__in_pidns(nsi);
-		if (nsi->mntns_path) {
-			nnsi->mntns_path = strdup(nsi->mntns_path);
-			if (!nnsi->mntns_path) {
-				free(nnsi);
-				return NULL;
-			}
+	nnsi = nsinfo__alloc();
+	if (!nnsi)
+		return NULL;
+
+	RC_CHK_ACCESS(nnsi)->pid = nsinfo__pid(nsi);
+	RC_CHK_ACCESS(nnsi)->tgid = nsinfo__tgid(nsi);
+	RC_CHK_ACCESS(nnsi)->nstgid = nsinfo__nstgid(nsi);
+	RC_CHK_ACCESS(nnsi)->need_setns = nsinfo__need_setns(nsi);
+	RC_CHK_ACCESS(nnsi)->in_pidns = nsinfo__in_pidns(nsi);
+	if (RC_CHK_ACCESS(nsi)->mntns_path) {
+		RC_CHK_ACCESS(nnsi)->mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
+		if (!RC_CHK_ACCESS(nnsi)->mntns_path) {
+			nsinfo__put(nnsi);
+			return NULL;
 		}
-		refcount_set(&nnsi->refcnt, 1);
 	}
 
 	return nnsi;
@@ -195,51 +206,60 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 
 static void nsinfo__delete(struct nsinfo *nsi)
 {
-	zfree(&nsi->mntns_path);
-	free(nsi);
+	if (nsi) {
+		WARN_ONCE(refcount_read(&RC_CHK_ACCESS(nsi)->refcnt) != 0,
+			"nsinfo refcnt unbalanced\n");
+		zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+		RC_CHK_FREE(nsi);
+	}
 }
 
 struct nsinfo *nsinfo__get(struct nsinfo *nsi)
 {
-	if (nsi)
-		refcount_inc(&nsi->refcnt);
-	return nsi;
+	struct nsinfo *result;
+
+	if (RC_CHK_GET(result, nsi))
+		refcount_inc(&RC_CHK_ACCESS(nsi)->refcnt);
+
+	return result;
 }
 
 void nsinfo__put(struct nsinfo *nsi)
 {
-	if (nsi && refcount_dec_and_test(&nsi->refcnt))
+	if (nsi && refcount_dec_and_test(&RC_CHK_ACCESS(nsi)->refcnt))
 		nsinfo__delete(nsi);
+	else
+		RC_CHK_PUT(nsi);
 }
 
 bool nsinfo__need_setns(const struct nsinfo *nsi)
 {
-        return nsi->need_setns;
+	return RC_CHK_ACCESS(nsi)->need_setns;
 }
 
 void nsinfo__clear_need_setns(struct nsinfo *nsi)
 {
-        nsi->need_setns = false;
+	RC_CHK_ACCESS(nsi)->need_setns = false;
 }
 
 pid_t nsinfo__tgid(const struct nsinfo  *nsi)
 {
-        return nsi->tgid;
+	return RC_CHK_ACCESS(nsi)->tgid;
 }
 
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi)
 {
-        return nsi->nstgid;
+	return RC_CHK_ACCESS(nsi)->nstgid;
 }
 
 pid_t nsinfo__pid(const struct nsinfo  *nsi)
 {
-        return nsi->pid;
+	return RC_CHK_ACCESS(nsi)->pid;
 }
 
 pid_t nsinfo__in_pidns(const struct nsinfo  *nsi)
 {
-        return nsi->in_pidns;
+	return RC_CHK_ACCESS(nsi)->in_pidns;
 }
 
 void nsinfo__mountns_enter(struct nsinfo *nsi,
@@ -256,7 +276,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	nc->oldns = -1;
 	nc->newns = -1;
 
-	if (!nsi || !nsi->need_setns)
+	if (!nsi || !RC_CHK_ACCESS(nsi)->need_setns)
 		return;
 
 	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
@@ -270,7 +290,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (oldns < 0)
 		goto errout;
 
-	newns = open(nsi->mntns_path, O_RDONLY);
+	newns = open(RC_CHK_ACCESS(nsi)->mntns_path, O_RDONLY);
 	if (newns < 0)
 		goto errout;
 
@@ -339,9 +359,9 @@ int nsinfo__stat(const char *filename, struct stat *st, struct nsinfo *nsi)
 
 bool nsinfo__is_in_root_namespace(void)
 {
-	struct nsinfo nsi;
+	pid_t tgid = 0, nstgid = 0;
+	bool in_pidns = false;
 
-	memset(&nsi, 0x0, sizeof(nsi));
-	nsinfo__get_nspid(&nsi, "/proc/self/status");
-	return !nsi.in_pidns;
+	nsinfo__get_nspid(&tgid, &nstgid, &in_pidns, "/proc/self/status");
+	return !in_pidns;
 }
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 567829262c42..8c0731c6cbb7 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
+#include <internal/rc_check.h>
 
 #ifndef HAVE_SETNS_SUPPORT
 int setns(int fd, int nstype);
@@ -29,7 +30,7 @@ struct namespaces {
 struct namespaces *namespaces__new(struct perf_record_namespaces *event);
 void namespaces__free(struct namespaces *namespaces);
 
-struct nsinfo {
+DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			pid;
 	pid_t			tgid;
 	pid_t			nstgid;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1f4c23052a54..103ab925ee2d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1959,7 +1959,7 @@ int dso__load(struct dso *dso, struct map *map)
 
 		is_reg = is_regular_file(name);
 		if (!is_reg && errno == ENOENT && dso->nsinfo) {
-			char *new_name = filename_with_chroot(dso->nsinfo->pid,
+			char *new_name = filename_with_chroot(RC_CHK_ACCESS(dso->nsinfo)->pid,
 							      name);
 			if (new_name) {
 				is_reg = is_regular_file(new_name);
-- 
2.40.0.rc1.284.g88254d51c5-goog

