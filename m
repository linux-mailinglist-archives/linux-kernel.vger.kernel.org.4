Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7838A6066FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJTR1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJTR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:27:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A71A9132;
        Thu, 20 Oct 2022 10:26:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso2806791pjn.0;
        Thu, 20 Oct 2022 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4HXp1K6cJN2Uvch9Zt2E9c0l3Bq0y7+eEz+/MYZtlw=;
        b=T3sM29kgnLfPvAoZlUtJdyFjX/xfem16+gUTDb/z1q8QdXRHrcxB/o8lttM99WnClB
         Tr9Zm8Majl9EDL5o/j5bYa8+RipiwiZgiDdTAKOtCMo0SKZPwkBs83ntd1WA0qYjfOhy
         A9LohDqY0/8KNsUEEfLRn/xzx4qKg1P5Ab1POUJdJ5Yu6FlSlFV9QGfn6OLB8U0jh9Td
         YvdIvDWsNujvFQ4i92v096f9ERevwpdnBeIE/2AoA2rJl6rFYzs1ktOCxNb9yeEzvgYi
         6NqfkZgFgcpAe4MMoH9KlpCPXUDdMaVQeSX3kuuOO8zYgBUZ0M12uK6fdZmzi96joGqx
         rsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P4HXp1K6cJN2Uvch9Zt2E9c0l3Bq0y7+eEz+/MYZtlw=;
        b=pOUazFphFz4hN62+Q6yAHyAfTSo15HhDL0w7bISQq6fr6cSqIO+AMSi/u1dgwN4/W/
         +CId2zh6OY0nkXDCHiFiG9/Aeiaw6e4eUAiCfHrjktwtnab8tNSWIod8S+2IAeh+KR8d
         Ji5smjZ4nEIVzsY2DZmuq1CBHAhzWFHfnIDN9VzPwk2ojmW4wUtHYTEcWxwd2uyg0ee7
         NELmEcRiNJilN5skPgwqdMkCtNtznJUNnCb5L+YHWrASaEJZd16Qs3i1G880SxhmYcjr
         YBOkuLNksvmS7KoPqpe+2KeFtERCnCyPHs8smqt4f/c/zQmiKIeqX8DP2gd283l8wb3f
         KLXA==
X-Gm-Message-State: ACrzQf0xOq3yaW/T+mXuTlZ5Gem+jmHDnuTrktBlT1k/eppFaBoUSzzl
        /nswsg2bK1EtmqvMI/+JpAGxsMnmvS8=
X-Google-Smtp-Source: AMsMyM5vfBFUCqhzBw4tJPGksdaIo7Njuuq8wJfCGOUmlOJ1jHHLr0fyzSs2VPh8cswqdPYxfBeOvw==
X-Received: by 2002:a17:902:f641:b0:17f:3633:5439 with SMTP id m1-20020a170902f64100b0017f36335439mr15072608plg.94.1666286812250;
        Thu, 20 Oct 2022 10:26:52 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017680faa1a8sm12951754ple.112.2022.10.20.10.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:26:51 -0700 (PDT)
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
Subject: [PATCH 5/8] perf test: Add system-wide mode in perf record tests
Date:   Thu, 20 Oct 2022 10:26:40 -0700
Message-Id: <20221020172643.3458767-6-namhyung@kernel.org>
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

Add system wide recording test with the same pattern.  It'd skip the
test when it failes to run perf record.  For system-wide mode, it needs
to avoid build-id collection and synthesis because the test only cares
about the test program and kernel would generates necessary events as
the process starts.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index d1640d1daf2e..345764afb745 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -154,10 +154,31 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
+test_system_wide() {
+  echo "Basic --system-wide mode test"
+  if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
+  then
+    echo "System-wide record [Skipped not supported]"
+    if [ $err -ne 1 ]
+    then
+      err=2
+    fi
+    return
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "System-wide record [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Basic --system-wide mode test [Success]"
+}
+
 build_test_program
 
 test_per_thread
 test_register_capture
+test_system_wide
 
 cleanup
 exit $err
-- 
2.38.0.135.g90850a2211-goog

