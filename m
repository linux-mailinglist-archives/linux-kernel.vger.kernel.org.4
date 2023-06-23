Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD53473B039
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFWFpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjFWFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:45:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15A1BD6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:45:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bfee5fd909aso454865276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687499127; x=1690091127;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NjLmKeMWSmb3eWAjfl0dBtX06VaF/92y1fARvMWRoy8=;
        b=ujjd41VHK2+bXNq7ZNjAH7mDCfeO0Y1E82Bue8UXNFcth6koW8w3pcLTWS29IwS4pb
         Rsdb5UqCppN5Nrm7KH5u5Do1K6fopPUgNgY0fPlQGoD4RruoTPi0QA2+AFOQXbIDu+H1
         Z43oNAAc6XcsrAvMzrgOwo4mp3S3IqU3eRnvp74/caoTSiNaR4O7BkrHLbCMD9rSaB/S
         IfghTZNjvttyxpD34zAWzwKrwC8GOSW0twtNQkr+IWGO3F1BOZLOE1q/OuZGJxAklmoT
         1AEsCUk5erVlaHfnhMipyuc4+VXuwQPy4EAec0N5D99qryjfWQLAV/tTKl9E2XMwTNfe
         cRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687499127; x=1690091127;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NjLmKeMWSmb3eWAjfl0dBtX06VaF/92y1fARvMWRoy8=;
        b=FIany4NCMgHfUhRlji2uPdCwTKig3nNHppk1LAwJAZ6geKP3TtmUkOPJCcMexcCpvi
         jRjrNgA1QRcMVW6kjM4QMcwvFfsQ0m9l/gGRNPbHbrjSmKzXThqpPbly6gLNXw1kKNGL
         r4jSFeTcB71vtRtjkgrbzzY3hmCvu2FFEFzlo03gwAjxHHwz8PnuAGTk0VW0vUV71ZvT
         4Ch/cdMqtJdRsLs0fnU9F9p4rtLZ0Y3TmDu8ZhGBYj9QtdE2SqcBF+UHYesEerQVYDVz
         UxyB0X/I7+fm+0KZ8zR7cm93Nilm6oy9t6ayiza+Aw1h95zCoj972wO+l3iE/nmW5zDA
         k49Q==
X-Gm-Message-State: AC+VfDy0hF8hK+PoI7tSPpHBJdUUnz81jA2dnF0YkoaKszeJ1sBzicPk
        07ojmECor0Tsx3jRnDkgFxFYy7XMBfyZ
X-Google-Smtp-Source: ACHHUZ4yDDI92XqYt3wZe7Xq0xDJsuGhL3DizYVTIoA6MNMaXqogjb60TD2ATgy9O7AeH1sznK4Ih8I796Qj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:ad94:0:b0:ba8:3600:c3d0 with SMTP id
 z20-20020a25ad94000000b00ba83600c3d0mr9031883ybi.8.1687499127719; Thu, 22 Jun
 2023 22:45:27 -0700 (PDT)
Date:   Thu, 22 Jun 2023 22:45:18 -0700
In-Reply-To: <20230623054520.4118442-1-irogers@google.com>
Message-Id: <20230623054520.4118442-2-irogers@google.com>
Mime-Version: 1.0
References: <20230623054520.4118442-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 1/3] perf dso: Sort symbols under lock
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
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Determine if symbols are sorted, set the sorted flag and sort under
the dso lock. Done in the interest of thread safety.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c    | 3 +--
 tools/perf/util/symbol.c | 8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index f30d34903aa4..a45708289cc6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -398,8 +398,7 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 		return NULL;
 
 	dso = map__dso(map);
-	if (!dso__sorted_by_name(dso))
-		dso__sort_by_name(dso);
+	dso__sort_by_name(dso);
 
 	return dso__find_symbol_by_name(dso, name);
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d275d3bef7d5..bb02047e1c59 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -613,8 +613,12 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name)
 
 void dso__sort_by_name(struct dso *dso)
 {
-	dso__set_sorted_by_name(dso);
-	return symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
+	mutex_lock(&dso->lock);
+	if (!dso__sorted_by_name(dso)) {
+		symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
+		dso__set_sorted_by_name(dso);
+	}
+	mutex_unlock(&dso->lock);
 }
 
 /*
-- 
2.41.0.162.gfafddb0af9-goog

