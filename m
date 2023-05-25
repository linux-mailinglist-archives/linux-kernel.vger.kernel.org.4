Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04C6710604
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbjEYHM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjEYHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A5E5D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56536dd5f79so6980187b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998725; x=1687590725;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlPCaRU+xHpyvioAMBbcb2cR7GEOpahymP580BUT4pI=;
        b=M6eC7xv1W49Kd+3AAhL16c4FxlLAHUGtjeSE3jeiHUFigV8dfF2e0FuBIvWEhAm9xa
         Wybcgh7qY65Mal3Nz0SyQfniolccJN95JfAnWffnzmJv070XF9OJFuFoTNKyaHjifl1s
         U6M03gV3GMRDxp7ZR3pc0IIaOLUzqK/bsSv+HIlvvAZz8SUyB+a5uF4EA3HKwAgRjXCd
         dgHYmML0KaPHZ2t7f80SX4LrAJKx3PZr1+OToNMlkx2zdPkT1kcJ0IxfKeyPZ/umqH1w
         11i2WaL6LmX9aMuoc5pKrcWE7lnjsL4/dOOdcfvNw6wulUf+WjOvlW9vBZ9G5bLeNyz+
         ZEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998725; x=1687590725;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SlPCaRU+xHpyvioAMBbcb2cR7GEOpahymP580BUT4pI=;
        b=OA2RRucb2i9e0kecp9Gn/WVGOkiahenmXzrUpU2oZYu63LP7J7QJf0alhrLwU5zQQg
         1LsNaKJT+EVQda5gMEaS1roncroQLv4J0KJuOJFFuOHgD1W7RfLaOWXDlGxk07DmanIj
         njwH4MHG5y/LyZ8MfSFEz7mwp6/SvIFWrgqxc1cbeJOPn4B8+1+ouX3oZDzGH6j18fRu
         APx5EaT3TM78LP708IbZiKW7yrPsaKVcqNQq2CBlED86uzRbFrjAmaa8YfLSjWlhktq/
         Jl6MVZovuEnBXOV07bNm5lkpPD8oJ6NHHB1Ublz8SHsae7EVBhM7dPggUIetuWU61RvW
         rRDg==
X-Gm-Message-State: AC+VfDwh/OqYj/itJZRhcgmAZPJjYiZ4aLiTzL0iIQzmmrLDz2cp27jx
        rxBXcr+ay1TwvS8w7zCCw0tEjMRDtFjq
X-Google-Smtp-Source: ACHHUZ5odFseIone018NrJslT74WKcaZ+KqvkC0Y8yT+cUfEo8eJExKfPDO0M2qefVV3PFJdZ1ON1G3gJ82k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:ae26:0:b0:ba8:2e68:7715 with SMTP id
 a38-20020a25ae26000000b00ba82e687715mr1665664ybj.2.1684998725497; Thu, 25 May
 2023 00:12:05 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:20 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-4-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 03/16] perf test x86: intel-pt-test data is immutable so
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
2.40.1.698.g37aff9b760-goog

