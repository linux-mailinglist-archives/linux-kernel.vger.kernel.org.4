Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0223C69BF74
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBSJa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBSJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:30:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6112045
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:53 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536885323c1so17938527b3.15
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ty9nxmBgJsUnSpKV2MHBIMxHaMhrZHfa8zZXWCP8Cbg=;
        b=fXPFn6oSwVykULAqbxpfhUL0GIEFqD2VYVuHvyjznRwBP0ndR6qs7rXslQtWXWUNDh
         /2XPYoU8PtIy6GaUZ111tSYonx7D26wZEZSKzGtpsztGeEjNKD6TZA1M4wYrnGZz9BuG
         GVN+QKkPziKsRuGsy1hU2SmnPxPPt+UDETmNsrK3VXcueClddLswkxO1Akd46lSS2YW6
         uaJoN9BzoCcsr3DJPtkDs+01a1IBH3ojOB4udgVPPUg7gGlIxu2bwhMSr/KvdeFjGumO
         BX/oZoE1NUz/N56t7evkLcNhnUn+6CYqcKAZlVrXPxXwzfkxuyJFXxTp6kiBL5aj5LHv
         Y3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty9nxmBgJsUnSpKV2MHBIMxHaMhrZHfa8zZXWCP8Cbg=;
        b=MdZGWXh5AdJn3XaJNJcJqerSfsvbKsvVqbJcW6YVAUhFmrS56KoJvvwwDFF51P56Cb
         Xd05KwxG0Dt64Q3rEu3aNdkIzwkdDhuIsiujCQoV2ZlIpvm0RHUcWmJJTU3CWxBtSfRQ
         l6Pj0u3kd4ORojuetsfGMFTdN4/60GWvLA0ajGiHnc1gxVl9E26c0AKm7x8jE31XZkE9
         2YjKeRhuxuBcQrglGyJ3JugTWwOO0HBsOF8haNVtqlGfeybny8ISHft5WT1hZkCQeCbm
         /DeO91A24nGoc0B1u8T3G8+Y7ECgnRPuCJkaZoZ+gr+SLr0Dmk93nIVXiX7IxZWdvzgV
         fAeQ==
X-Gm-Message-State: AO0yUKWfz3zrSze38HJw/JySXdadamm5lKPooSxGpSdSRUxlSExeb9O8
        2X3jLfOCAUjJHpXReK0ul89aptVtb3X0
X-Google-Smtp-Source: AK7set8/9xn2NisKgllh+YoZULn5eZpfNzaNw83XW4wPsTC6NQrB1+wc0RUp1LPVAPXQL8Pa5tslQGVII/VV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:690c:f01:b0:52e:ac97:115f with SMTP id
 dc1-20020a05690c0f0100b0052eac97115fmr228775ywb.5.1676798992575; Sun, 19 Feb
 2023 01:29:52 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:03 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-7-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 06/51] perf pmu-events: Change perpkg to be a bool
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

Switch to a more natural bool rather than string encoding, where NULL
implicitly meant false. The only value of 'PerPkg' in the event json
is '1'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py   |  2 +-
 tools/perf/pmu-events/pmu-events.h |  2 +-
 tools/perf/tests/pmu-events.c      |  4 ++--
 tools/perf/util/pmu.c              | 11 ++++-------
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 35ca34eca74a..2da55408398f 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -678,7 +678,7 @@ static void decompress_event(int offset, struct pmu_event *pe)
 {
 \tconst char *p = &big_c_string[offset];
 """)
-  enum_attributes = ['aggr_mode', 'deprecated']
+  enum_attributes = ['aggr_mode', 'deprecated', 'perpkg']
   for attr in _json_event_attributes:
     _args.output_file.write(f'\n\tpe->{attr} = ')
     if attr in enum_attributes:
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 2434bc7cf92d..4d236bb32fd3 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -23,7 +23,7 @@ struct pmu_event {
 	const char *long_desc;
 	const char *pmu;
 	const char *unit;
-	const char *perpkg;
+	bool perpkg;
 	bool deprecated;
 };
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 937804c84e29..521557c396bc 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -325,8 +325,8 @@ static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event
 		return -1;
 	}
 
-	if (!is_same(e1->perpkg, e2->perpkg)) {
-		pr_debug2("testing event e1 %s: mismatched perpkg, %s vs %s\n",
+	if (e1->perpkg != e2->perpkg) {
+		pr_debug2("testing event e1 %s: mismatched perpkg, %d vs %d\n",
 			  e1->name, e1->perpkg, e2->perpkg);
 		return -1;
 	}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 80644e25a568..43b6182d96b7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -328,17 +328,15 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	struct parse_events_term *term;
 	struct perf_pmu_alias *alias;
 	int ret;
-	int num;
 	char newval[256];
-	char *long_desc = NULL, *topic = NULL, *unit = NULL, *perpkg = NULL,
-	     *pmu_name = NULL;
-	bool deprecated = false;
+	char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
+	bool deprecated = false, perpkg = false;
 
 	if (pe) {
 		long_desc = (char *)pe->long_desc;
 		topic = (char *)pe->topic;
 		unit = (char *)pe->unit;
-		perpkg = (char *)pe->perpkg;
+		perpkg = pe->perpkg;
 		deprecated = pe->deprecated;
 		pmu_name = (char *)pe->pmu;
 	}
@@ -350,7 +348,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 	INIT_LIST_HEAD(&alias->terms);
 	alias->scale = 1.0;
 	alias->unit[0] = '\0';
-	alias->per_pkg = false;
+	alias->per_pkg = perpkg;
 	alias->snapshot = false;
 	alias->deprecated = deprecated;
 
@@ -402,7 +400,6 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 			return -1;
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
-	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
 	alias->str = strdup(newval);
 	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
 
-- 
2.39.2.637.g21b0678d19-goog

