Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BF373AD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFVXyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFVXyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:54:03 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533019F;
        Thu, 22 Jun 2023 16:54:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b52864b701so15725ad.3;
        Thu, 22 Jun 2023 16:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687478042; x=1690070042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io3AJeKq6FmEhdV8SAj8XJ3JVE9gFrrCwn+UOXWBK/A=;
        b=GR2L1ysMsiysuEz3pc8fhlncjYQeOkU2R6+iV7sHvyAT5SZ0E4J/Bzb4IaU6ACfPl6
         Rk9Z4Ir7ka41o93+68lWadX8OPV0FStME4g8atdNzCfFsb4KtruEqCTGAnc3MR2mxdZT
         nOty44h6GcnfigeHRdN0JbEC+Si6oqdYK5eQnaGTEBt36K4UYwKaTwy2IwH5ztp18ivx
         2QYMwDps7AAvds1s85Wqz99nBAHgNssymUyL9BrBNCW8TOt+7LwQJhdxj3Bko+1mGhzt
         3l89wGzJA1SOPFbQvgbQPH30M7HiMGSng/Yx6RwMNfx9VG/RLhRqJHJ+0gSMqyMFlGD6
         pSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687478042; x=1690070042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Io3AJeKq6FmEhdV8SAj8XJ3JVE9gFrrCwn+UOXWBK/A=;
        b=iM8TY7/pg5uV1JQ/hgMHeYuAkPM3nwVypjg0N7srQ72l2NAsKSiRF/vOtn/HWKqo/7
         B3thwGx+ODVMs82FNlZVSWEPnvMFhpuhuXQzjxCaTW89N4O2/n4a0ocC8gaoHX55zz5Z
         YVnMLAqrHoC43QT62qKFrPW1ij+oGOlU90dcL2lXMG8aLbFHhVDpamvwTv1LnKC6/7n3
         I6KoWmadyz6irWyukd3MzJuRuWHpvuu5rrfqAhZioNItgp7uuherFMBjG0+/o+iJ04Yn
         VyxR74dpuoxiYMS2lFwVkEeqHvjr7cKYK2GD9hPObW0zDtRF9KU8nLYjPb3bSvUSzPYm
         cfeA==
X-Gm-Message-State: AC+VfDwNJ0Lzyd0FsrmU1d2uMvHK2WLMebXwSgEP603Pw68iHq9jrsde
        i01fnR5ufe5UOWqRPZw+TRI=
X-Google-Smtp-Source: ACHHUZ5WXtGXq+rLo2IIRs7WnszUPjcXHr1bnTMhKdnEIDQSp3as5G2sTtxN11xTu796xiQ6dG6L0A==
X-Received: by 2002:a17:902:eccd:b0:1b5:561a:5c88 with SMTP id a13-20020a170902eccd00b001b5561a5c88mr18212230plh.66.1687478041939;
        Thu, 22 Jun 2023 16:54:01 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ad24:b28c:6f03:5b78])
        by smtp.gmail.com with ESMTPSA id ij26-20020a170902ab5a00b001ab12ccc2a7sm5960656plb.98.2023.06.22.16.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 16:54:01 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Aditya Gupta <adityag@linux.ibm.com>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>
Subject: [PATCH 2/2] perf test: Set PERF_EXEC_PATH for script execution
Date:   Thu, 22 Jun 2023 16:53:57 -0700
Message-ID: <20230622235357.225190-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230622235357.225190-1-namhyung@kernel.org>
References: <20230622235357.225190-1-namhyung@kernel.org>
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

The task-analyzer.py script (actually every other scripts too) requires
PERF_EXEC_PATH env to find dependent libraries and scripts. For scripts
test to run correctly, it needs to set PERF_EXEC_PATH to the perf tool
source directory.

Instead of blindly update the env, let's check the directory structure
to make sure it points to the correct location.

Fixes: e8478b84d6ba ("perf test: add new task-analyzer tests")
Cc: Petar Gligoric <petar.gligoric@rohde-schwarz.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index 59785dfc11f8..0095abbe20ca 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -5,6 +5,12 @@
 tmpdir=$(mktemp -d /tmp/perf-script-task-analyzer-XXXXX)
 err=0
 
+# set PERF_EXEC_PATH to find scripts in the source directory
+perfdir=$(dirname "$0")/../..
+if [ -e "$perfdir/scripts/python/Perf-Trace-Util" ]; then
+  export PERF_EXEC_PATH=$perfdir
+fi
+
 cleanup() {
   rm -f perf.data
   rm -f perf.data.old
-- 
2.41.0.162.gfafddb0af9-goog

