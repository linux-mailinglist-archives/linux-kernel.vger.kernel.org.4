Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995B461D872
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 08:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKEHYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 03:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiKEHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 03:24:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6181720BE9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 00:23:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b11so6348993pjp.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8CxQ8M2QM9sBIlwmPDF3sO4KY64cCnbt7okAkRcIdI=;
        b=c0dlly7hwTw7JU56MQSd2/9OjXdPEB8Z/l2dmasIIKMvsyZHc8sBbN5UJQtR7mVC09
         q1RR61V+SDTO2DuU2hQynG5H3e4yn4CM6fXf36AcT70kPYKmFbcQCH7SXXZkg4VyVfhu
         EPFrH9rYmLzLRfPkGFi1Qz02uF9/Zt1E3vUw0+DG9adou/Lc4Ndq83SCfiSm6MmDRz8s
         s1D/JRn7aWkc58Nrswu24cJ8DSKi/vsbmPgm6gAHhajuLe1RWjCt6XzHurTyatoUKKtT
         7iVtd1ml8i5VhcahkoMggu5Al7bKaRASIgh9v83JNHCWiqAvE+xNgcz8FYTpsyBAMetU
         3/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8CxQ8M2QM9sBIlwmPDF3sO4KY64cCnbt7okAkRcIdI=;
        b=j4KF5g20sibXdu1p8xmT0PB+7TJNqMs+odUkf72O8btstWteOYGT2fyaAY491tcOhR
         z3im2QZFh7ojmOUJRYcsvMoFxCvQpWN5eY1PTfLmoNGDjHjKSj/jw3yoWrob6VexVKiZ
         oMQJ6FUDqDkzOQUjN3t6kqE4eBv9qvbwUTTGVmiodD16uTn8tplKPHgtEF9RkyfsLDrR
         HrSYSWO1BYpxkZs7wFZWPSHVyxeyJhTBSndynkRpsp0JMsZST9xFWsD92Lbrq+1WGGpe
         aiOUywS7LjwzoFbZMmLEZyhFOvktFCtdmGBDaEf6IaejCT8AST5NPe1lfJ0o87TzxGXY
         iKVw==
X-Gm-Message-State: ACrzQf1mXbZBXV/DgOUV+po58POHG7oLjjTGZTVov3v/9gdTc3aIVkdU
        HbZhm7bHf7Fz6bK+rKCgPqAW8Q==
X-Google-Smtp-Source: AMsMyM5leRTjPX8cC2BZ8OxRg1qLemGZp+/Aqexr9F666mTxh2xSMl5cDCaV8E5Oxa1vtL+dJHRYXA==
X-Received: by 2002:a17:902:ec92:b0:186:9fc6:868c with SMTP id x18-20020a170902ec9200b001869fc6868cmr39074139plg.12.1667633034808;
        Sat, 05 Nov 2022 00:23:54 -0700 (PDT)
Received: from leoy-huangpu.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b00562ef28aac6sm698138pfj.185.2022.11.05.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 00:23:54 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/3] perf arm64: Support virtual CPU ID for kvm-stat
Date:   Sat,  5 Nov 2022 07:23:11 +0000
Message-Id: <20221105072311.8214-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221105072311.8214-1-leo.yan@linaro.org>
References: <20221105072311.8214-1-leo.yan@linaro.org>
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

Since the two trace events kvm_entry_v2/kvm_exit_v2 are added, we can
use the field "vcpu_id" in the events to get to know the virtual CPU ID.
To keep backward compatibility, we still need to rely on the trace
events kvm_entry/kvm_exit for old kernels.

This patch adds Arm64's functions setup_kvm_events_tp() and
arm64__setup_kvm_tp(), by detecting the nodes under sysfs folder, it can
dynamically register trace events kvm_entry_v2/kvm_exit_v2 when the
kernel has provided them, otherwise, it rolls back to use events
kvm_entry/kvm_exit for backward compatibility.

