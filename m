Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB721741933
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjF1UCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjF1UBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:01:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE51FE7;
        Wed, 28 Jun 2023 13:01:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ed230c81so151873b3a.0;
        Wed, 28 Jun 2023 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687982509; x=1690574509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVELursx7ZDvBYQWp0incqgL1857WVtGQabwOfefQSc=;
        b=gN/lr8UbwiJrrDE/KxtTTHGo8Y4o30+B6GIfeY7nBFzojGAOptzHMWWBaICsjeydhJ
         uJ4On3ApMAVXjXLmYWNeCIY9dBzWUCUxmdbq+N8FgOEPi/cTuMHmBxn7fqrrkcpSLIeC
         /0aVTVoQQMcEDP9htZcY1zQBA5Y6kO6Kc+4T62CICo69fcZd1TGuFxJ8yHttMopBfJty
         TRXh/CQWSyFbUY8RSiYh2k2zk9yWpLEsPds0cUB/xa4KivQlnO95lIuAXZyh0YlULULn
         VJTT+JM1xqEyFkhBgjmuGvd+7BegufSJ5JQW9mIr82B0g8dRnNLOIXVuDKNbTcOwOX1K
         XmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982509; x=1690574509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVELursx7ZDvBYQWp0incqgL1857WVtGQabwOfefQSc=;
        b=lcPutIIZxIUUkr3zKNwLpHWI7AeckIOLv9w9qkQj0xn8Z+MgUS7lfjc5ZQV8R6NraF
         8C6o/H+0RF5CLcUCKzoTKH4zBcpDrPEoADGt5eKGrl2TrVhqY9W9aSdxz0XSTLt/KKMn
         scGIPXXx85vpsXp3geM/UUCUZNOBdU1x2GJQ5wv8uS58+Diq6Br8QWGMw6qRQztiAf4/
         ut99S5+uMKgYwjT/50CR22JFatOOhyCeYxRpKIJrH74yP6S2PmChMc0xoHjEhUj3fEJJ
         bGcun6p+KWQKnsleCeaYztqBJ8uQpS1e6VRJQKvaRVGE7X7Ebyf6uB7ubNSmsOvb33wR
         1cxg==
X-Gm-Message-State: AC+VfDxEfCLscvfZpm2kRGnz7WwnWkMeITe0zU0cs7tPlQuuYtn0hjoI
        RNTcRWmLZXdTDBoEwwo57Vj/lOi33VE=
X-Google-Smtp-Source: ACHHUZ593BLR6RNR8eoFC7C/7TumlbXFyDfhoijcz6m9Pw/s/2wogOCaZI0M05UiUMZUa5KJ+eS85A==
X-Received: by 2002:a05:6a00:1504:b0:668:7325:e184 with SMTP id q4-20020a056a00150400b006687325e184mr39037691pfu.16.1687982509139;
        Wed, 28 Jun 2023 13:01:49 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:fc6b:e50c:c8f0:b09b])
        by smtp.gmail.com with ESMTPSA id f3-20020aa78b03000000b0065e154bac6dsm7340376pfd.133.2023.06.28.13.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:01:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 4/4] perf test: Test perf lock contention CSV output
Date:   Wed, 28 Jun 2023 13:01:41 -0700
Message-ID: <20230628200141.2739587-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230628200141.2739587-1-namhyung@kernel.org>
References: <20230628200141.2739587-1-namhyung@kernel.org>
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

To verify CSV output, just check the number of separators (",") using
the tr and wc commands like this.

  grep -v "^#" ${result} | tr -d -c | wc -c

Now it expects 6 columns (and 5 separators) in the output, but it may
be changed later so count the field in the header first and compare it
to the actual output lines.

  $ cat ${result}
  # output: contended, total wait, max wait, avg wait, type, caller
  1, 28787, 28787, 28787, spinlock, raw_spin_rq_lock_nested+0x1b

The test looks like below now:

  $ sudo ./perf test -v contention
   86: kernel lock contention analysis test                            :
  --- start ---
  test child forked, pid 2705822
  Testing perf lock record and perf lock contention
  Testing perf lock contention --use-bpf
  Testing perf lock record and perf lock contention at the same time
  Testing perf lock contention --threads
  Testing perf lock contention --lock-addr
  Testing perf lock contention --type-filter (w/ spinlock)
  Testing perf lock contention --lock-filter (w/ tasklist_lock)
  Testing perf lock contention --callstack-filter (w/ unix_stream)
  Testing perf lock contention --callstack-filter with task aggregation
  Testing perf lock contention CSV output
  test child finished with 0
  ---- end ----
  kernel lock contention analysis test: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index f2cc187b6186..4a194420416e 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -233,6 +233,41 @@ test_aggr_task_stack_filter()
 	fi
 }
 
+test_csv_output()
+{
+	echo "Testing perf lock contention CSV output"
+	perf lock contention -i ${perfdata} -E 1 -x , --output ${result}
+	# count the number of commas in the header
+	# it should have 5: contended, total-wait, max-wait, avg-wait, type, caller
+	header=$(grep "# output:" ${result} | tr -d -c , | wc -c)
+	if [ "${header}" != "5" ]; then
+		echo "[Fail] Recorded result does not have enough output columns: ${header} != 5"
+		err=1
+		exit
+	fi
+	# count the number of commas in the output
+	output=$(grep -v "^#" ${result} | tr -d -c , | wc -c)
+	if [ "${header}" != "${output}" ]; then
+		echo "[Fail] Recorded result does not match the number of commas: ${header} != ${output}"
+		err=1
+		exit
+	fi
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		echo "[Skip] No BPF support"
+		return
+	fi
+
+	# the perf lock contention output goes to the stderr
+	perf lock con -a -b -E 1 -x , --output ${result} -- perf bench sched messaging > /dev/null 2>&1
+	output=$(grep -v "^#" ${result} | tr -d -c , | wc -c)
+	if [ "${header}" != "${output}" ]; then
+		echo "[Fail] BPF result does not match the number of commas: ${header} != ${output}"
+		err=1
+		exit
+	fi
+}
+
 check
 
 test_record
@@ -244,5 +279,6 @@ test_type_filter
 test_lock_filter
 test_stack_filter
 test_aggr_task_stack_filter
+test_csv_output
 
 exit ${err}
-- 
2.41.0.255.g8b1d071c50-goog

