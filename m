Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7717251C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjFGBrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjFGBo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87411BD9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565d1b86a64so85432317b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102295; x=1688694295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpqdBOXtu+XA2l9VAqqYrUmzRP4oQxTaswm8YIVLP/c=;
        b=oyAMvyvKd7H3iN2vs+5b0ZGuiOACYVPYVqF6UfnASiCblIW8XWaFPO+vux0yta4hEO
         hfQDbKGo944R0aqkreNE0o00KCsErwgAguftl6ZXevwn/x1HtDWumPSrb0Yt+T/MF5M9
         jZ24pj9t7MeljL9SyLOhJtEi/AqxlZJSnhXi7KT3kld9blW4geT4ldBkXV2ScxBet8h9
         7z7IWlmOO+5scKxUm7y9+AeKPN8dBouxwfJOXpD2QprsQGR1QsLnl/IGqBnBHwVyFrLs
         pmG3VJDsI9GJqTveB+yM+MQDmfm07ano0FF8TrAZF30D6nC+JeD+dAQCewDB4N6pBia9
         9zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102295; x=1688694295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpqdBOXtu+XA2l9VAqqYrUmzRP4oQxTaswm8YIVLP/c=;
        b=ZVdp0ab4QK/Vsz8e+fSXtiz/gMQEAHdlbVwvVvL4dDpSVxlXk4NanIrh9j2pWKK6Ml
         a6UF9Fb0COcJRjvgOHrXInQ6rrW/KDS+yfvXCKKxu3YC/zAsQ0/Jwt8mCPOvOhBAzTab
         K9ZIVb/gGmTonZmwlx+op9mUeOHFUk2o2+ayajJDPajR+1SxJt3qwpj+pV+YxMTgLgco
         ZzV6+i4tfOu4XOJCaHhcMDjs9pIY6PwJVFMEe+OrKvv8ZNenxKoykoTDzTrfEfr2UqbN
         GJa3UQ7vB/lyxRNHOfmhDTU2ib19nk2a4yXQ6qJM4dgcDJN1K8wIC7TMoiDeOOtMtYrL
         xKUw==
X-Gm-Message-State: AC+VfDxi3jUMSL8jiN4sd82sQtAdkwF0zkZa/LXe3ihssDRdSXVdlDIG
        3kDMYTYHI3vkhdT4tu9cAWt7moNfOrMm
X-Google-Smtp-Source: ACHHUZ46Eck1lbC5mSIJzGH2gMBwJxRSh1jBmUauiOGfGoKRuuP34DT5BWMC2bAna9Eip/A8WkG4acWqFPIE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:183:b0:ba8:1f20:ff4f with SMTP id
 t3-20020a056902018300b00ba81f20ff4fmr2118729ybh.12.1686102295606; Tue, 06 Jun
 2023 18:44:55 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:53 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-21-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 20/20] perf map/maps/thread: Changes to reference counting
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missed reference count gets and puts as detected with leak
sanitizer and reference count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/callchain.c |  7 +++++--
 tools/perf/util/event.c     |  3 +++
 tools/perf/util/hist.c      |  6 ++++--
 tools/perf/util/machine.c   | 14 ++++++++------
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index b0dafc758173..437325d19ad3 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1065,8 +1065,10 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	}
 
 	node->ip = ip;
+	maps__zput(node->ms.maps);
 	map__zput(node->ms.map);
 	node->ms = *ms;
+	node->ms.maps = maps__get(node->ms.maps);
 	node->ms.map = map__get(node->ms.map);
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
@@ -1114,7 +1116,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 {
 	struct machine *machine = maps__machine(node->ms.maps);
 
-	al->maps = node->ms.maps;
+	maps__put(al->maps);
+	al->maps = maps__get(node->ms.maps);
 	map__put(al->map);
 	al->map = map__get(node->ms.map);
 	al->sym = node->ms.sym;
@@ -1127,7 +1130,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 		if (al->map == NULL)
 			goto out;
 	}
