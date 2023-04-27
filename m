Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD78C6F04DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbjD0LUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbjD0LTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:19:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE574ECB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:19:45 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682594383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PHOtkCkq4CqHkz943Yvm6KBQagbgm6BWReS7ewgzDtc=;
        b=0yWZlgpQsKfkiGJeN6q+QnaDZtPKEvPMndOSb3+3YOYcXz3pFkzGAk5PtqYU29aK1ZLxcp
        ZEpFibWPLEJFVJ4CGkCM+roEMRtGDYrAGCg+2fGK4n2faxUTYP9dE7Syr6ymBRgY+FZoTn
        IYzwpAYZOyzoxfq/lZBJ4wVmKiDDIGkNc7/OyWgM4AbN3W3fk0oki5xrXC8MLMq6uCfo4W
        +siC9JQ0K72VRJlS71QO5tHXj2cSLtl3hLLwSlgGhJTr6lKXWePcwqqRjpY0Qy7v51lTLj
        VTJ+MofwyjK8yKdZercUjFFNWeWKSfnizQmVeMOeKnzTtHdvxoFvdsVQ9StvYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682594383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PHOtkCkq4CqHkz943Yvm6KBQagbgm6BWReS7ewgzDtc=;
        b=6Jsp9oV4Xp+1rmByiBu58SWIrKvWQqeqt5le4CRLVFeR4WxLUy+/dOT8Y+FUwVUABXJenI
        4FeV3DuoMAAw0zCw==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Crystal Wood <swood@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 0/4] locking/rtmutex: Avoid overwriting pi_blocked_on while invoking blk_flush_plug().
Date:   Thu, 27 Apr 2023 13:19:33 +0200
Message-Id: <20230427111937.2745231-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Crystal Wood reported that task_struct::pi_blocked_on can be overwritten
by mistake that is:
	rt_mutex_slowlock()
	  - task_blocks_on_rt_mutex()
	    - current->pi_blocked_on =3D waiter;
	  - rt_mutex_slowlock_block()
	    - schedule()=20
	      - sched_submit_work()
	        - blk_flush_plug()
		  - *any* RT sleeping lock used by the plug
		     - rtlock_slowlock_locked()
	               - task_blocks_on_rt_mutex()
		         - current->pi_blocked_on =3D waiter; <-- XXX

The requirement is
- I/O queued
- lock contention on a sleeping lock (a mutex_t)
- lock contention while flushing queued I/O (in blk_flush_plug(), a
  spin_lock_t on PREEMPT_RT).

Later in review it was pointed out by tglx that any function within
sched_submit_work() is affected so it is not limited to
blk_flush_plug().

This series addresses the problem by
- export sched_submit_work()
- invoke sched_submit_work() if it is clear that the slow path is
  needed.
- invoke schedule_rtmutex() while blocking on lock which contains only
  the schedule loop (without sched_submit_work().

Original report by Crystal
	https://lore.kernel.org/all/4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel=
@redhat.com

v1: https://lore.kernel.org/all/20230322162719.wYG1N0hh@linutronix.de

v1=E2=80=A6v2:
   - Avoid invoking blk_flush_plug() with DEBUG-enabled
   - Fix also the ww-mutex implementation based on RT-mutex.
   - Export sched_submit_work() and do the whole block before blocking
     not just blk_flush_plug().

Sebastian


