Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB5728BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbjFHXb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjFHXbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:31:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB53AB2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:30:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565ef5a707dso15472497b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267016; x=1688859016;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvDaWeTNK3WSoU7RxteMJWYjgKCzqqKrMU8SOHl6IsA=;
        b=zq7n0FG6q55kI1lknHAHE1lHuS0TVc2SIL7xiqJwpHFzQgHoHR7VyUNJvMJLM7LqZK
         PReM7k5azlxan7GYT1OEQt6A9BGBbAC3OZKpRnVe2PD57AM/SvI0WBHohv4qVe4lmE8e
         XM8+/NASVm3hFIJF3NtAK4Z98KBICfnux+nLsiXJ4NUp463Ykl0ZkWzFvMFlk/BFoSD9
         DPIiedqbcOjh/XwcM6s3MbzY8xp8RCXeqbF2SA9G2Lb7D5ayo8igY25wrzJmVtqrLy4K
         akYi8T8ZNXtjwn6ejlcluxF5wrXbxLo1nhT5TB0nexOVLZO/9jIWD3tBE3eT80vTS7OY
         rL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267016; x=1688859016;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvDaWeTNK3WSoU7RxteMJWYjgKCzqqKrMU8SOHl6IsA=;
        b=bYoFG20lpIrHD+RohVdFHwio8uf8f3E9waV6uRJdKpl+FSnPY/tOl/U1BzmbQs/vsR
         BcYUvN+JSrtkB6xLJrmTo8Ff9rgTnnRWuaKBo4DCxJvWUXpQeeG3/rZVuW06RoOMYZW/
         wYBhJfpuzV4ZN/2/imi9akJyvRhArVFZkSm+ZYmzKpxWa7V+Y821f2/n/Kl4rSGNQOgr
         4mRJwHqP3kTTKKusK1c++YvYyPO9T9mPltFiTyPgaPCh0ML1HD8dfSuxspMdCRKUPgfA
         u2O0iTGTUlBkBcgEC/VMtlV0nqsTe09cvRXTDRS8E2hsMuWRu5xbp7CBWct7MvvZ0NjJ
         KovA==
X-Gm-Message-State: AC+VfDzmtBgetWqAbd8S8X95yBUTOSooBm5ki7HmbnHWxLyg40Sxtqr7
        UA28yYUnuVOP0Q9U19MwHxDuLQLaKNJQ
X-Google-Smtp-Source: ACHHUZ5mehvIfiWPsR3FMIB5AYIB4oykjMARcMG88ABn1UYKXC7tDYxPh/EBCaYSpCh78GjCUjEvdjauAAmr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:b116:0:b0:ba8:4c16:78b7 with SMTP id
 g22-20020a25b116000000b00ba84c1678b7mr600676ybj.12.1686267015833; Thu, 08 Jun
 2023 16:30:15 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:23 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-27-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 26/26] perf hist: Fix srcline memory leak
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
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

srcline isn't freed if it is SRCLINE_UNKNOWN. Avoid strduping in this
case as such strdups are redundant and leak memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 77cb2cc83bb9..cc6f7f51faa5 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -484,7 +484,7 @@ static int hist_entry__init(struct hist_entry *he,
 			goto err_infos;
 	}
 
-	if (he->srcline) {
+	if (he->srcline && strcmp(he->srcline, SRCLINE_UNKNOWN)) {
 		he->srcline = strdup(he->srcline);
 		if (he->srcline == NULL)
 			goto err_rawdata;
-- 
2.41.0.162.gfafddb0af9-goog

