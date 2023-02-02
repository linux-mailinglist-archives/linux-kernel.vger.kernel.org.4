Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5A687399
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBBDEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBBDEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:04:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA855BF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:04:36 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c75-20020a621c4e000000b00592501ac524so260328pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEMJGeDtED5Z6IXdZ3S6Hy8H0y0x1giIRcxgJ32fnIg=;
        b=IUDfU2t601spzzSukrWYsRkhVVuFKcEjzY1zoCUJ+BNtssxo6h3ZsnGfMhfV7sCflt
         oCllChT4V4waSsyTlm6mEl5O5gGWRUH2WcssjMTwkQwOQB+TfC30rcoiG3sX2cJyGzhd
         SeVdUFx2iNAQya5u2pCh5zyzn5qAmM0xp9+gR8n2nFUHYJ+Kr6nbv9IMHdKY9x4yvFP2
         NUKdHS1FwL7z1z1tblaaakzn4jZTyWn+8IeIhYLfxxOmDA0G0BqAoEssM3IVhbMZqlDz
         mh18EzM6mNIgGtlQo563UxTdq1C2qEtxzBDcbwr6jBFatKL1cH5vuGT0oqn54b7bXZp1
         rVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEMJGeDtED5Z6IXdZ3S6Hy8H0y0x1giIRcxgJ32fnIg=;
        b=rd8IAtM4/jYFzdGFZOt0qXQV96g+hCicX5XOiZAsAar8uB9RiAaZAOsIVwLYyJ080c
         Fe2M9VWf2IJ3DoDfLjvE2fWsNvEg420K9eTo/2scNl37cZjxg8zc1zW+SRUZgpwJbIdZ
         KS5/6hBn84jG3rXr3sKIdKEB4LOL+A8CRJTejMM83dV2i6nRntfl5NLzMHni19pp/qMx
         wmHJRj855XSttc49/1OSCC0EbyyBNoHOlc454dKNs7X0GPyNF9kRHaKDAJOomhZdiAvs
         0X8LzJM1qIAUgXRAxG2aT3O6Zr3nYoiZV+kQyMHxN7v60QukZVo+IXPv0cbFl0Bvny7H
         H4lA==
X-Gm-Message-State: AO0yUKUJFlVSHkpf6RjcNhYPG0/ZXn7nFsCTvF2tiH84RWbSpJQn9ivD
        EVcv8dPEqi0wFoCiH/nrhkJ3aSUq1ZM=
X-Google-Smtp-Source: AK7set8p/ktYLQoJTnacFwCM35IRUMm7RmR/mfVJLmqZJdjlY8foiDQEShkFDOci1t6wuDjBEOuu4EDIz3U=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:eee0:dc42:a911:8b59])
 (user=avagin job=sendgmr) by 2002:a63:6d07:0:b0:4ef:2f60:f762 with SMTP id
 i7-20020a636d07000000b004ef2f60f762mr759784pgc.22.1675307075696; Wed, 01 Feb
 2023 19:04:35 -0800 (PST)
Date:   Wed,  1 Feb 2023 19:04:23 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230202030429.3304875-1-avagin@google.com>
Subject: [PATCH 0/6 v5] seccomp: add the synchronous mode for seccomp_unotify
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, avagin@gmail.com,
        Andrei Vagin <avagin@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
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

seccomp_unotify allows more privileged processes do actions on behalf
of less privileged processes.

In many cases, the workflow is fully synchronous. It means a target
process triggers a system call and passes controls to a supervisor
process that handles the system call and returns controls back to the
target process. In this context, "synchronous" means that only one
process is running and another one is waiting.

The new WF_CURRENT_CPU flag advises the scheduler to move the wakee to
the current CPU. For such synchronous workflows, it makes context
switches a few times faster.

Right now, each interaction takes 12=C2=B5s. With this patch, it takes abou=
t
3=C2=B5s.

v2: clean up the first patch and add the test.
v3: update commit messages and a few fixes suggested by Kees Cook.
v4: update the third patch to avoid code duplications (suggested by
    Peter Zijlstra)
    Add the benchmark to the perf bench set.
v5: Update the author email. No code changes.

Kees is ready to take this patch set, but wants to get Acks from the
sched folks.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Oskolkov <posk@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Will Drewry <wad@chromium.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>

Andrei Vagin (4):
  seccomp: don't use semaphore and wait_queue together
  sched: add a few helpers to wake up tasks on the current cpu
  seccomp: add the synchronous mode for seccomp_unotify
  selftest/seccomp: add a new test for the sync mode of
    seccomp_user_notify

Peter Oskolkov (1):
  sched: add WF_CURRENT_CPU and externise ttwu

 include/linux/completion.h                    |   1 +
 include/linux/swait.h                         |   2 +-
 include/linux/wait.h                          |   3 +
 include/uapi/linux/seccomp.h                  |   4 +
 kernel/sched/completion.c                     |  26 ++-
 kernel/sched/core.c                           |   5 +-
 kernel/sched/fair.c                           |   4 +
 kernel/sched/sched.h                          |  13 +-
 kernel/sched/swait.c                          |   8 +-
 kernel/sched/wait.c                           |   5 +
 kernel/seccomp.c                              |  72 +++++++-
 tools/arch/x86/include/uapi/asm/unistd_32.h   |   3 +
 tools/arch/x86/include/uapi/asm/unistd_64.h   |   3 +
 tools/perf/bench/Build                        |   1 +
 tools/perf/bench/bench.h                      |   1 +
 tools/perf/bench/sched-seccomp-notify.c       | 167 ++++++++++++++++++
 tools/perf/builtin-bench.c                    |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c |  55 ++++++
 18 files changed, 346 insertions(+), 28 deletions(-)
 create mode 100644 tools/perf/bench/sched-seccomp-notify.c

--=20
2.37.2

