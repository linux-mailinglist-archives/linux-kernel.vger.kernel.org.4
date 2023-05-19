Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED93709DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjESRVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjESRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:21:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC51721
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so1239066b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516868; x=1687108868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie3WjW8dWxj5WOSXB5283RQPy/3pGkianoLx2tVNmSE=;
        b=YFzuFJ4eWMAMLZhwqw3DBL6QSzTZYYa5+5StBECaLdL4G4pigB8ofT1gcUdimpiEex
         TUDIfFVtwz5+KlRL7JQHT2da3WMxmdqENRL5ms2CGY+2q3hdCV2Nt79wd9AtATEzbUlN
         2n+bREyXkWhUEo1Yo+8a9WsEEPMByfDapf0rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516868; x=1687108868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie3WjW8dWxj5WOSXB5283RQPy/3pGkianoLx2tVNmSE=;
        b=l80nn14j6IAfGbibHxjcogvQfAGRkfqFqzaJELgo/4lyNQB03O7/M7od4qfiLZkxnv
         Jcv9S6hXne5rTmjtxqIPkmd9uK8Ob414dEHXUMHJZtwY8+cdIz27bh7jd1bsrTA0Quii
         uIgDK/M2JAsU1LXfYYvsShNCXKo3466pqcxLbZWdjCGVpN5ohxkVOqJaEL5LDkz43Jkd
         IJtYfX9cqFvZcag16MgeoqY32pL/oii8mcpqZTp+bbasJ//EtC04gHxeY7rGctDbOXzS
         M+gJOAoENjKC+1PnLleslp52k0EyvaGOggNbPuj66VmPGY27wLysaZzjAl2+M046XJjs
         B1Fw==
X-Gm-Message-State: AC+VfDzGDtrdOTKbpg1h54emUnfI/fiKS4RS5h14itmlFO2YVpTbzyUj
        jNPE3nE+h9oqhWY8JuwWlUdrUQ==
X-Google-Smtp-Source: ACHHUZ7ATOZ4rrYyAkhTlLlxcJ+5wIJmhvaJz9egSunvv+DUCDA9ft5dxcoQbbZfEUNE16sB4U4I0A==
X-Received: by 2002:a17:903:2343:b0:1ae:bf5:7a7 with SMTP id c3-20020a170903234300b001ae0bf507a7mr3990597plh.35.1684516867869;
        Fri, 19 May 2023 10:21:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:21:07 -0700 (PDT)
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
Subject: [PATCH v5 10/18] watchdog/hardlockup: Add a "cpu" param to watchdog_hardlockup_check()
Date:   Fri, 19 May 2023 10:18:34 -0700
Message-ID: <20230519101840.v5.10.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid>
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

In preparation for the buddy hardlockup detector where the CPU
checking for lockup might not be the currently running CPU, add a
"cpu" parameter to watchdog_hardlockup_check().

As part of this change, make hrtimer_interrupts an atomic_t since now
the CPU incrementing the value and the CPU reading the value might be
different. Technially this could also be done with just READ_ONCE and
WRITE_ONCE, but atomic_t feels a little cleaner in this case.

While hrtimer_interrupts is made atomic_t, we change
hrtimer_interrupts_saved from "unsigned long" to "int". The "int" is
needed to match the data type backing atomic_t for hrtimer_interrupts.
Even if this changes us from 64-bits to 32-bits (which I don't think
is true for most compilers), it doesn't really matter. All we ever do
is increment it every few seconds and compare it to an old value so
32-bits is fine (even 16-bits would be). The "signed" vs "unsigned"
also doesn't matter for simple equality comparisons.

hrtimer_interrupts_saved is _not_ switched to atomic_t nor even
accessed with READ_ONCE / WRITE_ONCE. The hrtimer_interrupts_saved is
always consistently accessed with the same CPU. NOTE: with the
upcoming "buddy" detector there is one special case. When a CPU goes
offline/online then we can change which CPU is the one to consistently
access a given instance of hrtimer_interrupts_saved. We still can't
end up with a partially updated hrtimer_interrupts_saved, however,
because we end up petting all affected CPUs to make sure the new and
old CPU can't end up somehow read/write hrtimer_interrupts_saved at
the same time.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- Don't dump stack on the buddy CPU if we fail to backtrace the hung CPU.
- Use atomic_t for hrtimer_interrupts.

