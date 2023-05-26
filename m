Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF4B712C81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjEZSe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbjEZSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C21B7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso2702455276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126054; x=1687718054;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhs20KFbrBjMvIkaCaPHOIOyU5CqMAw5GkT0rX0TX0U=;
        b=pDsfCR/qApd6BnNf5BC300XSLP2L05MlgSQ/+ZqWZ3VQmMjw4LHyrVtWRt03skSLoI
         3ubDd7OwPnvf3CKmlqt9hJodEoCcRbQBzDr1oIaDNNewcZ5aJdnSGU1/LrGfohkCGu3u
         GMUW+z2+VWYhlPciW/c3oBk78a+bx0ItNwaXGGh+UCAaaAKMfOcKbYrdNO5/tdC0rDzK
         NU2qxy0/rSKHcTxt+lZuSrGE6rpmeqsegRhDeuXl0xf2VDShbDU1xAC+ba8Jpx2QFmQq
         Q4tph4YXASgoo+KuJVAuenGVuKWZAGR/AWDGO4v0pSa69npEyf0nMDiz4NcUU9enCocq
         TaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126054; x=1687718054;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhs20KFbrBjMvIkaCaPHOIOyU5CqMAw5GkT0rX0TX0U=;
        b=WPV8IVAX7vd8j5CJxjFGe1WmRRNqFjpgpe9phs+MR00eFYzlFqujMgt1Lg2atnm7cs
         vwExJn797ndpbCSbDIdfLDzsAQZIQIUZ4W+1CnMIEXEbfUBcBNFuw0sjk7f/OVsQhcPN
         VIMFf/ag/hTC2US4Z+MXTUO9+6dFIiiJj3/Go8PIKEOIvXRKxIPiTYMvXPktZUYUrrnO
         lc9SyFD47upEzxM/sA9CQ7NSl+sdHrV6ldIWTYZI0SOvvDwZ7FIYQNJA1C/hMcvY4RRj
         HYqNjwt3s7ZCLC6ljzRdomFQtoBlOnOYIKbX6nfx5IAKfmkJG36qhnIUSOsGK8MfmLCP
         aGnQ==
X-Gm-Message-State: AC+VfDwV/emNGlytaPZTEK2asqEZvxEbpM3//q4rfLcn9oWK/1pvKyzR
        P6Ell7prYCdnj1KztRG/vK/9ILjV3DGY
X-Google-Smtp-Source: ACHHUZ6+rvkIOvNHoGwO95tDYhf6xgF/LAx36BZB1O5qRld+APf77syKzYKfTngPqwODAWdeN/l+yodizVw+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:8211:0:b0:bad:14ac:f22e with SMTP id
 q17-20020a258211000000b00bad14acf22emr999303ybk.5.1685126054570; Fri, 26 May
 2023 11:34:14 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:47 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-3-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 02/16] perf test x86: insn-x86 test data is immutable so
 mark it const
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

This allows the movement of some sizeable data arrays (168,624bytes)
to .data.relro. Without PIE or the strings it could be moved to
.rodata.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/insn-x86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index 735257d205b5..7b5eb8baf0f2 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -18,14 +18,14 @@ struct test_data {
 	const char *asm_rep;
 };
 
-struct test_data test_data_32[] = {
+const struct test_data test_data_32[] = {
 #include "insn-x86-dat-32.c"
 	{{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \trdpkru"},
 	{{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \twrpkru"},
 	{{0}, 0, 0, NULL, NULL, NULL},
 };
 
-struct test_data test_data_64[] = {
+const struct test_data test_data_64[] = {
 #include "insn-x86-dat-64.c"
 	{{0x0f, 0x01, 0xee}, 3, 0, NULL, NULL, "0f 01 ee             \trdpkru"},
 	{{0x0f, 0x01, 0xef}, 3, 0, NULL, NULL, "0f 01 ef             \twrpkru"},
@@ -97,7 +97,7 @@ static int get_branch(const char *branch_str)
 	return -1;
 }
 
-static int test_data_item(struct test_data *dat, int x86_64)
+static int test_data_item(const struct test_data *dat, int x86_64)
 {
 	struct intel_pt_insn intel_pt_insn;
 	int op, branch, ret;
@@ -147,9 +147,9 @@ static int test_data_item(struct test_data *dat, int x86_64)
 	return 0;
 }
 
-static int test_data_set(struct test_data *dat_set, int x86_64)
+static int test_data_set(const struct test_data *dat_set, int x86_64)
 {
-	struct test_data *dat;
+	const struct test_data *dat;
 	int ret = 0;
 
 	for (dat = dat_set; dat->expected_length; dat++) {
-- 
2.41.0.rc0.172.g3f132b7071-goog

