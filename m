Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB56C61D86F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 08:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKEHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 03:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKEHXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 03:23:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC23640A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 00:23:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g62so6336350pfb.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfZA8Oeq546U9rjXWlvF9+hmpzEZ8iLdnFqiiX6KOGA=;
        b=bHXFAvPFjUm6i2kX0+cKQ9kyX3IEu0dAg7rej/TY3PIo8z+3oigqZrU9IyDTpig+R3
         HJN1Txjluse6j+vStwPJGRMGQ2GQfVNq9iTZQAZG/88DlBTj+WoYddnMO7dEAGRRy81/
         7uNc8LfdswOlXFqzrYNoY8hk83/eFkQeePpTXaZNoWlSiI6RkzO9bBj1Lra5u7PKE7XI
         YZp8JMGcjrYuXqAQUIfNvqMj6q3LmZW7DsihaejeJi5LGY/dO0jhHe1SpWyFBo0LGCh0
         NU/4w+dZlOR2PRJFjVuQstVilJzYNAhIsBuGRf0wBs9nuZ+/VHjwdaQp2+kwd9dj3X8W
         dBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfZA8Oeq546U9rjXWlvF9+hmpzEZ8iLdnFqiiX6KOGA=;
        b=gn736Y0+rpNAFXQX3GWUgRJFIfZcDApLChWg2jSCXwpWWyeqckccFsDrohFl80j73B
         udraQQNKMdfHbZYbxrxFabwvk/THcYt2o3KHcDa8K/5x3bzUUbGv+1teDVoQYjfv7F8l
         iM1nZ8AZRNzsEtMP+PXpsKt/Tyb+EbD9jOMUJeDGIonQbH0fUKVcOHV0TDpP/i+OEMPF
         HCEFeuoqhdCLOKNtirUvU43/iokz7O9flWbtCcG3de0Rmtvic878flkTltySk8j6oNdK
         uTor7C0kwGmbmAL9sFbBti/OxspKSGZi5ZE+ZadJuh2K2gt57KzYKNykoVfthVXDArU/
         u0TA==
X-Gm-Message-State: ACrzQf0s1rhg8l3mOF3Ll1WlNx+GWsT0RxJWGV2JW3EPa6They5mAseU
        QXXebRJuyeZ4LIQJ6I/cKtQKpg==
X-Google-Smtp-Source: AMsMyM5wcfHGBOZqSWFQQMZBQipB+vd3qIPfNGFDpVK5wLEQTDZBAIR4i3sEAE/hnRLXOzTBhLMmoA==
X-Received: by 2002:a63:1a60:0:b0:43c:9bcd:6c37 with SMTP id a32-20020a631a60000000b0043c9bcd6c37mr33168645pgm.125.1667633028514;
        Sat, 05 Nov 2022 00:23:48 -0700 (PDT)
Received: from leoy-huangpu.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b00562ef28aac6sm698138pfj.185.2022.11.05.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 00:23:48 -0700 (PDT)
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
Subject: [PATCH v1 2/3] KVM: arm64: Add trace events with field 'vcpu_id'
Date:   Sat,  5 Nov 2022 07:23:10 +0000
Message-Id: <20221105072311.8214-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221105072311.8214-1-leo.yan@linaro.org>
References: <20221105072311.8214-1-leo.yan@linaro.org>
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

The existed trace events kvm_entry and kvm_exit don't contain the info
for virtual CPU id, thus the perf tool has no chance to do statistics
based on virtual CPU wise; and the trace events are ABI and we cannot
change it to avoid ABI breakage.

For above reasons, this patch adds two trace events kvm_entry_v2 and
kvm_exit_v2 with a new field 'vcpu_id'.  To support both the old and
new events, we use the tracepoint callback to check if any event is
enabled or not, if it's enabled then the callback will invoke the
corresponding trace event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kvm/trace.c     |  6 +++++
 arch/arm64/kvm/trace_arm.h | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/arm64/kvm/trace.c b/arch/arm64/kvm/trace.c
