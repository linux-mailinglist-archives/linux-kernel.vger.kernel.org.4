Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8864E709DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjESRWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjESRWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:22:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53548E49
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae50da739dso24493635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684516887; x=1687108887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ8xaDz4TWJj5VUxOczM3/qedYb/4TuBRfOr+o2w8q8=;
        b=PATq2+SZhC3nVJZLQNVYmgZXAZp0EGQ62U+p/BHRYOHS5+VE3ibJLQpQYlSVjOJXCO
         wLqEn6wQAk/zqs4i4YOg0RrMuWnX6Zew4XdlM/vNbDqcZK1ppauCR6oqe4D0ha5zp+pu
         QU3dBm300YtU/XNEnjJsWyLF4alt5Q2AfL4Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516887; x=1687108887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJ8xaDz4TWJj5VUxOczM3/qedYb/4TuBRfOr+o2w8q8=;
        b=HrvEKghzwRaHAiRj/v9f11f3QLujy9J6BMVbxsrP2T7HPWXMCBhJaX5UfLlubYLEAI
         28ihIioQoUbTTHLh8ibGndT9cyO/LnvvAVlq3xFN9QgaYgEdaUHqJBsM62D2NknAgP9E
         WpAHeelTev1akJMnGHqFgReIZpkxZqB2j1ysrfZjJnlP+vHeRRpHxvopALac4c96KvWa
         x1X5HyNziKHqHQfBo5sxm5MSO5/NrYFpB7nrhmcoJqRLxY0VS72lhJu9yKAKO5WJE0Nu
         geLhIMYCGaemURmMBvH9JGHJTGex8p5FzJ2wLFemX2D+cdlCbfX8DDuQlSPB2KMPo6/L
         C8PQ==
X-Gm-Message-State: AC+VfDwIRf/9YnYMuoqG7sIoM19Q0tb6yC2MtVMKTVt/djS4Bg1Xo8P3
        60oEp0qr8k+Q7JmzXl///q2GsQ==
X-Google-Smtp-Source: ACHHUZ6Gtx0YpqXCB5KZGOLGsarZgHxkvpPbd2TpiRXaYgv4/gEwDRKkPtcKXNwMfxLde3dNLwE7uw==
X-Received: by 2002:a17:903:244a:b0:1ac:63b6:f1ca with SMTP id l10-20020a170903244a00b001ac63b6f1camr4941839pls.0.1684516887198;
        Fri, 19 May 2023 10:21:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9b89:2dd0:d160:429d])
        by smtp.gmail.com with ESMTPSA id gj19-20020a17090b109300b0024e4f169931sm1763835pjb.2.2023.05.19.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:21:26 -0700 (PDT)
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
Subject: [PATCH v5 16/18] watchdog/perf: Adapt the watchdog_perf interface for async model
Date:   Fri, 19 May 2023 10:18:40 -0700
Message-ID: <20230519101840.v5.16.If4ad5dd5d09fb1309cebf8bcead4b6a5a7758ca7@changeid>
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

From: Lecopzer Chen <lecopzer.chen@mediatek.com>

When lockup_detector_init()->watchdog_hardlockup_probe(), PMU may be
not ready yet. E.g. on arm64, PMU is not ready until
device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
with the driver model and cpuhp. Hence it is hard to push this
initialization before smp_init().

But it is easy to take an opposite approach and try to initialize
the watchdog once again later.
The delayed probe is called using workqueues. It need to allocate
memory and must be proceed in a normal context.
The delayed probe is able to use if watchdog_hardlockup_probe() returns
non-zero which means the return code returned when PMU is not ready yet.

Provide an API - lockup_detector_retry_init() for anyone who needs
to delayed init lockup detector if they had ever failed at
lockup_detector_init().

The original assumption is: nobody should use delayed probe after
lockup_detector_check() which has __init attribute.
That is, anyone uses this API must call between lockup_detector_init()
and lockup_detector_check(), and the caller must have __init attribute

Reviewed-by: Petr Mladek <pmladek@suse.com>
Co-developed-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I yanked this patch from the mailing lists [1] into my series just to
make it easier to avoid conflicts between my series and the one adding
the arm64 perf hardlockup detector, in case someone wanted to test
them both together.

