Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3C6A54A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjB1IoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjB1InS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:43:18 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC37955B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:56 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id h31so5155040pgl.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDkwPaQEOTBzYzqPisJaEh7NsOd42gLqOAC1p2FbXvM=;
        b=z0IOKzTGAOai7e0Qt1kuE+D6nfuSe1gjosV9N/N2vspuxUAw0dq8gc87/A25m5HAvT
         KMnd9uEEwYS8+gtjLxRE+ZZShmPuyc8ZFgfMwLjRLShNHYjImqo0+y7PNGt25GZBAClN
         BTLY/phrQFIpqGxuS07MiwHdJpbdyD+3R4mKL0MiK1KNypYhrF31TKNBwd1YRC+FExn4
         x429KCKCfQQ4FzDvatEs5kbDGvjkPMlHBfLrj2imZ6TdfLY9dXjOGkDTBLir4mJxUd/G
         QllzUIEiZ9xg73nJBcCFO0CThPRg4qkYwaQT6PwffRbf932eBKpMZJUNxLgvzL95f0ci
         wL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDkwPaQEOTBzYzqPisJaEh7NsOd42gLqOAC1p2FbXvM=;
        b=mP4JO6g/ib4oO4P3NzBJ+z2wCqFVY6xZCRjeIfL++EPNyOI5RHDCcrxLc+V9bg/PHa
         TU9RJhbFZBSBWBRz2Bi3MdBebUfY9rC8kPJGH8qe7JLYZ/DHvp5tWEj8XKAe+vyyx16F
         QMi3Y0gnGMN3AbWF7shXLSPeC0hANypnsEWaD+i43CpNCE01RNbVfsOTjlIKjWtGTXM4
         vxWnCUa54ajXHQDvPZuy1Dk/FNgCxAC1/YzWzmojDRqH6DNkAgzQSkLqLsvUH00vXd//
         T/ip3MzuPDGYw95jEkNyDVHvqnOA5WtSi/11+SwKcx6uz9z85VVBwn3trcHNKrthIZjv
         ro9A==
X-Gm-Message-State: AO0yUKXNHPbVV4LoYFhVa4Z6dIzaVu/oMnNTdzU8ton9yPQGNtt4Tuv+
        RbBw8DlIc7ADb+Us6IuVOTCFcQ==
X-Google-Smtp-Source: AK7set/rxO0nwUO7JSO1wNCD6d8xQsZaroriXGmPDEuas0CBh0KK+mcRu9/2OFxUyS/vViRS5h1YkQ==
X-Received: by 2002:a62:6586:0:b0:5a8:5e6d:28d7 with SMTP id z128-20020a626586000000b005a85e6d28d7mr1968099pfb.0.1677573776087;
        Tue, 28 Feb 2023 00:42:56 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:55 -0800 (PST)
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
Subject: [PATCH v2 13/14] perf kvm: Add TUI mode for stat report
Date:   Tue, 28 Feb 2023 16:41:46 +0800
Message-Id: <20230228084147.106167-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
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

Since we have supported histograms list and prepared the dimensions in
the tool, this patch adds TUI mode for stat report.  It also adds UI
progress for sorting for better user experience.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 110 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/kvm-stat.h |   1 +
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 5b1b2042dfed..b0be59577779 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -23,6 +23,8 @@
 #include "util/data.h"
 #include "util/ordered-events.h"
 #include "util/kvm-stat.h"
+#include "ui/browsers/hists.h"
+#include "ui/progress.h"
 #include "ui/ui.h"
 #include "util/string2.h"
 
@@ -506,10 +508,98 @@ static int kvm_hists__init(struct perf_kvm_stat *kvm)
 
 	__hists__init(&kvm_hists.hists, &kvm_hists.list);
 	perf_hpp_list__init(&kvm_hists.list);
+	kvm_hists.list.nr_header_lines = 1;
 	return kvm_hpp_list__parse(&kvm_hists.list, output_columns,
 				   kvm->sort_key);
 }
 
