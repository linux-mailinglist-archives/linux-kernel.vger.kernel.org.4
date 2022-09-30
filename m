Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF35F138D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiI3UVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiI3UVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:21:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DBC169E67;
        Fri, 30 Sep 2022 13:21:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso654526pjk.1;
        Fri, 30 Sep 2022 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=EumHp6TLGBfFK/IXQi0XQcmxp+3vp9b8V9xf/+XBZzo=;
        b=eb2aMmqxUWWIevgv0urAloBKPje/XQNVxtuwz3gBbrA0wZDvcJQUFEIvb3Nw5FgHVw
         ImS+9OABoBHHLZOhWejBW1c9zBqN97hIlntUWE6IFQhhAe6j3KT2xSI/sfBFUmPsrN80
         2CwWS5jicQwzlDUa6vnHbx5Uq3N2NwbkaqqxFex3ZvNVYQ4DukrrKWvHy78YpEXJquSp
         VtWj1f/1nGzU6wPS8l5BAo9NliFLJ4bYfq2W461q0YpTmPQ8QON9b5tM3F2qX+wIzugt
         RV4QYMuGcozrzF3601AgbmOl6Ug1sEYKROyyDfhtktzONa63ho7I3IAnPYp6PYz6TeLX
         ujYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=EumHp6TLGBfFK/IXQi0XQcmxp+3vp9b8V9xf/+XBZzo=;
        b=vKEfzVAtP7BxI9M/bbDv4b9AQBblFUyw5zyV56c28Q+rU2W+0+ESoaWEKW3r6a1pft
         74vcufZvRIjuwpzqndb510+K3wBN9HJ8bgxgr0I2IDNExHHUB2A1gVAOs83z+nNk8frg
         1J74lnIvAcnLH7rgk1H3OFwJbqc72oDUOyQx5NdsGipqkp+AqLhOgYxRXB67GO2M2erR
         zuwTOK0k3rHjziD5Y1PmzOgpdlE1SIXc4CCgQc3QUKqbjqxyvRVd2jH6dM0xC+vlFvkR
         PvxKDkzJbwMz1ZhfcXY7K7poofmZmGvubbe3NY/0fsfiu1PmLsVU61Rmufe2Rn3h8DIA
         ojpA==
X-Gm-Message-State: ACrzQf3PViL+cFuaN2Bs8LIBHCHBMLGUmfRO7Nk9NVetpHWDahDr1Sk6
        jkUFsorkZgFkCUeoKiwtheU=
X-Google-Smtp-Source: AMsMyM4YKeAQMm9yJ3xvbG2PdKlH4wDwkq42WCpaY0GydIJvuBzFeyOym1PHw8yygzEp9TwQmt98Jw==
X-Received: by 2002:a17:902:8693:b0:17a:f71:98fd with SMTP id g19-20020a170902869300b0017a0f7198fdmr10672350plo.25.1664569284066;
        Fri, 30 Sep 2022 13:21:24 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id s10-20020a63e80a000000b0042fe1914e26sm2105540pgh.37.2022.09.30.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 13:21:23 -0700 (PDT)
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
Subject: [PATCH 2/7] perf stat: Don't call perf_stat_evsel_id_init() repeatedly
Date:   Fri, 30 Sep 2022 13:21:05 -0700
Message-Id: <20220930202110.845199-3-namhyung@kernel.org>
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

The evsel__reset_stat_priv() is called more than once if user gave -r
option for multiple run.  But it doesn't need to re-initialize the id.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 6bcd3dc32a71..e1d3152ce664 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -135,7 +135,6 @@ static void evsel__reset_stat_priv(struct evsel *evsel)
 	struct perf_stat_evsel *ps = evsel->stats;
 
 	init_stats(&ps->res_stats);
-	perf_stat_evsel_id_init(evsel);
 }
 
 static int evsel__alloc_stat_priv(struct evsel *evsel)
@@ -143,6 +142,7 @@ static int evsel__alloc_stat_priv(struct evsel *evsel)
 	evsel->stats = zalloc(sizeof(struct perf_stat_evsel));
 	if (evsel->stats == NULL)
 		return -ENOMEM;
+	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

