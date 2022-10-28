Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3E6119D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJ1SCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJ1SBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:01:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C020FB2B;
        Fri, 28 Oct 2022 11:01:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so10552262pji.1;
        Fri, 28 Oct 2022 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDQ26YrilcoiUxmd9QdQ1Dk7XFU7csSgsYNB1op6NE8=;
        b=SQ3Z7rvGLUrN/t+Hbqt2wDeDYS+lmrdAuACOFCN3M0r2GzZxb/crepMgS5OP/2NbkF
         cShzFKOVPzUVMu/4Q3R7Bz/pcOtmgyOxVgdcU+PSkvvPXf/mHjwUInz7cX/LFupYbQsF
         5fgXhixo3JpdAiOIoqLKejnqonJtnoS8NuHJ8Z16m3ZpXaaFDLjXee+tNGbpTWloi/tz
         qYP1zAB6XKeJ8lA1jd6b3EyIYqGIPUOyP5PtS0TonCxJDzbiJqq8cVzxqQ9WKHgzdm8/
         tEyKfNfcJExD656B2UX8dM/cEOY4pkLpgCRU4vC4t7G3xWFgwSZFqCym2Q/LfDnemOqf
         szkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BDQ26YrilcoiUxmd9QdQ1Dk7XFU7csSgsYNB1op6NE8=;
        b=ji/c5lZiXBorY7XHTCEpMCOUzcIOgIA5Ei1GLUbV46y5Jl2NnztKMVMe1XFviUCDOn
         BnAo0bWls/53Z3Mj6qZPXgr+Kku3QX0tEeezEn+QHgQ8TiKWSL0h4+ONtEwu1eDNiFEP
         OeHHQuFl9cVpkNG9n8lxu72Yw9ababNJThyIDzllbck2pzDrvR/g16kIW8kRlM9KcE/u
         J0dX72tcq7o7yoH3i3eZb4LGUMmWi+JTOIRmVvpI6jZST/GhcpmXfpw+tqLOmMZ7JQ7d
         sV4nKpoqrL+ry1+hLUgW74cl+xNnhmNrFdVEAiP5zOQnNKvYBHZadZ+NoTUEbuXCypLC
         3NLg==
X-Gm-Message-State: ACrzQf0mrUCsA/fs63fNQJ2Cgcz6jaBVgQcUGhAuk7340LcZE4W/tK/0
        3TdmgA7Ur5m2Lw755i/9dwM=
X-Google-Smtp-Source: AMsMyM5m9Lm/S0KoGT3x/3K7T1Jq3Rxgk521iBeyuY+kBc39zhp8SIBXmFAjnqpX4WDh/taOsk3Fiw==
X-Received: by 2002:a17:902:ce0e:b0:17d:a730:3835 with SMTP id k14-20020a170902ce0e00b0017da7303835mr172589plg.131.1666980097967;
        Fri, 28 Oct 2022 11:01:37 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:976f:f075:7c14:87a2])
        by smtp.gmail.com with ESMTPSA id n3-20020a170903110300b00186b86ed450sm3400236plh.156.2022.10.28.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:01:36 -0700 (PDT)
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
Subject: [PATCH 3/4] perf lock contention: Avoid variable length arrays
Date:   Fri, 28 Oct 2022 11:01:27 -0700
Message-Id: <20221028180128.3311491-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221028180128.3311491-1-namhyung@kernel.org>
References: <20221028180128.3311491-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msan also warns about the use of VLA for stack_trace variable.
We can dynamically allocate instead.  While at it, simplify the error
handle a bit (and fix bugs).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c | 41 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 06466da792e4..0deec1178778 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -108,28 +108,36 @@ int lock_contention_stop(void)
 
 int lock_contention_read(struct lock_contention *con)
 {
-	int fd, stack;
+	int fd, stack, err = 0;
 	s32 prev_key, key;
 	struct lock_contention_data data = {};
-	struct lock_stat *st;
+	struct lock_stat *st = NULL;
 	struct machine *machine = con->machine;
-	u64 stack_trace[con->max_stack];
+	u64 *stack_trace;
+	size_t stack_size = con->max_stack * sizeof(*stack_trace);
 
 	fd = bpf_map__fd(skel->maps.lock_stat);
 	stack = bpf_map__fd(skel->maps.stacks);
 
 	con->lost = skel->bss->lost;
 
+	stack_trace = zalloc(stack_size);
+	if (stack_trace == NULL)
+		return -1;
+
 	prev_key = 0;
 	while (!bpf_map_get_next_key(fd, &prev_key, &key)) {
 		struct map *kmap;
 		struct symbol *sym;
 		int idx = 0;
 
+		/* to handle errors in the loop body */
+		err = -1;
+
 		bpf_map_lookup_elem(fd, &key, &data);
 		st = zalloc(sizeof(*st));
 		if (st == NULL)
-			return -1;
+			break;
 
 		st->nr_contended = data.count;
 		st->wait_time_total = data.total_time;
@@ -163,25 +171,32 @@ int lock_contention_read(struct lock_contention *con)
 				st->name = strdup(sym->name);
 
 			if (ret < 0 || st->name == NULL)
-				return -1;
+				break;
 		} else if (asprintf(&st->name, "%#lx", (unsigned long)st->addr) < 0) {
-			free(st);
-			return -1;
+			break;
 		}
 
 		if (verbose) {
-			st->callstack = memdup(stack_trace, sizeof(stack_trace));
-			if (st->callstack == NULL) {
-				free(st);
-				return -1;
-			}
+			st->callstack = memdup(stack_trace, stack_size);
+			if (st->callstack == NULL)
+				break;
 		}
 
 		hlist_add_head(&st->hash_entry, con->result);
 		prev_key = key;
+
+		/* we're fine now, reset the values */
+		st = NULL;
+		err = 0;
 	}
 
-	return 0;
+	free(stack_trace);
+	if (st) {
+		free(st->name);
+		free(st);
+	}
+
+	return err;
 }
 
 int lock_contention_finish(void)
-- 
2.38.1.273.g43a17bfeac-goog

