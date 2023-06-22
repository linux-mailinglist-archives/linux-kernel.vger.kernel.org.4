Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD707396B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjFVFLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFVFKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:10:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4DF1BCB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:10:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704995f964so82246727b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687410632; x=1690002632;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iwkvo3drwBmCh3irzLZqUQdw68f0F8NzA1rA0HnILRE=;
        b=DhKdtVPrmYHxiqjIKCbVGRxMjbXrvSQn+TCrG60I5aPx7c7YMFttQxbOAnjuiNvSKt
         ZBZ64IyZ6mpIB4RKj4p4a89tn8PJjxXPagqSybROjPUgGS0esLOwOEWVfi3U41BZrUKg
         Pr0ZYPWUaLrEeNgzVXC6UNOtI8+cFJKyDveKgVvWtzn4RxbD+CF1FbKnoaa58+ROWh5L
         InT4O4Bzo/yyWR3xkWxHPIoW/V3Jthf6X6MVMpCrFl8rTr/mtKpGB1bQvA7GIbYr1b8q
         B6eVEqekcxhU4dSVNyP3JbV8XRuhEhyfgwc6OEFURVr9h49gl+/Bh0Peos6QsbUGeJbs
         ov5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410632; x=1690002632;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iwkvo3drwBmCh3irzLZqUQdw68f0F8NzA1rA0HnILRE=;
        b=Zuc18KZI2bLpkfz5bIJnGm0Sa3E3VaawF+2vspQ36xAYAJig7SqHno1kyy0B31Cpaw
         W8I+6zVOlZc+nqTZIShmASirqDSK9xr8skIEVdpo3WpQdczD0dVKNeLAjhqbS8dbpUUg
         vZ50nhmaG9BNBbgkdSqQy7uSbnTNO3JCfaCCFVx7E2zyJdrskMggrPgKKVOVsYRWvI9W
         FC60FoprEtALXG4LkCkd5wluhAwAlHAQA2lPCuJdYyI+eykRZniLMU0kPO+0JFlvpmJ+
         fTokVPV+q9IZwKgfzFScbfjvIWGb57mrkfgPgtdF0BcnE0KNHuSee8j3ImbboS5Wk8T2
         arnQ==
X-Gm-Message-State: AC+VfDzXHxWFW+Z3apalqGpxtXrF4NDY4nnVrMkdFYLTpy3wasfe975N
        8huYjxEuNdjKt0u1m9EHIT4e4aUCpfMc
X-Google-Smtp-Source: ACHHUZ5T7atXtGkQMSxCdZ4xuhdT4/Ifw+IX69REESlIEt/eN1LK8ciV7SNPoINgMMdPTtphocXQrxUgq6WM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91f3:1da5:6427:50d6])
 (user=irogers job=sendgmr) by 2002:a05:690c:70e:b0:573:4ed9:c69a with SMTP id
 bs14-20020a05690c070e00b005734ed9c69amr3818009ywb.10.1687410632774; Wed, 21
 Jun 2023 22:10:32 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:10:29 -0700
Message-Id: <20230622051029.3733815-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 1/1] perf unwind: Fix map reference counts
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of thread__find_map is the map in the passed in
addr_location. Calling addr_location__exit puts that map and so copies
need to do a map__get. Add in the corresponding map__puts.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libunwind-local.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 36bf5100bad2..9cb82d7c7dc7 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -419,7 +419,8 @@ static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
 	struct map *ret;
 
 	addr_location__init(&al);
-	ret = thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	ret = map__get(al.map);
 	addr_location__exit(&al);
 	return ret;
 }
@@ -476,11 +477,11 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 
 		memset(&di, 0, sizeof(di));
 		if (dwarf_find_debug_frame(0, &di, ip, base, symfile, start, map__end(map)))
-			return dwarf_search_unwind_table(as, ip, &di, pi,
-							 need_unwind_info, arg);
+			ret = dwarf_search_unwind_table(as, ip, &di, pi,
+							need_unwind_info, arg);
 	}
 #endif
-
+	map__put(map);
 	return ret;
 }
 
@@ -539,7 +540,7 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
 
 	size = dso__data_read_addr(dso, map, ui->machine,
 				   addr, (u8 *) data, sizeof(*data));
-
+	map__put(map);
 	return !(size == sizeof(*data));
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

