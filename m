Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAB56B1606
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCHXAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCHXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:00:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36E6D330D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:00:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o3-20020a257303000000b00a131264017aso206423ybc.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316414;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=PZRWXsWyADHy4mHeUXfY7eIe/xrWmdkDJrMwb2jSMuPSbFIhhmJzZ1o0/wjrUqNstt
         cqtNrNIfM5xuzRRHpDGe9KgHWeCS1PN7gzn2xt4jLpq06QR2klOwgxB7GtHWAUsCwqPI
         eoEqtmRdgmFINGPcsI+w4704lHFMvDkZYFWvALIWLS+RVWM7dHzTFEMpNTjSkjgpeNqI
         6HjGyK4aGU+gEF6gYHMayjhtdhdJHW44d2PA0zp2OGqdyXV/QRp78bXUC15kbkUb70n9
         vwfjR2VH6Y+by5dQIfLTsh1tb49rv8CQbdFX3gw+M1+dzhmJhSI1wpR7BCmJsH/QHzdq
         HUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316414;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=3NJNedIRAWfzrrgnEFcRUuAzN2hCmV6mz5RTb+UjZDTGEgTI5Ybaa3+dpyzK6jr3+V
         aOE4UsEuxCFAKlKkJyA+l1kY1jYWpE9g6WNIV40j8f5T3iO/4qcacSu23kxf4Xb3OSFn
         ZWwRuNPQiiQRmYdzdT+wBuA+D2mwvfmb+8FRXXlG2tcii4a7sJlyS4JdfjKBPhEF+pcE
         qKoCpMzxhYYmDEt9R2s+APmrapxjNMRPymjkRtIARhdeEnWjZF6rMdeNG/I4xSBxJS7r
         jzTdos8mYCunP8UStpMQuR2J4Hc30O7Jw8Kfl4tVCSlqEQxE6o22Yap5d03mk3Kke7n6
         trKQ==
X-Gm-Message-State: AO0yUKXpwIKidLlWi2+vStmiyKOEyZBF+EMS0ZN91LVOlcA+LaU6VeNC
        vypZm+GyeKt79n7mz2OgGT08NAoiCfsJ
X-Google-Smtp-Source: AK7set92OL1DUlHDMUMQ4k9Yj7wQXKCg/3n8NSJSe2/cDPHS5azdpg94Ta35YErsydO4/UTa/tFbOgZB/LCJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a5b:b03:0:b0:ad7:b81e:69bd with SMTP id
 z3-20020a5b0b03000000b00ad7b81e69bdmr9346841ybp.2.1678316413963; Wed, 08 Mar
 2023 15:00:13 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:08 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-8-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 07/11] perf parse-events: Pass ownership of the group name
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Pass ownership of the group name rather than copying and freeing the
original. This saves a memory allocation and copy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 3 ++-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0336ff27c15f..1be454697d57 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1761,6 +1761,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 
 handled:
 	ret = 1;
+	free(name);
 out:
 	free(leaders);
 	return ret;
@@ -1786,7 +1787,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
 
 	leader = arch_evlist__leader(list);
 	__perf_evlist__set_leader(list, &leader->core);
-	leader->group_name = name ? strdup(name) : NULL;
+	leader->group_name = name;
 	list_move(&leader->core.node, list);
 }
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index be8c51770051..541b8dde2063 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -202,8 +202,8 @@ PE_NAME '{' events '}'
 	struct list_head *list = $3;
 
 	inc_group_count(list, _parse_state);
+	/* Takes ownership of $1. */
 	parse_events__set_leader($1, list, _parse_state);
-	free($1);
 	$$ = list;
 }
 |
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

