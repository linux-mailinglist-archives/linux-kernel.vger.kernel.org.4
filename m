Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9F709DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjESRWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjESRVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:21:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E11BC6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25343f0c693so2483278a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516877; x=1687108877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNhCL1Huez0uTcL8SW38wDXgmNTYe9rvFeaGt7OObeE=;
        b=DE9ifr/I3G7wJ8II405PBbAcS++31EpYP/eYxV2Sqw9gEjlXEiqZL3Rnu4bmnmd5jh
         CLMn/65EiiSwED/Fr5hrsrF54ilv7twfAOG8cLqgV19i5+0tZ3x9T4leakl5h6Z++Bea
         n+ur25VX7VjlNaBvGlg8u7d/+jLb9LCbxCA3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516877; x=1687108877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNhCL1Huez0uTcL8SW38wDXgmNTYe9rvFeaGt7OObeE=;
        b=A8/+iCnVzDTE3jrc0vuSa2FOZho+hj1i0e7elxreRF0VyOS8aCVHrgjFlSdkJv+S60
         cm4pKkSuI5nClveNiInnz6vL0VHUc2yoSpk8u4lSOZauFHI/oqIBYA5T21SOEUtW+h5G
         G92wn8feo+jTLDZ5pFaTxN2cNRuqUl2XT9GMlaXZt5z3lJ/MrCNWn8utHFoyiktTZt+i
         yCpEDVJa9VCQDqp6d/9rQlFOFUiBxGnzDmkmje8K2yZNxB5nNL52OpC0aYVzdh7jbokl
         +/qaiJlJXZxhgIX0MhQYShqd3PQLQUvQyVuq0qXtQZ0cEii8xgBr+8rf9OiL5J9I8nqD
         oPLg==
X-Gm-Message-State: AC+VfDyqZFt2e022vRr3GssqrQBh6XDiZGJ7519WXtjHcC0YDUFMlTzK
        UlF3SDi+TZAIucxdWhgBAAsJxQ==
X-Google-Smtp-Source: ACHHUZ47UO7H7vKVliZ0X4KGmqcy5S/0HcN/HZXZb72n0w2ePUZMd48yQA/ampwFoC0q6hJBZ/47tQ==
X-Received: by 2002:a17:90a:c503:b0:253:41b8:13d6 with SMTP id k3-20020a17090ac50300b0025341b813d6mr2749539pjt.21.1684516877257;
        Fri, 19 May 2023 10:21:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:21:16 -0700 (PDT)
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
Subject: [PATCH v5 13/18] watchdog/hardlockup: Have the perf hardlockup use __weak functions more cleanly
Date:   Fri, 19 May 2023 10:18:37 -0700
Message-ID: <20230519101840.v5.13.I847d9ec852449350997ba00401d2462a9cb4302b@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fact that there watchdog_hardlockup_enable(),
watchdog_hardlockup_disable(), and watchdog_hardlockup_probe() are
declared __weak means that the configured hardlockup detector can
define non-weak versions of those functions if it needs to. Instead of
doing this, the perf hardlockup detector hooked itself into the
default __weak implementation, which was a bit awkward. Clean this up.

From comments, it looks as if the original design was done because the
__weak function were expected to implemented by the architecture and
not by the configured hardlockup detector. This got awkward when we
tried to add the buddy lockup detector which was not arch-specific but
wanted to hook into those same functions.

This is not expected to have any functional impact.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v4)

Changes in v4:
- ("Have the perf hardlockup use __weak ...") new for v4.

 include/linux/nmi.h    | 10 ----------
 kernel/watchdog.c      | 30 ++++++++++++++++++------------
 kernel/watchdog_perf.c | 20 ++++++++++++++------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 83076bf70ce8..c216e8a1be1f 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -103,21 +103,11 @@ static inline void arch_touch_nmi_watchdog(void) { }
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
-extern void hardlockup_detector_perf_disable(void);
-extern void hardlockup_detector_perf_enable(void);
 extern void hardlockup_detector_perf_cleanup(void);
