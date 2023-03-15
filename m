Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A796BB693
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjCOOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjCOOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:52:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC895E22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so2280128pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxPULJO486xqHJLRx8ubmkrWzwK0iscBf1dUdchHcWA=;
        b=ZG/EslB6f9/yZgtygYyLalr/i45+cTyqD6wRGVjTxOdd7TWk/8vE9TdItJGBNewgvh
         3KbsUsgRWQXrncEp3I3jNl3GYazW55VQF/E1YK7YcNix0tfCf+T4GCHgNBOTkIoeavo5
         152APIwoh4PuPEuyfV2T+1L0ZlK9MmzttdZHQATRNTyFQ9JzwrIl7bBMLnV1DdGZvk7R
         n0MiLIGN+11YRriy+F6haDjrxnbBu2fXfDIp2XP/rlLlZL1dFunykx1yMhHmEU02sriM
         W9dPj2mht+HhvdEYnC+8cqXLqvyIDe/sfVGBaxlezH+Nh0T14MX4032pNzqW9nstfYDD
         MBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxPULJO486xqHJLRx8ubmkrWzwK0iscBf1dUdchHcWA=;
        b=yPZ11rceVMpe3slfcrI0+h+81kjLgMfowfCm1XNpcS99nHJe4l8eozIEDs9P+DZn75
         vSl8Aeqt9s6A6V6ZdJJcIkeXLP4zreKeS3BoNGE3OPv7HAeZfII33MZNblK7hB/q3g/3
         P1SaH0xdU8pVOFY/2MCR2eGNSykWQA6N8ocG6Jw5lB6MsP33LZsklTBo8Kg/YViOv2ZP
         yX7UVpHTmd/xpyMRmG0w3Abebig7gr56INF3At99iF0zF89wamrD+wRUWmN01W80zESn
         TQuVI2vTCI8agJxho01KvQE9dRbr0+SYhBK/hhBbGYL/pNszjP9OG/LlE1O/FvaydaCI
         nRXQ==
X-Gm-Message-State: AO0yUKU79h0yzDtMEC9bUWRc8wYGXkmIgaUB9GO5vKhmdijuTRuPyT43
        rEIplwiHAq8uG9UKxBjfkn0Jgw==
X-Google-Smtp-Source: AK7set8ko9n4ei4Die1EmIH61gaaEgOSpmUg0Rela+nxsidAZyB6jjslXFnUZTGMDc+45BGJhugZOQ==
X-Received: by 2002:a17:902:da8d:b0:1a0:6bd4:ea78 with SMTP id j13-20020a170902da8d00b001a06bd4ea78mr3242115plx.31.1678891935892;
        Wed, 15 Mar 2023 07:52:15 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:52:15 -0700 (PDT)
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
Subject: [PATCH v5 08/16] perf kvm: Parse address location for samples
Date:   Wed, 15 Mar 2023 22:51:04 +0800
Message-Id: <20230315145112.186603-9-leo.yan@linaro.org>
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

Parse address location for samples and save it into the structure
'perf_kvm_stat', it is to be used by histograms entry.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/builtin-kvm.c   | 5 +++++
 tools/perf/util/kvm-stat.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 5ea723fd45a4..fa91c8deb628 100644
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
index e2c17662bac7..3b2eab91a9be 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -7,6 +7,7 @@
 #include "tool.h"
 #include "sort.h"
 #include "stat.h"
+#include "symbol.h"
 #include "record.h"
 
 #define KVM_EVENT_NAME_LEN	40
@@ -88,6 +89,9 @@ struct perf_kvm_stat {
 	const char *sort_key;
 	int trace_vcpu;
 
+	/* Used when process events */
+	struct addr_location al;
+
 	struct exit_reasons_table *exit_reasons;
 	const char *exit_reasons_isa;
 
-- 
2.34.1

