Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4C46B7636
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCMLmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjCMLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E664B1F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so11350129pjg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygfxx0XS0Skh5yEpdT4mJzv/3MvrNT373bzz9DkGUB4=;
        b=Wx+waaKfMUU6sOzzAcpMsIz/5BgPy51Sblvw1oxRbHogJwZiGABhiwdqf6tgtxoeoz
         5oLuApkLypxZxAgAxFFdYLgGGYrQ1oxxygX8eLckC+tNwe3Lvmr2hCowAnbpyb9GNbKm
         QvDKXioBA7ru6YXqZwqdYfvJiDCmS9SpsKYfkuO8tOfP25d8qeV3edxXdljXuEqXg6TQ
         O0Z2T6EvHYY/utz6arVSdDaDdJmg8/At3PxKKCDTA70ongM5sI/D4cLdE0498R74b4Ps
         jnATtrCs+a5HB49xL9Vwdt2CaQP0OnVDyXwEFu/AEMLqiLAqQirFqrhQ/TmV7E0M8OXx
         n+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygfxx0XS0Skh5yEpdT4mJzv/3MvrNT373bzz9DkGUB4=;
        b=JvCDFU5L0FtkHsWaENyftonN+Z0EYWaNBl6Te1anj2FQHEoDoCD+Hf+1s7Uag/PET0
         IF3sMRPshYDpnYlCTCnwP7C+QIXrCtpY7nqBr0aLMM+xN9jsCxssQdGb5gMmvijK89rF
         5xe/BxtJUE1CAAonMzcko4CW3vsLArBId3XwevQ6KfS2/Rr2LIX1HfG0btJWa9kCzP06
         SLmoZ0VG4UJ0aHuAf2PeD8GU1nwiwQH3mG+d+GkJh9+z/mxMDiyB61KmTRqTqZmcPmXN
         onUmO8vtyzN2dpqiSKKkEZ8VkosZW5I4aM/3hb64xKCHuhn9zS1JBxuROWzi9M9MaBsX
         uC2Q==
X-Gm-Message-State: AO0yUKWtGfyErP85T0zFTyxnIyYPPbyrj4RSptN3me4zF3T/8XLn9x3X
        5wVzgb6fOQW1HmQXsTLKzlLAlw==
X-Google-Smtp-Source: AK7set/Dozj1HoRO5RN3CbjTkCs7qKoMXvP2jNYP2m6mHopQoT7G2BMN6DBnf4OsRGhIq6GidEqVoA==
X-Received: by 2002:a17:90a:3ea3:b0:23b:4614:6f84 with SMTP id k32-20020a17090a3ea300b0023b46146f84mr6304138pjc.28.1678707675655;
        Mon, 13 Mar 2023 04:41:15 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:15 -0700 (PDT)
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
Subject: [PATCH v4 08/16] perf kvm: Parse address location for samples
Date:   Mon, 13 Mar 2023 19:40:10 +0800
Message-Id: <20230313114018.543254-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
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
index a53cebe519b3..2d791b04379a 100644
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

