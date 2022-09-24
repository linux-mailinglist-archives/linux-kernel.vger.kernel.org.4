Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187D35E86CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIXAmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiIXAm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:42:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF83D115BCC;
        Fri, 23 Sep 2022 17:42:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm5so1526736plb.13;
        Fri, 23 Sep 2022 17:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=nsTuKY7W4PY53LlO1HXB0XbCZ8PJy5sf3lmL8N0J30g=;
        b=nhVl3BIrKBOJYJuLzSM7AeliCsGuqV3cZiOyh3Ggtm6jHMriiA+42Klv4Gi+vhDZIX
         KWvuhYpH3/na5nk3p9htonaM+diUKqA5NloBD8gYPsaGjMkf8WDRnmpm6vfO9gDABbz2
         cCdSqtOZFpoH+luUsCSbLU/Z8WCObuIawhYQOqugpGTWvBJSJdldbvcv9KBP6hoFQoVn
         Clo8fxC+GAjmq9GNVnAGPmAS1BLC0/idKLul5T5LwjoWvIz4slduKcTAF9q7L6qIumo3
         yg5VIksiLxQl65i4sfOnXeLcjSRtPgrk+ilRbCpYBnKn96xR4ly4Xcrpp9yd2SUWIjh6
         6PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=nsTuKY7W4PY53LlO1HXB0XbCZ8PJy5sf3lmL8N0J30g=;
        b=bvLn2G+sQENzxOUqx7/hxGELEZ9+4hnffHgcz0zypuNQtm29xdWdSw2DCWGETCoRvv
         QIb+8oskPbf+xBfoEufniY4fq1sPpNBR7miwSoghaujYosrxPn38823xYA4F9ugIEgSX
         Qs4qbdnLuQ9+8qMuT1Ua421q0JQj66fTvgiUHgUgvBLRiE48mygHAvJCdLAqg410wb7y
         anAGHimQuWPNzipDZQUJMYnNvSKGwwF/LkWmDuJFWDlKDo9LH9aW+04RMmAWKc7VlE33
         6ujSDB7jELAqcB9Tg3dnyc1uohda+EHdghHEJN1qT4o5vWtX0hXqteqqTGZB1l6L2znG
         ImiQ==
X-Gm-Message-State: ACrzQf2w1NuLvK3RONqtHf3Osd/R74zm6VG0cV/d4WbT5xWrp5t0348Z
        4O+8qJ8hYEZlK6MBCKkULEI=
X-Google-Smtp-Source: AMsMyM5hKURUKXXsenYOl0Idh82XT7fllNvMpBg42nbj1F9Tg/UwQf7y9b+h0mHgRtt8tVStcvsxDg==
X-Received: by 2002:a17:902:e808:b0:178:1520:b255 with SMTP id u8-20020a170902e80800b001781520b255mr10963314plg.54.1663980147164;
        Fri, 23 Sep 2022 17:42:27 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:9987:f0b9:ad5:1fe7])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b00176acc23a73sm6639516plx.281.2022.09.23.17.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 17:42:26 -0700 (PDT)
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
Subject: [PATCH 3/3] perf test: Add kernel lock contention test
Date:   Fri, 23 Sep 2022 17:42:21 -0700
Message-Id: <20220924004221.841024-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220924004221.841024-1-namhyung@kernel.org>
References: <20220924004221.841024-1-namhyung@kernel.org>
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

Add a new shell test to check if both normal perf lock record +
contention and BPF (with -b) option are working.  Use perf bench
sched messaging as a workload since it'd create some contention for
sending and receiving messages.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100755 tools/perf/tests/shell/lock_contention.sh

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
new file mode 100755
index 000000000000..04bf604e3c6f
--- /dev/null
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+# kernel lock contention analysis test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+result=$(mktemp /tmp/__perf_test.result.XXXXX)
+
+cleanup() {
+	rm -f ${perfdata}
+	rm -f ${result}
+	trap - exit term int
+}
+
+trap_cleanup() {
+	cleanup
+	exit ${err}
+}
+trap trap_cleanup exit term int
+
+check() {
+	if [ `id -u` != 0 ]; then
+		echo "[Skip] No root permission"
+		err=2
+		exit
+	fi
+
+	if ! perf list | grep -q lock:contention_begin; then
+		echo "[Skip] No lock contention tracepoints"
+		err=2
+		exit
+	fi
+}
+
+test_record()
+{
+	echo "Testing perf lock record and perf lock contention"
+	perf lock record -o ${perfdata} -- perf bench sched messaging > /dev/null 2>&1
+	# the output goes to the stderr and we expect only 1 output (-E 1)
+	perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] Recorded result count is not 1:" $(cat "${result}" | wc -l)
+		err=1
+		exit
+	fi
+}
+
+test_bpf()
+{
+	echo "Testing perf lock contention --use-bpf"
+
+	if ! perf lock con -b true > /dev/null 2>&1 ; then
+		echo "[Skip] No BPF support"
+		exit
+	fi
+
+	# the perf lock contention output goes to the stderr
+	perf lock con -a -b -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	if [ $(cat "${result}" | wc -l) != "1" ]; then
+		echo "[Fail] BPF result count is not 1:" $(cat "${result}" | wc -l)
+		err=1
+		exit
+	fi
+}
+
+check
+
+test_record
+test_bpf
+
+exit ${err}
-- 
2.37.3.998.g577e59143f-goog

