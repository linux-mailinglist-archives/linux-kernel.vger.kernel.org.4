Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44CA6C746E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCXATd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCXATb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B4193F7;
        Thu, 23 Mar 2023 17:19:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so77346pjz.1;
        Thu, 23 Mar 2023 17:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679617165; x=1682209165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=suA1jKhcCOcixXpCVcZ12id0ImQVSXHARQLzFn5G688=;
        b=K8yiMNIxCIwbaoE1vowESnH4hmdNOEIlQEDou+HVvhwgdL7eFWV0JyW5TQ89hgccGB
         whgyLfye3QllyjiS8MwJ4OyalsouO58WrU2EICYmFr1F/S8GZSMNt6a+BbWNsSc088QE
         2faYgpmsKgx57c7bAri/bWZ/u2V+WjJ45qL4m/DPjJ1a/YyX97neS5AMnSerBo6bswbJ
         Sfysmo08c9M/IsJ88ODIskzd+iQmB0HJ2U92auyyYB1Np/j0GKH6hrUChrH5YQcKAa5G
         SlmIezxPiNVmSnWeg8oNGggiGMsZLCMfOaNWxQEQiYFKhDYC0DPJUF9ypT38wAVp4uPc
         5ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679617165; x=1682209165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suA1jKhcCOcixXpCVcZ12id0ImQVSXHARQLzFn5G688=;
        b=mlXKMLh79i78wlbA7XtHW/ZIxo/fH1A6nHP2AapWaTm0RUo3yGQkgHMdOmPMDFIWJj
         DDCsDN+m7c1oVXR6MXrb29dP54hHalKRFrtZdYcXeTlHBADo/5vRcKqShVUiBrmRtTVE
         e5I+z2966ayfepk0i+XECb2xV3qywWqD/ajakfgHmB4FOriGNC9YD3Y7r80QoY2K/fUx
         yKq0C0Q4+bLVqTMxLXnYFY9U+zcCwdFPkLebqvY3aCGuOLH4KF4kF9qNlBVgFE+nelOc
         Ho3KFoqPLRuBzEIsGcNHH5YQi/2XdmzZHsv2FnneAuuc9FLObDykPq1W/nvi/+BBljVT
         bvkw==
X-Gm-Message-State: AAQBX9e/kVCJ/7NhYbmrQfh2KhmdO1ZH/UKT2Vhw57AMNMghqnxBp8Bk
        1xwm0QAfP72y8aonq6lJq3jIeMK/0iU=
X-Google-Smtp-Source: AKy350ZAajLtafXS2eumPKcAZTQWHAgGg4qFsVyTIdctzYlBvd9M6SM/mLwWVQMYikGr/MYnVYpf2g==
X-Received: by 2002:a17:903:32d1:b0:1a1:80ea:4352 with SMTP id i17-20020a17090332d100b001a180ea4352mr943126plr.0.1679617165387;
        Thu, 23 Mar 2023 17:19:25 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:77d1:5545:2244:c784])
        by smtp.gmail.com with ESMTPSA id m3-20020a63fd43000000b004facdf070d6sm12292278pgj.39.2023.03.23.17.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 17:19:24 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf lock contention: Fix msan issue in lock_contention_read()
Date:   Thu, 23 Mar 2023 17:19:22 -0700
Message-Id: <20230324001922.937634-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a report of a msan failure like below:

  $ sudo perf lock con -ab -- sleep 1
  ...
  ==224416==WARNING: MemorySanitizer: use-of-uninitialized-value
      #0 0x5651160d6c96 in lock_contention_read  util/bpf_lock_contention.c:290:8
      #1 0x565115f90870 in __cmd_contention  builtin-lock.c:1919:3
      #2 0x565115f90870 in cmd_lock  builtin-lock.c:2385:8
      #3 0x565115f03a83 in run_builtin  perf.c:330:11
      #4 0x565115f03756 in handle_internal_command  perf.c:384:8
      #5 0x565115f02d53 in run_argv  perf.c:428:2
      #6 0x565115f02d53 in main  perf.c:562:3
      #7 0x7f43553bc632 in __libc_start_main
      #8 0x565115e865a9 in _start

It was because the 'key' variable is not initialized.  Actually it'd be set
by bpf_map_get_next_key() but msan didn't seem to understand it.  Let's make
msan happy by initializing the variable.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 235fc7150545..5927bf0bd92b 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -249,7 +249,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack, err = 0;
-	struct contention_key *prev_key, key;
+	struct contention_key *prev_key, key = {};
 	struct contention_data data = {};
 	struct lock_stat *st = NULL;
 	struct machine *machine = con->machine;
-- 
2.40.0.348.gf938b09366-goog