-extern int hardlockup_detector_perf_init(void);
 #else
 static inline void hardlockup_detector_perf_stop(void) { }
 static inline void hardlockup_detector_perf_restart(void) { }
-static inline void hardlockup_detector_perf_disable(void) { }
-static inline void hardlockup_detector_perf_enable(void) { }
 static inline void hardlockup_detector_perf_cleanup(void) { }
-# if !defined(CONFIG_HAVE_NMI_WATCHDOG)
-static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
-# else
-static inline int hardlockup_detector_perf_init(void) { return 0; }
-# endif
 #endif
 
 void watchdog_hardlockup_stop(void);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 31548c0ae874..08ce046f636d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -187,27 +187,33 @@ static inline void watchdog_hardlockup_kick(void) { }
 #endif /* !CONFIG_HARDLOCKUP_DETECTOR_PERF */
 
 /*
- * These functions can be overridden if an architecture implements its
- * own hardlockup detector.
+ * These functions can be overridden based on the configured hardlockdup detector.
  *
  * watchdog_hardlockup_enable/disable can be implemented to start and stop when
- * softlockup watchdog start and stop. The arch must select the
+ * softlockup watchdog start and stop. The detector must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-void __weak watchdog_hardlockup_enable(unsigned int cpu)
-{
-	hardlockup_detector_perf_enable();
-}
+void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
 
-void __weak watchdog_hardlockup_disable(unsigned int cpu)
-{
-	hardlockup_detector_perf_disable();
-}
+void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
 
 /* Return 0, if a hardlockup watchdog is available. Error code otherwise */
 int __weak __init watchdog_hardlockup_probe(void)
 {
-	return hardlockup_detector_perf_init();
+	/*
+	 * If CONFIG_HAVE_NMI_WATCHDOG is defined then an architecture
+	 * is assumed to have the hard watchdog available and we return 0.
+	 */
+	if (IS_ENABLED(CONFIG_HAVE_NMI_WATCHDOG))
+		return 0;
+
+	/*
+	 * Hardlockup detectors other than those using CONFIG_HAVE_NMI_WATCHDOG
+	 * are required to implement a non-weak version of this probe function
+	 * to tell whether they are available. If they don't override then
+	 * we'll return -ENODEV.
+	 */
+	return -ENODEV;
 }
 
 /**
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 9e6042a892b3..349fcd4d2abc 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -132,10 +132,14 @@ static int hardlockup_detector_event_create(void)
 }
 
 /**
- * hardlockup_detector_perf_enable - Enable the local event
+ * watchdog_hardlockup_enable - Enable the local event
+ *
+ * @cpu: The CPU to enable hard lockup on.
  */
-void hardlockup_detector_perf_enable(void)
+void watchdog_hardlockup_enable(unsigned int cpu)
 {
+	WARN_ON_ONCE(cpu != smp_processor_id());
+
 	if (hardlockup_detector_event_create())
 		return;
 
@@ -147,12 +151,16 @@ void hardlockup_detector_perf_enable(void)
 }
 
 /**
- * hardlockup_detector_perf_disable - Disable the local event
+ * watchdog_hardlockup_disable - Disable the local event
+ *
+ * @cpu: The CPU to enable hard lockup on.
  */
-void hardlockup_detector_perf_disable(void)
+void watchdog_hardlockup_disable(unsigned int cpu)
 {
 	struct perf_event *event = this_cpu_read(watchdog_ev);
 
+	WARN_ON_ONCE(cpu != smp_processor_id());
+
 	if (event) {
 		perf_event_disable(event);
 		this_cpu_write(watchdog_ev, NULL);
@@ -227,9 +235,9 @@ void __init hardlockup_detector_perf_restart(void)
 }
 
 /**
- * hardlockup_detector_perf_init - Probe whether NMI event is available at all
+ * watchdog_hardlockup_probe - Probe whether NMI event is available at all
  */
-int __init hardlockup_detector_perf_init(void)
+int __init watchdog_hardlockup_probe(void)
 {
 	int ret = hardlockup_detector_event_create();
 
-- 
2.40.1.698.g37aff9b760-goog

