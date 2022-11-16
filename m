Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B966962B465
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbiKPH7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKPH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:59:36 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A6C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:59:35 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s11-20020a056a00178b00b0056cb4545c3fso9247225pfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+hYJaXe8VccsG7sR2P+T2WSzGYuGwVvhae4PlnMjyE=;
        b=EGM0r71OHh53QwMfOCk3RD1rLjyaq53A4xPV1ynnwGmbsqWxl6xFJuh1c/VsFtWA4m
         L+c0kQvPqxTTcTBmbuFRjWKProNMKU+yMysNuuN84y/2i+tdVyB1Wf0D3A6tqWrL6qiC
         qHjNtSSZE9a71urnJyBxsRWGSNt+MNucZgyAxA998KXaAj15V98ClBUyz66fHmlZD6dW
         6L74vyYjkyoLClqIPGwW+D9VvwuzNuQA+QAbL1S7Bc88hpGPti+ZyXp4TjMoM3P5IeR+
         IHlb2y3EW3JzO4eI5QYgB+plQB7emo1gffzBe/MAd/fxrpXvaOeStHOl26gG7R5huIAW
         IMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+hYJaXe8VccsG7sR2P+T2WSzGYuGwVvhae4PlnMjyE=;
        b=pRP8TGFRDZO7NZWsfDh1al+4qG9h0J9PLXtawSXEjlKrH8XE26xTwcPjVBIbmMu9pA
         rHlsgkv3jtFzP0KyAmpjBWNiX62U0zC16D/k5rDfqNlCMagqizhom4LZMW8bVKkYTCvW
         cfshBh0RMseq5qn3rjb1E2Zdi5sCyIkktDUlUFsv6RkwwjnpMHTovIN2PzQZ8rNhdLcV
         at1WqxSVZrEFXlAdwkalTuGLelRB4LVHjNh08rJIVypZgiAlmXmUZ7k99LJmmE3jixUf
         14NFNn/qr3noKeVrcvDLBxoyrjZRKWlmOtl+l292E4oFZn/pZ7FNbicCWV5WmPBF5pNq
         luTg==
X-Gm-Message-State: ANoB5pmCHGDm2EGoyAJ8N8O7e64dx0c1ZVS0JAApsYjw2GcjJwSgbjcw
        qGZDZ6w015dxUNF/SuSk9Xvzh/udC+GeFYsVZ7+Upb+ssGi84m0Tn5SUWc5dz2tdvKdT9jpdbe4
        X1Jy41ciglXTEAb09lqkSX9+FvoiCvoZ7uVqmszDIZrXLROAJ3s3EK5jQqfaFGunwLKrQ340=
X-Google-Smtp-Source: AA0mqf49FlS/fo7yCdn4ta3Ou91+qwrLKmNO9ofVRqn63YNgi+4fGUFp6S6gSBw+rG4UOcwDVx6iAsqUoV2E
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:ac3:b0:562:69d4:f9f3 with SMTP id
 c3-20020a056a000ac300b0056269d4f9f3mr22298971pfl.5.1668585574962; Tue, 15 Nov
 2022 23:59:34 -0800 (PST)
Date:   Wed, 16 Nov 2022 07:59:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116075929.453876-1-jstultz@google.com>
Subject: [PATCH v5 0/3] Softirq aware -rt scheduling
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
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

This series is a set of patches that optimize scheduler decisions around
realtime tasks and softirqs.  This series is a rebased and reworked set
of changes that have been shipping on Android devices for a number of
years, originally created to resolve audio glitches seen on devices
caused by softirqs for network or storage drivers.

Long running softirqs cause issues because they aren=E2=80=99t currently ta=
ken
into account when a realtime task is woken up, but they will delay
realtime tasks from running if the realtime tasks are placed on a cpu
currently running a softirq.

This can easily be seen on some devices by running cyclictest* along
with some heavy background filesystems noise:

Without the patches:
T: 0 ( 7596) P:99 I:1000 C:  59980 Min:      7 Act:   13 Avg:   29 Max: 410=
7
T: 1 ( 7597) P:99 I:1500 C:  39990 Min:     14 Act:   26 Avg:   36 Max: 899=
4
T: 2 ( 7598) P:99 I:2000 C:  29995 Min:      7 Act:   22 Avg:   35 Max: 361=
6
T: 3 ( 7599) P:99 I:2500 C:  23915 Min:      7 Act:   25 Avg:   49 Max: 402=
73
T: 4 ( 7600) P:99 I:3000 C:  19995 Min:      8 Act:   22 Avg:   38 Max: 105=
10
T: 5 ( 7601) P:99 I:3500 C:  17135 Min:      7 Act:   26 Avg:   39 Max: 131=
94
T: 6 ( 7602) P:99 I:4000 C:  14990 Min:      7 Act:   26 Avg:   40 Max: 947=
0
T: 7 ( 7603) P:99 I:4500 C:  13318 Min:      8 Act:   29 Avg:   44 Max: 201=
01