Let cpu_isa_init() to invoke arm64__setup_kvm_tp(), this can allow the
command "perf kvm stat report" also to dynamically setup trace events.

Before:

  # perf kvm stat report --vcpu 27

  Analyze events for all VMs, VCPU 27:

               VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

  Total Samples:0, Total events handled time:0.00us.

After:

  # perf kvm stat report --vcpu 27

  Analyze events for all VMs, VCPU 27:

               VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

                 SYS64        808    98.54%    91.24%      0.00us    303.76us      3.46us ( +-  13.54% )
                   WFx         10     1.22%     7.79%      0.00us     69.48us     23.91us ( +-  25.91% )
                   IRQ          2     0.24%     0.97%      0.00us     22.64us     14.82us ( +-  52.77% )

  Total Samples:820, Total events handled time:3068.28us.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/kvm-stat.c | 54 ++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
index 73d18e0ed6f6..1ba54ce3d7d8 100644
--- a/tools/perf/arch/arm64/util/kvm-stat.c
+++ b/tools/perf/arch/arm64/util/kvm-stat.c
@@ -3,6 +3,7 @@
 #include <memory.h>
 #include "../../../util/evsel.h"
 #include "../../../util/kvm-stat.h"
+#include "../../../util/tracepoint.h"
 #include "arm64_exception_types.h"
 #include "debug.h"
 
@@ -10,18 +11,28 @@ define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
 define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
 
 const char *kvm_trap_exit_reason = "esr_ec";
-const char *vcpu_id_str = "id";
+const char *vcpu_id_str = "vcpu_id";
 const int decode_str_len = 20;
 const char *kvm_exit_reason = "ret";
-const char *kvm_entry_trace = "kvm:kvm_entry";
-const char *kvm_exit_trace = "kvm:kvm_exit";
+const char *kvm_entry_trace;
+const char *kvm_exit_trace;
 
-const char *kvm_events_tp[] = {
+#define NR_TPS	2
+
+static const char *kvm_events_tp_v1[NR_TPS + 1] = {
 	"kvm:kvm_entry",
 	"kvm:kvm_exit",
 	NULL,
 };
 
+static const char *kvm_events_tp_v2[NR_TPS + 1] = {
+	"kvm:kvm_entry_v2",
+	"kvm:kvm_exit_v2",
+	NULL,
+};
+
+const char *kvm_events_tp[NR_TPS + 1];
+
 static void event_get_key(struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct event_key *key)
@@ -78,8 +89,41 @@ const char * const kvm_skip_events[] = {
 	NULL,
 };
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+static int arm64__setup_kvm_tp(struct perf_kvm_stat *kvm)
 {
+	const char **kvm_events, **events_ptr;
+	int i, nr_tp = 0;
+
+	if (is_valid_tracepoint("kvm:kvm_entry_v2")) {
+		kvm_events = kvm_events_tp_v2;
+		kvm_entry_trace = "kvm:kvm_entry_v2";
+		kvm_exit_trace = "kvm:kvm_exit_v2";
+	} else {
+		kvm_events = kvm_events_tp_v1;
+		kvm_entry_trace = "kvm:kvm_entry";
+		kvm_exit_trace = "kvm:kvm_exit";
+	}
+
+	for (events_ptr = kvm_events; *events_ptr; events_ptr++) {
+		if (!is_valid_tracepoint(*events_ptr))
+			return -1;
+		nr_tp++;
+	}
+
+	for (i = 0; i < nr_tp; i++)
+		kvm_events_tp[i] = kvm_events[i];
+	kvm_events_tp[i] = NULL;
+
 	kvm->exit_reasons_isa = "arm64";
 	return 0;
 }
+
+int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
+{
+	return arm64__setup_kvm_tp(kvm);
+}
+
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+{
+	return arm64__setup_kvm_tp(kvm);
+}
-- 
2.34.1

