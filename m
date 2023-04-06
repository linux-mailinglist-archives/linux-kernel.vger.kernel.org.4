Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB46DA655
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjDFXyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjDFXx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:53:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E496589
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:53:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso40428756ybi.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680825237;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FLvfuP/ppd0j0/1co5enb/ElBXDAvYlZqA+xyY4YSI0=;
        b=MolppwmDeQulqB6WA5Ouco2p4R1r5C2to0lWGjzVHcaM482Z9Z2qbmq3XwcAINxepf
         FyaqSU8m0jBggXmE0PEFmg75/745IQSTW1x/JZl1X1ca+BqygoxccjIiUW5sJaTul+pI
         Mr0R69EuJ4DyWwUh7RaKz85Am1dmQyO2HLljVgHDBs8P6NKJW5Uuy1N1FM9hRmTGpzTz
         5gGbn9h3PSS/32c1fW3inLlYvfwkJYwaWgfzyWMjmHeCzY3jWWdoYvlrrgzbh0mVui5o
         6xykRwQ7cs6rwi8Yop99ZSCdQBP5Gegw4HU80Uz6m54r9pMMNqepTAzGCewBzg/pTnAi
         B8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825237;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLvfuP/ppd0j0/1co5enb/ElBXDAvYlZqA+xyY4YSI0=;
        b=eHZWw349WZoZdZZ9bbBYVTFDO7EyC11HmglSAJ0W/aKA7NGkCcAv4sNtRh1VFdggAR
         AEENnFUaMrm2FdqQmFH0SQ3h8FxLFKsz37rtMT6I/ZlaR6pqiIya3s3DDXXt+Umdn8BO
         Wa9VkIjy3mnnQjEevvDA8wW4vP+g+mv09k3wDghbUjNh22oaC6qD7ppfTmdK3xdlNi2H
         JTQIx00oqHazR0v/727flAmJbMLa6BUF68jGsWrKZD2887M4ukHw1y87xcKHV9DMSysH
         EOMynT4bwf5bagep1UIDZCcyIJbSEKlWL+kONlU6MZGhcs3RtxSZtiR00I1hyxNp0hwa
         IetQ==
X-Gm-Message-State: AAQBX9dAKiR52f7uzACA8PZxxcxJWlGYKCd5Rm8GgCVz6rU23Vs2nob4
        CCmpoZiJNhoP3YwQuT8X8+l2Q4AeY4RS
X-Google-Smtp-Source: AKy350bEziOXF5P1ia/8qPKeLmnd9NJTDiichJKVjV8ga2NYjwK5cvlXgdbsiEmKYbN+0fsk9G4RfaSJi+v4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:939d:185a:97bb:59ee])
 (user=irogers job=sendgmr) by 2002:a81:b1c4:0:b0:52e:ac97:115f with SMTP id
 p187-20020a81b1c4000000b0052eac97115fmr123710ywh.5.1680825236846; Thu, 06 Apr
 2023 16:53:56 -0700 (PDT)
Date:   Thu,  6 Apr 2023 16:52:54 -0700
Message-Id: <20230406235256.2768773-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 1/3] perf pmu: Fewer const casts
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
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
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

struct pmu_event has const char*s, only unit needs to be non-const for
the sake of passing as an out argument to strtod. Reduce the const
casts from 4 down to 1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 78a407b42ad1..63a33fcfd42d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -338,16 +338,16 @@ static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char *name,
 	struct perf_pmu_alias *alias;
 	int ret;
 	char newval[256];
-	char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
+	const char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
 	bool deprecated = false, perpkg = false;
 
 	if (pe) {
-		long_desc = (char *)pe->long_desc;
-		topic = (char *)pe->topic;
-		unit = (char *)pe->unit;
+		long_desc = pe->long_desc;
+		topic = pe->topic;
+		unit = pe->unit;
 		perpkg = pe->perpkg;
 		deprecated = pe->deprecated;
-		pmu_name = (char *)pe->pmu;
+		pmu_name = pe->pmu;
 	}
 
 	alias = malloc(sizeof(*alias));
@@ -405,7 +405,7 @@ static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char *name,
 				desc ? strdup(desc) : NULL;
 	alias->topic = topic ? strdup(topic) : NULL;
 	if (unit) {
-		if (perf_pmu__convert_scale(unit, &unit, &alias->scale) < 0)
+		if (perf_pmu__convert_scale(unit, (char **)&unit, &alias->scale) < 0)
 			return -1;
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
-- 
2.40.0.577.gac1e443424-goog

