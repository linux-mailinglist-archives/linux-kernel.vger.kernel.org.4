Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53C6A2E21
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBZEWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBZEVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1835EB4A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z2so3504060plf.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA7VJN/YcBA7IE+nNQeWn+LVdWT4KUb0IqvxyHZoo8o=;
        b=yphIfzPv05IfIc6/1JjUPJ2e4gRqh66jjIcuDpczDTonK4ArNDx4y+So9iG0FMtm+/
         fwWtRRUmcMe1HVG0qrTS8NjNGGMnRU9KhkbxYie5RvfCuq7/FgRvvmaJzxwydmMkjVzu
         UnbD24ww//iKoNLFEDWeX4KsWPKo4L3T05BneHWWd5BqF+AWwutZPpmnBmKMHojrRPmB
         3VFlySGh9zIo3/PNDaXbHTEjGeb1AlwlxtwACkBH6vGUKuLwkSlxdpN1B6TP/nsPqkyW
         qoWK9BoM5ZaMZggeuyCqYR+kDHIyZn/Z6sfAlqzH/yJfPDC6k7RYPGElCxaxc3g+dVXk
         GRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA7VJN/YcBA7IE+nNQeWn+LVdWT4KUb0IqvxyHZoo8o=;
        b=PGfF+GIPCNwjw4e0RUZrlJUQsje5LYEAimE44YE2dfNpp5UttBf1ckYs3yr21VqQlI
         Ddyl6rXiNSIClmB+mBGlHSgbYfhkuGi+P7PJ3sD1A4gQrSoHaFNz7t4YLRv32v4LHT4j
         su+JeB/c8OmWD0DLtFEqmyPEJmD2Ev6TmHG4pHgbvlSmwrvkYKj/uJnjFFC8I62lzPg5
         8WMxVLQzVVQY7jcK+M0s0k7E+OzDt7Hvf/csLwLztdUJkFfFK0U5GaAlpFiAnlYrq0TI
         6SrZqTn/ln4xqzWO5FuyNBFR8B8W+GO98sk5QvjWJFKgE/W7OvvrpUGQm5sFMnmcbZKs
         6YxQ==
X-Gm-Message-State: AO0yUKXGIL1tNu6CnQl5ocuRPDT9FyyiJtj+1t2SsCBDhHYnl7vldmO3
        SX83/ZLdupVC0MXTb1WGXdZTHA==
X-Google-Smtp-Source: AK7set8vNeV+3T/sIVqYTTFSdekoL/MKxMsPS57H24aP7VTKLtxQw18XhaGNJw89YOrVjSHLRaRg1A==
X-Received: by 2002:a17:903:2283:b0:19a:ae30:3a42 with SMTP id b3-20020a170903228300b0019aae303a42mr5383543plh.21.1677385285179;
        Sat, 25 Feb 2023 20:21:25 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:24 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 05/14] perf kvm: Introduce histograms data structures
Date:   Sun, 26 Feb 2023 12:20:44 +0800
Message-Id: <20230226042053.1492409-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation to support histograms in perf kvm tool.  As first
step, this patch defines histograms data structures and initialize them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 18 ++++++++++++++++++
 tools/perf/util/kvm-stat.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 6eec0db2dda6..4ae54ba4fdaf 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -85,6 +85,20 @@ static struct kvm_event_key keys[] = {
 	{ NULL, NULL }
 };
 
+struct kvm_hists {
+	struct hists		hists;
+	struct perf_hpp_list	list;
+};
+
+static struct kvm_hists kvm_hists;
+
+static int kvm_hists__init(void)
+{
+	__hists__init(&kvm_hists.hists, &kvm_hists.list);
+	perf_hpp_list__init(&kvm_hists.list);
+	return 0;
+}
+
 static const char *get_filename_for_perf_kvm(void)
 {
 	const char *filename;
@@ -957,6 +971,8 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	set_term_quiet_input(&save);
 	init_kvm_event_record(kvm);
 
+	kvm_hists__init();
+
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
@@ -1152,6 +1168,8 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	init_kvm_event_record(kvm);
 	setup_pager();
 
+	kvm_hists__init();
+
 	ret = read_events(kvm);
 	if (ret)
 		goto exit;
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 40a4b66cfee6..a3219829c448 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -5,6 +5,7 @@
 #ifdef HAVE_KVM_STAT_SUPPORT
 
 #include "tool.h"
+#include "sort.h"
 #include "stat.h"
 #include "record.h"
 
-- 
2.34.1

