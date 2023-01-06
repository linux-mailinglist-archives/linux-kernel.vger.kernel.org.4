Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B36602D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjAFPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjAFPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:13:34 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87671809BA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:13:33 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c11ae6ab25so20824177b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WQYhbBO5EgEKPlarlDf3lbw8Z+u809vOBp5gbzOXfWg=;
        b=ZglYSagXvvcpZ/nsgRjuPaZDjdPN8PQgxIP65++2BPx/oEUTNGiJ6AoAHFhWjzunNj
         z0Wh2NzigVLGZE5V70sHsDkSHRIlbX04YSsFY4kZj+VKrKXUSKQU/IHyWYpeZ4h6s+LM
         HuFMdrRs+7Os/tAO0gnglPLlsTOnUvsLWM2eD5F3eYPeJZTBYEIeitL6HpEE9KDqjSpQ
         fHJLpcogYbfis5/hdrejzsvN++vqkalAmAZWn3OYTiEmPV1uKdzaXwfIs9Cwkqa4oU3m
         vJ6baOqAhLGcADA5RNODdFXe/HvYbRrf2AfZG0Xg+OxM7u0cMNGAGrzoIYzm23eopTfF
         RLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQYhbBO5EgEKPlarlDf3lbw8Z+u809vOBp5gbzOXfWg=;
        b=2vNDX4dst3HGe71ZArnun7ZRnQJh5hav4USi7McdjUrQKPGekxESUdNbWaBJQiJx5Y
         vIhmbvBxL1BsU4ugaAxBuP03srEAsHCAPJFDprJie1In6pzyp6wv3MN7O+oVO5ak+7Rv
         xJ/MbhWF4JOXY9GIeFUToV+1mN0h+pYsyv1qDTfc/Fp4TJXmR6SMqmEC66JSFPoNcmXF
         xrZRCbZ32wQZgsuNu30yfMWxK4YkBKqceBNpyiKfry2mnG+3wFYlLbMGMxxzMPHBbAg/
         EjoisngqqwKIzGzs8PKkpOqevrG+etRqsikqbrT2uiYxvmhf50VE6jh2lBFoC60kM4Fp
         Arcg==
X-Gm-Message-State: AFqh2kowwdKb6MOS638TxF/cVvbwds+4N65tqnlm/N6vMkZchu04OnZY
        78QSi2C5toRLiZ7IdLRZrBiAaiYQrAk/
X-Google-Smtp-Source: AMrXdXv4uHiZIJSyj4+N+cNmODTWl//P88+WIKFyg84i0Dqs6IfbUibr86rm2sJOmfCfZgkb0LKGk2RcYAU8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b317:a30:653a:18e5])
 (user=irogers job=sendgmr) by 2002:a0d:cbd5:0:b0:469:d2b9:d8e8 with SMTP id
 n204-20020a0dcbd5000000b00469d2b9d8e8mr5538863ywd.177.1673018012862; Fri, 06
 Jan 2023 07:13:32 -0800 (PST)
Date:   Fri,  6 Jan 2023 07:13:19 -0800
Message-Id: <20230106151320.619514-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v3 1/2] perf build: Properly guard libbpf includes
From:   Ian Rogers <irogers@google.com>
To:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including libbpf header files should be guarded by
HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
under HAVE_BPF_SKEL.

Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c    | 2 ++
 tools/perf/util/bpf_counter.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 86e06f136f40..d21fe0f32a6d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -16,7 +16,9 @@
 
 #include "util/record.h"
 #include <api/fs/tracing_path.h>
+#ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
+#endif
 #include "util/bpf_map.h"
 #include "util/rlimit.h"
 #include "builtin.h"
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index 4dbf26408b69..c6d21c07b14c 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -4,9 +4,12 @@
 
 #include <linux/list.h>
 #include <sys/resource.h>
+
+#ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#endif
 
 struct evsel;
 struct target;
@@ -87,6 +90,8 @@ static inline void set_max_rlimit(void)
 	setrlimit(RLIMIT_MEMLOCK, &rinf);
 }
 
+#ifdef HAVE_BPF_SKEL
+
 static inline __u32 bpf_link_get_id(int fd)
 {
 	struct bpf_link_info link_info = { .id = 0, };
@@ -127,5 +132,6 @@ static inline int bperf_trigger_reading(int prog_fd, int cpu)
 
 	return bpf_prog_test_run_opts(prog_fd, &opts);
 }
+#endif /* HAVE_BPF_SKEL */
 
 #endif /* __PERF_BPF_COUNTER_H */
-- 
2.39.0.314.g84b9a713c41-goog

