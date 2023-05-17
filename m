Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F83706CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjEQP1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjEQP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:27:20 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC58A24A;
        Wed, 17 May 2023 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684337223;
        bh=dIw3rhHMZ7Lp2h8DWiNDF2A2BTJ7aMsSgYnH7zjBLU8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ma0LIvxE0jZ5ZvZwg6GwgWj+R1P3SB+GJKRMi9UulYmtLrksnVnQkJ9z/UK54Bzno
         kQjEoMfbNmFmXiz0lN0ihUTjEDPpiZUwRWbnB8aJDrk1U12zEil19+/Rdy6YSBQzoF
         TQ/O0+hPRr4KZZz3icQDL6t+VJHP7PKMKO+n/uvHHNe6xdVWNAbLco6aXWwuzpTaJh
         ciAkvV1+RT7sfGvMIEHxbEglHeziORNeGVcjS6pBMsdY/x39g96eoTXxE1uX3wFxH0
         97O7NlHgZJ6S/F2I7GK60igTX+RcJsj5r5URFbyrVT4L8kvK9WOmB9U9QHIC2MlpSU
         uinfMzhVaNCvQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLxmR1RqKz131q;
        Wed, 17 May 2023 11:27:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 0/4] Extend rseq with sched_state field
Date:   Wed, 17 May 2023 11:26:50 -0400
Message-Id: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prototype extends struct rseq with a new sched_state field, which
contains a "on-cpu" flag kept up-to-date by the scheduler.

It is meant to be used by userspace adaptative mutexes to decide between
busy-wait and futex wait system call (releasing the CPU) behaviors based
on the current state of the mutex owner.

The goal is to improve use-cases where the duration of the critical
sections for a given lock follows a multi-modal distribution, preventing
statistical guesses from doing a good job at choosing between busy-wait
and futex wait behavior.

This is in response to the LWN coverage of 2023 Open Source Summit North
America (https://lwn.net/Articles/931789/) unscheduled slot "Adaptive
spinning in user space" presented by André Almeida.

Feedback is welcome!

Mathieu

Mathieu Desnoyers (4):
  rseq: Add sched_state field to struct rseq
  selftests/rseq: Add sched_state rseq field and getter
  selftests/rseq: Implement sched state test program
  selftests/rseq: Implement rseq_mutex test program

 include/linux/sched.h                         |  12 ++
 include/uapi/linux/rseq.h                     |  17 +++
 kernel/rseq.c                                 |  14 ++
 tools/testing/selftests/rseq/.gitignore       |   2 +
 tools/testing/selftests/rseq/Makefile         |   3 +-
 tools/testing/selftests/rseq/rseq-abi.h       |  17 +++
 tools/testing/selftests/rseq/rseq.h           |   5 +
 tools/testing/selftests/rseq/rseq_mutex.c     | 120 ++++++++++++++++++
 .../testing/selftests/rseq/sched_state_test.c |  71 +++++++++++
 9 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/rseq_mutex.c
 create mode 100644 tools/testing/selftests/rseq/sched_state_test.c

-- 
2.25.1

