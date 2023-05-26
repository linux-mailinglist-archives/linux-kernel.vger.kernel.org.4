Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92855712C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbjEZSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbjEZSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43AEE42
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4eefd3so1399023276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126057; x=1687718057;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQ6/7wH3wD+sz3l8jATNpn1TZP74J5iSNRHOLe9pzI0=;
        b=AUsGHk1c9uTHOghP5ICbKsK1um7JsTzGLRPWZUjJIfN5E2WrVSOFdOrqJu/tv99hd8
         ewuYNgOMwXmdbKIHQbdVpXweNIEL+jY7QjWrUeBKdHfCI1ck3e09pHpzzd63jjzW18Z1
         kPT2/UDwNRh94p9o+F5V7XEwAJ84y224EelIL3IaP+cb9H7SQer0EwFev6vh6UdUoeCF
         rBDj78sV7z3SLwRTYpKELGkD0sOqpNb5Nkqf+Nf5vtxruSzwDVY2/uMuO2yWujkVfBFu
         82gPmmJBt2/rQlTpIJMfKKSBMFQYDVHBOj7f7Rx3a29OOyyD1hz2O8fniSlJId5vB3c3
         u4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126057; x=1687718057;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ6/7wH3wD+sz3l8jATNpn1TZP74J5iSNRHOLe9pzI0=;
        b=C9zwWLp0rnw05xXESucgTYsA6iwiYSLCB2GzBFw7Kovu8zXsXKyV7f5+N3QTilrmUm
         IGp9l8DCUuCyyCD505FtL4U+jv6qm6Q67U3DrWdF0pt/Twszegayn7y+oZLoSp+aACwD
         PCiid7chsiEYxniJyOvbxKC9EEA/QfNkFvYP/2eZgXZbxM7wNAWiMtLDOByFZHA0a3V8
         WcdWcNq8eifxaXqVwR2OlByRgLNkhm0B5WB2le/SjCTEUUPh1zhOw2HQP+yq8MH72+Ut
         zC0sK/j5xvT7nNKLILtDbMb9YZnKwmu553x7ylcpnT08l2yJGRukXB/pbkJe7ve8czq6
         qSxA==
X-Gm-Message-State: AC+VfDy1y8z6lDhaije/9BVdIXD0vMKNoAg8K+4Sbzh6IiV+D4NN57Fb
        fbt98zgqK3wuTyfDcfM/xUKyX9a3tV5O
X-Google-Smtp-Source: ACHHUZ4zT9LUn7F28yS/jJQpZRHjLu6YwE5B/u1eMByll0FnuiZaqF3ZyXswJfnaDiLO+Qqj6Gts33K0tiQ7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:4542:0:b0:ba8:93c3:331a with SMTP id
 s63-20020a254542000000b00ba893c3331amr1404539yba.5.1685126056971; Fri, 26 May
 2023 11:34:16 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:48 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-4-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 03/16] perf test x86: intel-pt-test data is immutable so
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the movement of 5,808 bytes from .data to .rodata.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/intel-pt-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/tests/intel-pt-test.c b/tools/perf/arch/x86/tests/intel-pt-test.c
index 70b7f79396b1..09d61fa736e3 100644
--- a/tools/perf/arch/x86/tests/intel-pt-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-test.c
@@ -22,7 +22,7 @@
  * @new_ctx: expected new packet context
  * @ctx_unchanged: the packet context must not change
  */
-static struct test_data {
+static const struct test_data {
 	int len;
 	u8 bytes[INTEL_PT_PKT_MAX_SZ];
 	enum intel_pt_pkt_ctx ctx;
@@ -186,7 +186,7 @@ static struct test_data {
 	{0, {0}, 0, {0, 0, 0}, 0, 0 },
 };
 
-static int dump_packet(struct intel_pt_pkt *packet, u8 *bytes, int len)
+static int dump_packet(const struct intel_pt_pkt *packet, const u8 *bytes, int len)
 {
 	char desc[INTEL_PT_PKT_DESC_MAX];
 	int ret, i;
@@ -206,14 +206,14 @@ static int dump_packet(struct intel_pt_pkt *packet, u8 *bytes, int len)
 	return TEST_OK;
 }
 
-static void decoding_failed(struct test_data *d)
+static void decoding_failed(const struct test_data *d)
 {
 	pr_debug("Decoding failed!\n");
 	pr_debug("Decoding:  ");
 	dump_packet(&d->packet, d->bytes, d->len);
 }
 
-static int fail(struct test_data *d, struct intel_pt_pkt *packet, int len,
+static int fail(const struct test_data *d, struct intel_pt_pkt *packet, int len,
 		enum intel_pt_pkt_ctx new_ctx)
 {
 	decoding_failed(d);
@@ -242,7 +242,7 @@ static int fail(struct test_data *d, struct intel_pt_pkt *packet, int len,
 	return TEST_FAIL;
 }
 
-static int test_ctx_unchanged(struct test_data *d, struct intel_pt_pkt *packet,
+static int test_ctx_unchanged(const struct test_data *d, struct intel_pt_pkt *packet,
 			      enum intel_pt_pkt_ctx ctx)
 {
 	enum intel_pt_pkt_ctx old_ctx = ctx;
@@ -258,7 +258,7 @@ static int test_ctx_unchanged(struct test_data *d, struct intel_pt_pkt *packet,
 	return TEST_OK;
 }
 
-static int test_one(struct test_data *d)
+static int test_one(const struct test_data *d)
 {
 	struct intel_pt_pkt packet;
 	enum intel_pt_pkt_ctx ctx = d->ctx;
@@ -307,7 +307,7 @@ static int test_one(struct test_data *d)
  */
 int test__intel_pt_pkt_decoder(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	struct test_data *d = data;
+	const struct test_data *d = data;
 	int ret;
 
 	for (d = data; d->len; d++) {
-- 
2.41.0.rc0.172.g3f132b7071-goog

