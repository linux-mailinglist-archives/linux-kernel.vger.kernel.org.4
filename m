Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0046714F96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjE2TOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjE2TO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:14:27 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567AAD;
        Mon, 29 May 2023 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685387662;
        bh=BuBFuJov4/08X+aS9ZPKMQM67VPLxpAoQ7NIMWm8KVA=;
        h=From:To:Cc:Subject:Date:From;
        b=F/U4EMf3L4KQEw4uC86Y2qkSiRYS7EegfItvbqZ3mgR+CV3EHp/2aGZmEn+ZAJcQ8
         NNlrnk66WzIwMhyqM7kr3nvCdEO1Sf5q0WY9B/Wt/hXY3cQGelIIbd4aigq+DeXhDk
         vXCKtNbgKIJAVt77ji+jQ9SZjBAWxzCltQPDVn8TjoaxTzO+/cznrrloXjzX98o50v
         c0Koe/YMLrRzMIJMd0CjeLpFRAA39P5yd8bHn/rLuW3tx3+ueoaAYaW4VGps8MUi+Y
         qJ2TYxTNBZ1ppbdCq4XB5y/HNaNx82HjOkpxwBWzUJtSfe7vsnLX1073+9TgzwYTd0
         mkCQ4lO6o3Kdw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QVQF94MPDz16DG;
        Mon, 29 May 2023 15:14:21 -0400 (EDT)
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
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH v2 0/4] Extend rseq with sched_state_ptr field
Date:   Mon, 29 May 2023 15:14:12 -0400
Message-Id: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prototype extends struct rseq with a new sched_state_ptr field,
which points to a structure containing a "on-cpu" flag kept up-to-date
by the scheduler.

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

New in this v2:

- Introduce a "struct rseq_sched_state", which contains the on-cpu
  scheduler flag and a thread ID field. This eliminates false sharing
  on the struct rseq cache lines caused by busy-waiting.

I have favored adding a "thread ID" field to struct rseq_sched_state
rather than adding stores of owner pointer in addition to a
compare-and-swap and store on a uint32_t for lock state to minimize the
number of stores to perform on the fast-path.

Feedback is welcome!

Mathieu

Mathieu Desnoyers (4):
  rseq: Add sched_state field to struct rseq
  selftests/rseq: Add sched_state rseq field and getter
  selftests/rseq: Implement sched state test program
  selftests/rseq: Implement rseq_mutex test program

 include/linux/sched.h                         |  16 +++
 include/uapi/linux/rseq.h                     |  41 ++++++
 kernel/rseq.c                                 |  43 +++++++
 tools/testing/selftests/rseq/.gitignore       |   2 +
 tools/testing/selftests/rseq/Makefile         |   3 +-
 tools/testing/selftests/rseq/rseq-abi.h       |  42 ++++++
 tools/testing/selftests/rseq/rseq.c           |  13 ++
 tools/testing/selftests/rseq/rseq.h           |   5 +
 tools/testing/selftests/rseq/rseq_mutex.c     | 120 ++++++++++++++++++
 .../testing/selftests/rseq/sched_state_test.c |  72 +++++++++++
 10 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/rseq_mutex.c
 create mode 100644 tools/testing/selftests/rseq/sched_state_test.c

-- 
2.25.1

