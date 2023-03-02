Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A66A8B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCBWAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCBWA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:00:29 -0500
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F95A6C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:00:20 -0800 (PST)
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-172a051bbcfso438908fac.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677794360;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=a0EFQEXvTO9IIE/LbOtPkcXViHfv9dEzXj8KSiVYaUh/sfzCdbrhhP8l0pmjo5LgoH
         iCQfdg0jkNGGbXMATVpflZsd6HJpzPtVA1RFhbgExab2unqHTMW+rwt4K15tYs0KAi9P
         80tyGzoWONd8IGNIjajpRKV5M0A9LxLjHwysi8kKGR/fhjc7VvEYGbD8Pe4UcTGGzIv2
         g/OGbLCIz53lSA3DZgvMoMNXLR8Rb/wj2BCmi0GL496xDFIL2WodN3XWa6IUkLqS2RZf
         H7IbtmT/9RE39P2lQmVmT3Tmojo+52+37FcMlryUdsk+qA0JyGACrkFdm+ao1lnecuUy
         wpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677794360;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvWMdLTJ1iuXhAaTLlBF3OqMzr4/MuwhIZh3sQrcPM=;
        b=YS6DYVKIoMbvlpYW0YUNAdawnL2guvHqHRKku4gG/deEbw7d//6yDs1x9aGA+SEX0b
         0unNJDvYB+iCcDj/IKjAqyK3NxO33f55Cal5NHCs0Ou/xW7f1/LUz9WVmyPiU94Vr39d
         JozPMte2gnhdnW+8eaDolYzjPGmPs5zcP6X/3I3h6wwvLFTvOV2fY4FxARRDooizK8N1
         Cr6lSxuXlsjoAMsK3CoQaNRbRXU2psd3qgDMovSubY6TWTY7O2tmc7YvIC9sKZvMOErK
         vyh6E9fqN4KSbW9P4bienmV2+Dp8vbKDh7mROOIpd3H8dBnzhKoWt76cuKpbx2l9WI/a
         pMQA==
X-Gm-Message-State: AO0yUKXTaVZIY9J5oJ3hC0y0dtY2ygQBRjWc4RbEYuXdq7glGSOI2UI0
        FAGwv29oRFZw0JOL/KgMwIn+YiDddQfC
X-Google-Smtp-Source: AK7set+J7xhJXlPokHx7LXJwm2IqRttp6kpC4gGTiT8erLWQVPEcFhFcT67z288CpJXfg3wHvD28CGfNiln2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a05:6902:4f0:b0:a9d:be6e:3340 with SMTP id
 w16-20020a05690204f000b00a9dbe6e3340mr6135153ybs.1.1677792402429; Thu, 02 Mar
 2023 13:26:42 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:28 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-8-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 07/10] perf parse-events: Pass ownership of the group name
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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