Changes in v4:
- ("Add a "cpu" param to watchdog_hardlockup_check()") new for v4.

 include/linux/nmi.h    |  2 +-
 kernel/watchdog.c      | 52 ++++++++++++++++++++++++++----------------
 kernel/watchdog_perf.c |  2 +-
 3 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 0c62c1bf0a71..92aa568c0c42 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -88,7 +88,7 @@ static inline void hardlockup_detector_disable(void) {}
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
-void watchdog_hardlockup_check(struct pt_regs *regs);
+void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 #endif
 
 #if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 169e5dffbc00..2552e224f76a 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -87,29 +87,34 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 
-static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
-static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
+static DEFINE_PER_CPU(atomic_t, hrtimer_interrupts);
+static DEFINE_PER_CPU(int, hrtimer_interrupts_saved);
 static DEFINE_PER_CPU(bool, watchdog_hardlockup_warned);
 static unsigned long watchdog_hardlockup_all_cpu_dumped;
 
-static bool is_hardlockup(void)
+static bool is_hardlockup(unsigned int cpu)
 {
-	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
+	int hrint = atomic_read(&per_cpu(hrtimer_interrupts, cpu));
 
-	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
+	if (per_cpu(hrtimer_interrupts_saved, cpu) == hrint)
 		return true;
 
-	__this_cpu_write(hrtimer_interrupts_saved, hrint);
+	/*
+	 * NOTE: we don't need any fancy atomic_t or READ_ONCE/WRITE_ONCE
+	 * for hrtimer_interrupts_saved. hrtimer_interrupts_saved is
+	 * written/read by a single CPU.
+	 */
+	per_cpu(hrtimer_interrupts_saved, cpu) = hrint;
 
 	return false;
 }
 
 static void watchdog_hardlockup_kick(void)
 {
-	__this_cpu_inc(hrtimer_interrupts);
+	atomic_inc(raw_cpu_ptr(&hrtimer_interrupts));
 }
 
-void watchdog_hardlockup_check(struct pt_regs *regs)
+void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 {
 	/*
 	 * Check for a hardlockup by making sure the CPU's timer
@@ -117,35 +122,42 @@ void watchdog_hardlockup_check(struct pt_regs *regs)
 	 * fired multiple times before we overflow'd. If it hasn't
 	 * then this is a good indication the cpu is stuck
 	 */
-	if (is_hardlockup()) {
+	if (is_hardlockup(cpu)) {
 		unsigned int this_cpu = smp_processor_id();
+		struct cpumask backtrace_mask = *cpu_online_mask;
 
 		/* Only print hardlockups once. */
-		if (__this_cpu_read(watchdog_hardlockup_warned))
+		if (per_cpu(watchdog_hardlockup_warned, cpu))
 			return;
 
-		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", this_cpu);
+		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
 		print_modules();
 		print_irqtrace_events(current);
-		if (regs)
-			show_regs(regs);
-		else
-			dump_stack();
+		if (cpu == this_cpu) {
+			if (regs)
+				show_regs(regs);
+			else
+				dump_stack();
+			cpumask_clear_cpu(cpu, &backtrace_mask);
+		} else {
+			if (trigger_single_cpu_backtrace(cpu))
+				cpumask_clear_cpu(cpu, &backtrace_mask);
+		}
 
 		/*
-		 * Perform all-CPU dump only once to avoid multiple hardlockups
-		 * generating interleaving traces
+		 * Perform multi-CPU dump only once to avoid multiple
+		 * hardlockups generating interleaving traces
 		 */
 		if (sysctl_hardlockup_all_cpu_backtrace &&
 		    !test_and_set_bit(0, &watchdog_hardlockup_all_cpu_dumped))
-			trigger_allbutself_cpu_backtrace();
+			trigger_cpumask_backtrace(&backtrace_mask);
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
-		__this_cpu_write(watchdog_hardlockup_warned, true);
+		per_cpu(watchdog_hardlockup_warned, cpu) = true;
 	} else {
-		__this_cpu_write(watchdog_hardlockup_warned, false);
+		per_cpu(watchdog_hardlockup_warned, cpu) = false;
 	}
 }
 
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 04415812d079..4e60e8023515 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -120,7 +120,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		return;
 	}
 
-	watchdog_hardlockup_check(regs);
+	watchdog_hardlockup_check(smp_processor_id(), regs);
 }
 
 static int hardlockup_detector_event_create(void)
-- 
2.40.1.698.g37aff9b760-goog

