Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812215FE8C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJNGQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJNGP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:15:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBC91ACAA3;
        Thu, 13 Oct 2022 23:15:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gf8so4013412pjb.5;
        Thu, 13 Oct 2022 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiMyw7YB2EnKoani26cg+4Uepi4pmm8Ijh9bPfSD/gc=;
        b=jh8JYNdHA1hyHQLhEMYdwS9V0KiqddfEclbPYcqBepEodjjQVy3LAQTVD53HUFJi6m
         06J/TS8+cbDSP2NvlpeEltTnfyPURKTlhgg4yVy6CQGwStSpN+dEcJFOPmFHmefchgl3
         xbJn0PAq2KHPmJqETYcOlIKty650+cYw9t5rHL3643GHW+qlWX7E+fb5cfLx6HFd6e+U
         zAhV8O2V5qs2dT1ALEOa6krnOkP5dEAYuhhtu8oQoHj2BuolfKl0sd2geR5mqdhCHxc0
         aW36hrOz3vaLPjmQiMDBksKqLa03R6Z5t248WGHjJKn1GhoMSLFuhkdFHxOoQLlJKdyR
         YLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MiMyw7YB2EnKoani26cg+4Uepi4pmm8Ijh9bPfSD/gc=;
        b=oYW2k07A70PmZb9bR0y0yNkJZ+UmBnFcfNSLqoAMP+JPJPtbiJA7W4ynISdoI1UPTZ
         gw/Sg22pAgceJl0/hU+cgIA5APjqaoSPeaMSxRKXK4wcXvNaJ4M9B3LbiEiMDkY7yUcw
         KikZf970HCvCJfISqYb5WAT20oPmuIR6Gn1SoGaykU9jqfdVpdjikLAPuZSkPblUBlSW
         saGf0SSmxg4goad4RdgWUYrvW9+EzjZnBj3h1aIfnm5TKX4uhXNRM34vJZhJF09qEe8p
         CCwqub9kcTsW5dW3fmhLoobBr6lQYqh5y4xQoQHkzrherq4Nfem158PCulqSmX4pC79T
         pzwQ==
X-Gm-Message-State: ACrzQf32rNcdv7u7BSom+u9MIAMuAAMBItosOsF84fxSJu2IQY4kq1Av
        k9Ud7KDn2hBOc/I02XG67Gw=
X-Google-Smtp-Source: AMsMyM7YXABzLevTe1aaSSDqnHePe36nPl3xm8nI0IL27OfqiY9nk4KGX+jLRhSWgC1oufWF5g0YiQ==
X-Received: by 2002:a17:902:7102:b0:17f:3da:f18c with SMTP id a2-20020a170902710200b0017f03daf18cmr3590394pll.24.1665728155691;
        Thu, 13 Oct 2022 23:15:55 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:630:195c:38a7:a411])
        by smtp.gmail.com with ESMTPSA id 94-20020a17090a09e700b0020af2411721sm721942pjo.34.2022.10.13.23.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:15:55 -0700 (PDT)
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
Date:   Thu, 13 Oct 2022 23:15:33 -0700
Message-Id: <20221014061550.463644-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014061550.463644-1-namhyung@kernel.org>
References: <20221014061550.463644-1-namhyung@kernel.org>
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

Acked-by: Ian Rogers <irogers@google.com>
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
2.38.0.413.g74048e4d9e-goog

