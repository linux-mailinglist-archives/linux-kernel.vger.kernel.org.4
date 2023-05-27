Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB3B7132B2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjE0Fza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 01:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjE0Fz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 01:55:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E64116
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 22:55:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a33c35f6so20018217b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 22:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685166926; x=1687758926;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QXQxaED4vp6H14Psblq6TQZfsUPt84iSNNTs5r5nIVk=;
        b=OEDp5myjnZeIgIl+eYSLbYatcxAxQpyiOtdmgkZg6uAStnx0PVtD+ICPFf1FV9osSw
         uH2j1iaWKIkDplA/fZ9UjmqXves9T0v8NSv6GkvUwl4sGhOTNa/oFhWuhqwsBzxLWD3z
         K4f7RRR/RCp9TOujLTd0QD2xScpb13H2oBNpj1aEJ48YwG08ezp5/UjL5tWzZcxOScrF
         d6MrjsOTn3aFsE0kao1GpSljB6GRXYIztusfsNiAzq0eCaOVqz4TVCyWm8Bv5QyGEQcn
         WjpM8QNwJauKgn8hOSmfkwFHYMkq5mpkoKzmtvBAOLMFeDGIHDgCCtiObw8BnJ+6R1Iq
         R/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685166926; x=1687758926;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXQxaED4vp6H14Psblq6TQZfsUPt84iSNNTs5r5nIVk=;
        b=N9y8zSSykKP0crOpypNX1jdcxQAjynYdKZOzz2dHw4rd8BopWg+xyHQOGOI390VrKk
         ik03ZOnO3QUadVPByRoijOu4H/+Tig3YWjoy2mmGHPPO0VEx3/VYEiFK6mjNEmQEwV1f
         XS+ZC4cCfMOaSIayQYuOzbHDjlKdaLCHR3xfP/aukdP+xkeqjyUBPyQat7/DH/Nu8nYA
         P4rWbvhbADSA43UbS96MTfRGXl8q7bQ7N67zljAuJPr8GPQLMZ+17Ar3aDWdiSVyzvdz
         BiyB9wQBgGpnhR04WLdUlIkot7FW+2oA1WzxvBSTxB9iXfW9qxdluFqFCKhc0SS//s3O
         Gm9w==
X-Gm-Message-State: AC+VfDxaj6ngrYS0KujJZF9oKtAczh6PK46qsaoitJptThiQeuZCVcnd
        06o6BoDahNFyjI+2/Eue9A/VfRabJ7F5
X-Google-Smtp-Source: ACHHUZ7Z2jZnaomLhv+CmPE/K5wVWznhPumiRtXyxfDPzjZ3Y4WJYmBxpEgtlp1KVvEaTkiQTR8rt68upOPP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:ad83:0:b0:ba9:9a4f:a40 with SMTP id
 z3-20020a25ad83000000b00ba99a4f0a40mr2202137ybi.13.1685166926450; Fri, 26 May
 2023 22:55:26 -0700 (PDT)
Date:   Fri, 26 May 2023 22:55:17 -0700
Message-Id: <20230527055517.2711487-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1] perf test python: Put perf python at start of sys.path
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

This avoids picking up a system installed version of the perf python module.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/python-use.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 6b990ee38575..0ebc22ac8d5b 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -14,7 +14,7 @@ static int test__python_use(struct test_suite *test __maybe_unused, int subtest
 	char *cmd;
 	int ret;
 
-	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
+	if (asprintf(&cmd, "echo \"import sys ; sys.path.insert(0, '%s'); import perf\" | %s %s",
 		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
 		return -1;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