Which you can visually see in the image here:
 https://github.com/johnstultz-work/misc/raw/main/images/2022-08-09-softirq=
-rt-big-latency.png

Which is from the perfetto trace captured here:
 https://ui.perfetto.dev/#!/?s=3D33661aec8ec82c2da0a59263f36f7d72b4a2f4e7a9=
9b28b222bd12ad872f

The first patch adds a bit of generic infrastructure to get the per-cpu
softirq_pending flag.

The second patch in the series adds logic to account for when softirqs
are running, and then conditionally based on
CONFIG_RT_SOFTIRQ_AWARE_SCHED allows rt-task placement to be done in a
way that=E2=80=99s aware if a current softirq might be a long-running one, =
to
potentially place the rt task on another free core.

The third patch in the series adds logic in __do_softirq(), also under
CONFIG_RT_SOFTIRQ_AWARE_SCHED, to defer some of the potentially long
running softirqs to ksoftirqd if a -rt task is currently running on the
cpu. This patch also includes a folded down fix that stubbs out
ksoftirqd_running() based on CONFIG_RT_SOFTIRQ_AWARE_SCHED, since in
changing to more frequently defer long running softirqs, the logic using
ksoftirqd_running will end up being too conservative and needlessly
delay shorter-running softirqs.

With these patches we see dramatic improvements in the worst case
latencies in the cyclictest* + filesystem noise test above:

With the patches
T: 0 ( 7527) P:99 I:1000 C:  59998 Min:      6 Act:   29 Avg:   35 Max: 173=
4
T: 1 ( 7528) P:99 I:1500 C:  40000 Min:      7 Act:   39 Avg:   35 Max: 118=
1
T: 2 ( 7529) P:99 I:2000 C:  30000 Min:      7 Act:   25 Avg:   25 Max: 444
T: 3 ( 7530) P:99 I:2500 C:  24000 Min:      7 Act:   34 Avg:   36 Max: 172=
9
T: 4 ( 7531) P:99 I:3000 C:  20000 Min:      7 Act:   36 Avg:   25 Max: 406
T: 5 ( 7532) P:99 I:3500 C:  17143 Min:      7 Act:   38 Avg:   34 Max: 126=
4
T: 6 ( 7533) P:99 I:4000 C:  15000 Min:      7 Act:   27 Avg:   33 Max: 235=
1
T: 7 ( 7534) P:99 I:4500 C:  13334 Min:      7 Act:   41 Avg:   29 Max: 228=
5

Since these patches have been carried along for years, and have at times
badly collided with upstream, I wanted to submit them for some initial
review, discussion and feedback so we could hopefully eventually find a
reasonable solution that might land upstream.

* Unfortunately cyclictest had a bug that causes it to always affine
threads to cpus preventing them from being migrated. So you=E2=80=99ll need
to update to the latest version (which includes a fix) to reproduce.

Let me know what you think!

thanks
-john

New in v5:
* Conditionalize active_softirqs handling (suggested by Alexander
  Gordeev <agordeev@linux.ibm.com>)
* Reorder rt_task_fits_cpu to have the "fast" function first
  (Suggested by Alexander Gordeev <agordeev@linux.ibm.com>)
* Fix bug I introduced in v2 condensing
  task_thread_info(task)->preempt_count to preempt_count()
  (Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>)
* Tweak comment discription to remove the vauge "slow"
  descriptor of softirqs being run by ksoftirqd
  (Suggested by Alexander Gordeev <agordeev@linux.ibm.com>)
* Switch to using CONFIG_RT_SOFTIRQ_AWARE_SCHED (suggested by
  Joel Fernandes <joel@joelfernandes.org>)
* Simplify cpu_busy_with_softirqs() logic as pointed out by
  Alexander Gordeev <agordeev@linux.ibm.com>
* Switch to using IS_ENABLED rather then defining my own macro
  (suggsted by Joel Fernandes <joel@joelfernandes.org>)

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

Connor O'Brien (1):
  sched: Avoid placing RT threads on cores handling long softirqs

John Stultz (1):
  softirq: Add generic accessor to percpu softirq_pending data

Pavankumar Kondeti (1):
  softirq: defer softirq processing to ksoftirqd if CPU is busy with RT

 arch/s390/include/asm/hardirq.h |  6 ++++
 include/linux/interrupt.h       | 20 ++++++++++++++
 init/Kconfig                    | 10 +++++++
 kernel/sched/rt.c               | 49 +++++++++++++++++++++++++++------
 kernel/softirq.c                | 46 +++++++++++++++++++++++++++++--
 5 files changed, 120 insertions(+), 11 deletions(-)

--=20
2.38.1.431.g37b22c650d-goog

