Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CADB710602
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbjEYHMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbjEYHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FDCE58
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56561689700so6270037b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998723; x=1687590723;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hra6WZ69L60AglI3672uw9bYTDH1KKdTR4WzF2eX2xU=;
        b=TA8mB11I1h+QeQQMXUG+vE9M/EN78BRwaxlLxUeqzVJ34TnG10IS0ugy3AVMvd9/xC
         eMPwd9a/QSq0g2ImBqKqt7J/QfGPS28JdZVv5y9SymqrKJdeoA85n3wRz88Y42poyCXf
         LTrwJ6kjvw5GcPH61PUch/P3C9WkzlUoESnNK825zrFM0TJZAalIEQakn7KWQ8T6s63P
         5QsBLD9b6Z/MIUiWBm+ZmnOaq0fTx9MJJ336uGoTCx8VWt0UF6xr6eQrx8JJFkL6N1Gc
         ZFtC1f44h1U+lclYFbSBZNy9wNKyLL3C/P3j+JlWhhivKTQuB1oQzgNJr3cAWmbbTz0x
         nfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998723; x=1687590723;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hra6WZ69L60AglI3672uw9bYTDH1KKdTR4WzF2eX2xU=;
        b=R1/BQ54Hp/LrdpDM8PApK4co+LXIY6miI/IQ4kC3/ZtGZYHFQxurt03YoHQboxVQgI
         v8evc7ktafK1zuvwm3EbWIQoORorN+kyQ/6sPbvisDI7dKzF4Ud5w2k6+TsxSkk/+oY6
         0VU3oV+5vC+uA4cLmE9ZE/EjupDFJNQM573lsQy5Tq59AYsVo1Q5o5NKO49lsiNBxzZy
         LuzKjAugiAdqvTyPtyG4cs2ntn6zdrCMXjLldYxYNaINedi8qZBZbzUrJDLM2bm03odY
         yV0MrdKcPBcfr9yxXHi//lSSITSZHZOrCAb/RT1DDU+fqwTu//2armqSwlApkZtFbpuK
         kV9A==
X-Gm-Message-State: AC+VfDxQpj/bHxE1aRJ3l8MmKsXUJ6o2wcdh6Ex2pBC0OEgLjPV60z4d
        PJKmURKEwIxLYmW4WhaRLQRPw+0mip3w
X-Google-Smtp-Source: ACHHUZ7jaebbxMj65Qp3RY/tMW9DiUNK6wQ5cXeeS7I29t97r1ExaRLt2iqCakfQG8xC2up0vFMD8BAVirTh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ae09:0:b0:55a:8930:b13 with SMTP id
 m9-20020a81ae09000000b0055a89300b13mr12708203ywh.9.1684998723538; Thu, 25 May
 2023 00:12:03 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:19 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-3-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 02/16] perf test x86: insn-x86 test data is immutable so
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
2.40.1.698.g37aff9b760-goog