As part of making this match with my series, I resolved a few
conflicts and did a few renames. I also fixed the kernel test robot
yell [2] by providing a dummy implementation of the retry function if
CONFIG_LOCKUP_DETECTOR wasn't defined. That led me to move the
definition of the function and sanitize the name of the function to
match others around it.

This patch makes less sense without the patches to add support for the
arm64 perf hardlockup detector. Thus, I've put it at the end of the
series.

I removed the "kernel test robot" tag since that didn't really make
sense. Presumably the robot found a problem on a previous version of
the patch, but that's not normally a reason to add the Reported-by.

[1] https://lore.kernel.org/r/20220903093415.15850-5-lecopzer.chen@mediatek.com/
[2] https://lore.kernel.org/r/202209050639.jDaWd49E-lkp@intel.com/

(no changes since v4)

Changes in v4:
- Pulled ("Adapt the watchdog_hld interface ...") into my series for v4.

 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index eb616fc07c85..d23902a2fd49 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -13,6 +13,7 @@
 
 #ifdef CONFIG_LOCKUP_DETECTOR
 void lockup_detector_init(void);
+void lockup_detector_retry_init(void);
 void lockup_detector_soft_poweroff(void);
 void lockup_detector_cleanup(void);
 
@@ -34,6 +35,7 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 
 #else /* CONFIG_LOCKUP_DETECTOR */
 static inline void lockup_detector_init(void) { }
+static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
 static inline void lockup_detector_cleanup(void) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 4110f7ca23a5..877d8670f26e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -208,7 +208,13 @@ void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
 
 void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
 
-/* Return 0, if a hardlockup watchdog is available. Error code otherwise */
+/*
+ * Watchdog-detector specific API.
+ *
+ * Return 0 when hardlockup watchdog is available, negative value otherwise.
+ * Note that the negative value means that a delayed probe might
+ * succeed later.
+ */
 int __weak __init watchdog_hardlockup_probe(void)
 {
 	/*
@@ -954,6 +960,62 @@ static void __init watchdog_sysctl_init(void)
 #define watchdog_sysctl_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+static void __init lockup_detector_delay_init(struct work_struct *work);
+static bool allow_lockup_detector_init_retry __initdata;
+
+static struct work_struct detector_work __initdata =
+		__WORK_INITIALIZER(detector_work, lockup_detector_delay_init);
+
+static void __init lockup_detector_delay_init(struct work_struct *work)
+{
+	int ret;
+
+	ret = watchdog_hardlockup_probe();
+	if (ret) {
+		pr_info("Delayed init of the lockup detector failed: %d\n", ret);
+		pr_info("Hard watchdog permanently disabled\n");
+		return;
+	}
+
+	allow_lockup_detector_init_retry = false;
+
+	watchdog_hardlockup_available = true;
+	lockup_detector_setup();
+}
+
+/*
+ * lockup_detector_retry_init - retry init lockup detector if possible.
+ *
+ * Retry hardlockup detector init. It is useful when it requires some
+ * functionality that has to be initialized later on a particular
+ * platform.
+ */
+void __init lockup_detector_retry_init(void)
+{
+	/* Must be called before late init calls */
+	if (!allow_lockup_detector_init_retry)
+		return;
+
+	schedule_work(&detector_work);
+}
+
+/*
+ * Ensure that optional delayed hardlockup init is proceed before
+ * the init code and memory is freed.
+ */
+static int __init lockup_detector_check(void)
+{
+	/* Prevent any later retry. */
+	allow_lockup_detector_init_retry = false;
+
+	/* Make sure no work is pending. */
+	flush_work(&detector_work);
+
+	return 0;
+
+}
+late_initcall_sync(lockup_detector_check);
+
 void __init lockup_detector_init(void)
 {
 	if (tick_nohz_full_enabled())
@@ -964,6 +1026,9 @@ void __init lockup_detector_init(void)
 
 	if (!watchdog_hardlockup_probe())
 		watchdog_hardlockup_available = true;
+	else
+		allow_lockup_detector_init_retry = true;
+
 	lockup_detector_setup();
 	watchdog_sysctl_init();
 }
-- 
2.40.1.698.g37aff9b760-goog

