Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D292162B466
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiKPH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiKPH7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:59:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F1C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:59:37 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id om10-20020a17090b3a8a00b002108b078ab1so1167530pjb.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7v71ZLMMw9Ypk/qBIbo+9W6doSfdrcneW8rCdbD8mEA=;
        b=aVyjfoFajZKLOg+r2F+ZQPrKrjySyvIWcFKpJ4d1e/CHJ+bdY58v7gW+f+Uko6nH3q
         RP7ZRjV924KcAXvTR872pThBb1PBfZDwI7ClhwK6GnQXqxyGtxoLvgHaaQnmdTqo3wuF
         0geX7hpH8jUu5+RwxicO37D214kmNIZ77WZQsMgg/OUarnykVJDAR5LSF6U2kPfeyvG8
         tTzIZfYtvRtuBhA69pk4ncCYsPHVvjW1YNHQI6BN8e2pKkTolxwRmWGq6FF2A2xn2g96
         ysvANC+S6GVrtMlLqB6D/tngj+IkyohmnBIV5/Oxeb1stneOUaM93jc8AJk9FPlW6aYM
         MSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7v71ZLMMw9Ypk/qBIbo+9W6doSfdrcneW8rCdbD8mEA=;
        b=K8RH5Ww4LEbl/qx6nQIRw+h0xgfOtFaQ7Y30nhdxNn6P4xzUKT5Ai2w/TETKeHCWLq
         U6GVer2wh0S/AE1pf6VOBsJRBTU1O45QnBY0Kt06UXP1PHiZzTvTHeF7HXPsitFcWG++
         cBIRSBTOrWf9FxmSszRVuYVGJJBa65OdlIgF3pV9VwOLAbUyJ3HPBoeRZ3H0XqOuYSBJ
         2ofWvaB+0vXEv4svKN2s9kKqobPRiHaWNivIFOcaVFTcSbeujmfZ0Hw1EYjginrSxDAZ
         gJ83hCZOACuu6UakbG4yMJcqt1X5WSAnsbirKzpw9MyCR9YUwtPANysGSuTAVkNNTIQz
         w9/g==
X-Gm-Message-State: ANoB5pmqt+eQEwnAmhl03leP5yijnD5KrSMarJNS7Z6xz8ythv1DZ8G7
        vDebokOf0tKy2sOx/7oX7nakB2a0uZb0dX+sBr6TweX8E6ww7NEZHfbGgyG3dC96lT3+KvIumYJ
        a2pHNaMx89bFDRs5vOiofn4dsANmVQfDXFAJtRDfcp0w1a3sKjTwLkfrR6krSBGEbdSV5AnE=
X-Google-Smtp-Source: AA0mqf5zdCB8zDLqALqxeUrqXKtJdklvUaACudcSRvctdG4d1OSjkhAibLqVajh1x9fSGf32ro7DsfCFSxoA
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:8d90:b0:187:3bc8:fc56 with SMTP id
 v16-20020a1709028d9000b001873bc8fc56mr7837879plo.83.1668585576869; Tue, 15
 Nov 2022 23:59:36 -0800 (PST)
Date:   Wed, 16 Nov 2022 07:59:26 +0000
In-Reply-To: <20221116075929.453876-1-jstultz@google.com>
Mime-Version: 1.0
References: <20221116075929.453876-1-jstultz@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116075929.453876-2-jstultz@google.com>
Subject: [PATCH v5 1/3] softirq: Add generic accessor to percpu
 softirq_pending data
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kernel-team@android.com, kernel test robot <lkp@intel.com>
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

In a previous iteration of this patch series, I was checking:

   per_cpu(irq_stat, cpu).__softirq_pending

which resulted in build errors on s390.

This patch tries to create a generic accessor to this percpu
softirq_pending data.

This interface is inherently racy as its reading percpu data
without a lock. However, being able to peek at the softirq
pending data allows us to make better decisions about rt task
placement vs just ignoring it.

On s390 this call returns 0, which maybe isn't ideal but
results in no functional change from what we do now.

TODO: Heiko suggested changing s390 to use a proper per-cpu
irqstat variable instead.

Feedback or suggestions for better approach here would be
welcome!

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: kernel-team@android.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 arch/s390/include/asm/hardirq.h |  6 ++++++
 include/linux/interrupt.h       | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index 58668ffb5488..cd9cc11588ab 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -16,6 +16,12 @@
 #define local_softirq_pending() (S390_lowcore.softirq_pending)
 #define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
 #define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
+/*
+ *  Not sure what the right thing is here  for s390,
+ *  but returning 0 will result in no logical change
+ *  from what happens now
+ */
+#define __cpu_softirq_pending(x) (0)
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..a749a8663841 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -527,6 +527,17 @@ DECLARE_STATIC_KEY_FALSE(force_irqthreads_key);
 #define set_softirq_pending(x)	(__this_cpu_write(local_softirq_pending_ref, (x)))
 #define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
 
+/**
+ * __cpu_softirq_pending() - Checks to see if softirq is pending on a cpu
+ *
+ * This helper is inherently racy, as we're accessing per-cpu data w/o locks.
+ * But peeking at the flag can still be useful when deciding where to place a
+ * task.
+ */
+static inline u32 __cpu_softirq_pending(int cpu)
+{
+	return (u32)per_cpu(local_softirq_pending_ref, cpu);
+}
 #endif /* local_softirq_pending */
 
 /* Some architectures might implement lazy enabling/disabling of
-- 
2.38.1.431.g37b22c650d-goog

