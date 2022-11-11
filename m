Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08A62546D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiKKHcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKKHcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:32:05 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3ED5B599
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:04 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e8-20020a056a00162800b0056e953c5088so2354799pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ69LpM5uj+DV1KKeCxNBgJ7y7QpJFhXLsQQVf7AHf4=;
        b=XfCHi78dMMZG4W/MZEfxKdiOO3uXdrJu1obiRiSb5rJqsDbB/3LST8+gPfIIYMSrkw
         E/gq4JF+pUEqCwChDxK6yASWrlG1QNbYuAHsAXieNSEQD8xWbFxqGIhwZHfj0rURLqSA
         SjYQp97lTCLucSCU8y/mtuk+i5tIBLsMWer+Acj/BqG0BvArsSlJwiJamLhFc0O3FNhL
         fvEvDLULChaPgqRIMxSBtp87bN/xh/3/qhRT08VbdBGXevVDg2oyY2wRSvTaozd+4m+a
         g7JCEGRaOQjtlEnFzYfLtLiw7Ww/3waiGGSOClGuiCZKVSmBmLwWe/hSshA51Ua4a1zy
         qzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZ69LpM5uj+DV1KKeCxNBgJ7y7QpJFhXLsQQVf7AHf4=;
        b=xRwIe6qjHR7furTel1B5gxzjaybZ84gyEQLpNOmMuHt4IyHcHIFhyTHFaW9i6R4bOb
         ZlBWpilG6hyalTScgnyucZjCt9R+/CFV932iksKzeCbMyIGLoii8OsUxsaGDgjUj4Ayi
         Zjqe1fTt/+iKoYzIUd1GUfGyZtwSxtxSaExVJGV77gNswwY3vLfCDfPoDdEX5oBerRIB
         UMtNlL4NFDWjxEwJB48Ttgm4dp8r4+m7lrwscqRIADF+v4rGeNnIa80re3rLlSHbzDwJ
         3buIyUZFqGPfgTmG3JK/7lPcrpusK9QccMG+u0Wmh7chXDzekGarvQCdfc4m9WBuM2Pe
         7xGA==
X-Gm-Message-State: ANoB5pmugQ+T0exn6/o1zmhMTh/1FfLv4/8mYNcHpPH0cwPda92+uN25
        ZojPvVq9eq+S3vJ6QXovLmvQbo9kBPg=
X-Google-Smtp-Source: AA0mqf778nO7caUw7isvnVtJcUCUoYJE/rucKh1qcEhtvVo+MWYve5+SA+MWH3mxvTTXSicI/guwoGiqsl8=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:8cf3:f53:2863:82a3])
 (user=avagin job=sendgmr) by 2002:aa7:972c:0:b0:56e:1ce2:c919 with SMTP id
 k12-20020aa7972c000000b0056e1ce2c919mr1340397pfg.78.1668151923917; Thu, 10
 Nov 2022 23:32:03 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:31:49 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221111073154.784261-1-avagin@google.com>
Subject: [PATCH 0/5 v3] seccomp: add the synchronous mode for seccomp_unotify
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
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

