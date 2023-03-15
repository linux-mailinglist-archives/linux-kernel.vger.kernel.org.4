Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51B86BB690
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjCOOwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjCOOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:52:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D48A3BA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:51:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so2087213pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZjK+hr7JcZKa/bO3cuF+Qb3HZ2OSLLueCbPuYXRIsQ=;
        b=IyU4UgiasNb7sQ+9KfUeWXj6x+B0edjXQNGe8p+rVaNpm3PkPUswmR2xSxu6v9CbGo
         ptmsIxMZdIs0kdw7wuZso4xmCS/3F8XVS6Fh4rfbBPYJxu6u/xrucec9brj/wt6f4unx
         NCJdJ65y3Wqe0hQJQ4mTSbxEeIHMZS+Y2HgMQsH52BwTO7bVP4vzQBkdXxdtHuXAxAb/
         6aAN+phPK7GVEESezJOzxgnZ/h2Boigz7qIcV6Jkx9CRdzYVQdTcFVzJP+XfY0caiSop
         0O4wTIxTdlX8z+OVpkTapRmaGlZQJAxDSQFOE+s7MLSEfRBSFsNDG7elDlsvmXtLnoM4
         0Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZjK+hr7JcZKa/bO3cuF+Qb3HZ2OSLLueCbPuYXRIsQ=;
        b=u9NukOqGTCZpWLWRkE5iyMKnPwQf7zDGKIa8o72C5+4aJiqVDUfN+mJhgNOWIHX39Q
         0Ci2tF2mA/PyhFwbfKzmQOxFf/IypPoRLJ5aJz9ya+nSYXLDXJ8PJ9o+qgnWW0IvAWLA
         WWa+QofDopHxyKTItSS4WnLk4aCPesagGV/mOIAx2m88dOpjR+Oy0GUAMUmVfOq5SZMs
         Qxj4IjMt4AFG+bn+QsdFIUmVVoWUEgcpuk0PckprnCdALRUQviv/ICQ0cIFbEiJesc/M
         dY1FnfPENQPxBYzHuFeMiTvQxXY6NN6c0URD6nQBhgW5PqhFtn4mRkKGv/fqjgnST7NU
         VHjg==
X-Gm-Message-State: AO0yUKWTgY07bow84WxUie6Vdgn6Ylkme/TMCBYxwPPEtzk9e2YDVmMm
        a+YyO4qo5vJAA7XiMbmNr12Sxg==
X-Google-Smtp-Source: AK7set8Yh2PYaPUVuTnwTRUWOSUJd8SHurhxbIimvPTgXecs/zyq/ORsGmnyEvsiBWGfEbATml+14g==
X-Received: by 2002:a17:902:fb4c:b0:1a0:53f3:3762 with SMTP id lf12-20020a170902fb4c00b001a053f33762mr2708370plb.46.1678891919097;
        Wed, 15 Mar 2023 07:51:59 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:51:58 -0700 (PDT)
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
Subject: [PATCH v5 05/16] perf kvm: Use macro to replace variable 'decode_str_len'
Date:   Wed, 15 Mar 2023 22:51:01 +0800
Message-Id: <20230315145112.186603-6-leo.yan@linaro.org>
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

The variable 'decode_str_len' defines the string length for KVM event
name and every arch defines its own values.

This introduces complexity that the variable definition are spreading in
multiple source files under arch folder.  This patch refactors code to
use a macro KVM_EVENT_NAME_LEN to define event name length and thus
remove the definitions in arch files.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/kvm-stat.c   |  1 -
 tools/perf/arch/powerpc/util/kvm-stat.c |  3 +--
 tools/perf/arch/s390/util/kvm-stat.c    |  1 -
 tools/perf/arch/x86/util/kvm-stat.c     |  7 +++----
 tools/perf/builtin-kvm.c                | 10 +++++-----
 tools/perf/util/kvm-stat.h              |  3 ++-
 6 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
index 73d18e0ed6f6..72ca9bb45804 100644
--- a/tools/perf/arch/arm64/util/kvm-stat.c
+++ b/tools/perf/arch/arm64/util/kvm-stat.c
@@ -11,7 +11,6 @@ define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
 
 const char *kvm_trap_exit_reason = "esr_ec";
 const char *vcpu_id_str = "id";
-const int decode_str_len = 20;
 const char *kvm_exit_reason = "ret";
 const char *kvm_entry_trace = "kvm:kvm_entry";
 const char *kvm_exit_trace = "kvm:kvm_exit";
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 1a9b40ea92a5..d04a08c9fd19 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -14,7 +14,6 @@
 #define NR_TPS 4
 
 const char *vcpu_id_str = "vcpu_id";
-const int decode_str_len = 40;
 const char *kvm_entry_trace = "kvm_hv:kvm_guest_enter";
 const char *kvm_exit_trace = "kvm_hv:kvm_guest_exit";
 
