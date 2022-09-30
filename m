Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFE75F1391
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiI3UV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiI3UVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:21:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC81174BC5;
        Fri, 30 Sep 2022 13:21:30 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i6so5200122pfb.2;
        Fri, 30 Sep 2022 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=JhAk8jSmxMWkCEVM3knhsAVjv/gWnWdiuhVd0n4baOg=;
        b=MY2RdwI51+Vo3z3dMvtblPy2m5lc2LUYm26Ha9eKO3Ib496w/QOA3sPY8KToQIk+zp
         w93Obkl0gxh0ERhoCg4hB2y+q5uzWV5OXERrWqdYSs+v559nPrRgn2EnoCfTKpzC/OMk
         JRereyO/MANkfeAHe9ZTwbg/74iXDzMiXYthVXHoAYUKt8cThbtMVC4XvIxDQCNjSikd
         V7opWC38/Xvnv8SKNcnBjW7vxQy8EnsyixUVHntlbivu9CVDM5nzHZ6xg2ZgslCcuekS
         HvwIPBvocR39bIiiptUQ7bf5mw7CkUAswJzrVkFWU4ulY2UebTFzjwiIpoLim1yZ/1vo
         zDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=JhAk8jSmxMWkCEVM3knhsAVjv/gWnWdiuhVd0n4baOg=;
        b=ZL/uWDDlmHYT362JG29HgjeXihvXiLxH0vF0ET5+yWV79NFurznGB3GnYl5uZGlWg8
         PEilZMwhADYb4jO1iZueIIJSAXyckRIOYFz0FUT2XM1iK1Kz2FDyg4Gjx6m6JDfZJ6Gw
         PipHXjp1Eu20dwgNeRI5sRCWpdLrZqRuSaPnIhbziFlsYF23M0N1USC8IP1MdVxmO6mc
         NIoyZblrqXVoiNDONzbn5DVC+Xvrfdj0ShZWtC6CzKw6ByxlQKdbkn08JwECNKLVTBdW
         lZUUbK28Jj9Z1n/LUQXBZ+ebVSRR3GHER6a0v3t0qYESpyBI5QQZGOoJCeACkAXVwdSO
         LagQ==
X-Gm-Message-State: ACrzQf1sO6ZZGbkEAQE/Bpu94QmaWRj3CLc3KfjJxZe5AlhOZC7ezji8
        j7wO4vFrMicL4rlS55wj85w=
X-Google-Smtp-Source: AMsMyM5vJWAzdsu8Z1cOrmVbtnJYAGG+mwgJ9tz+7jWN3+D08kvpbOSP5bJmS5Ct0CUOVjgMCoQBNw==
X-Received: by 2002:a65:5688:0:b0:3c2:1015:988e with SMTP id v8-20020a655688000000b003c21015988emr9021900pgs.280.1664569289303;
        Fri, 30 Sep 2022 13:21:29 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id s10-20020a63e80a000000b0042fe1914e26sm2105540pgh.37.2022.09.30.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:21:28 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH 6/7] perf stat: Don't compare runtime stat for shadow stats
Date:   Fri, 30 Sep 2022 13:21:09 -0700
Message-Id: <20220930202110.845199-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930202110.845199-1-namhyung@kernel.org>
References: <20220930202110.845199-1-namhyung@kernel.org>
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

Now it always uses the global rt_stat.  Let's get rid of the field from
the saved_value.  When the both evsels are NULL, it'd return 0 so remove
the block in the saved_value_cmp.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-shadow.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 0676ee9986ff..f08291e55f1b 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -35,7 +35,6 @@ struct saved_value {
 	int ctx;
 	int map_idx;  /* cpu or thread map index */
 	struct cgroup *cgrp;
-	struct runtime_stat *stat;
 	struct stats stats;
 	u64 metric_total;
 	int metric_other;
@@ -67,16 +66,6 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
 	if (a->cgrp != b->cgrp)
 		return (char *)a->cgrp < (char *)b->cgrp ? -1 : +1;
 
-	if (a->evsel == NULL && b->evsel == NULL) {
-		if (a->stat == b->stat)
-			return 0;
-
-		if ((char *)a->stat < (char *)b->stat)
-			return -1;
-
-		return 1;
-	}
-
 	if (a->evsel == b->evsel)
 		return 0;
 	if ((char *)a->evsel < (char *)b->evsel)
@@ -120,7 +109,6 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 		.evsel = evsel,
 		.type = type,
 		.ctx = ctx,
-		.stat = st,
 		.cgrp = cgrp,
 	};
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

