Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E67739694
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjFVFBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFVFBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:01:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D1D198B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:01:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5732d86d932so6192267b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687410080; x=1690002080;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iwkvo3drwBmCh3irzLZqUQdw68f0F8NzA1rA0HnILRE=;
        b=zaZl9DCNtcP6svk/wI5eStzXTHQciXwiZSVitJsx8zfw/LvHcUcq209/c/SA4v73mP
         zcE1AkwIb3XjVt/3scpYaDBPbdEMDMlDNY0iTx9tcctm4vcceaaHYRuJ/0PrPrViAUcj
         ShwinelMgXO0LAY9rHTqMpl+ImtsrycwSftaxNeznHJGd+koILLNEKslOYDyAko1S9ws
         Vh/Xt/2/WJQU7scGUa63nHgcQCwcWaKPk9wFgwQVGQAaDkyUOXwxx+XbHryv44cVIyr+
         2f54gonBeorCAsDrqfrtDGwN/dl8N78ictJP59xPn6/wmbF1sBOf/akDUOZZCne68e3f
         sv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410080; x=1690002080;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iwkvo3drwBmCh3irzLZqUQdw68f0F8NzA1rA0HnILRE=;
        b=MepyoCzqN90LbzrEWNNFTqrtSY0QQQeI4Hk4ixgMtmnA6SYmbEmLOyLJUt3fAxAX0l
         gdVcXstlcWa3jVzFscFBYVYBF3lcgoWW3qgeE/08zgUrt71aW46Du1ZxSVXc/r8wI6u5
         7R02Qae/2JXTNhvUvECB0kfsIOMgssr/jym2t5SAZj5HemCQk0kJZ4vvk247gfnNR0cN
         z/fP28NFfges4VALLaZ8iH8dmw79PDA1ftdKL/6jkAtcl0FaFhw/r3miq97Dms2oykzB
         b2/WtindvOp47uW1rvHMXY/3ZjvrhI+LMGta43MDmnurDm73mG7RI60ovgRH/RFGFGQ/
         Wk5A==
X-Gm-Message-State: AC+VfDzDRxd8Ges6N9vcSwYof3hM1qvn0sAkTYfrXq1Wg41YZRr9/19t
        1ODK084PhQeTIa6kNy1Lb2gnZx9y+Bim
X-Google-Smtp-Source: ACHHUZ6V42Ju8DgyqLJJ/41hsH9tR7ZTZd0Vw6T1aay7/Xp8KL5Voyhfc5kxAIJ9bAjPKeZw7d81BC/lSW+i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91f3:1da5:6427:50d6])
 (user=irogers job=sendgmr) by 2002:a25:238e:0:b0:c01:e0f8:5ae with SMTP id
 j136-20020a25238e000000b00c01e0f805aemr413447ybj.4.1687410079873; Wed, 21 Jun
 2023 22:01:19 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:01:16 -0700
Message-Id: <20230622050116.3732814-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 1/3] perf unwind: Fix map reference counts
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

