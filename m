Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8B6F0D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbjD0UvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbjD0UvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:51:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63536E55
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:51:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso1382821366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682628668; x=1685220668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g4RDaUovQX8o3mmvcOgvWuGQSKyHai0bKleXM8gPs2c=;
        b=e4xbyJ47JaqJQT7+PtdKVawgs+czmD1JJEjzCqdmbgar/aYjS6nhVWJ23Z/2yhVgNK
         nZOTICuEu7oWBemgZjoRaFI9T4as0uvqXH5yYSnt+AnEo0J4cFKa606/QqRo/vwam0gT
         0cDhwdD7TQne8rWPxgyh//1uns7PYNN7YtfwgRnA8JesYPWjIk1TWF6SH1oZ3fQiO3uc
         HXrWgaMCzxxtvn8LDh+ZSDZlpq8hBkx/5nPJAuialpEWDAczU+X7btf6hq+BJzo0GqYp
         cDrU/U1j5HPNrI8DrkmQuWfusOjM+4Y6eHZYS7OQhQTSau460Q2Yn/cZFVzBrEiSvHbr
         NcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628668; x=1685220668;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4RDaUovQX8o3mmvcOgvWuGQSKyHai0bKleXM8gPs2c=;
        b=arp+qcWYojU0Y2w2fan7GrnVDgua/Y/3FK7J934T47N0QQu/Eed0eevJcQBDn9CvBo
         5qmcvy76HGidH1JeTQZYa48zfZlxi2mJTLoz+yEQFsj1n4CD405PJ2NbInB/hv3p2GMT
         hZLZ/sg6DYx2rPbpE5KTxOrlfy7VaZlIfrD4Gyk38CLAguvQwgtDZZkrrWk91xu3UfwM
         6tdRvx0wsAQmZcc2v0Th8HxU5dK1NSmEXYTQdjCS2MgNJtaVdmqsmhUyTKKKKjxuvcfo
         B4WLJUxt1yK/HBQ3bKHXPOQR6FHhL6jZWIlvad5N6pw+vmEJMRdjINON8SOCoo0EhJ7o
         YotQ==
X-Gm-Message-State: AC+VfDzQmZ8s37Oa1AyFbRDJ8bgzZhIhKhxEt0BDGuOX3A/yQczbR+Ia
        i0TcxmOjY+J+T7MwT0XeKfE=
X-Google-Smtp-Source: ACHHUZ5LfqMZCOp83MXPOWAkHxBTsnnnEYTzKn6n6H1sPpyGFQnWS1cE3wQ+jCAovPY4chLcgXau9g==
X-Received: by 2002:a17:907:728d:b0:94f:3074:14fe with SMTP id dt13-20020a170907728d00b0094f307414femr3413971ejc.17.1682628667774;
        Thu, 27 Apr 2023 13:51:07 -0700 (PDT)
Received: from gmail.com (1F2EF38A.nat.pool.telekom.hu. [31.46.243.138])
        by smtp.gmail.com with ESMTPSA id a20-20020a170906469400b0094f7744d135sm10142175ejr.78.2023.04.27.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:51:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 27 Apr 2023 22:51:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler changes for v6.4
Message-ID: <ZErgOfOLrBwluTbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-04-27

   # HEAD: f31dcb152a3d0816e2f1deab4e64572336da197d sched/clock: Fix local_clock() before sched_clock_init()

Scheduler changes for v6.4:

 - Allow unprivileged PSI poll()ing

 - Fix performance regression introduced by mm_cid

 - Improve livepatch stalls by adding livepatch task switching to cond_resched(),
   this resolves livepatching busy-loop stalls with certain CPU-bound kthreads.

 - Improve sched_move_task() performance on autogroup configs.

 - On core-scheduling CPUs, avoid selecting throttled tasks to run

 - Misc cleanups, fixes and improvements.

 Thanks,

	Ingo

------------------>
Aaron Thompson (1):
      sched/clock: Fix local_clock() before sched_clock_init()

Domenico Cerasuolo (4):
      sched/psi: Rearrange polling code in preparation
      sched/psi: Rename existing poll members in preparation
      sched/psi: Extract update_triggers side effect
      sched/psi: Allow unprivileged polling of N*2s period

Hao Jia (1):
      sched/core: Avoid selecting the task that is throttled to run when core-sched enable

Josh Poimboeuf (5):
      livepatch: Convert stack entries array to percpu
      livepatch: Skip task_call_func() for current task
      livepatch,sched: Add livepatch task switching to cond_resched()
      vhost: Fix livepatch timeouts in vhost_worker()
      sched/core: Make sched_dynamic_mutex static

Libo Chen (1):
      sched/fair: Fix inaccurate tally of ttwu_move_affine

Mathieu Desnoyers (1):
      sched: Fix performance regression introduced by mm_cid

Schspa Shi (1):
      sched/rt: Fix bad task migration for rt tasks

Shrikanth Hegde (1):
      sched: Interleave cfs bandwidth timers for improved single thread performance at low utilization

Tom Rix (1):
      sched/topology: Make sched_energy_mutex,update static

wuchi (1):
      sched/core: Reduce cost of sched_move_task when config autogroup


 Documentation/accounting/psi.rst |   4 +
 drivers/vhost/vhost.c            |   3 +-
 include/linux/livepatch.h        |   1 +
 include/linux/livepatch_sched.h  |  29 ++
 include/linux/mm_types.h         |  82 ++++-
 include/linux/psi.h              |   2 +-
 include/linux/psi_types.h        |  43 +--
 include/linux/sched.h            |  23 +-
 include/linux/sched/mm.h         |   5 +
 kernel/cgroup/cgroup.c           |   2 +-
 kernel/fork.c                    |   9 +-
 kernel/livepatch/core.c          |   1 +
 kernel/livepatch/transition.c    | 122 +++++--
 kernel/sched/clock.c             |   3 +
 kernel/sched/core.c              | 669 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/deadline.c          |  11 +
 kernel/sched/fair.c              |  22 +-
 kernel/sched/psi.c               | 473 ++++++++++++++-------------
 kernel/sched/rt.c                |  23 ++
 kernel/sched/sched.h             | 243 ++++++++++++--
 kernel/sched/topology.c          |   4 +-
 21 files changed, 1424 insertions(+), 350 deletions(-)
 create mode 100644 include/linux/livepatch_sched.h