-	if (al->maps == machine__kernel_maps(machine)) {
+	if (RC_CHK_ACCESS(al->maps) == RC_CHK_ACCESS(machine__kernel_maps(machine))) {
 		if (machine__is_host(machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2fcfba38fc48..3860b0c74829 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -711,6 +711,9 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 	if (thread__is_filtered(thread))
 		al->filtered |= (1 << HIST_FILTER__THREAD);
 
+	thread__put(thread);
+	thread = NULL;
+
 	al->sym = NULL;
 	al->cpu = sample->cpu;
 	al->socket = -1;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index dfda52d348a3..fb218b3e8a7c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -450,6 +450,7 @@ static int hist_entry__init(struct hist_entry *he,
 			memset(&he->stat, 0, sizeof(he->stat));
 	}
 
+	he->ms.maps = maps__get(he->ms.maps);
 	he->ms.map = map__get(he->ms.map);
 
 	if (he->branch_info) {
@@ -497,7 +498,7 @@ static int hist_entry__init(struct hist_entry *he,
 	}
 
 	INIT_LIST_HEAD(&he->pairs.node);
-	thread__get(he->thread);
+	he->thread = thread__get(he->thread);
 	he->hroot_in  = RB_ROOT_CACHED;
 	he->hroot_out = RB_ROOT_CACHED;
 
@@ -523,6 +524,7 @@ static int hist_entry__init(struct hist_entry *he,
 		map__put(he->mem_info->daddr.ms.map);
 	}
 err:
+	maps__zput(he->ms.maps);
 	map__zput(he->ms.map);
 	zfree(&he->stat_acc);
 	return -ENOMEM;
@@ -611,7 +613,6 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 		 * keys were used.
 		 */
 		cmp = hist_entry__cmp(he, entry);
-
 		if (!cmp) {
 			if (sample_self) {
 				he_stat__add_period(&he->stat, period);
@@ -1309,6 +1310,7 @@ void hist_entry__delete(struct hist_entry *he)
 	struct hist_entry_ops *ops = he->ops;
 
 	thread__zput(he->thread);
+	maps__zput(he->ms.maps);
 	map__zput(he->ms.map);
 
 	if (he->branch_info) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 359ef6b4e840..16dc49876e87 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -539,7 +539,7 @@ static void machine__update_thread_pid(struct machine *machine,
 		goto out_err;
 
 	if (thread__maps(th) == thread__maps(leader))
-		return;
+		goto out_put;
 
 	if (thread__maps(th)) {
 		/*
@@ -579,7 +579,7 @@ __threads__get_last_match(struct threads *threads, struct machine *machine,
 			machine__update_thread_pid(machine, th, pid);
 			return thread__get(th);
 		}
-
+		thread__put(threads->last_match);
 		threads->last_match = NULL;
 	}
 
@@ -601,7 +601,8 @@ threads__get_last_match(struct threads *threads, struct machine *machine,
 static void
 __threads__set_last_match(struct threads *threads, struct thread *th)
 {
-	threads->last_match = th;
+	thread__put(threads->last_match);
+	threads->last_match = thread__get(th);
 }
 
 static void
@@ -664,7 +665,6 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 
 	rb_link_node(&nd->rb_node, parent, p);
 	rb_insert_color_cached(&nd->rb_node, &threads->entries, leftmost);
-
 	/*
 	 * We have to initialize maps separately after rb tree is updated.
 	 *
@@ -673,6 +673,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 	 * the rb tree.
 	 */
 	if (thread__init_maps(th, machine)) {
+		pr_err("Thread init failed thread %d\n", pid);
 		rb_erase_cached(&nd->rb_node, &threads->entries);
 		RB_CLEAR_NODE(&nd->rb_node);
 		free(nd);
@@ -682,11 +683,10 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 	/*
 	 * It is now in the rbtree, get a ref
 	 */
-	thread__get(th);
 	threads__set_last_match(threads, th);
 	++threads->nr;
 
-	return th;
+	return thread__get(th);
 }
 
 struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
@@ -2395,6 +2395,8 @@ static int add_callchain_ip(struct thread *thread,
 				      iter_cycles, branch_from, srcline);
 out:
 	addr_location__exit(&al);
+	maps__put(ms.maps);
+	map__put(ms.map);
 	return err;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

