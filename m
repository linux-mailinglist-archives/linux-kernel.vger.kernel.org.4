Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA16D8FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjDFGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjDFGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:52:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B4A269
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:52:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54bf8af4063so33382057b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680763967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hz2UPK4m45H+1eNN7MZgSequAvZQRYw5qeG2C4U++jk=;
        b=JxgoYm9UaTnNWuZkXDXX1g4D5/7zh5yHMr4HPxAMthnTd8D5SBZzzwPDE+HfqEk058
         5wEGGsjfB4wrShPwguhXbZmGiFu4sFReXYGOI7bqs3H+wslYTM6G8/vlwibP589vhr2n
         xbyCz5xeyw/7ASmTNfLYcXjRTtWc7zuvrPrlBJ4xi4VnLLBFtKZqez8kVBsZi9hjFzTv
         Dpl6VmL6EgtW13Ki8uSWD3QHcnaTvisYMm7ZYID9MGlgDLHcadl774eOcyL7LViWtBiv
         V4dbwl4yK8QJavb0G7Tr2P/VEvuq2CBB1gw8j8vnGYqkVgR+AQoY+SU0BXTc++3M+mbp
         FHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hz2UPK4m45H+1eNN7MZgSequAvZQRYw5qeG2C4U++jk=;
        b=1bh7vykTSld50Y2ym8DCjwkXTwCzHlI9sGwwNVpkQ1rYdW882JKeXQVBXAaaz15GST
         jPHEkLzAYzA6yOPIV77upmSyT8UM8zG8bPXA6Ks2Cq+Rs/x5cd6pEMpS7bpY93qx7Qqn
         B0jnJqjWqfNXNmDRPIe5gHWAJtO4bELd5hEjKmd9KfVbuJ7+/SL0JaMf5y3fti2Q+r2Z
         migg1j6fUIxmjXgItOoJI1Esn0GMPaABDMWQCU9xvPhU7U5PMfDnJRnCD6LUA1ycoUvy
         dd/RUIM9/GCLPLBqkx+kwzaOmFN6qntebOGnycQn4059iDvtM+JG8YGzWJfpY3KVc9In
         97jA==
X-Gm-Message-State: AAQBX9fpQnOx9kBJ/KZbrsnEmTpDUtPMQuTp0mCz0wM0OCx8542Q08zQ
        1d1BhuHf2VeDAg/djfgu9yJ3+Y8WTDg4
X-Google-Smtp-Source: AKy350ZN+bpSdH/jgcCOg5dClBkm0s9eVVLb9BjDZSxUljOR/Wj0s8JlpiFEeW1BY9w/pUlxwP7EunrjT9MI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:713a:ed0b:3d14:a4da])
 (user=irogers job=sendgmr) by 2002:a05:6902:909:b0:a27:3ecc:ffe7 with SMTP id
 bu9-20020a056902090900b00a273eccffe7mr1473850ybb.3.1680763967198; Wed, 05 Apr
 2023 23:52:47 -0700 (PDT)
Date:   Wed,  5 Apr 2023 23:52:24 -0700
In-Reply-To: <20230406065224.2553640-1-irogers@google.com>
Message-Id: <20230406065224.2553640-2-irogers@google.com>
Mime-Version: 1.0
References: <20230406065224.2553640-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 2/2] perf pmu: Fix a few potential fd leaks
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
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure fd is closed on error paths.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 96ef317bac41..9eedbfc9e863 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -494,9 +494,13 @@ static int pmu_aliases_parse(int dirfd, struct list_head *head)
 			continue;
 
 		fd = openat(dirfd, name, O_RDONLY);
+		if (fd == -1) {
+			pr_debug("Cannot open %s\n", name);
+			continue;
+		}
 		file = fdopen(fd, "r");
 		if (!file) {
-			pr_debug("Cannot open %s\n", name);
+			close(fd);
 			continue;
 		}
 
@@ -1882,9 +1886,13 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 			continue;
 
 		fd = openat(caps_fd, name, O_RDONLY);
+		if (fd == -1)
+			continue;
 		file = fdopen(fd, "r");
-		if (!file)
+		if (!file) {
+			close(fd);
 			continue;
+		}
 
 		if (!fgets(value, sizeof(value), file) ||
 		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
-- 
2.40.0.348.gf938b09366-goog

