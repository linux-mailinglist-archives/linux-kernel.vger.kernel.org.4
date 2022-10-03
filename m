Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2635F39BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJCXUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJCXUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:20:41 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA625186CB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 16:20:39 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id v4-20020aa78504000000b0056186e60814so1999276pfn.19
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date;
        bh=mJ9pdyhdVYiWTXKMtz/JjK6KCD6laLMzSjDpKqhOcBM=;
        b=mdo7p5V7L0HHSIr+zPeTtU+1Z1GGYJuXKWy932I2yuwPPz+4CtzccfITII266Hxc7p
         xzWB34b+106FOKg8y8spbuuixKlrYGoYWCV1hKJGZqXy1+W0NeSRqzylqZeI6GJsPGYK
         AgJWFzNxpk+vRtEVIboQBMk0xSHuYvSvrIwbHeLQDC7NqiRam5lngqKhZsg3KrJQittz
         D5Edz14l8JqWiwgsDYoCOLCKkOm/ZWE2iRiEhymZsVNCQiIWTVJ6S/I9WzSufSSqHC3S
         h5VBT1CV8PlDg4XSSvswUyZBLY1TLt413x7OEtUhY4Een6r4gwbMXdwLEV1/Z9xDIpzy
         Wf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mJ9pdyhdVYiWTXKMtz/JjK6KCD6laLMzSjDpKqhOcBM=;
        b=MpYNxtbJFHzinuN6+y+QphZWAuHSRe0QX159LXeL9MvUyof9phVEjzqHwUfPSC0obK
         oElI/OYkph1dkhh+CxPMgv/eyjGOGcalHf1uqh3ZyzE4Tu03q161+RHtWRtiEP1xCwmk
         STbX4wnE3LFlSK81g6jmvznrmKvSP6pFzZXeZggBgRla9uim+rlBbeoDMQWu2vEsU8CL
         6E4m035QgPJFkvtXcH5d3ktT4XSmDfCYv26bFCEU6dAM72J99pVcDD/VEbZ66mZMj7Fu
         QxucUT7kDe1CyNMruG/XYdMdJsBDV5dmvDoIyT9ydelFdaeKcOYcNP2TDMJYtpGtX9PX
         Zypw==
X-Gm-Message-State: ACrzQf025x869ssvn6VteSvOMbxFRIAFn82Zz8i5vfH1ttX2wiLIBNV2
        3mN1Pe2qAOFaEVSVQN9m3hN5NR5+hpQ2Sep5LZzv1yxK6eRA4xZFpY1keVy1hOpKrrRDCXZi3Qo
        4ZfuCnjv/7gqW48wP35STk/lspSfgTBUoRNfuen3MjUKHntSSWR/aeZ54rnI+Mg+D1n3+Vi4=
X-Google-Smtp-Source: AMsMyM6kK0eScHfe1V05ufErjxwEC+1UA51gpJb1xSBdeyqBw92+IEY/loIFLvBSbNDfMGI3K5uS7kSF5VEJ
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:4a0b:b0:202:8568:4163 with SMTP id
 kk11-20020a17090b4a0b00b0020285684163mr14484981pjb.217.1664839239315; Mon, 03
 Oct 2022 16:20:39 -0700 (PDT)
Date:   Mon,  3 Oct 2022 23:20:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003232033.3404802-1-jstultz@google.com>
Subject: [RFC PATCH v4 0/3] Softirq -rt Optimizations
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>
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


Chages in v4:
* Drop TASKLET_SOFTIRQ from LONG_SOFTIRQS (suggested by Qais)
* Depend on !PREEMPT_RT (Suggested by Qais)
* Larger simplification of logic (suggested by Qais)
* Rework LONG_SOFTIRQS to use BIT() macros
* Rename task_may_preempt() to cpu_busy_with_softirqs()
* Fix commit message to accurately note long-running softirqs
  (suggested by Qais)
* Switch to using rt_task(current) (suggested by Qais)


Connor O'Brien (1):
  sched: Avoid placing RT threads on cores handling long softirqs

John Stultz (1):
  softirq: Add generic accessor to percpu softirq_pending data

Pavankumar Kondeti (1):
  softirq: defer softirq processing to ksoftirqd if CPU is busy with RT

 arch/s390/include/asm/hardirq.h |  6 ++++
 include/linux/interrupt.h       | 17 +++++++++
 init/Kconfig                    | 10 ++++++
 kernel/sched/rt.c               | 61 ++++++++++++++++++++++++++++-----
 kernel/softirq.c                | 38 ++++++++++++++++++--
 5 files changed, 121 insertions(+), 11 deletions(-)

--=20
2.38.0.rc1.362.ged0d419d3c-goog

