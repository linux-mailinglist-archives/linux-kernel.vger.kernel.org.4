Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79646A58A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjB1LyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjB1Lx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:53:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC91B571
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id oj5so5553179pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV9q9AQ7PpikYhUvBV5aI2kpk7FdoFpdqjCf8IW8jGw=;
        b=bCcgKbxuDOTflQKpoQhNx01CaIPNoYsiLM9Ib/2v90GsIsckcYB9ufRIPxmbyEXCKf
         qRMUwfQTsYit5fncJpmA3lwmlhki1UH51NQXi9Idyd9SQVNXxHWRPtfu3IyWgGOBBB2o
         7CbqDr3twqzrQ5UDaiiq3vucmOjVD1LCHlQqhwVIMLNsVsVLvNeUWxTkmcI3Utt+ydTe
         4L9Z2TysgigWiYg5G+32ZAdszy8K2yoIHSDpaInj5cCQYjoC1qOUqFEAj4tyjlRKMDNZ
         5Eeb5bD7P4u4s48MsDLNSBoH5Jv1gTgwOmRNJ5gwmsmQYL+qQ78CAaNne7xY9uKGcK3S
         IK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV9q9AQ7PpikYhUvBV5aI2kpk7FdoFpdqjCf8IW8jGw=;
        b=Io5Z8uRGuu1qi3ibj3++wtioYPfyQ26rVoBxHCXItR+bhHh76SnGteT8weOVLaQyVw
         20vA4A3lZIMrdzoOWVcuVXzb///wIEEcRqmj/zBGpTmyiJ41eHPcHYLB781Ckfh8EJ9W
         KIXdd4+wetQ5t5moMWuzpWGT3xX0FuP+jFDPHynVqhTkOHr3YfBjAE+kawy0HbL2mnOF
         fXsQafPmaaSNchoJ85lvpZ/oJ1RGG6T/bqssk2PU+WdqwkC1ndAnxf9fgvIJNPydqMqo
         oLhB/ln/f2MY89qHrpFYodoxedE3odE3Qzoih7SOthqz3gkIE4lzouiBW6T7QdtpaQgf
         cUfg==
X-Gm-Message-State: AO0yUKUFEgKtUFX11IZFEETVXXsD8ZBsOmM2NWYOpZ9arI4zzMyxpB2M
        TygFD+BwrLAd49QE/pr7Qq7VNw==
X-Google-Smtp-Source: AK7set93eWAJkgjHhW+UMztvbrVGCIilaOO8+EZEgmfBkfUxiVw5qkcsFtxCKI/KkVzq55wdoXqCNQ==
X-Received: by 2002:a17:90a:850a:b0:238:b70:b94 with SMTP id l10-20020a17090a850a00b002380b700b94mr3194461pjn.11.1677585208190;
        Tue, 28 Feb 2023 03:53:28 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:27 -0800 (PST)
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
Subject: [PATCH v3 07/14] perf kvm: Parse address location for samples
Date:   Tue, 28 Feb 2023 19:51:18 +0800
Message-Id: <20230228115125.144172-8-leo.yan@linaro.org>
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

Parse address location for samples and save it into the structure
'perf_kvm_stat', it is to be used by histograms entry.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
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

