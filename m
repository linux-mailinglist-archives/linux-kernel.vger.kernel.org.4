Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98D728BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjFHXad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjFHX3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:29:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E13598
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568bc5db50dso47624807b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266981; x=1688858981;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cxVt6j8z1zIEddbGRdbnpWEVyu2s2AhOUuVVlGcUcvA=;
        b=ZDaKU3gh0whGBinBkCTBD7l56ny7TFWktGEZvsQMsPvV9tisV+0JT41exFAx8f6gPi
         zL3CSPldjAK2Tum+6BzTspyaRIu5wm+1PoXPeSjrfOL1NY7BMfHgvo9JlyLedqUh8Oi+
         ya3aNjwm6T7pwaa/Uik0jkBtYS9Z0Nz1ywYTRuab3h9NhtucJbP8VbA2TzT5gIYfYcsA
         6Cfor+XWTdxq+SohC7OZmWQA7FEak49o/YJEpOAAvnoT1BhGSQrtYsCAaqala9qpeEOC
         z60k3sB64OJ+I4/JV0EuFtLt0nJqfzd8OBui4LSHZMvwTUyUfT8rxZ9oJawMBrse0Ljf
         qpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266981; x=1688858981;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxVt6j8z1zIEddbGRdbnpWEVyu2s2AhOUuVVlGcUcvA=;
        b=bDNl2LbOhkGQqNt01WxTh96NrDkW+F192f6e//2T4jDTSbjA2Wn1zkTWnGueCFkcit
         BHqHHe5/htwj37GT+QbTtk3zZYKYgKmEYTtsCzn8ar4rpZBVYabDVcXbxtGtrf9o2jU1
         a6mPnnleHO5tryE0R5xSX6P3Cs04Nr56Q5awcMDX0QmgubP5KUW9q2BaeHAFjhwRXXUs
         I+ZGLZJ+X+URw845SjUYmpg9DY2gVu0v//eq+BB1jNVWf/kNOywDdTWV8T7OB7xKDCN9
         WjZJTVUn4oQWY8XQJaZP8bMs5xiqzyn28+hgKYWjnL0dURodWfZflxHnPS6DP2MzU/QU
         ceaw==
X-Gm-Message-State: AC+VfDyRUhZyWFjUXpw8dYnrpoH7AnpIsh2hlXdUy2krcuF9qGCgaTQB
        p6+EzgT99u/KoEBf7QKn4zJQ8KmV/cL4
X-Google-Smtp-Source: ACHHUZ7n4Icj81DhdrrgIFwHFE3eedXZ++Aq+OOgMSXdAebV/QYv7OE0ML9Jkqv1obQo2p7dDDiW5LZxa8Rz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b8f:b0:561:4723:2088 with SMTP
 id en15-20020a05690c2b8f00b0056147232088mr590334ywb.4.1686266981201; Thu, 08
 Jun 2023 16:29:41 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:09 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-13-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 12/26] perf intel-pt: Fix missed put and leak
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

Add missing put and free, detected with leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-pt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 783ce61c6d25..dbf0bc71a63b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1280,6 +1280,7 @@ static void intel_pt_add_br_stack(struct intel_pt *pt,
 				     pt->kernel_start);
 
 	sample->branch_stack = pt->br_stack;
+	thread__put(thread);
 }
 
 /* INTEL_PT_LBR_0, INTEL_PT_LBR_1 and INTEL_PT_LBR_2 */
@@ -3580,6 +3581,7 @@ static void intel_pt_free(struct perf_session *session)
 	zfree(&pt->chain);
 	zfree(&pt->filter);
 	zfree(&pt->time_ranges);
+	zfree(&pt->br_stack);
 	free(pt);
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

