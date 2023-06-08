Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8D728BD1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbjFHX3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjFHX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFCD30F1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bac6a453dd5so1655485276.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266961; x=1688858961;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8nZzpxNSCbRXHMzfJBAp7eVEh2n3zxwlDLBqqql/Uw=;
        b=Qc8L5FoARN90TEPW/tyBzgIkWZWMgC4vWKig+/L6A+nCr71SA5XPdM4GS9PuePF8XD
         vDVxVO4oJh1fDlu65LjQD5xdYcsCS7gzFhfD9C41ue5zDcLBzC2PR5pa1JLVsFMSFmwR
         /Gjccb+eR+2tOYSY/bXlfmbYOqiBN4vn8OyOVFLo6eGRNsJcG3cObVOUT3yOPgaWmt/e
         0t3prXyPPW2p8WgFaTmsrsK+nwyFr0+bA5n3BJoyGFQxtmlXO9gnb2wQgqdg91RtnM5Y
         u9HM9/WhfiAzifHPJ9RsufS+aukJguBxiGtTEZZAzCE+10ItDUd4dhL1y8uJwJIsO8Rx
         QbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266961; x=1688858961;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8nZzpxNSCbRXHMzfJBAp7eVEh2n3zxwlDLBqqql/Uw=;
        b=fQ8zqv09AwOQvMQFEMH5ktqq51kYbZTb/Ggx+OkWOp5xN6tQk8C2SS3sdCBrovxHFc
         D0FstONN5Bba4CWve/2nrYCvMsdEJaW11husdKKKMit4k6SFRfX7+KA1ihldiCjU9MRK
         xl25E7ZVCvLIk60us/d7eo1vxi+51D7KPTkEvIx+mkJCv2nzh/JN0nUmcZhfQFuzFE/e
         RjSbOTGmts9GQstaxYS0kmgtX0j1RoVul2CquNAomE4HPrmsX5wj1NnQOl2MA3DcquHT
         tfqLyXhG4E8ujejE2/fNRKqaAkRsXau/Q8GAUp6xiYbXQioTm2K0HRHAjUz/poH50a5D
         065w==
X-Gm-Message-State: AC+VfDw6MhFYEFwWn3R8cNY8kVy8MMe/4QTCil3iH3+Pn9cg9lHHQ9yx
        owIXw32v3BBMppX0kFhRs2+wmF7lk/aJ
X-Google-Smtp-Source: ACHHUZ6mO0KY7WuSqm4kMAhhX7wri86AghEsVjmLTPQvjGHUK8KzarbyNv9ibdY6QZfzQ4veQySzF++IRrLF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:2004:0:b0:bbb:8c13:ce26 with SMTP id
 g4-20020a252004000000b00bbb8c13ce26mr599080ybg.11.1686266961427; Thu, 08 Jun
 2023 16:29:21 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:01 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-5-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 04/26] perf maps: Make delete static, always use put
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
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

Address/leak sanitizer with reference count checking can identify the
location of leaks, so use put rather than delete to avoid free-ing
memory when the reference count is >1. Add maps__zput to ensure the
variable is cleared.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c   | 2 +-
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/maps.c    | 2 +-
 tools/perf/util/maps.h    | 9 ++++++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 8c0eb5cf8bb5..5bb1123a91a7 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -140,7 +140,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	ret = check_maps(merged3, ARRAY_SIZE(merged3), maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	maps__delete(maps);
+	maps__zput(maps);
 	return TEST_OK;
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5d34d60a0045..8972c852d3bd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -248,7 +248,7 @@ void machine__exit(struct machine *machine)
 		return;
 
 	machine__destroy_kernel_maps(machine);
-	maps__delete(machine->kmaps);
+	maps__zput(machine->kmaps);
 	dsos__exit(&machine->dsos);
 	machine__exit_vdso(machine);
 	zfree(&machine->root_dir);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 5ae6379a1b42..5206a6433117 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -171,7 +171,7 @@ struct maps *maps__new(struct machine *machine)
 	return result;
 }
 
-void maps__delete(struct maps *maps)
+static void maps__delete(struct maps *maps)
 {
 	maps__exit(maps);
 	unwind__finish_access(maps);
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index d2963456cfbe..83144e0645ed 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -57,13 +57,20 @@ struct kmap {
 };
 
 struct maps *maps__new(struct machine *machine);
-void maps__delete(struct maps *maps);
 bool maps__empty(struct maps *maps);
 int maps__clone(struct thread *thread, struct maps *parent);
 
 struct maps *maps__get(struct maps *maps);
 void maps__put(struct maps *maps);
 
+static inline void __maps__zput(struct maps **map)
+{
+	maps__put(*map);
+	*map = NULL;
+}
+
+#define maps__zput(map) __maps__zput(&map)
+
 static inline struct rb_root *maps__entries(struct maps *maps)
 {
 	return &RC_CHK_ACCESS(maps)->entries;
-- 
2.41.0.162.gfafddb0af9-goog

