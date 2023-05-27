Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C57131A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjE0BnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243270AbjE0Bmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE00E59
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso1800012b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151747; x=1687743747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LzYkR+VFFLH6wRBHL6FlKd+tRCEo62Tgi4gzgiGicM=;
        b=MJPM8uBHWtcGykg6NBnTXOlp/wt/zisapv2LqVrNAXkdImxD++McjkPouYYjhNBMZ/
         FtnMFxUfnwDPpZ8d3KsgOQlpZlNtaUXpmKC4q99ybOisJ5hfu5QhtX1wrIemYl3fq166
         Chku98BUooqaBLPGzQqvfd2wrHxDC0QaznFMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151747; x=1687743747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LzYkR+VFFLH6wRBHL6FlKd+tRCEo62Tgi4gzgiGicM=;
        b=kwDYCkH8FvthVbx11PGQoP98SaTt/MfkXV2mZSCD3YrCj/F1g3J4wl7j+5ngZC5SKu
         ZxPBaHKf04xZuQOpitvScGIEtoUzbAv9lG34Z4YucyCUoKPU7v9L2T4zyxJMVwY/90S9
         wWmVV1YSXrwUFrufQY2n6ZQTSpMBUg63R5F0ADJjGGSWbxYa22jVpi3iYVmQk3TFB3Mq
         +QaXFYHLNQ69DWKHrtZ+YnTsH7F0GBdDxenMEo1+17dRcwN8qtb88YM5eV9B9HhFoKPw
         5QbGkKLwPMfOQvy2uv94dp05LGv240LbtKOOcU7eCUPTZV7JV42nzwqeckdUrB138oNe
         eTgg==
X-Gm-Message-State: AC+VfDwGbFMlg3nCXLbaCgzInMj/rMIHg5+hJpafKvou0/Cijz+oklLj
        ngj2vh3sITswxeftn8H8Ci6k6A==
X-Google-Smtp-Source: ACHHUZ49rllat2/JyQzbGZ3WjkseglfJC0pbWMXitDuVE2AIZugbceGuvm9VVDVfo56QxxDU2q8Bew==
X-Received: by 2002:aa7:888e:0:b0:63b:8eeb:77b8 with SMTP id z14-20020aa7888e000000b0063b8eeb77b8mr6362327pfe.13.1685151746880;
        Fri, 26 May 2023 18:42:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:26 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 06/10] watchdog/buddy: Cleanup how watchdog_buddy_check_hardlockup() is called
Date:   Fri, 26 May 2023 18:41:36 -0700
Message-ID: <20230526184139.6.I006c7d958a1ea5c4e1e4dc44a25596d9bb5fd3ba@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("watchdog/hardlockup: detect hard lockups using
secondary (buddy) CPUs"), we added a call from the common watchdog.c
file into the buddy. That call could be done more cleanly.
Specifically:
1. If we move the call into watchdog_hardlockup_kick() then it keeps
   watchdog_timer_fn() simpler.
2. We don't need to pass an "unsigned long" to the buddy for the timer
   count. In the patch ("watchdog/hardlockup: add a "cpu" param to
   watchdog_hardlockup_check()") the count was changed to "atomic_t"
   which is backed by an int, so we should match types.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/nmi.h     |  4 ++--
 kernel/watchdog.c       | 15 +++++++--------
 kernel/watchdog_buddy.c |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 6c6a5ce77c66..43893e5f858a 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -114,9 +114,9 @@ void watchdog_hardlockup_disable(unsigned int cpu);
 void lockup_detector_reconfigure(void);
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
-void watchdog_buddy_check_hardlockup(unsigned long hrtimer_interrupts);
+void watchdog_buddy_check_hardlockup(int hrtimer_interrupts);
 #else
-static inline void watchdog_buddy_check_hardlockup(unsigned long hrtimer_interrupts) {}
+static inline void watchdog_buddy_check_hardlockup(int hrtimer_interrupts) {}
 #endif
 
 /**
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 85f4839b6faf..6cc46b8e3d07 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -131,9 +131,12 @@ static bool is_hardlockup(unsigned int cpu)
 	return false;
 }
 
-static unsigned long watchdog_hardlockup_kick(void)
+static void watchdog_hardlockup_kick(void)
 {
-	return atomic_inc_return(this_cpu_ptr(&hrtimer_interrupts));
+	int new_interrupts;
+
+	new_interrupts = atomic_inc_return(this_cpu_ptr(&hrtimer_interrupts));
+	watchdog_buddy_check_hardlockup(new_interrupts);
 }
 
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
@@ -195,7 +198,7 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 
 #else /* CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER */
 
-static inline unsigned long watchdog_hardlockup_kick(void) { return 0; }
+static inline void watchdog_hardlockup_kick(void) { }
 
 #endif /* !CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER */
 
@@ -449,15 +452,11 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	struct pt_regs *regs = get_irq_regs();
 	int duration;
 	int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
-	unsigned long hrtimer_interrupts;
 
 	if (!watchdog_enabled)
 		return HRTIMER_NORESTART;
 
-	hrtimer_interrupts = watchdog_hardlockup_kick();
-
-	/* test for hardlockups */
-	watchdog_buddy_check_hardlockup(hrtimer_interrupts);
+	watchdog_hardlockup_kick();
 
 	/* kick the softlockup detector */
 	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
index fee45af2e5bd..3ffc5f2ede5a 100644
--- a/kernel/watchdog_buddy.c
+++ b/kernel/watchdog_buddy.c
@@ -72,7 +72,7 @@ void watchdog_hardlockup_disable(unsigned int cpu)
 	cpumask_clear_cpu(cpu, &watchdog_cpus);
 }
 
-void watchdog_buddy_check_hardlockup(unsigned long hrtimer_interrupts)
+void watchdog_buddy_check_hardlockup(int hrtimer_interrupts)
 {
 	unsigned int next_cpu;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

