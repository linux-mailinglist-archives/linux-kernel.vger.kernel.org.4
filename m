Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B85E86CD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiIXAm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiIXAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:42:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02568115BC2;
        Fri, 23 Sep 2022 17:42:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b75so1580946pfb.7;
        Fri, 23 Sep 2022 17:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=gspQs1QxEjtC7bSEvRo4TJDBF3NPEEStSRBNzrI3ftQ=;
        b=WCAmjSzEYYB2ZiNbehzODWOC+xQAyg6HZiWcRjqce9eJnPGJDQ9m4RyWxS0FNTZDHt
         O3D2lldIS53pjj5bbdZenDE1lRX5lZLUhrP/CVH8yR7SlZjvcIyo4VezjTqFlJRFnRpp
         NxPqOGfqh1PhYUo0wjq1XHGI5m4V6nhzG3mbSeU0kV9smFBeUZ3o0wy7t7xTL4AiSX5O
         BgmVqbwIpaevFr3ppE7gPkseKkx6M11YEdD4ibpE4j9R9HVY0X0CU77iJjT1finUhVse
         LZ4LNdyNJXtbbHWgXtGzsLhdm1HWxfC7yLy+YaZuWvXRoLl/mq2RcjDJUB8VYeSPeEVR
         5c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=gspQs1QxEjtC7bSEvRo4TJDBF3NPEEStSRBNzrI3ftQ=;
        b=C4uhsmrzHP54+BpBltZvPzC9SDH7cx1YbcbFIQmHXLIepNv7n7KiZSa9xuahP97Sq7
         MB9GnU/Tdwd64xJ4HUZ8s9qFX2G6c5HJsCRP4XpjE+llD4HnB6fH4DBBBVwD1IbUiJoQ
         igUaQAPGprtl3WNO+8kGz//YPyW+OCJE9+2KIBTjG45LJ2KnorDkwHZG34gJFR058r41
         R7e3D5Ea2nrN/oD1tQqPdpYJh0LOiOXnjRImlmdQO9ZMCA6pbz+x88guJqsPL77sEWWB
         JVZsWsl2Jl++PgvQ2CKa8zFDPZ4ah8mvoA6ZpfNXmznUMUSLGHMwlStE9oN1jmi26ry2
         bmmg==
X-Gm-Message-State: ACrzQf3FdJQtSvO5tR3TTDX+8bM4APLs1gyo0QldS6vQXOGQGzE5+0T4
        LsqsGk/js7ohVAXtXnVANIk=
X-Google-Smtp-Source: AMsMyM5hIlGpGGuYrjto56F3dA1+95TXjX6OoTHeX1RAwE2C3V08eCUp6c6ADnoqueCHDuUov47BJA==
X-Received: by 2002:a63:6a03:0:b0:43a:18ce:7473 with SMTP id f3-20020a636a03000000b0043a18ce7473mr10280198pgc.616.1663980144377;
        Fri, 23 Sep 2022 17:42:24 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:9987:f0b9:ad5:1fe7])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b00176acc23a73sm6639516plx.281.2022.09.23.17.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 17:42:23 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf lock: Add -E/--entries option
Date:   Fri, 23 Sep 2022 17:42:19 -0700
Message-Id: <20220924004221.841024-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like perf top, the -E option can limit number of entries to print.
It can be useful when users want to see top N contended locks only.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt | 10 ++++++++++
 tools/perf/builtin-lock.c              | 20 +++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 5f2dc634258e..b23e76200ac2 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -94,6 +94,11 @@ REPORT OPTIONS
          EventManager_De       1845          1             636
          futex-default-S       1609          0               0
 
+-E::
+--entries=<value>::
+	Display this many entries.
+
+
 INFO OPTIONS
 ------------
 
@@ -105,6 +110,7 @@ INFO OPTIONS
 --map::
 	dump map of lock instances (address:name table)
 
+
 CONTENTION OPTIONS
 --------------
 
@@ -154,6 +160,10 @@ CONTENTION OPTIONS
 --stack-skip
 	Number of stack depth to skip when finding a lock caller (default: 3).
 
+-E::
+--entries=<value>::
+	Display this many entries.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 25d75fa09b90..1c0d52384d9e 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -58,6 +58,7 @@ static bool use_bpf;
 static unsigned long bpf_map_entries = 10240;
 static int max_stack_depth = CONTENTION_STACK_DEPTH;
 static int stack_skip = CONTENTION_STACK_SKIP;
+static int print_nr_entries = INT_MAX / 2;
 
 static enum {
 	LOCK_AGGR_ADDR,
@@ -1266,14 +1267,14 @@ static void print_result(void)
 	struct lock_stat *st;
 	struct lock_key *key;
 	char cut_name[20];
-	int bad, total;
+	int bad, total, printed;
 
 	pr_info("%20s ", "Name");
 	list_for_each_entry(key, &lock_keys, list)
 		pr_info("%*s ", key->len, key->header);
 	pr_info("\n\n");
 
-	bad = total = 0;
+	bad = total = printed = 0;
 	while ((st = pop_from_result())) {
 		total++;
 		if (st->broken)
@@ -1311,6 +1312,9 @@ static void print_result(void)
 			pr_info(" ");
 		}
 		pr_info("\n");
+
+		if (++printed >= print_nr_entries)
+			break;
 	}
 
 	print_bad_events(bad, total);
@@ -1476,7 +1480,7 @@ static void print_contention_result(struct lock_contention *con)
 {
 	struct lock_stat *st;
 	struct lock_key *key;
-	int bad, total;
+	int bad, total, printed;
 
 	list_for_each_entry(key, &lock_keys, list)
 		pr_info("%*s ", key->len, key->header);
@@ -1486,7 +1490,7 @@ static void print_contention_result(struct lock_contention *con)
 	else
 		pr_info("  %10s   %s\n\n", "type", "caller");
 
-	bad = total = 0;
+	bad = total = printed = 0;
 	if (use_bpf)
 		bad = bad_hist[BROKEN_CONTENDED];
 
@@ -1507,7 +1511,7 @@ static void print_contention_result(struct lock_contention *con)
 			/* st->addr contains tid of thread */
 			t = perf_session__findnew(session, pid);
 			pr_info("  %10d   %s\n", pid, thread__comm_str(t));
-			continue;
+			goto next;
 		}
 
 		pr_info("  %10s   %s\n", get_type_str(st), st->name);
@@ -1527,6 +1531,10 @@ static void print_contention_result(struct lock_contention *con)
 				pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
 			}
 		}
+
+next:
+		if (++printed >= print_nr_entries)
+			break;
 	}
 
 	print_bad_events(bad, total);
@@ -1878,6 +1886,7 @@ int cmd_lock(int argc, const char **argv)
 		    "combine locks in the same class"),
 	OPT_BOOLEAN('t', "threads", &show_thread_stats,
 		    "show per-thread lock stats"),
+	OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -1905,6 +1914,7 @@ int cmd_lock(int argc, const char **argv)
 	OPT_INTEGER(0, "stack-skip", &stack_skip,
 		    "Set the number of stack depth to skip when finding a lock caller, "
 		    "Default: " __stringify(CONTENTION_STACK_SKIP)),
+	OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
 	OPT_PARENT(lock_options)
 	};
 
-- 
2.37.3.998.g577e59143f-goog

