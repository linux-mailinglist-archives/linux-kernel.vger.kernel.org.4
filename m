Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C670FFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjEXVGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXVGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:06:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F6191;
        Wed, 24 May 2023 14:06:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so749253a12.0;
        Wed, 24 May 2023 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684962364; x=1687554364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DvpEdbo9D8eOCupgJdY5TOmPtHK0qONBFxkN7MU8U54=;
        b=OmFeoysniEmDOVLFTnSjviPsyEGrlwzRNwOWEeXOw4xv6KGAiC+ir8i0HOhuEDYmYg
         KbuwYql0xMKH1y3RvMO9DmLcjKXdoqhxJ10qgK511fCCaODrZraYjN7KnAvl7i1/D7um
         T0eUQWaB+qTLxel6VKAngFL+EL4hEbnbaTZptflUTzYhzJ6YIM8ktH15ubu4+AUvQZmO
         7UOhcpn46W7GyNWqi6Vl6HpYgux3fwA/6qkvwNpXqNyStEDLn2QBSXMBS9+FzgozIhD8
         zVA14yR/npyOgCnRN6yigcc6gwLW5JkdNKZdMoq22eaBZaHfL/TJyD/v4A7GXWSgOVxb
         Sf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684962364; x=1687554364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvpEdbo9D8eOCupgJdY5TOmPtHK0qONBFxkN7MU8U54=;
        b=e/AmHB9EaWrREGqXEu6SyHHmQnqX7VchjYKyCbowGojg56z7sNH0AiX061ybghTpvO
         FOWLoBMl4AOAZKpm5NdwjneXBGOmoOEfBOF5GJupHQrAoc3a2w4sV1FfwT4tA3NVGwOE
         KmYVcfT9Dyd6zMUBcmR3ljsyV5Y3perMIz8Wf1zf7EZ4vNxkLTmq2/T4t2Wj1y99y7jv
         ZLo89Ru58EHiBxsScBUMxB5iJa8ZJcIdxY5MY5Jj5hq6emDUnnA8zrAt4GD7bCqax8QF
         FGQiVV+IMKdjKOv0O99Wxo+XHfsWbWX1Bj2kkwem+7dWxJquUAn0F/b+aoeagD/ktUc3
         LdIg==
X-Gm-Message-State: AC+VfDyZAD6re7FM4HVJKU2PTPeDRdVmD1qHhEvlXucR9eszL5Ri7b50
        XsQA3sqhNsipu+xJ4IC7txQ=
X-Google-Smtp-Source: ACHHUZ6uLEiJsfUYRUT7ujTAZGflGDS8UhUpP6v5F5mtbI+s5v+fNAdekpSl6ZOVAMY3Q74NRufQfg==
X-Received: by 2002:a17:90b:3106:b0:253:3cfa:e310 with SMTP id gc6-20020a17090b310600b002533cfae310mr17570513pjb.19.1684962364082;
        Wed, 24 May 2023 14:06:04 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:121:f908:b42d:c399])
        by smtp.gmail.com with ESMTPSA id hi20-20020a17090b30d400b0024ffa911e2asm1726221pjb.51.2023.05.24.14.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 14:06:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH] perf test: Fix perf stat JSON output test
Date:   Wed, 24 May 2023 14:06:00 -0700
Message-ID: <20230524210600.3095830-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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

The recent --per-cache option test caused a problem.  According to
the option name, I think it should check args.per_cache instead of
args.per_cache_instance.

  $ sudo ./perf test -v 99
   99: perf stat JSON output linter                                    :
  --- start ---
  test child forked, pid 3086101
  Checking json output: no args [Success]
  Checking json output: system wide [Success]
  Checking json output: interval [Success]
  Checking json output: event [Success]
  Checking json output: per thread [Success]
  Checking json output: per node [Success]
  Checking json output: system wide no aggregation [Success]
  Checking json output: per core [Success]
  Checking json output: per cache_instance Test failed for input:
  ...
  Traceback (most recent call last):
    File "linux/tools/perf/tests/shell/lib/perf_json_output_lint.py", line 88, in <module>
      elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache_instance:
  AttributeError: 'Namespace' object has no attribute 'per_cache_instance'
  test child finished with -1
  ---- end ----
  perf stat JSON output linter: FAILED!

Fixes: bfce728db317 ("pert tests: Add tests for new "perf stat --per-cache" aggregation option")
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 4acaaed5560d..b81582a89d36 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -85,7 +85,7 @@ Lines = args.file.readlines()
     expected_items = 7
   elif args.interval or args.per_thread or args.system_wide_no_aggr:
     expected_items = 8
-  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache_instance:
+  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache:
     expected_items = 9
   else:
     # If no option is specified, don't check the number of items.
-- 
2.41.0.rc0.172.g3f132b7071-goog

