Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78E3675808
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjATPDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC6F10415
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674226983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TLOWCWdvP7Mw76tPsWEdql+JcbZ7sGhlRjsTCSJjmvg=;
        b=LmO3mcUNVwkmHPMiaZus5+7zCqkDxiEvaKcrS6HADfWztLdA4xDoYvFKK9+9ZeiCkRZoYU
        6chljr8Ooshh5Jr1kWwm8f6f2SBVEgWdDgCCJ1wgf6ypen96oajxljHS79vCAE9Z0FGn8m
        tovnZ9TOdfXMQFrub6g/uKLG9jNMds4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-1g2HogO0Psi3wtB4CLFcVA-1; Fri, 20 Jan 2023 10:02:59 -0500
X-MC-Unique: 1g2HogO0Psi3wtB4CLFcVA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BF1B8030D0;
        Fri, 20 Jan 2023 15:02:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.32.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C83CC492B03;
        Fri, 20 Jan 2023 15:02:52 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/4] Fix put_task_struct() calls under PREEMPT_RT
Date:   Fri, 20 Jan 2023 12:02:38 -0300
Message-Id: <20230120150246.20797-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_task_struct() decrements a usage counter and calls
__put_task_struct() if the counter reaches zero.

__put_task_struct() indirectly acquires a spinlock, which is a sleeping
lock under PREEMPT_RT. Therefore, we can't call put_task_struct() in an
atomic context in RT kernels.

This patch series introduces put_task_struct_atomic_safe(), which defers
the call to __put_task_struct() to a process context when compiled with
PREEMPT_RT.

It also fixes known problematic call sites.

Changelog:
==========

v2:
 * Add the put_task_struct_atomic_safe() function that is responsible for
   handling the conditions to call put_task_struct().
 * Replace put_task_struct() by put_task_struct_atomic_safe() in known
   atomic call sites.

Wander Lairson Costa (4):
  sched/task: Add the put_task_struct_atomic_safe function
  sched/deadline: fix inactive_task_timer splat
  sched/rt: use put_task_struct_atomic_safe() to avoid potential splat
  sched/core: use put_task_struct_atomic_safe() to avoid potential splat

 include/linux/sched/task.h | 21 +++++++++++++++++++++
 kernel/fork.c              |  8 ++++++++
 kernel/sched/core.c        |  2 +-
 kernel/sched/deadline.c    |  2 +-
 kernel/sched/rt.c          |  4 ++--
 5 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.39.0

