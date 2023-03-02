Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF46A7A59
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCBEOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCBENo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:13:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6774608A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:13:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bbaeceeaso300768047b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 20:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677730418;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8e2GbMOJCiKu31bRYD395XKtu1B0wMiO24x2A+fRDY=;
        b=Aqy8a7r86cYMeWfSGW4ApM7jCJHRfZfX6lC7MGITzZBZFk8BccoaKzvaKBEOPPT5OB
         nfNFTcCbajzSA10N/Bsznosyz9V/I9PYHFY9iZkv53xckgR/vBLv5Fa/n5EpjzYEQb9f
         N2ZFXeSQynryaBhzqg7m331cZpt+UsWZ/SfXSv+K2XoHzrVEOAoMDlquiKBgqS2D7vd7
         QjAxm3DeeXtAAMqkHttbbFO9w37uv3BPpYUfH5sHFjXV4qM64d4gN3eiG+RyJu+jRI86
         DUuwNpdvxXEixmNLix17/YVV2lXeT9dnMhiadzZf2JDJCvh+GCfhGf2TKTN+H+NTHG+B
         oc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677730418;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8e2GbMOJCiKu31bRYD395XKtu1B0wMiO24x2A+fRDY=;
        b=MEHdTc9NFRuGpeWnb4mf22/V0cvZEqM0Pmk4W/P/IjfE8AhfJyqoWZGoxyQx4iXjED
         7ZK5s1bOiL0pGXeA62kw+FCli6NH7YzmFEIMUCix8UV4KTNiaQOagUfP7bpfD3ijsTuO
         MC4XcZ6RouX995DrqhpjkrVwcpDOHv4wwxDDB1zrxJ2Ojs9GWY6Ogh5nai8WZa1MzwEv
         RAKxLRKUypFj75vQdF3ku7aGVkOr+v4286nunhzeAX6SDiwa06X6fP909ftupD41GZdu
         +xjE38skfYh2diTJggPLKqoj324tQD916hTTu0QEEUwJ98fn2P4B3vFb9VhYPH8cm1Ju
         6crQ==
X-Gm-Message-State: AO0yUKULpqPQGz2U/1UcTJ26Fg0empvAvP5ioGbOghVAvh39utSERtw7
        pTf3FjcQ4YImNzmZ01bXyOxqkFe7QQM7
X-Google-Smtp-Source: AK7set/3Ple0PpXkqYIrXmPMzXDI7RYhZscTwrY6yWIaY05VqKoWtRvy3KcSVdAjUeCSIcoVWmRAIDoP/Kqz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bdf9:f5cb:d05:c4d5])
 (user=irogers job=sendgmr) by 2002:a05:6902:88:b0:a27:3ecd:6 with SMTP id
 h8-20020a056902008800b00a273ecd0006mr532396ybs.1.1677730418420; Wed, 01 Mar
 2023 20:13:38 -0800 (PST)
Date:   Wed,  1 Mar 2023 20:12:09 -0800
In-Reply-To: <20230302041211.852330-1-irogers@google.com>
Message-Id: <20230302041211.852330-9-irogers@google.com>
Mime-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 08/10] perf parse-events: Pass ownership of the group name
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.39.2.722.g9855ee24e9-goog

