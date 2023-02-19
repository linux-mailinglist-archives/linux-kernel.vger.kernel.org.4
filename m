Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F169BFE0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjBSJtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjBSJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:49:38 -0500
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA4C9010
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:49:00 -0800 (PST)
Received: by mail-vk1-xa4a.google.com with SMTP id j23-20020ac5ce17000000b003ea10940e34so124644vki.23
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBnNbiH+hab12DiOKBd4pcQP1xg7aEKLvUH64+SdruU=;
        b=lMQXrD7/f5Md4Cv/Wu4Z3DRM30d0/Nfh2T/ynQgxAmUmcGDb50w7szQMN0mpyoaGO2
         /KdOcvlaYuqHsrNTWXuo8TUwMlOEss4q8f9kTxFsrrK0yzTDOal0zeVsikFKmnYi1xy1
         ISw/xdS0uAhog4e1fTOEADlDMT1LTOMPedDe904T1ZO1xypLhlaFsSaeUjrSXaUz6fFk
         msQHGNFimxoQ+TOS/hoLyrv1/fbNc/ptM/wx+RLmFSGLlTDitFY8whrioOlTCio/r8RJ
         kf7fNFbYz1FDSf1lcNFUE8BVZf9eCYbnaM+F9qAETfZ5JX+dy6Dc7IZB7eKVK/qH0GCF
         upeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBnNbiH+hab12DiOKBd4pcQP1xg7aEKLvUH64+SdruU=;
        b=FPxZRrvochmZbnTpDdnm/Cmu+fSgNW8zFwrmyB70FVnT+tNEfrHyGqhwh8L4cFYcoD
         dfmSpJ2lMStttjmK0twijBt6ymI9vbGmNz6B5jU2FNm+YqDnPpgX9b55PYKGQ51iR/j5
         n9QZhRT3I8J2Qf+Wdt76PwL9sRHBtYqS4UK69ZYko07+7VVkC6mtoAMYVkYIvswEd6CL
         rtKQlhGOn3jpEtAFLtpUWKjuL/Rr+uD3Q/oXgwNmSXdCr6WG2BigyX8m9CfX5St8P2lN
         cwmcGmf1VpkzVy3zg3a0NqBlkhhFWlburpNK19PLKm+BLy/Dhd1OKHkSRQqIpF0usFOU
         xB0g==
X-Gm-Message-State: AO0yUKXKWgD5OGtwR4HH2+1uIHVQkMaqPfQqN0xpzn/FsqR+AyF1zaKl
        BT86ecxW/szVaY05SJDV5Ls9hBIi3EKQ
X-Google-Smtp-Source: AK7set/W4P4gwQTQ14PucGRNx4H4xnyILVPXxlki8k+imj9Y/kafkRTfhg634nDIsQh4lilI/Yabl8NyXI7+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c6:b0:97a:ebd:a594 with SMTP id
 w6-20020a05690210c600b0097a0ebda594mr390732ybu.3.1676799250687; Sun, 19 Feb
 2023 01:34:10 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:34 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-38-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 37/51] perf expr: More explicit NAN handling
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

Comparison and logical operations on NAN won't ensure the result is
NAN. Ensure NANs are propogated so that threshold expressions like
"tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15" don't yield a
number when the components are NAN.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 635e562350c5..250e444bf032 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -127,7 +127,11 @@ static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
 	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
 		assert(LHS.ids == NULL);				\
 		assert(RHS.ids == NULL);				\
-		RESULT.val = (long)LHS.val OP (long)RHS.val;		\
+		if (isnan(LHS.val) || isnan(RHS.val)) {			\
+			RESULT.val = NAN;				\
+		} else {						\
+			RESULT.val = (long)LHS.val OP (long)RHS.val;	\
+		}							\
 		RESULT.ids = NULL;					\
 	} else {							\
 	        RESULT = union_expr(LHS, RHS);				\
@@ -137,7 +141,11 @@ static struct ids handle_id(struct expr_parse_ctx *ctx, char *id,
 	if (!compute_ids || (is_const(LHS.val) && is_const(RHS.val))) { \
 		assert(LHS.ids == NULL);				\
 		assert(RHS.ids == NULL);				\
-		RESULT.val = LHS.val OP RHS.val;			\
+		if (isnan(LHS.val) || isnan(RHS.val)) {			\
+			RESULT.val = NAN;				\
+		} else {						\
+			RESULT.val = LHS.val OP RHS.val;		\
+		}							\
 		RESULT.ids = NULL;					\
 	} else {							\
 	        RESULT = union_expr(LHS, RHS);				\
-- 
2.39.2.637.g21b0678d19-goog

