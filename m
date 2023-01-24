Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD767A6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjAXXmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjAXXmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:42:03 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84939366AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:02 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id gn18-20020a17090ac79200b0022bef1f49c9so1330129pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkhD0Tw+OGmOLT92C/MUl6CgkknkQumZIN+qYMh4b14=;
        b=rpxhqe6MCriifM80NUUvU2aDSKqKs8WddMRwE/ftpPTXaoGRZr2NxeJBrBZjCFbimD
         Po2hXKdAwNgq2sQ79QGoT6/FgjNb1u71+505eeIpOj9PyExY9NSGj5DswGU3tt66+U5c
         IbX9qcAHswmWI6TQcm/FcEZ7wDgRdu6jTLf1/dnO9L7Vk0ynwYpj281qV2QsEIHEIKDa
         RlvWoPvOw5qsmAOGSVfOz1vC7rr9GJw/kR6cYBqS5c3JMqvTTkA4gug3xXBksN1JZipH
         0gk8ZwOAjqGRlgD2RX+GFh01D4zMBg38VczOz6/kVhwF6xxfnDsIVIRnB8BzR0coU0d4
         wEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkhD0Tw+OGmOLT92C/MUl6CgkknkQumZIN+qYMh4b14=;
        b=V1tjhJvPms5IyO9Dl7VjQ+N4aa76JkPtGXdYyusYg9SMu4nJ+AsFzpZaOdrYl/qonY
         YoUBrbFdcsiFCUT+ht6j7lne4tjE+aXbU9ZhqmKOhXPUfSINzzGPYpp8NwASoAE/Obpp
         PEbx31UeWXDMTGOWdEiD9AxvYGGfw2hECK545CNpImlxxLqlDDluKMoIKM4GsjjZRTAg
         egc8VSEZtVZXWU2KdnR0vqoSdoRfLcAQ4xEVqVynhMDaV7s8bRDLg1t7a59M/trDjN/w
         Hg0DYp02yCNZfiL/dtnCVahlwsl2/k1YabPJL//t+mdh8Dtcalc5DboDdrbIHVc5qBvx
         cdOQ==
X-Gm-Message-State: AFqh2koZkThH3rJyZAmdzx8uBrgNWiKcQG2UbJ4c4Kisve6ge59EJsUI
        AMuS4Iw4w5hAyI7mAat/kxolWRtED0U=
X-Google-Smtp-Source: AMrXdXs3Rh4ZUGmrWjd7LIlpVEwho1ZcfFJFXpF0IZe3JFExEWcAsqj5H8m2jarMU/RW3UNbWdMDUwCgVhs=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:cf1b:2f7f:3ca1:6488])
 (user=avagin job=sendgmr) by 2002:a17:90a:9b8c:b0:228:d2c5:5b35 with SMTP id
 g12-20020a17090a9b8c00b00228d2c55b35mr2732741pjp.98.1674603721876; Tue, 24
 Jan 2023 15:42:01 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:41:50 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230124234156.211569-1-avagin@google.com>
Subject: [PATCH 0/6 v4] seccomp: add the synchronous mode for seccomp_unotify
From:   Andrei Vagin <avagin@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Andrei Vagin <avagin@gmail.com>,
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

From: Andrei Vagin <avagin@gmail.com>

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