@@ -80,7 +79,7 @@ static void hcall_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 {
 	const char *hcall_reason = get_hcall_exit_reason(key->key);
 
-	scnprintf(decode, decode_str_len, "%s", hcall_reason);
+	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", hcall_reason);
 }
 
 static struct kvm_events_ops hcall_events = {
diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index 34da89ced29a..0aed92df51ba 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -19,7 +19,6 @@ define_exit_reasons_table(sie_diagnose_codes, diagnose_codes);
 define_exit_reasons_table(sie_icpt_prog_codes, icpt_prog_codes);
 
 const char *vcpu_id_str = "id";
-const int decode_str_len = 40;
 const char *kvm_exit_reason = "icptcode";
 const char *kvm_entry_trace = "kvm:kvm_s390_sie_enter";
 const char *kvm_exit_trace = "kvm:kvm_s390_sie_exit";
diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index c5dd54f6ef5e..ef513def03ba 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -18,7 +18,6 @@ static struct kvm_events_ops exit_events = {
 };
 
 const char *vcpu_id_str = "vcpu_id";
-const int decode_str_len = 20;
 const char *kvm_exit_reason = "exit_reason";
 const char *kvm_entry_trace = "kvm:kvm_entry";
 const char *kvm_exit_trace = "kvm:kvm_exit";
@@ -77,7 +76,7 @@ static void mmio_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 				  struct event_key *key,
 				  char *decode)
 {
-	scnprintf(decode, decode_str_len, "%#lx:%s",
+	scnprintf(decode, KVM_EVENT_NAME_LEN, "%#lx:%s",
 		  (unsigned long)key->key,
 		  key->info == KVM_TRACE_MMIO_WRITE ? "W" : "R");
 }
@@ -121,7 +120,7 @@ static void ioport_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 				    struct event_key *key,
 				    char *decode)
 {
-	scnprintf(decode, decode_str_len, "%#llx:%s",
+	scnprintf(decode, KVM_EVENT_NAME_LEN, "%#llx:%s",
 		  (unsigned long long)key->key,
 		  key->info ? "POUT" : "PIN");
 }
@@ -165,7 +164,7 @@ static void msr_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
 				    struct event_key *key,
 				    char *decode)
 {
-	scnprintf(decode, decode_str_len, "%#llx:%s",
+	scnprintf(decode, KVM_EVENT_NAME_LEN, "%#llx:%s",
 		  (unsigned long long)key->key,
 		  key->info ? "W" : "R");
 }
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 4e9519390da6..d400434aa137 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -159,7 +159,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kvm,
 	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
 						  key->key);
 
-	scnprintf(decode, decode_str_len, "%s", exit_reason);
+	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
 }
 
 static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
@@ -432,7 +432,7 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
 	time_diff = sample->time - time_begin;
 
 	if (kvm->duration && time_diff > kvm->duration) {
-		char decode[decode_str_len];
+		char decode[KVM_EVENT_NAME_LEN];
 
 		kvm->events_ops->decode_key(kvm, &event->key, decode);
 		if (!skip_event(decode)) {
@@ -603,7 +603,7 @@ static void show_timeofday(void)
 
 static void print_result(struct perf_kvm_stat *kvm)
 {
-	char decode[decode_str_len];
+	char decode[KVM_EVENT_NAME_LEN];
 	struct kvm_event *event;
 	int vcpu = kvm->trace_vcpu;
 
@@ -614,7 +614,7 @@ static void print_result(struct perf_kvm_stat *kvm)
 
 	pr_info("\n\n");
 	print_vcpu_info(kvm);
-	pr_info("%*s ", decode_str_len, kvm->events_ops->name);
+	pr_info("%*s ", KVM_EVENT_NAME_LEN, kvm->events_ops->name);
 	pr_info("%10s ", "Samples");
 	pr_info("%9s ", "Samples%");
 
@@ -633,7 +633,7 @@ static void print_result(struct perf_kvm_stat *kvm)
 		min = get_event_min(event, vcpu);
 
 		kvm->events_ops->decode_key(kvm, &event->key, decode);
-		pr_info("%*s ", decode_str_len, decode);
+		pr_info("%*s ", KVM_EVENT_NAME_LEN, decode);
 		pr_info("%10llu ", (unsigned long long)ecount);
 		pr_info("%8.2f%% ", (double)ecount / kvm->total_count * 100);
 		pr_info("%8.2f%% ", (double)etime / kvm->total_time * 100);
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 0c2400d9b227..841b3174c211 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -8,6 +8,8 @@
 #include "stat.h"
 #include "record.h"
 
+#define KVM_EVENT_NAME_LEN	40
+
 struct evsel;
 struct evlist;
 struct perf_session;
@@ -143,7 +145,6 @@ extern const char *kvm_events_tp[];
 extern struct kvm_reg_events_ops kvm_reg_events_ops[];
 extern const char * const kvm_skip_events[];
 extern const char *vcpu_id_str;
-extern const int decode_str_len;
 extern const char *kvm_exit_reason;
 extern const char *kvm_entry_trace;
 extern const char *kvm_exit_trace;
-- 
2.34.1

