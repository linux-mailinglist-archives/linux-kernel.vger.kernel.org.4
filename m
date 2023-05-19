Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49179709DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjESRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjESRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:22:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E83E5A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25343f0c693so2483481a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516891; x=1687108891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofKCq2S0sG4HUWPTrK47G6OxIUEY0NpUnbveH+FrW0Q=;
        b=li5Y+b1MKSL5H1TcUJ/gnT7tpJRmScW/yX7Xn4EozrdVenjMOyka4dNkjUbb0TmJ44
         u5glYz+gYHxOpEkslJ/3sx7pea49YLQ1oj/Q+flL2o8pYyT1TVZwVbZIPOdhZuFElcEo
         GWlDeqfsuUlpQPXerEDkwuL+kLQXlybCMyzdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516891; x=1687108891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofKCq2S0sG4HUWPTrK47G6OxIUEY0NpUnbveH+FrW0Q=;
        b=BDQxjR4kWGmRNUlajh0JBP61Yk/UOsEO31NdkMRS0rBWq5p6H0QTIUzFazM2uoNNqO
         Q5QTYRqwtz2zM27daqqqGrsl9B0x+2Z8PBPHPtUGC7xC9ekpf53KnPCdXn2sbtpOq6Lr
         RG4qJtDwTkmU3rj4Tt81u6T9nIPOWUYXULPWMAIC1T4qVZWLSj1T602fO9hxqYjpviVl
         MJiSmAVmYow4y9wOx6dktLamXzjXuUl8GrXGSso3f9p7r/+ZRGgVvN66B5cmmAZtosNl
         bdnFJN2g0crwMOsIQpmV0+S87kIfX26ijT2emi+OH33PfSGSJEvi6WZ9Ve5LuaD2+jzg
         5wUg==
X-Gm-Message-State: AC+VfDw662Lq1GhhTinUt9mVEghQPV+uO398au5g0uILMTR6huw/DaKj
        3tLhoVfoeUqiE8Z+5wpXHBgSmA==
X-Google-Smtp-Source: ACHHUZ7fGH54d53wt7Qy3yd+9dOsRWtuxyqWrzI9KH6HBzcejmAdPhN2FZgql87OeZSuuRnqTNforg==
X-Received: by 2002:a17:90a:c503:b0:253:41b8:13d6 with SMTP id k3-20020a17090ac50300b0025341b813d6mr2750064pjt.21.1684516890703;
        Fri, 19 May 2023 10:21:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:21:29 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v5 17/18] arm64: add hw_nmi_get_sample_period for preparation of lockup detector
Date:   Fri, 19 May 2023 10:18:41 -0700
Message-ID: <20230519101840.v5.17.Ia9d02578e89c3f44d3cb12eec8b0176603c8ab2f@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lecopzer Chen <lecopzer.chen@mediatek.com>

Set safe maximum CPU frequency to 5 GHz in case a particular platform
doesn't implement cpufreq driver.
Although, architecture doesn't put any restrictions on
maximum frequency but 5 GHz seems to be safe maximum given the available
Arm CPUs in the market which are clocked much less than 5 GHz.

On the other hand, we can't make it much higher as it would lead to
a large hard-lockup detection timeout on parts which are running
slower (eg. 1GHz on Developerbox) and doesn't possess a cpufreq driver.

Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I yanked this patch from the mailing lists [1] into my series just to
make it easier to avoid conflicts between my series and the one adding
the arm64 perf hardlockup detector, in case someone wanted to test
them both together.

The only change I made here was to remove an extra blank line that
checkpatch complained about.

As mentioned in the cover letter, I'm not really expecting this patch
to land together with the patches for the buddy detector. I included
it with my series simply for convenience of testing both series
together.

NOTE: the previous patch posted by Lecopzer pointed to Sumit's
patch [2] in the commit text but provided no context. I moved it to
this "after the cut" note.

[1] https://lore.kernel.org/r/20220903093415.15850-6-lecopzer.chen@mediatek.com/
[2] http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org

(no changes since v4)

Changes in v4:
- Pulled ("add hw_nmi_get_sample_period for ...") into my series for v4.

 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/watchdog_hld.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 7c2bb4e72476..cc22011ab66a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)	+= watchdog_hld.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
new file mode 100644
index 000000000000..2401eb1b7e55
--- /dev/null
+++ b/arch/arm64/kernel/watchdog_hld.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpufreq.h>
+
+/*
+ * Safe maximum CPU frequency in case a particular platform doesn't implement
+ * cpufreq driver. Although, architecture doesn't put any restrictions on
+ * maximum frequency but 5 GHz seems to be safe maximum given the available
+ * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
+ * hand, we can't make it much higher as it would lead to a large hard-lockup
+ * detection timeout on parts which are running slower (eg. 1GHz on
+ * Developerbox) and doesn't possess a cpufreq driver.
+ */
+#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long max_cpu_freq;
+
+	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
+	if (!max_cpu_freq)
+		max_cpu_freq = SAFE_MAX_CPU_FREQ;
+
+	return (u64)max_cpu_freq * watchdog_thresh;
+}
-- 
2.40.1.698.g37aff9b760-goog