+static int kvm_browser__title(struct hist_browser *browser,
+			      char *buf, size_t size)
+{
+	scnprintf(buf, size, "KVM event statistics (%lu entries)",
+		  browser->nr_non_filtered_entries);
+	return 0;
+}
+
+static struct hist_browser*
+perf_kvm_browser__new(struct hists *hists)
+{
+	struct hist_browser *browser = hist_browser__new(hists);
+
+	if (browser)
+		browser->title = kvm_browser__title;
+
+	return browser;
+}
+
+static void print_result(struct perf_kvm_stat *kvm);
+
+#ifdef HAVE_SLANG_SUPPORT
+static void kvm_browser__update_nr_entries(struct hist_browser *hb)
+{
+	struct rb_node *nd = rb_first_cached(&hb->hists->entries);
+	u64 nr_entries = 0;
+
+	for (; nd; nd = rb_next(nd)) {
+		struct hist_entry *he = rb_entry(nd, struct hist_entry,
+						 rb_node);
+
+		if (!he->filtered)
+			nr_entries++;
+	}
+
+	hb->nr_non_filtered_entries = nr_entries;
+}
+
+static int kvm__hists_browse(struct hists *hists)
+{
+	struct hist_browser *browser;
+	int key = -1;
+
+	browser = perf_kvm_browser__new(hists);
+	if (browser == NULL)
+		return -1;
+
+	/* reset abort key so that it can get Ctrl-C as a key */
+	SLang_reset_tty();
+	SLang_init_tty(0, 0, 0);
+
+	kvm_browser__update_nr_entries(browser);
+
+	while (1) {
+		key = hist_browser__run(browser, "? - help", true, 0);
+
+		switch (key) {
+		case 'q':
+			goto out;
+		default:
+			break;
+		}
+	}
+
+out:
+	hist_browser__delete(browser);
+	return 0;
+}
+
+static void kvm_display(struct perf_kvm_stat *kvm)
+{
+	if (!use_browser)
+		print_result(kvm);
+	else
+		kvm__hists_browse(&kvm_hists.hists);
+}
+
+#else
+
+static void kvm_display(struct perf_kvm_stat *kvm)
+{
+	use_browser = 0;
+	print_result(kvm);
+}
+
+#endif /* HAVE_SLANG_SUPPORT */
+
 static const char *get_filename_for_perf_kvm(void)
 {
 	const char *filename;
@@ -988,8 +1078,12 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 
 static void sort_result(void)
 {
+	struct ui_progress prog;
+
+	ui_progress__init(&prog, kvm_hists.hists.nr_entries, "Sorting...");
 	hists__collapse_resort(&kvm_hists.hists, NULL);
 	hists__output_resort_cb(&kvm_hists.hists, NULL, filter_cb);
+	ui_progress__finish();
 }
 
 static void print_vcpu_info(struct perf_kvm_stat *kvm)
@@ -1587,7 +1681,14 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 	if (!register_kvm_events_ops(kvm))
 		goto exit;
 
-	setup_pager();
+	if (kvm->use_stdio) {
+		use_browser = 0;
+		setup_pager();
+	} else {
+		use_browser = 1;
+	}
+
+	setup_browser(false);
 
 	kvm_hists__init(kvm);
 
@@ -1596,7 +1697,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 		goto exit;
 
 	sort_result();
-	print_result(kvm);
+	kvm_display(kvm);
 
 exit:
 	return ret;
@@ -1703,6 +1804,7 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		OPT_STRING('p', "pid", &kvm->opts.target.pid, "pid",
 			   "analyze events only for given process id(s)"),
 		OPT_BOOLEAN('f', "force", &kvm->force, "don't complain, do it"),
+		OPT_BOOLEAN(0, "stdio", &kvm->use_stdio, "use the stdio interface"),
 		OPT_END()
 	};
 
@@ -1720,6 +1822,10 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 					   kvm_events_report_options);
 	}
 
+#ifndef HAVE_SLANG_SUPPORT
+	kvm.use_stdio = true;
+#endif
+
 	if (!kvm->opts.target.pid)
 		kvm->opts.target.system_wide = true;
 
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a8e919ca59f4..b66eb4e8c547 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -97,6 +97,7 @@ struct perf_kvm_stat {
 	unsigned int display_time;
 	bool live;
 	bool force;
+	bool use_stdio;
 };
 
 struct kvm_reg_events_ops {
-- 
2.34.1

