Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239BC6A589E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjB1Lxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjB1Lxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:53:32 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B221954
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c23so9507479pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JejwbkE0SW/Fq6/DugwFIOqvWMBBxjg6ekVlYn5zaW0=;
        b=JrXFg3xf10Yfn2iwMT0Gay/nRRy2177rQRMSOe3akRXKr5DvA+LXtueqlg2sQyOmtB
         fICl8x4NDS8jdeiiYc168J+7nrC/yMRax/u/Z+NMcKI8pte6dX/ueMclSlJXr9nBIhHa
         hlwO/AHxu+a3C1GwC/IUAzCrV5BGkkQsEfK5XgaJAhGpZcSv09IPqTlzyjf5QljvvDfE
         hu73XDRYmx/Umf3ss3e6K6mRpVUN2WY7niotltge0C1Pe1/zIn2O+Py2nsVpys6rO9VV
         WtY1nUHXooRvKdyaheo2zAMFdhDkZdVOcC5zPT0Lb4yGtVgygCz/dsbKpsaq5COmxr4B
         DLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JejwbkE0SW/Fq6/DugwFIOqvWMBBxjg6ekVlYn5zaW0=;
        b=rMGmpnIMM37/NyiPu6HbDoRaBDYNk6LeR7Dt/XDVdgl50vElDh2FUpALzGKg8YKVMi
         d/wzMkmmA2D37UhsTTjvMxW9e57dGd0EdLO67Tor4CTcwEfBqi/QD2/6KbQqT8n/1Wuv
         VqpYSz/bAEDP4002yKNANtNu+DJveiIAjV3N87XOaiMhaGLAB+TB1PIb+js1Y+UTO5MR
         KG+/Jy21QC+990Vq5IQ98K8NDUpCTwwzS+c1opjBo65tPLYvZZVaui9x7VHsMZpLJCNL
         VllYLuvw6k0vBEdNnSze4z7Vtui5R1qwWjRU+BljgQI0MVqgg+VGZa8nlUHqVpzUtbaQ
         W4XQ==
X-Gm-Message-State: AO0yUKV05U1fylsZXKmyj9Y/FG9/8ALfgUTbXAiD4LI/cQf5L0FD5kd9
        0ua/7jppvofPKHSvE2lJM8cFmQ==
X-Google-Smtp-Source: AK7set+OhY2iyERAW9jX8ez1+PG+4kZtkEX/evSCTeN9uyVDyxih01bY2TtUYP9nVnAgScKdtpmacA==
X-Received: by 2002:a17:90a:19de:b0:233:ca14:6ae8 with SMTP id 30-20020a17090a19de00b00233ca146ae8mr2899553pjj.45.1677585197539;
        Tue, 28 Feb 2023 03:53:17 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:17 -0800 (PST)
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
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 05/14] perf kvm: Introduce histograms data structures
Date:   Tue, 28 Feb 2023 19:51:16 +0800
Message-Id: <20230228115125.144172-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
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

This is a preparation to support histograms in perf kvm tool.  As first
step, this patch defines histograms data structures and initialize them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
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

