Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF96A2E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBZEXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBZEWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:22:18 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC113DCA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:22:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso2039550pjs.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkztQHJFG8E1HY0jnPOj65OXed/JJ8e8RRCYx562Gss=;
        b=rdGn+rf3EDX9CoYEE1C9HkAkC13CzlzzeZwDTwdu2uovrBiZCP7QAv8NiebbDMvT8T
         JHhdIv62FpvSbHs1zot1bC8VmC71l4Km4a5aQlLtRIQjU+xrViz0kF9urSHjWDwjFYT3
         qzmK4ItBVCMfBq+7/H6PYN8ooO2M9cYKvbXdJVBndfNafw/oFKBMpUc6XdqYCnD7Y6VG
         kQa5Nuc+xsPLcsvGCttpBLXLc3rc8AP024x+i9Aj1CjQQ4S9/Htt1sOYR8aM5xJBD+ND
         FXnk2AQB26lvVQ5mlDFeg5DBXfdox0OT3Yweyr/lbczjd9MOhmo+i9ZdWn7k9p2lpygf
         hSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkztQHJFG8E1HY0jnPOj65OXed/JJ8e8RRCYx562Gss=;
        b=fUzOAcN1KbTEMSjb8//gY8/vIasL7gdNxfBRv3HD86t74+DS3cA6httTFsw5Q5Pgbx
         zzl4vmHRkYhGCRPGhpt5U4ygfxNu3xQWeFS0dPKGliLP08rCYyNm/TGKN8RnY1IN1YHp
         tblCIo8MbrGIPEGEj9DUt4qnWRdWaEvjvUvDng3Sgp3qRk9IQOrUe0aGgaItnCZPujNv
         5Sy/s17umB9as8gTejg7kqz9ATRdICBnzmM57TArCeucb6aQxFwPQRVhL7MBpHS5KHOJ
         cxsM8UjxKqP62nrKXEOmOGftvvEXTeFjdvHnpxiju0p/ZZdO7MXfTiYNjw04o2zVmBpW
         Y4mQ==
X-Gm-Message-State: AO0yUKWXbFbn9OIh+m1BZPGRsEtW1jQYn5Xl2HCp+TwGHKcBBIN86mvl
        vex65Mo9J5a89nuzvyLyDI8jFQ==
X-Google-Smtp-Source: AK7set+TXjDoU3ITiFcCYO8sve9Pfp//o1f/rvAn0oCkU01bwS3v67bVJT87Af1odtFsZXDNzCo2gg==
X-Received: by 2002:a17:902:fb90:b0:19c:d97f:5d20 with SMTP id lg16-20020a170902fb9000b0019cd97f5d20mr5995110plb.38.1677385316213;
        Sat, 25 Feb 2023 20:21:56 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:55 -0800 (PST)
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
Subject: [PATCH v1 13/14] perf kvm: Add TUI mode for stat report
Date:   Sun, 26 Feb 2023 12:20:52 +0800
Message-Id: <20230226042053.1492409-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 tools/perf/builtin-kvm.c   | 101 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/kvm-stat.h |   1 +
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 5b1b2042dfed..3851e5798d75 100644
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
 
@@ -506,10 +508,89 @@ static int kvm_hists__init(struct perf_kvm_stat *kvm)
 
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
+static void print_result(struct perf_kvm_stat *kvm);
+
+static void kvm_display(struct perf_kvm_stat *kvm)
+{
+	if (!use_browser)
+		print_result(kvm);
+	else
+		kvm__hists_browse(&kvm_hists.hists);
+}
+#endif
+
 static const char *get_filename_for_perf_kvm(void)
 {
 	const char *filename;
@@ -988,8 +1069,12 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 
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
@@ -1587,7 +1672,14 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
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
 
@@ -1596,7 +1688,7 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 		goto exit;
 
 	sort_result();
-	print_result(kvm);
+	kvm_display(kvm);
 
 exit:
 	return ret;
@@ -1703,6 +1795,7 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		OPT_STRING('p', "pid", &kvm->opts.target.pid, "pid",
 			   "analyze events only for given process id(s)"),
 		OPT_BOOLEAN('f', "force", &kvm->force, "don't complain, do it"),
+		OPT_BOOLEAN(0, "stdio", &kvm->use_stdio, "use the stdio interface"),
 		OPT_END()
 	};
 
@@ -1720,6 +1813,10 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
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

