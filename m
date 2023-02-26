Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE846A2E23
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBZEW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBZEVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:50 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C75D33C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h8so232803plf.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCXvY3VOyromxWZSsh4iONVhiGPWxZ3OU8P5j9wqMDM=;
        b=DaNxzuvhNXQ4wLJCYxYJ+wm5GTMCmnmX7mKLaXKDpQ/55+I+7Uan/JFCiCyRt25vc9
         wN0dRrC09xps5a0nKV6Yxww+EuFZuq178G7Eh/kj7U2GBoZTCFQ4U9iuyb/hWEq0VizP
         5CFx+8zCFmcfZhizaPIS5ChS8G2rbUatvmxq2er3inqcRB6kb18KJKz6+2ISDgouLrZD
         SjNrXh2mP0TXtK15gpllKaDJaTfA3CNou4LYFtAmygJODh8aA9QTsY1GlW7+43DOQhr9
         6b3B08uFMqKIMnVa4VUL4blCAutgcB8gqWd23/bLXyLGSAlyABo0wNOFcgHpRsq8j+o3
         blPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCXvY3VOyromxWZSsh4iONVhiGPWxZ3OU8P5j9wqMDM=;
        b=DpDk6x79jq6PXEmsY1Ojj5pLwYYJuEQytFW7C7Emj/pc+GdybXKqLM4uRD0aXIFMhD
         nEem6uASAo6eEAOPpILePwTtXz4+HCtwcBM+WRsfGqVKWaQhsuJhPIjPpqy1DSeRXosl
         cgtXvJAAoMtEUpKazo+aDfmwWZgb9Z85+HieWkMDm8KxWuFgF5wMOyl2cj9m/7S08JEQ
         6PiGOdwxm9nj5XAUllIoDH7QGDggvV9rDExd1xDLdhHiGXjUhZhK+59u6PkHQBcANBp4
         NWtmvL6cq24KLtjG3v9CpOZUrIJ7QePnnQVFV1sMTWBhAh5OR2PtfIkZUdc6aQjtPsaR
         boTg==
X-Gm-Message-State: AO0yUKWzyD7xB2IMHSY7O4gbhGzZLtmoQVYcBuHcRt9iqFuy56v7lwuQ
        EBekI7weVajn7GRfmuCm1td4lw==
X-Google-Smtp-Source: AK7set+V2MihlpZmRYi8DJrjsaU7OadR3+v1rZvW4ZJkAo+N6PyadTQpdQRpaf47UjZPBy76vzH15w==
X-Received: by 2002:a17:903:2347:b0:19a:9859:be26 with SMTP id c7-20020a170903234700b0019a9859be26mr4289506plh.22.1677385292839;
        Sat, 25 Feb 2023 20:21:32 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:32 -0800 (PST)
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
Subject: [PATCH v1 07/14] perf kvm: Parse address location for samples
Date:   Sun, 26 Feb 2023 12:20:46 +0800
Message-Id: <20230226042053.1492409-8-leo.yan@linaro.org>
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

Parse address location for samples and save it into the structure
'perf_kvm_stat', it is to be used by histograms entry.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 5 +++++
 tools/perf/util/kvm-stat.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 779881901a05..a9f467926bdd 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -704,6 +704,11 @@ static int process_sample_event(struct perf_tool *tool,
 	if (skip_sample(kvm, sample))
 		return 0;
 
+	if (machine__resolve(machine, &kvm->al, sample) < 0) {
+		pr_warning("Fail to resolve address location, skip sample.\n");
+		return 0;
+	}
+
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
 	if (thread == NULL) {
 		pr_debug("problem processing %d event, skipping it.\n",
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a3219829c448..80d5c5a9ae31 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -7,6 +7,7 @@
 #include "tool.h"
 #include "sort.h"
 #include "stat.h"
+#include "symbol.h"
 #include "record.h"
 
 struct evsel;
@@ -86,6 +87,9 @@ struct perf_kvm_stat {
 	const char *sort_key;
 	int trace_vcpu;
 
+	/* Used when process events */
+	struct addr_location al;
+
 	struct exit_reasons_table *exit_reasons;
 	const char *exit_reasons_isa;
 
-- 
2.34.1

