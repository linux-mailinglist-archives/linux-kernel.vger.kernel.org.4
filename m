Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96B73D725
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjFZFbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFZFbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:31:04 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92E5180
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:31:03 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-66872889417so1000882b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687757463; x=1690349463;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=peuhcomyzUm1WYfUTQS3mV4fqDU7Ve4mUuTiDhGA//A=;
        b=fOXpdUaZpej6Gu9iwqHFOMuLQxAluPKvXFsnjABYVGHAdhFmMMZlzBLf2BPpUz6H1k
         9uek95cDC0dE+g4z3Iz4zbYzGe+OlRkpoNLnYBj2cwF2ORWmneFuss/BR9jQ70rEAHn5
         6QPppbcHZjTaK3Viw6NKfq66q5d0x34arwKuayDxSc+5+a37hgtyr1/5BxowKUOgagul
         jLSJ9CPTIvOLAMChFvMl+uRJ4qixmwnk2/s4aCgpcHURMuE+JUsxFxazmtykCdOVXD/X
         L7Ucr4WbtWhwbytcOBdW1eWwSxm1OXYpxmD89IkADnvq/BAR2RJoSGmDLxyXwHPT1Bkw
         WIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687757463; x=1690349463;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=peuhcomyzUm1WYfUTQS3mV4fqDU7Ve4mUuTiDhGA//A=;
        b=B7gGlYILmEPgm3fCcFEa319lbA+4fMmggrCS57dBpFpQvAVRL2tn+4W2vpQ94HY48W
         O73ASQtoQ4r4ao5b9O7lb+51Wcp82UH6a26XOlJnLrQvjiRdvYYXIQYpqXodIYz5VFRy
         CTrJjhKtMy6s6RVzyxTEFia7/nbwRWVvF0baamg0NoF5NEmWN3rTxBcKGv0E02KFfnmy
         hHo+tvmtiywVjEH7KrY1F1DzSBGf485M2MSyz+vUJZR7TpyIpI3SBlGmkgoYsqB1DeN3
         eBQ5D+N1KLfvOak+qyKpHHZDbauMwReDRPk7pz8q8PU2CuoccbGft9sf+k0GxEsP64nZ
         iVfA==
X-Gm-Message-State: AC+VfDz+Jj5qTLXHRP75O0P+V2dDOqVguEydkzdT6JjP/bSxrDg2F/3a
        TAlq49jQXW16V4yzAGLJbVG/01Mb2epX
X-Google-Smtp-Source: ACHHUZ7mD6277JxlxdO/XpkoyniIWck0W2cN665ORJ+jVm63PNgz8tlijTmz4vMCjEZYvDp87f7MNUI4UCob
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:595f:edfe:c81f:233a])
 (user=irogers job=sendgmr) by 2002:a05:6a00:139b:b0:678:e0b1:7f28 with SMTP
 id t27-20020a056a00139b00b00678e0b17f28mr341064pfg.6.1687757463098; Sun, 25
 Jun 2023 22:31:03 -0700 (PDT)
Date:   Sun, 25 Jun 2023 22:30:48 -0700
Message-Id: <20230626053048.257959-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1] perf pmu: Correct auto_merge_stats test
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
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original logic was:
https://lore.kernel.org/all/20230527072210.2900565-35-irogers@google.com/
return !is_pmu_hybrid(pmu->name)

is_pmu_hybrid was removed but with the incorrect condition which was
fixed for core PMUs but not uncore. This change fixes both.

Fixes: e23421426e13 ("perf pmu: Correct perf_pmu__auto_merge_stats() affecting hybrid")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 64fa568a5426..8d5ecd4ff1a9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1427,7 +1427,7 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
-	return pmu->is_core && perf_pmus__num_core_pmus() == 1;
+	return !pmu->is_core || perf_pmus__num_core_pmus() == 1;
 }
 
 bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
-- 
2.41.0.162.gfafddb0af9-goog

