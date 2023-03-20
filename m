Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9411D6C0961
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCTDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCTDjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:39:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DE82279D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:39:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5446a91c40cso109976187b3.18
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283548;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWDjPPDoVS0JDf2qDq/S5D6izq+O5FLiZzLIDYhTDcw=;
        b=nLz4ieuq6UQ5762iyzEeXxWSNK23K6yAuzQg63tWTPUIEyVjby55CsOVPeUtvgl1yI
         HcneNx08ADteLp+/O4bi+8YI0ur6CZ7cZBuHbFdrn/k2l5ddq7nfLQILexB0idnupNXt
         w//iLOiyCoxAN57trk5THriviyko0qKJ5C0TCMc24ZSufaekqPSTiY2CwqtDNhcW91BN
         07P8aJ15SRl2/dwVRVr0S6lrQYbmxbFi/IwX/Ecr9HTBRoRLBSVu7S4R3Dm6qFRT66IW
         +ums7G4p3gNHeT9ZvVnnPnnTzYl3upmQoDXnwHM6tvEhQjSqj9mSuYE4OFEdrsf+z/+E
         djGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283548;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWDjPPDoVS0JDf2qDq/S5D6izq+O5FLiZzLIDYhTDcw=;
        b=qPipz7zCFtV4AbsYf/Fj594NMUCuO0FxCgfBg6eHo2YmQ65zrb8ChffPFc0kIgBH5F
         FZnRd9yUs1MwrvRLBXovUUTsaMVjLTjqTBTF2g5Pl8XEiCzFj74v5A9WleKNP33bxds9
         CIovNqOXVperDVwMi7HHnTHGdP5wQfIzvXcPw/HBrj0rgDhjDHcxKvDmsUKZwIQYf0pf
         vZ2/ISTQ4xHPgkQJFQPv8aAQoI7Lyq9AEdmSc2/uN/1wtzAAIm2lF5JHfHjTP6lMe9TK
         4xSF5rryLUFCoWR4F7oH5/zSicf7fnf5hc8aO0zXO1G3Sk3rVrC1uQ9HmAaCOLXeYs+K
         zX4w==
X-Gm-Message-State: AO0yUKWZCE8uaFlkn68qA8sTFjUosxAfgd7aZrnN9maLlZazR/t4u+Yg
        bSwbbX2SK0pYZ6ibl5iyreFDkiykMHeE
X-Google-Smtp-Source: AK7set+e/p/tdOZmnVTvRXJkVG1NofWhKYs0Acw/s+ryqCYiUJ57g7N82BnK7fiHBi5vw8sOBCGCb/J/FUzC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a81:af02:0:b0:541:822f:af40 with SMTP id
 n2-20020a81af02000000b00541822faf40mr9649912ywh.10.1679283548003; Sun, 19 Mar
 2023 20:39:08 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:52 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-5-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 04/22] perf test: Fix memory leak in symbols
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
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

machine__delete doesn't delete threads. Add call to delete threads
ahead of deleting the machine.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/symbols.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index 057b16df6416..0793f8f419e2 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -38,6 +38,7 @@ static int init_test_info(struct test_info *ti)
 static void exit_test_info(struct test_info *ti)
 {
 	thread__put(ti->thread);
+	machine__delete_threads(ti->machine);
 	machine__delete(ti->machine);
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

