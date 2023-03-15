Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8B6BB691
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjCOOwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjCOOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:52:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4195294754
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so2307323pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dWIAjzu4GgQ80mkmjPpe056TgbhyOFnv3PTrWVTdCA=;
        b=fUzax12tR1jc4yHd7um52yUFMB4DBpD59HmSPy6v2+XXoKDz2q9k8Miwh7oLSR05Ub
         kQfqCFoaWtwiET3HLUD/Wwm8NHCtxZh0xOND0EfXTSfXPpB9pax5H2wFZYq33eiXrmv6
         c6mEMagKB5KyibDwg2fnwH9zaUA5HURAgvayY2vZQxIfDVH72qUu0yQTVQHqlS5hGlUL
         cKYTKOYL64ufrUHf6+wk7p/Yc0egjNySxbPTxDIHVPr/ND3KoG1O28AREWQc2Y58wW0u
         QkIZ0p/3GfJVJUcv7u3S+AMTtkX46ac8IgOv7uniyAL2SYqSO53BEK3knnVNxFoSzZOq
         JX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dWIAjzu4GgQ80mkmjPpe056TgbhyOFnv3PTrWVTdCA=;
        b=AHj+mgsdxDxVYuDNHzUfgDXRv5xPlzFfn+V8FKAprK4QCbRl/McWbHcvmzrPepVSQu
         8GxWdIXpnViwZSqFAqF3CgH9OWxfBrKJmDesi3XD3nJAaUSs/PqepUZCR34eTiZzEJH8
         fhK233d/TuGYD/j/Auk1tYhAaEipXyklxwWU/qpZjn65OkxzgGz+Plox/c1ZNPwEN++3
         ne62qj4Xe3OXzYHLKTAgLkNEyX+yTXwi35B2GLIATUDyZhfSrPA8/ZHIBuBVDbya9/cU
         UL7ASklhMcbs76u8bvalg9BqnlSXQErp+fW06SJhrtN4ZWfgTCwsS35wa0KFlNqirZss
         sJTA==
X-Gm-Message-State: AO0yUKX6zHRa8AysJgFgtril8s9eMlt29IUWQXD6dkrvPnYCqJNF26C0
        VYWP4vrgkO2d+YzFD0fP+UKGew==
X-Google-Smtp-Source: AK7set+0vZiNilSAoQVttsUGF4dFlIy3XJFLbztvrLMK/BPFXynFDi8kiNCSEB7dOrxUJzH4eKLQ0w==
X-Received: by 2002:a17:903:410a:b0:19f:2b42:5d01 with SMTP id r10-20020a170903410a00b0019f2b425d01mr2475678pld.9.1678891924631;
        Wed, 15 Mar 2023 07:52:04 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:52:04 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 06/16] perf kvm: Introduce histograms data structures
Date:   Wed, 15 Mar 2023 22:51:02 +0800
Message-Id: <20230315145112.186603-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315145112.186603-1-leo.yan@linaro.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index d400434aa137..384992c8a01a 100644
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
index 841b3174c211..e2c17662bac7 100644
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

