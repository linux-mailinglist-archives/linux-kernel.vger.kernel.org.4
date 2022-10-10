Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CFA5F97D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiJJFgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiJJFgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:36:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A23DEE9;
        Sun,  9 Oct 2022 22:36:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gf8so8965460pjb.5;
        Sun, 09 Oct 2022 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMQ9Nr134jTsiGubldmik2SSGo5GiaQNz3NaNpTchwQ=;
        b=VRkFyJlBI5IZ1Et9MvJK2iqInmhfh7AoF/MlT7QEroFzWtAnIqRwqxkUZoW2ixzOIz
         ZDMrrTmBF9kJRdPlIP3v3ictLW7oqdkX6VQdbRpy9pKXwesfzzMR1FTmESuLUdneEya7
         16+FhT4SBVCwLQV6hlHvSBEKqG7MXjyTZFQT5c88DzXt6dNSKwV/xnNWLtj2wvzVTwyu
         Ko6Ua6HQ54aITfo53Um8aUfw/svAUro1MTXO/OMgTG39yBXxC6jhnDDmmYozMUTO9Lp2
         wzr3BO9t9QruOoLHp5HW/Pkc6/HBV3kNMhTGid/N14IlHVhsSn+/kClLiSAvPB9UUcde
         04+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMQ9Nr134jTsiGubldmik2SSGo5GiaQNz3NaNpTchwQ=;
        b=O9F7g13DJ4afVvdGyfRBCQPenh+m1DhoU5JW/Un75qcPU6K9YVlmnyJTZdaEZfhmyJ
         GcOO7MTUCxylziYanj6dpGe4k2qrc/QYWFBcpwRNnDRoIqcu5zUNAClg7VRt8eTN2qbx
         4SsiJuf5LmVWR2gwsAok0jXQAKLnTc3eJnQ2DVxyEspN6E8xFCsWO41bGZZzKMR6C+Qo
         VpajHHaHCzTUVKTFyPdwcyA8u+3dlbK/5KV+7NZauTnToHxqaT7b3r5C0owKYwfVa87f
         09Fb6GKZ9g2Hcwswi++SNAAoASI2boUBvpDtd87jICKXNMFF/zX40QPjCQO1tPEfVItI
         ccsw==
X-Gm-Message-State: ACrzQf28VjVEKm+r/2f3fm+WaTWwsHADYxfIfhTXHumGY8bwW/QPZWME
        iZcNpH4YPTdnZpHufLu62Y4Om159CVk=
X-Google-Smtp-Source: AMsMyM5iFsnTvLuvizpAJciGkx89svCIdMIVWr3MaIlqyjVda2kbJs00dSZY4Jqye98bczq+VgyQHA==
X-Received: by 2002:a17:902:e88b:b0:17f:8514:cf5f with SMTP id w11-20020a170902e88b00b0017f8514cf5fmr17599210plg.163.1665380166013;
        Sun, 09 Oct 2022 22:36:06 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:862f:cd0e:bf30:6d69])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0017f7e0f4a4esm5667594plg.35.2022.10.09.22.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:36:05 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH 02/19] perf tools: Use pmu info in evsel__is_hybrid()
Date:   Sun,  9 Oct 2022 22:35:43 -0700
Message-Id: <20221010053600.272854-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
References: <20221010053600.272854-1-namhyung@kernel.org>
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

If evsel has pmu, it can use pmu->is_hybrid directly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 196f8e4859d7..a6ea91c72659 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3132,6 +3132,9 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 
 bool evsel__is_hybrid(struct evsel *evsel)
 {
+	if (evsel->pmu)
+		return evsel->pmu->is_hybrid;
+
 	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
 }
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

