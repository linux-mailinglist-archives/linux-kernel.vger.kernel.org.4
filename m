Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC95BF2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiIUB1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiIUB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:26:59 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE955508A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:26:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 126-20020a630284000000b0043942ef3ac7so2609304pgc.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date;
        bh=ZVDZZ15QqdmdXVj+AZhUnUEEq+BCIPvivbVBbzcp4z4=;
        b=BqdZf1ouAPtnpx2vDdxZAb72hSzTROu0vs3otl4rv3ukFLt7qR4AHyCjlfWmgO+atT
         +oNqcQ2iOFjAmdfb7mp4VbjuEn7KC0iaDJJNMJ8naiKxoc7/eB+RfL1RLWL3pIG2+psk
         zOHNEdDUQUpo+otFwzv18RvxYYwHpVWWTiOjGnKtYhL8o9tGiLLmwPZoQrlMq2aiAC6W
         nuEu1JyWWWD500cXWGUKnOq0JfH9YAb4yCqyxLbUfeRt23ZfcbEC/AN40Dqn4Fzs9Sjs
         wVs5wSH9nL0VhNOG/ByWbyObBjykFBuak73CB0JmmuWlHIcuiJ41sgS+OsQsXqEkmyXR
         wzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZVDZZ15QqdmdXVj+AZhUnUEEq+BCIPvivbVBbzcp4z4=;
        b=p4vnJYN2rwFcWBUE4WAWkoI8AA6/qDWqVVbnIXdATR3zRSaswhgQbYtxGDSSLBPwMe
         4a7DcJQ1YxYykS9KLUQVHTUZ80PIZBiVOvXHYDLA9fe/SPIZxUJHMGpJ2+ozZC4aaT+C
         WwqMhQlCs7NjQSGJfSTFTobUBeEoRWT2CcOyY1s5o7v/CoSDJwGzq6f7AwyVXzMgXwlB
         +eMXK6H/B/SrSba+Ip0j6fDjVrO0Jzih29/t8jZ+lfBOyTNvHMqWtGghPdsM63QeCx7l
         Fv/NPfC7ulHKzGk+YLF5Zv1bdx1So7D9EFEa2cTxv6UURm3xR/9MGB7LMOcef+8DwJU1
         YD1A==
X-Gm-Message-State: ACrzQf1txVtSTLxYrl8Njrg55c6wrnYqiLqG/Ng/QIz8++JifI4m9R1C
        D05FIOEdMaITuptBs4o5VQPBWg4ZUcXFjzyyHj6eUHuPs+5Vs602fONjYjHE4dW5PewDZTOnbLr
        2DzA0gG3k8VAXt9x6DHnhTnOuXMG8OtC0dIiAHeyQlJyUPmxY/tndopNFLwOFGqX8+Hx5yf4=
X-Google-Smtp-Source: AMsMyM6P1RQdaIhvs1wlCpMgLs18ccyZ5W35MLWV5pldi5YyaCLmBVJNOTZAxCDa+n/VkteUawnR9Vlkt+wp
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:2104:b0:176:a9ef:418b with SMTP id
 o4-20020a170903210400b00176a9ef418bmr2349378ple.134.1663723555348; Tue, 20
 Sep 2022 18:25:55 -0700 (PDT)
Date:   Wed, 21 Sep 2022 01:25:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921012550.3288570-1-jstultz@google.com>
Subject: [RFC][PATCH v3 0/3] Softirq -rt Optimizations
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
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
        Vasily Gorbik <gor@linux.ibm.com>, kernel-team@android.com
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
CONFIG_RT_SOFTIRQ_OPTIMIZATION allows rt-task placement to be done in a
way that=E2=80=99s aware if a current softirq might be a long-running one, =
to
potentially place the rt task on another free core.

The third patch in the series adds logic in __do_softirq(), also under
CONFIG_RT_SOFTIRQ_OPTIMIZATION, to defer some of the potentially long
running softirqs to ksoftirqd if a -rt task is currently running on the
cpu. This patch also includes a folded down fix that stubbs out
ksoftirqd_running() based on CONFIG_RT_SOFTIRQ_OPTIMIZATION, since in
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

Changes in v3:
* Added generic __cpu_softirq_pending() accessor to avoid s390 build
  trouble

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qais.yousef@arm.com>
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
Cc: kernel-team@android.com


Connor O'Brien (1):
  sched: Avoid placing RT threads on cores handling long softirqs

John Stultz (1):
  softirq: Add generic accessor to percpu softirq_pending data

Pavankumar Kondeti (1):
  softirq: defer softirq processing to ksoftirqd if CPU is busy with RT

 arch/s390/include/asm/hardirq.h |  6 ++++
 include/linux/interrupt.h       | 18 ++++++++++
 include/linux/sched.h           | 10 ++++++
 init/Kconfig                    | 10 ++++++
 kernel/sched/cpupri.c           | 13 +++++++
 kernel/sched/rt.c               | 64 ++++++++++++++++++++++++++++-----
 kernel/softirq.c                | 34 ++++++++++++++++--
 7 files changed, 144 insertions(+), 11 deletions(-)

--=20
2.37.3.968.ga6b4b080e4-goog

