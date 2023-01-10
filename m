Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF81664E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjAJVbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjAJVaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:30:18 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9063395
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:17 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902e54100b00192cc6850ffso9176876plf.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kR7E5lKTXGCIxIfu8WA7EkUmjLuM6fKOUzhK6YsIuhE=;
        b=U0vOf0BGKvhCP7pKH7UBvRVAOBoVvHGWrq1IH/IgkCmbZCucOkfHG2cgyi3w0M3S31
         d1hVJ9WAUpxce+9HpybH0qgBtL++HpMxBdhAkx70EfjwJ31A0uAjm42l9I6aIZFSve8w
         wtf47yDgbxGwXSmASNCJMqBJD0ZYeGmOxJ2fWsGo9dmoWDrcuCTq6eScCuSpW2g+MFCU
         LdrIFKuy8SMyInFJnUsFugLrtIVUEsUod/UAmhro/LP2EIndNOiZAXoKcRgOQFG+qdRp
         XCe6kSj6FmCFHLZvIa6GsiM+O+LCQMMXix2uNmxZ9/6UAN5/KySv66cBv+Q1VuKo60Jv
         0lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR7E5lKTXGCIxIfu8WA7EkUmjLuM6fKOUzhK6YsIuhE=;
        b=k2eD68FdRi4YLsRMSFMiBj9Szmd4N6XfoqEMGjmAiSn6i5YRKo8VpERS9jl0NGcRuq
         mPJ7htSEzcBcoxi5/ffeVt7InD6kVMgxiAruRDC1IimPK/iCYbaumNXvKByW6hKwpiBV
         ZB5O8g6Crhpkk6ke+f3FJlVba11l7Mo++OVH4dzhaeg/Ko6kvPyEjVH6b+BWlnfRj9pO
         0hVjGDEEaLEdd+xkUapbwx9V7nVndQKosTWmL1GJLgGwgcuV2nRvBt5c2Da75Sd8QGkD
         mHtrVGGZlpZhc8JmLqjpcAgeXeyV8IFg3CEF840TvAWMraJ5DePIoq1M8hOC+usCOgij
         N1dg==
X-Gm-Message-State: AFqh2kpiFwrmmxSGfPlgIMtc9rN+jysS/MCaNKotuyd2sXR3+RHlKS9G
        E4x1Bc9BlAZK6r/g92dgzqWBmUinxu0=
X-Google-Smtp-Source: AMrXdXsfrknjaRrq4LcfwjupZceQ0hZxQx6onuFm29uy247QqRuRQoGk9l9LaV9iNcdgL35Ar4M3W8fy7lo=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:6203:13b5:2d85:b75c])
 (user=avagin job=sendgmr) by 2002:a17:902:b613:b0:193:37c2:89d1 with SMTP id
 b19-20020a170902b61300b0019337c289d1mr627749pls.80.1673386217384; Tue, 10 Jan
 2023 13:30:17 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:30:05 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110213010.2683185-1-avagin@google.com>
Subject: [PATCH 0/5 v3 RESEND] seccomp: add the synchronous mode for seccomp_unotify
From:   Andrei Vagin <avagin@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
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

 include/linux/completion.h                    |  1 +
 include/linux/swait.h                         |  1 +
 include/linux/wait.h                          |  3 +
 include/uapi/linux/seccomp.h                  |  4 +
 kernel/sched/completion.c                     | 12 +++
 kernel/sched/core.c                           |  5 +-
 kernel/sched/fair.c                           |  4 +
 kernel/sched/sched.h                          | 13 +--
 kernel/sched/swait.c                          | 11 +++
 kernel/sched/wait.c                           |  5 ++
 kernel/seccomp.c                              | 72 +++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 88 +++++++++++++++++++
 12 files changed, 204 insertions(+), 15 deletions(-)

--=20
2.37.2

