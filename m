Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475D56DC9F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDJRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjDJRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:25:24 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4502114
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:25:23 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id e20so5038022vsj.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681147523;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bwMG36sYz/Uvq18Im8sLnPRehEyBCLbtlztOHVAVA3o=;
        b=k7m3L/zbvVogQjiR2DFCzhsWh63ElUv4OuT9hTHwjJWj5POoV+Kyn13JXf3+YKiAwg
         R+/XzKHpwOQD+2/nQ5nJNaiS4x8BGoa3nMiT0/IfhWW5v6F2yUxeBUNoTskI0mqfYeZ/
         C5XYQx3x0F/V1SPQ7Z/h2avjHVTd2/F8viK5JeI8owDjLVq30cY+WV4dl6j75cSIpio6
         o79Sppno6GLoEiqzpHt1yHliAFNNak9taCZTXGYZVVbWOH8gm3JHPj+tvMm9f8CF9oQ8
         88yCeuFpdkhVSGEG2wV4uEBhHKn/fykgCspwqOx2v7kRkOFb6B+y4Pat+xcgEJVMvfAw
         JODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681147523;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwMG36sYz/Uvq18Im8sLnPRehEyBCLbtlztOHVAVA3o=;
        b=XD9XijVOuAf/qHg09bR0MQJl7l0uD4Xi5NPj8lAb1Q1JOAdQgKLTpziNb0QQSjSd28
         SYZqzaXc7XzElwZRQ6SjwWEEzT4OH86Kg6A1o6PX9fJMSd374JO4ItBAHCTCCEhkfuUG
         PYraE5QwSxOl3s5Xxqr9GteVKUc+9TnQl9qmOaa62lCllLqmHStV2pfG5EPLukp3gcnr
         d+4Hv2WHHfxlY5XBX0+3g3IScWrE5xluqgLVGYCvraoUjma43zDk0VCPPa6IasbrLd/f
         hFaKIUmlD+jId4W+Ne3JnwLp7t5Qrtt60w/WrKuM0He9K4MQNhVsuvB5P/l0WyHnA8Fc
         S0kA==
X-Gm-Message-State: AAQBX9dPD3M1h7z36rkcrwdftfDlwtCmDavQB6q1PVKknuq7LCSZSZn7
        +FgFtdYsi6wzODg5Zg5vY8qmfJujVnajWvtFlio=
X-Google-Smtp-Source: AKy350Z/sd/ocXAqzFIQLlxWO1bTM8gpLuLNuKpzX+EW4wNn+PNEgHEMvUmKC5UFesvXQMjUXVD+C2TJ9m3lT2SZIpQ=
X-Received: by 2002:a67:d904:0:b0:42c:54d4:1a1b with SMTP id
 t4-20020a67d904000000b0042c54d41a1bmr3438950vsj.0.1681147522629; Mon, 10 Apr
 2023 10:25:22 -0700 (PDT)
MIME-Version: 1.0
From:   Tingjia Cao <tjcao980311@gmail.com>
Date:   Mon, 10 Apr 2023 13:25:11 -0400
Message-ID: <CABcWv9_DAhVBOq2=W=2ypKE9dKM5s2DvoV8-U0+GDwwuKZ89jQ@mail.gmail.com>
Subject: [BUG] Interger overflow when calculating imbalance for CFS scheduler
To:     mingo@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e6e02805f8fea81e"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e6e02805f8fea81e
Content-Type: text/plain; charset="UTF-8"

We have identified an issue with the rebalance algorithm of CFS
scheduler when using kernel versions 6.0 or 6.3-rc5. Specifically, the
calculate_imbalance function in kernel/sched/fair.c may produce
incorrect results due to an integer overflow bug.

The algorithm is designed to pull some tasks from the busiest group to
the local group. But when both groups are or will become overloaded,
the algorithm doesn't want to push the local group above the average
load of the sched domain. However, in some cases, the calculation of
imbalance can be wrong, causing meaningless migration and even
amplifying the imbalance.

The problem arises when the function executes the following lines:
env->imbalance = min(
(busiest->avg_load - sds->avg_load) * busiest->group_capacity,
(sds->avg_load - local->avg_load) * local->group_capacity
) / SCHED_CAPACITY_SCALE;

In some cases (e.g. when local->group_type = group_fully_busy and
busiest->group_type = group_overloaded), the system cannot guarantee
sds->avg_load being larger than local->avg_load. Since both
sds->avg_load and local->avg_load are unsigned long, it will cause an
integer overflow when executing (sds->avg_load - local->avg_load). The
calculated imbalance is not the minimum of (busiest - sds) and (sds -
local) anymore. As a result, the rebalance algorithm is likely to do
some meaningless migration and make the local_group's load exceed the
sched_domain's avg load after the migration.


Reproduce
=============
We attach a patch and a module that can trace the local->avg_load,
sds->avg_load, and busiest->avg_load.

We used the following workloads to test the algorithm:
- We firstly create two task group:
mkdir /sys/fs/cgroup/t0
mkdir /sys/fs/cgroup/t1
echo 100000 10000 > /sys/fs/cgroup/t0/cpu.max

- Then, we run the following programs in a shell (the c files are attached):
./test0 &
./test0 &
./test0 &
./test1 &

In test0, we clone 9 processes to cgroup t0 and make them sleep
occasionally. In test 1, we clone 10 processes to cgroup t1 and make
them run continuously.

- Then, we use the trace module we provided in the attachment to get
the trace, here are example trace items we get:
         392168005763 nsecs IC    236  103   104   133
         392168015305 nsecs LB    8    1     85    133

The first line means that in the calculate_imbalance function,
1) busiest->avg_load = 236
2) local->avg_load = 104
3) sds->avg_load = 103
It will cause an integer overflow and get a very large imbalance 133.
The expected value is min(236 - 103, 103 - 104) = -1.

The second line means that the wrong imbalance calculation will lead
to an unreasonable migration from cpu 8 to cpu 1, though the
local_group's load  will exceed the sds->avg_load a lot after the
migration. The migrated task's h_load is 85, the env->nr_balanced_fail
= 0. If the imbalance = -1, it shouldn't do the migration. However,
with the wrong imbalance 133, it'll do the task migration.

Kernel Info
===============
Host OS: ubuntu20.04
Processor: Two Intel Xeon Silver 4114 10-core CPUs at 2.20 GHz (forbid
hyperthread)
Kernel Version: 6.3-rc5, 6.0

Here's the link in the bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217316

Best,
Tingjia

--000000000000e6e02805f8fea81e
Content-Type: application/zip; name="bug_report.zip"
Content-Disposition: attachment; filename="bug_report.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_lgb3mjco0>
X-Attachment-Id: f_lgb3mjco0

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
--000000000000e6e02805f8fea81e--