index d25a3db994e2..d9b2587c77c3 100644
--- a/arch/arm64/kvm/trace.c
+++ b/arch/arm64/kvm/trace.c
@@ -10,6 +10,9 @@ static void kvm_entry_tp(void *data, struct kvm_vcpu *vcpu)
 {
 	if (trace_kvm_entry_enabled())
 		trace_kvm_entry(*vcpu_pc(vcpu));
+
+	if (trace_kvm_entry_v2_enabled())
+		trace_kvm_entry_v2(vcpu);
 }
 
 static void kvm_exit_tp(void *data, int ret, struct kvm_vcpu *vcpu)
@@ -17,6 +20,9 @@ static void kvm_exit_tp(void *data, int ret, struct kvm_vcpu *vcpu)
 	if (trace_kvm_exit_enabled())
 		trace_kvm_exit(ret, kvm_vcpu_trap_get_class(vcpu),
 			       *vcpu_pc(vcpu));
+
+	if (trace_kvm_exit_v2_enabled())
+		trace_kvm_exit_v2(ret, vcpu);
 }
 
 static int __init kvm_tp_init(void)
diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
index ef02ae93b28b..932c9d0c36f3 100644
--- a/arch/arm64/kvm/trace_arm.h
+++ b/arch/arm64/kvm/trace_arm.h
@@ -4,6 +4,7 @@
 
 #include <kvm/arm_arch_timer.h>
 #include <linux/tracepoint.h>
+#include <asm/kvm_emulate.h>
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM kvm
@@ -30,6 +31,23 @@ TRACE_EVENT(kvm_entry,
 	TP_printk("PC: 0x%016lx", __entry->vcpu_pc)
 );
 
+TRACE_EVENT(kvm_entry_v2,
+	TP_PROTO(struct kvm_vcpu *vcpu),
+	TP_ARGS(vcpu),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	vcpu_id		)
+		__field(	unsigned long,	vcpu_pc		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id		= vcpu->vcpu_id;
+		__entry->vcpu_pc		= *vcpu_pc(vcpu);
+	),
+
+	TP_printk("vcpu: %u PC: 0x%016lx", __entry->vcpu_id, __entry->vcpu_pc)
+);
+
 DECLARE_TRACE(kvm_exit_tp,
 	TP_PROTO(int ret, struct kvm_vcpu *vcpu),
 	TP_ARGS(ret, vcpu));
@@ -57,6 +75,33 @@ TRACE_EVENT(kvm_exit,
 		  __entry->vcpu_pc)
 );
 
+TRACE_EVENT(kvm_exit_v2,
+	TP_PROTO(int ret, struct kvm_vcpu *vcpu),
+	TP_ARGS(ret, vcpu),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	vcpu_id		)
+		__field(	int,		ret		)
+		__field(	unsigned int,	esr_ec		)
+		__field(	unsigned long,	vcpu_pc		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id		= vcpu->vcpu_id;
+		__entry->ret			= ARM_EXCEPTION_CODE(ret);
+		__entry->esr_ec			= ARM_EXCEPTION_IS_TRAP(ret) ?
+						  kvm_vcpu_trap_get_class(vcpu): 0;
+		__entry->vcpu_pc		= *vcpu_pc(vcpu);
+	),
+
+	TP_printk("%s: vcpu: %u HSR_EC: 0x%04x (%s), PC: 0x%016lx",
+		  __print_symbolic(__entry->ret, kvm_arm_exception_type),
+		  __entry->vcpu_id,
+		  __entry->esr_ec,
+		  __print_symbolic(__entry->esr_ec, kvm_arm_exception_class),
+		  __entry->vcpu_pc)
+);
+
 TRACE_EVENT(kvm_guest_fault,
 	TP_PROTO(unsigned long vcpu_pc, unsigned long hsr,
 		 unsigned long hxfar,
-- 
2.34.1

