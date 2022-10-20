Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299336066FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJTR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJTR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:27:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03631B90DD;
        Thu, 20 Oct 2022 10:26:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so4183386pji.1;
        Thu, 20 Oct 2022 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbvlWwvCQIXli5FcQTv9AFEFHOhWzSEZm+yuuSXSI1Y=;
        b=cXqwaexVjlldcSmD9j/JF4WwT60IM8xZoK52mGka5Ar1EDuWUbFq1GNlz4zzWOWW9V
         kcWXD0mh9qajCcrhNFJGUeAfAEM0IIX4jNjZuVb3XSMKpPOtdXM0tWZcIdIrfORBfl1X
         L4ZH7yfoYogm1IkfvCXuNKODfsxyFNCSQr6/SBwqEAtzj6W8F6AHDQZyd6O++4hXjzAB
         ZNkYwgaO8JVss5ptCatN/yS8ClEloJTI0OeFjB92ExQ7ikmIno4llZ6p/fbCF05sGX0j
         jGnZcUemSPcaH/yuRI5ERe7CZ2kPI4m1D8v/8Hgxd1aPSjW+m9wfCcj6bpXgAIdTG8/y
         LHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dbvlWwvCQIXli5FcQTv9AFEFHOhWzSEZm+yuuSXSI1Y=;
        b=4NtJGA1Si0BH8yUzWkmuRx/akjkTw1mnr/fgWvGZVz651JKff9r3JC8gkLsbX/b6Tg
         n3Pn3jwtyF3rAJzvoNkTTdpEFaVRwEhvVhe7gVJoc9EFAl5JZl1TjjlG6k/A5aV2VBXN
         jPTOrcMYknyN4tQDoM6yUALf5terGM6m8Mz23ADpm0cqVdQWkRJeMz+q/SsYhh84iKOg
         CoY3hoL+nNXbK6aSvNF7vX2dhMko9L+uu8iUtmrQPeT1cPuvoIzir6XEuRs8jD9AFzuJ
         xUwRCAZ5GMoLfQ8KqdUxwWBKQXrlE5BwdPM8iWGMZ6KlbtycrzDSY83KOCvAqMCwhZN4
         /XGw==
X-Gm-Message-State: ACrzQf2PeWVwK+JSYqz9MtNWNbvtMe9Hy88oixiC44ne4LXYhd4YVfQo
        Gf1lEcSDl6jpcoPE6mpThMQ=
X-Google-Smtp-Source: AMsMyM6XU2T+Dev6JrjcPYiNxlxD0Qvn9a4Dxsa++kp+vtcROmXkuqGO6PefLX++oV7P1k/xPXM8iQ==
X-Received: by 2002:a17:90b:3949:b0:211:2cb7:d598 with SMTP id oe9-20020a17090b394900b002112cb7d598mr7037048pjb.73.1666286813303;
        Thu, 20 Oct 2022 10:26:53 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:52 -0700 (PDT)
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
Subject: [PATCH 6/8] perf test: Add target workload test in perf record tests
Date:   Thu, 20 Oct 2022 10:26:41 -0700
Message-Id: <20221020172643.3458767-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221020172643.3458767-1-namhyung@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a subtest which profiles the given workload on the command line.
As it's a minimal requirement, test should run ok so it doesn't skip
the test even if it failed to run the perf record.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 345764afb745..c59d1459c960 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -174,11 +174,29 @@ test_system_wide() {
   echo "Basic --system-wide mode test [Success]"
 }
 
+test_workload() {
+  echo "Basic target workload test"
+  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
+  then
+    echo "Workload record [Failed record]"
+    err=1
+    return
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "Workload record [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Basic target workload test [Success]"
+}
+
 build_test_program
 
 test_per_thread
 test_register_capture
 test_system_wide
+test_workload
 
 cleanup
 exit $err
-- 
2.38.0.135.g90850a2211-goog

