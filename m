Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFB070CB60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjEVUlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjEVUlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:41:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6753BF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:41:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso8229684276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788090; x=1687380090;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgLToyH0lnEbwO8zhqRrZrm3XuhDqU+MJzbkMRH5C7k=;
        b=K5zoWRcJdhHs4Vn8kI3E4+lDj7GTBugL3Ry0p9774ja90Sj0bOvmnfon6gLnZQPS87
         CLBBLKJX6uT9gNbXzYjCXkoR/Gk1a6A5XeQkK4k+hWThTK8AR4SnzfZf5tPJUF8HQrOx
         liqCS97QVPLwWlATh4pRcEDCGSXPYAlZ4XTm6aYYOj1rAVpca7T/6ckb6ozaeIWa6l+c
         Njg7fpDZV1H9/EgFG6SBzoTVhR4VdmIZwvRP2ES0W20TqYm6xugAXQ6bN1Xd4QgqhRWK
         8Z+5r5GAA+HQTVbMDwc1x/x1qKXkjiS3qDMYFQ4TFOoPBGKxV0BuFt7Cf7QWsyXyF70+
         JSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788090; x=1687380090;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgLToyH0lnEbwO8zhqRrZrm3XuhDqU+MJzbkMRH5C7k=;
        b=RWHK6EDuVkao8E+8/Aw0UM0vhpoVhQ8xBicGJxeLSt18V8R+mHZ3wPbfykuZfZJr1V
         R6wz2+u4CrXELDNYUjUXNV7KA/D9/F+2sEkCRn80iw3bl8C5wMWpbDfVHXy8ihaW6NWZ
         Fe/PdbbOYFIosKDjWVH/pcDHQdls+kkgeQQdF7guea+6GEPVGJvkUwfGRVK+40C84MDb
         MDPjSx/F+w8ZGmcGRWNj5oDe19kXpWFQj5HT7Z8bw+6CsnGvTtaLkUYviURtwR4Yg4ob
         /rFa5sUE8f27JwhZR0UfbCu1s+x9RJlSbn+H/gPtHMnlKtnPYUdOCeHLjtgsTSwf+S2j
         oLLg==
X-Gm-Message-State: AC+VfDznUq8PKXB0Hmynbh0B+FKZEHZTsGeQNW9Z1rYT6G/SmKOfbJCZ
        4m8xWWL292auNbxUCVIjLq6EWQdstUT/
X-Google-Smtp-Source: ACHHUZ5cGmZiaHup6R57O0NY+JxfLefgb7v1B8WJ6vcL6g3Tk820S7eQCuWHWQyEwjIocNOdCEtubtQ2RsgT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a5b:110:0:b0:ba7:5d7a:b50d with SMTP id
 16-20020a5b0110000000b00ba75d7ab50dmr7092496ybx.10.1684788090119; Mon, 22 May
 2023 13:41:30 -0700 (PDT)
Date:   Mon, 22 May 2023 13:40:46 -0700
In-Reply-To: <20230522204047.800543-1-irogers@google.com>
Message-Id: <20230522204047.800543-3-irogers@google.com>
Mime-Version: 1.0
References: <20230522204047.800543-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 2/3] perf bpf: Move the declaration of struct rq
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
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct rq is defined in vmlinux.h when the vmlinux.h is generated,
this causes a redefinition failure if it is declared in
lock_contention.bpf.c. Move the definition to vmlinux.h for
consistency with the generated version.

Fixes: 760ebc45746b ("perf lock contention: Add empty 'struct rq' to satisfy libbpf 'runqueue' type verification")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c |  2 --
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h     | 10 ++++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 1d48226ae75d..8d3cfbb3cc65 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -416,8 +416,6 @@ int contention_end(u64 *ctx)
 	return 0;
 }
 
-struct rq {};
-
 extern struct rq runqueues __ksym;
 
 struct rq___old {
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index c7ed51b0c1ef..ab84a6e1da5e 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -171,4 +171,14 @@ struct bpf_perf_event_data_kern {
 	struct perf_sample_data *data;
 	struct perf_event	*event;
 } __attribute__((preserve_access_index));
+
+/*
+ * If 'struct rq' isn't defined for lock_contention.bpf.c, for the sake of
+ * rq___old and rq___new, then the type for the 'runqueue' variable ends up
+ * being a forward declaration (BTF_KIND_FWD) while the kernel has it defined
+ * (BTF_KIND_STRUCT). The definition appears in vmlinux.h rather than
+ * lock_contention.bpf.c for consistency with a generated vmlinux.h.
+ */
+struct rq {};
+
 #endif // __VMLINUX_H
-- 
2.40.1.698.g37aff9b760-goog

