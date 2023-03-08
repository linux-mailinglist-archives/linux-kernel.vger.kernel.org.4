Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3266AFFB7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCHHcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCHHcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:32:13 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3234BA7288
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:32:10 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i6-20020a170902c94600b0019d16e4ac0bso8955633pla.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678260729;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEMJGeDtED5Z6IXdZ3S6Hy8H0y0x1giIRcxgJ32fnIg=;
        b=e0ijmSi763yfus+Cd+UeP1fJIGUiCeeC4/hLMs5oD9/Ym+J8adTqgcI9agTYmKTSvU
         SNh/xR5WEkiII3Qfl6AAectVwkF1IMXzcRUTVsj9HiFaRvGVFMJTUKtNSMlHzNwtQiNg
         ++S8sdzpuojAkg6fTaawyyWmtBX5Y4voELdtbr/ChcB+gYJKZS509wdnZ887mOhX+VkM
         UKilw333WdonVYXFAoRNprZZoqvnzEMCw76q1q7185VJVpsPHPZTHKjD3uw+Oi5odiF/
         4yzgYJ7t7XVu2mGQWvl+QNl5Ry3rn3kWnCJXZL7D1ocCJi8uAZ9NgA1L5NnBZ3fzOanM
         FGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260729;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEMJGeDtED5Z6IXdZ3S6Hy8H0y0x1giIRcxgJ32fnIg=;
        b=FCidQxGcjVbw9UlVs4HW9DFf5Qjf3nq8AjjijADAbs8Ex6UMMznichWUvC3WA79TN1
         6UhMdJJ9vbrwEQAUsUhMTvHp5zV5wXUUwEXp0JmxA3s1GbfPTf3Gox8H3qPjsumEkYLj
         Y0XWVpJ29JPdEfJKoMR/HsXv6/0k0XEcMEpa86wTJl/ZXyNRKy+HXtpTg7amsz4U/TzV
         xEas28UfmwDXnZ/zjVsIbWKCyVv7hPggZmL1mF4FRYullzVKQy6zNSD+tevs3jrmUpEv
         EQRjxrofTU9Y54YBRB+PkrBv14H+Ck5RuYYgNhuhnIKqssXJ/P8Fx6HVN7KRzRkg0ehr
         T8RQ==
X-Gm-Message-State: AO0yUKV2kQ+tRtLOqJqT/i1Z+sYC3HlYMAbEGP5RYBLMlehkwaSMSgeT
        Qj3Q0ly/fMrIryV3rtsrrWQ95lZHEYI=
X-Google-Smtp-Source: AK7set/S6B5FVYKi5iQvhU2IUb4Xa+anrL+xLx0mYkpSvyaxJodXTgGA0XTQ/Z9grb+lFqwCgNCOPmLLlng=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:b53:99a6:b4fe:b30b])
 (user=avagin job=sendgmr) by 2002:a62:8307:0:b0:5a8:4dc1:5916 with SMTP id
 h7-20020a628307000000b005a84dc15916mr7343103pfe.2.1678260729582; Tue, 07 Mar
 2023 23:32:09 -0800 (PST)
Date:   Tue,  7 Mar 2023 23:31:55 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308073201.3102738-1-avagin@google.com>
Subject: [PATCH 0/6 v5 RESEND] seccomp: add the synchronous mode for seccomp_unotify
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

