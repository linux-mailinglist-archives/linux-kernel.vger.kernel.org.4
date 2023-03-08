Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60516B00BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjCHIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCHITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:19:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF6A4AFFE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:18:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a137-20020a25ca8f000000b0091b90b20cd9so16931975ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678263521;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=FWNtGJtYxUG//wEXtm6p8eRyzLunuHYYz3q8R61LClpUjKQP8mKwPSZjyu4xTFWlN5
         +T+8WTP2KH1fWLe6MSLjq8ZU1839uwN7XJljbSNFGfhpdtKde9GWyT4NmmS8xh+IEgJ1
         rZtr9N2R/FZZN/Md/pn1amM/6cPH1/Ktgx+nkl0encQuduucTBghVLBozAtXfpEkmrGd
         1c/QrmMiYwZ8WHhaPaqvNWyJ00GPdlvL+iUOH5smcPq2t2sH3O1QNUBH/0/2+1RsmNxY
         mJFLhPJRGhRK8DGOQM5m8kjiHyIoMZd7ipXJzXJ8RfA6ihWtkBiaCwQFNc2mIAKPZs35
         UXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263521;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=UsRvmIuDN5lsWm7t+kJyXiogSVtuwNMfyHIa4mFeF7ZOpmMttkvAvvw96Rjtbw2CVT
         GmpZG1M1f0juzju7JU3++7V8O/AcIAfo/pUWMC7OFA/M2HP1JrZDW7K9+Ec301jUdu0e
         HjsPQQKgDGxEgN11vY/HhI9ZlQrKE2JJa29cXdds6968hwMvRY/JP3bOgya/qrhIYjc3
         BfHFXS8ZykclPFN9AkXQ6FvLPgfNePnA0jBRDdrk9MlMd81AFAmc+8MMWF1e75ExC1Rf
         rQIsxJlXdUl+sA1qZuoTkJb85KLlvNXjlB4q5EXUIJG5omBQ+88j0DXEld1zNJpgxqjM
         qGYg==
X-Gm-Message-State: AO0yUKVy/7TVEpvxuuj4HJpw9M7JrFDVI+e1shPN9UJEiC40kYD3fZNo
        ZRHQqJq2KEzY5R+xxbhXPFd6tDyWNcQG
X-Google-Smtp-Source: AK7set+TIyKgKbB/riuRBP5LOZDBYsXH0JHi23Ny36X3MvlOQC+v1WdsfIm72GMBlqh4k28gZBKZR0ZdbLnG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9a99:fbc4:7488:8b5f])
 (user=irogers job=sendgmr) by 2002:a81:b243:0:b0:52e:d380:ab14 with SMTP id
 q64-20020a81b243000000b0052ed380ab14mr9684584ywh.3.1678263521140; Wed, 08 Mar
 2023 00:18:41 -0800 (PST)
Date:   Wed,  8 Mar 2023 00:17:27 -0800
In-Reply-To: <20230308081731.1887278-1-irogers@google.com>
Message-Id: <20230308081731.1887278-8-irogers@google.com>
Mime-Version: 1.0
References: <20230308081731.1887278-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v3 07/11] perf parse-events: Pass ownership of the group name
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
2.40.0.rc0.216.gc4246ad0f0-goog

