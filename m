Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4E5EBF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiI0KOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiI0KN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:13:59 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511CD33F7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:13:28 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id g15-20020adfbc8f000000b0022a4510a491so2010771wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=yS3IPm+gxmmhsWdtZ4ouwDB2i7Oa/4SmcSTrg3usShU=;
        b=HjM4bSVTtV4wueqKzndKUjuC79ceC+9zlvX9CnkPxEzIBXiUF6azvaidEpLQJbaOzw
         EqGO6ouldRiz/Lz9HWiLOup97cBf110Ghw5a3fMKpneVXmVPDtIkT0cVwA3x7F6JWrov
         FCHOwPrA1ANhJ71oMTdKXZtGN9tnVDf+LZ4l7oNwkJwwob3bxV3OrL7U4aYXjlrKn1V4
         dDV39F6Zvugvs4+FjrA9FSGw0reH9d8OMA2XVHc0Vk9jxEmbTCx5vyJ7yqlEGx4Uncp+
         mNbOetHBBwkY5hsNUrS8jaalUJCPwhYdfqDHxlMEcsv3YZArk8bIElVw/bBtS4fKfIlC
         SZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yS3IPm+gxmmhsWdtZ4ouwDB2i7Oa/4SmcSTrg3usShU=;
        b=phnFlwmULA2AOEccz34DoNkyoPTpFD7TeRrZtgmzELE3QocMwuKaW2qIfUazb7mjqa
         ao1vONdJwbKtriTSh5i80hklCvNFh2a82LJPESmqZ66jfqkAJYpBnRNq4Sych6ot8oGw
         MPXSh4jeDDRNZD+vK80OUbXgk7SVkmgxox0smRQ04GsjZ3mXg9Hnb+tzyB7rQ635uGTF
         rGNG2WxYgJBS+TYUVE7RDJZ7BpRix2o4r0Dt0+gnJnxEIPF9dm0ALrOTSCZbu5j56ajZ
         xgwHL/ccqG2xjFk88tW8b40jLGH0u32nCUkoTiPAdyn4rMvI18gwifgltiRwz1F7d5YK
         ISrA==
X-Gm-Message-State: ACrzQf0+QAxnCoykC2Hg8V73Qajnlg75JHU2ci5c/AXLZ1SidlFgSy8t
        Ec+CmdTBx2+G8FvKV8oMolaggCxXIZ7p/1Gb
X-Google-Smtp-Source: AMsMyM4cCLyhSLdM6LESpcyZJmlfasF6vQSbsfukYQhj5HmOPH5dP6bkVknYwId+54ihUuUl+rMm0EDggnUTboCX
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:fa12:0:b0:228:62a8:7c79 with SMTP
 id m18-20020adffa12000000b0022862a87c79mr15791500wrr.231.1664273584886; Tue,
 27 Sep 2022 03:13:04 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:12:59 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927101259.1149636-1-vdonnefort@google.com>
Subject: [PATCH v6] cpu/hotplug: Do not bail-out in DYING/STARTING sections
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, vschneid@redhat.com,
        regressions@leemhuis.info, kernel-team@android.com,
        Vincent Donnefort <vdonnefort@google.com>,
        Derek Dolney <z23@posteo.net>
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

The DYING/STARTING callbacks are not expected to fail. However, as reported
by Derek, drivers such as tboot are still free to return errors within
those sections, which halts the hot(un)plug and leaves the CPU in an
unrecoverable state.

No rollback being possible there, let's only log the failures and proceed
with the following steps. This restores the hotplug behaviour prior to
commit 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215867
Fixes: 453e41085183 ("cpu/hotplug: Add cpuhp_invoke_callback_range()")
Reported-by: Derek Dolney <z23@posteo.net>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Derek Dolney <z23@posteo.net>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

---

v5 -> v6:
   - Collect Reviewed-by
v4 -> v5:
   - Remove WARN, only log broken states with pr_warn.
v3 -> v4:
   - Sorry ... wrong commit description style ...
v2 -> v3:
   - Tested-by tag.
   - Refine commit description.
   - Bugzilla link.
v1 -> v2:
   - Commit message rewording.
   - More details in the warnings.
   - Some variable renaming

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375d3b..621e5af42d57 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -663,21 +663,51 @@ static bool cpuhp_next_state(bool bringup,
 	return true;
 }
 
-static int cpuhp_invoke_callback_range(bool bringup,
-				       unsigned int cpu,
-				       struct cpuhp_cpu_state *st,
-				       enum cpuhp_state target)
+static int __cpuhp_invoke_callback_range(bool bringup,
+					 unsigned int cpu,
+					 struct cpuhp_cpu_state *st,
+					 enum cpuhp_state target,
+					 bool nofail)
 {
 	enum cpuhp_state state;
-	int err = 0;
+	int ret = 0;
 
 	while (cpuhp_next_state(bringup, &state, st, target)) {
+		int err;
+
 		err = cpuhp_invoke_callback(cpu, state, bringup, NULL, NULL);
-		if (err)
+		if (!err)
+			continue;
+
+		if (nofail) {
+			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
+				cpu, bringup ? "UP" : "DOWN",
+				cpuhp_get_step(st->state)->name,
+				st->state, err);
+			ret = -1;
+		} else {
+			ret = err;
 			break;
+		}
 	}
 
-	return err;
+	return ret;
+}
+
+static inline int cpuhp_invoke_callback_range(bool bringup,
+					      unsigned int cpu,
+					      struct cpuhp_cpu_state *st,
+					      enum cpuhp_state target)
+{
+	return __cpuhp_invoke_callback_range(bringup, cpu, st, target, false);
+}
+
+static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
+						      unsigned int cpu,
+						      struct cpuhp_cpu_state *st,
+						      enum cpuhp_state target)
+{
+	__cpuhp_invoke_callback_range(bringup, cpu, st, target, true);
 }
 
 static inline bool can_rollback_cpu(struct cpuhp_cpu_state *st)
@@ -999,7 +1029,6 @@ static int take_cpu_down(void *_param)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int err, cpu = smp_processor_id();
-	int ret;
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
@@ -1012,13 +1041,11 @@ static int take_cpu_down(void *_param)
 	 */
 	WARN_ON(st->state != (CPUHP_TEARDOWN_CPU - 1));
 
-	/* Invoke the former CPU_DYING callbacks */
-	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
-
 	/*
+	 * Invoke the former CPU_DYING callbacks
 	 * DYING must not fail!
 	 */
-	WARN_ON_ONCE(ret);
+	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
 
 	/* Give up timekeeping duties */
 	tick_handover_do_timer();
@@ -1296,16 +1323,14 @@ void notify_cpu_starting(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
-	int ret;
 
 	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
-	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
 
 	/*
 	 * STARTING must not fail!
 	 */
-	WARN_ON_ONCE(ret);
+	cpuhp_invoke_callback_range_nofail(true, cpu, st, target);
 }
 
 /*
-- 
2.37.3.998.g577e59143f-goog

