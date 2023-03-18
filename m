Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8316BF6DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjCRAWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRAWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:22:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF4D5882;
        Fri, 17 Mar 2023 17:22:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13so7056382pjh.0;
        Fri, 17 Mar 2023 17:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679098941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4yU+Z21I1n6ZTEcdAUJLZP5nCp1KnymrYky69QflvpE=;
        b=UoRNMmWc3dTcvEUmRLVoYCCnpI7jyl3RWmla3Sm8tZ0TgYtW6yjUf6XFv6EE3uM6Ix
         6GmdcplsrfFRcjx6VmEXx2OMZWi4FkOnP7SYijKtD6lfjlzTkjrAGE12jNdP0z7cSVJi
         o07GNTSotKd4CUC5GDRK8Ct2JIsOyOHMV4oLhyvdhv9+tOwI6kvULU015Ga/6qSkgijG
         qwk1e5rDwr4FAWzFg/bVtNNtvpsKwwVLUqJBTijbV5uKA0Ub5M1/60xnyoSi+zJCGLH0
         1SQVjQnpAk+QuiSqv66jQQTQm3FpWGylgMGwQW00nDo42zPLxJdppXENPXnVa4Kzb1f8
         pI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679098941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yU+Z21I1n6ZTEcdAUJLZP5nCp1KnymrYky69QflvpE=;
        b=WOAVhYSFbaT6UT+coyTGcFmXpOe54T9hFP/8QZa1Eaa2zTd5kgBJhdcs6Q0vk2ShJe
         6LHx2QbmC8hR6zZMrpUhec+eLSdzwsWiQbIZlCakpfMsHk8h51lQBtGBiNl5ReN9nzDF
         FnTwKn8SYxBRDZZMnVQkvJwA6AmiauU3L/4AOvMuKG/gjTrS/bFKAPojPs3KbLg+nCzu
         56Uw4G6ecAmxyLaDAZeLFkjr0v6Gdtu4cQBBmtwup9Ud/VCBKSbIIcysME6XoV6NsFZz
         HniXz8Z8RqYFv74dD3eSpzjw7rvxBP3HKUC3GDu9s2InToxYj9tcNHSSzdeiDLUT4Mba
         VIyg==
X-Gm-Message-State: AO0yUKWJ0+c+X3f1AUkfP1bXGezngzWKGqVZasQgFUbgbmmCB6pIp3Xp
        cKIQzSXwezRwrPummk9akbw=
X-Google-Smtp-Source: AK7set+KZPeJd6aNgYNo+BP1h4HTqppNCdeOA7X1jHxCgQChP0A5/yxBObMoVhZBji9oLqrScAkL3A==
X-Received: by 2002:a05:6a20:4c1f:b0:d4:e6f:1ee2 with SMTP id fm31-20020a056a204c1f00b000d40e6f1ee2mr8084470pzb.56.1679098940561;
        Fri, 17 Mar 2023 17:22:20 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:44b0:d54a:f8f3:872:5c2e])
        by smtp.gmail.com with ESMTPSA id d10-20020a634f0a000000b0050f56964426sm137975pgb.54.2023.03.17.17.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 17:22:20 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf bpf filter: Add an error message for BPF filter
Date:   Fri, 17 Mar 2023 17:22:18 -0700
Message-Id: <20230318002218.2035109-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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

Currently there's no error message for filter (other than the help for
the option) when it's built with NO_BPF_SKEL=1.  It should show the
BPF filter is not supported like below:

  $ sudo ./perf record -e cycles --filter ip==1 true
  BPF filter is not supported        <------------------- added

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

          --filter <filter>
                            event filter

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6c5cf5244486..f1fa469712c4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2543,8 +2543,16 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
 
-	if (!nr_addr_filters)
-		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
+	if (!nr_addr_filters) {
+		int ret = perf_bpf_filter__parse(&evsel->bpf_filters, str);
+
+		if (ret == -EOPNOTSUPP)
+			fprintf(stderr, "BPF filter is not supported\n");
+		else if (ret)
+			fprintf(stderr, "failed to set the BPF filter\n");
+
+		return ret;
+	}
 
 	if (evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
-- 
2.40.0.rc1.284.g88254d51c5-goog

