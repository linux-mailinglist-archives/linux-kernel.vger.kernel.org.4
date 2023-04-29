Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8BE6F2322
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347258AbjD2FiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347285AbjD2Fhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:37:51 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD55448B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:37:21 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115ef7234so13838121b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746640; x=1685338640;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z2X7LmFVQauBlgGsGcOl9/drZBMwRT7E40p+z8ki8E=;
        b=Lki4BFoU0wJhrm6qPyBdhy7Hwi1vzisA++fBdRnnaU17YpmlddWwsS48JzwhPseNyT
         rgmodnRw4UOXQNpJxtInoEbORsbI/JGDSXJloX0Qb/VwGoDCC/TjGBUo2WoKQVY1hat7
         Ckfhn8ftwjPdsixTKYoYDTB3xGaB4cM3KTHynxciEqGVniOdgPoLZ/xrBzia3wh1USqJ
         It9YYj5f+PXoHasMxo87ZEVObcFEl9cEM/hVCefN9tI3rEY1HhAU7RbA345LR5QFoR94
         5DjzqlQcvUzj2xVZ2MOJWkVE3obYcG3wzHhhsAY5u4AaNTAjNMunbxJldBeAB08KXMJg
         u+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746640; x=1685338640;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Z2X7LmFVQauBlgGsGcOl9/drZBMwRT7E40p+z8ki8E=;
        b=WpWWba1skVHetJzlWSjhticUyCbmlzUXaKOWtmWk8sNcG0CoIAKaqW6RZVjp0snwun
         jEs14M5L/JETlvT0WbRYOrSNcUh13FaePRQ94V9xdDM0oK4thUFz7FVtjVG7bPbR3kj7
         +v4J72Sd/hh+Od6J6BIC2HzW/QC55cGt3cfK7VlszZ1QJAkIxgzOmLLTcLePEo+7gvBw
         STiFTnwiSFp/CwafqqjePKGxGlYnq8VkxdQd/JojnJvTgPsLNct/ASxOharsMhDsm1Os
         qUZiH8ShZMCYGLiiArIkTm8kSDJq2suUsw1lQV4QPqRrO2BC3gh17J3zCheH3N5k7ejj
         p5Pg==
X-Gm-Message-State: AC+VfDxvosI7KJ+L7gNSF68pqzhKjBp0NlJcf1+74HpCaBNs/f2FXbwO
        W8/Wa8XwpWoSmwFk5ADLGzJAhdyKAviW
X-Google-Smtp-Source: ACHHUZ7z+60JLxib2gP6eFfUI/PCkaYhkcAAkzD8U3O/q7R7A79USR9kQbfy65FsGW+0TJ8AdoQ2ABZFj54D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a17:902:eb81:b0:1a1:f9f5:4dac with SMTP id
 q1-20020a170902eb8100b001a1f9f54dacmr4057585plg.5.1682746640037; Fri, 28 Apr
 2023 22:37:20 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:34:35 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-16-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 15/46] perf test: Test more with config_cache
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
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

test__checkevent_config_cache checks the parsing of
"L1-dcache-misses/name=cachepmu/". Don't just check that the name is
set correctly, also validate the rest of the perf_event_attr for
L1-dcache-misses.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4ff1d70e8375..1b9513ef6aea 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1394,7 +1394,7 @@ static int test__checkevent_config_cache(struct evlist *evlist)
 	struct evsel *evsel = evlist__first(evlist);
 
 	TEST_ASSERT_VAL("wrong name setting", evsel__name_is(evsel, "cachepmu"));
-	return TEST_OK;
+	return test__checkevent_genhw(evlist);
 }
 
 static bool test__pmu_cpu_valid(void)
-- 
2.40.1.495.gc816e09b53d-goog

