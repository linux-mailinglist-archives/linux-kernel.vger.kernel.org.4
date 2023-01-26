Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD567D6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjAZUpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjAZUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:45:00 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07BC59550
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:44:59 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id by10-20020a056a00400a00b005918acc2e44so1405472pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqM3/Ci1lx/2tZr3NWii0Dt8IoCFwVmRmktSfadot+Y=;
        b=AtzLjLuseZj5IfJaGcz67eE/oecjONgYbERTV8bTih9QC+A3oBltmK9MFkMSv0YccD
         Vw87R9XzDLU6QOsDcXPrwnpEUShrgOoSmlwEzG4VLi2GH/5W5IO9jtvAyAc4dHaDA5kq
         rgbBknjoQ2mz7cj0vEBOP4NlV8qLF9qbw16CSCWzVcV3WnJ5kzpnwenW51IT+fqGjhgJ
         n86IW6+2o6lszwEHosMm0M6IX/XEgMWkU7X6yqL6zgUgsEXBBbq1tZgTn+ewksV0asbq
         mw2tJ5/S885VrDiPzj2IMoJ78LSNJNsYe8+guRMwppiw9mLfe57EgxXGqIYtzaCSrkpB
         IXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqM3/Ci1lx/2tZr3NWii0Dt8IoCFwVmRmktSfadot+Y=;
        b=8RnDETOvxzNj1NBtwN/eqaQ46hVorYkWl9cF/x/hF1PUhzMaFXuE/0CADtKAoRwv5w
         qQPQBw6QX29wLxJnU3UXsOzpVzr7V1Im7bBHpw2yHJc8uKKo03HEfRunBH+8GsjzlcrO
         8QJQ6ucuro1NOBAw24kYqWCJjq+uAKJvJjLfx4jXWi5+q1VZPhE+xScmHr9b+AX1UFCs
         vmPOK3pmN0CEkjkCzQ7iNALfOFMP3MYLGBps3DvpOPwmE5WgwtmE1isByaNd56PFMgzY
         vwBR7ius7wXkQtbLz/rbqROQwGLcIFGUQSkFPvfpF1jATJNtAn6/wMZucKaz78FFSEBa
         dlbg==
X-Gm-Message-State: AFqh2krVdbjAHtPX/+Ex9EdFppAtR0QO+it/Rb4OZW0upMyGEOrtctPF
        3RwZJOLjDjr7ULRrq45lECL8AErx1RnuRDc=
X-Google-Smtp-Source: AMrXdXuVOgVY7AWhbaZGyoii9f0mMWnbNgHUxwPn2DnS6IBBl2DP1jJc+mNdVEgrvBEVDl6hSca4Y8riumJsGwg=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:902:968f:b0:193:e89:f610 with SMTP
 id n15-20020a170902968f00b001930e89f610mr4137596plp.31.1674765899077; Thu, 26
 Jan 2023 12:44:59 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:40 -0500
In-Reply-To: <20230126204444.2204061-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230126204444.2204061-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-5-zalbassam@google.com>
Subject: [PATCH 4/8] perf: pmuv3: Add wrappers for KVM accesses
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM host support is available only on arm64. This patch adds wrappers
to the KVM host function references in the arm_pmuv3.c, so that it is
up to architecture to populate these wrappers if supported.

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h | 16 ++++++++++++++++
 drivers/perf/arm_pmuv3.c           | 11 +++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index f41a354d1022..9f2a48f5340c 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -20,6 +20,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
+#include <linux/kvm_host.h>
 
 /*
  * This code is really good
@@ -191,4 +192,19 @@ static inline u32 read_pmceid1(void)
 	return read_sysreg(pmceid1_el0);
 }
 
+static inline void armv8pmu_kvm_set_events(u32 set, struct perf_event_attr *attr)
+{
+	kvm_set_pmu_events(set, attr);
+}
+
+static inline void armv8pmu_kvm_clr_events(u32 clr)
+{
+	kvm_clr_pmu_events(clr);
+}
+
+static inline bool armv8pmu_kvm_counter_deferred(struct perf_event_attr *attr)
+{
+	return kvm_pmu_counter_deferred(attr);
+}
+
 #endif
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 505f0758260c..d7063dd52827 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -16,7 +16,6 @@
 
 #include <linux/acpi.h>
 #include <linux/clocksource.h>
-#include <linux/kvm_host.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
@@ -607,10 +606,10 @@ static inline void armv8pmu_enable_event_counter(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 	u32 mask = armv8pmu_event_cnten_mask(event);
 
-	kvm_set_pmu_events(mask, attr);
+	armv8pmu_kvm_set_events(mask, attr);
 
 	/* We rely on the hypervisor switch code to enable guest counters */
-	if (!kvm_pmu_counter_deferred(attr))
+	if (!armv8pmu_kvm_counter_deferred(attr))
 		armv8pmu_enable_counter(mask);
 }
 
@@ -629,10 +628,10 @@ static inline void armv8pmu_disable_event_counter(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 	u32 mask = armv8pmu_event_cnten_mask(event);
 
-	kvm_clr_pmu_events(mask);
+	armv8pmu_kvm_clr_events(mask);
 
 	/* We rely on the hypervisor switch code to disable guest counters */
-	if (!kvm_pmu_counter_deferred(attr))
+	if (!armv8pmu_kvm_counter_deferred(attr))
 		armv8pmu_disable_counter(mask);
 }
 
@@ -974,7 +973,7 @@ static void armv8pmu_reset(void *info)
 	armv8pmu_disable_intens(U32_MAX);
 
 	/* Clear the counters we flip at guest entry/exit */
-	kvm_clr_pmu_events(U32_MAX);
+	armv8pmu_kvm_clr_events(U32_MAX);
 
 	/*
 	 * Initialize & Reset PMNC. Request overflow interrupt for
-- 
2.39.0.246.g2a6d74b583-goog

