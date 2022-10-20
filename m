Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF56054AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJTBLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJTBLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:11:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4121645CF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l4so18868720plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXmF1Fme0OoaGcClCJY6Xyvjj+NVqhydfVGH2aZUMSE=;
        b=gwQ7iOk74wy0vx09Huu3NIH9uG77673F2QzlxYTFz4z/FXza67fkRjEIN6WOCpbden
         /sCsH1//M8InCtvhjZwAFUXJRGT2WXGUwx2DL28wa7Y1KuPoa5ck4dC3MS7D/jfr3S+0
         569ESGLHuuKbilTQ0c/TdC4MEB8dH4iX6YF1DyHSYtRMnV4gz/n7wFKQhgMLIcCr/KOs
         g7bBVwK2Z9fCKP/HzB+9yRciw4aXxfhPvSCSVgxLM0bUpI6PKND+Ivk9rP19MiPEt9OQ
         tS+XgLKQyWJLxBqhia72k8YyMrWfKRkM/XKWVfvWgXQ+LBuujtz+7P2sCfUfUoaJnD5d
         Wavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXmF1Fme0OoaGcClCJY6Xyvjj+NVqhydfVGH2aZUMSE=;
        b=5/jhukytxBAYRZk/Ih+J0mgyCBS4VbUNkUe9IQPZhaTzt5rAjQV/PUe0chx+2rMLWo
         R9cLoYdwmZjrkXmZiq+AXzT6KUl0CpEs6MoY70UyZaKakm/duNjlFkgXjQxuHfm4Nv+1
         bzXOiWkeve3rlzyL4Dpca2K4LRMNevsI/N+ZPBoaCfIYkuBrCCOnPKU1jTUOjTlq0NWg
         XsMqA1s//+vXnbdhbV/IEWJKElSaCCWjkwztVDpWehTNRROTV8W6MW2sd5T64ES8Qss2
         tdO1SMe1vI2aZpfud4lhLQdXfxf7KWfeyYYB2/NNX58UyYhm/J9x8nWsMaJQsqELOGmc
         k8eQ==
X-Gm-Message-State: ACrzQf3t6/OGFy8PShcS8zr2SmMG0N93ZjJILy1Rj9EOjSlhJQxTRcSt
        pvGI3e70AupOTuztQ9swDNY6x38frB2jtg==
X-Google-Smtp-Source: AMsMyM5ly37mPt72GG7eCGjV8FejiVBCmMCmiBjmyM0yXpXSOWzg/akBwHefbUEljGpEMG1m1vYhsQ==
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id om8-20020a17090b3a8800b00209f35dad53mr48234508pjb.102.1666228259276;
        Wed, 19 Oct 2022 18:10:59 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00174fa8cbf31sm11242938plk.303.2022.10.19.18.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:10:58 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/5 v2] seccomp: add the synchronous mode for seccomp_unotify
Date:   Wed, 19 Oct 2022 18:10:43 -0700
Message-Id: <20221020011048.156415-1-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seccomp_unotify allows more privileged processes does actions on behalf
of less privileged processes.

In many cases, the workflow is fully synchronous. It means a target
process triggers a system call and passes controls to a supervisor
process that handles the system call and returns controls back to the
target process. In this context, "synchronous" means that only one
process is running and another one is waiting.

The new WF_CURRENT_CPU flag advises the scheduler to move the wakee to
the current CPU. For such synchronous workflows, it makes context
switches a few times faster.

Right now, each interaction takes 12µs. With this patch, it takes about
3µs.

v2: clean up the first patch and add the test.

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
 kernel/seccomp.c                              | 72 +++++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 80 +++++++++++++++++++
 12 files changed, 196 insertions(+), 15 deletions(-)

-- 
2.37.2

