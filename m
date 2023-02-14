Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3751696A26
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBNQqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBNQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:46:22 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94822D173
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1676393128;
        bh=d1ZZvMqxKw/LrpzJx/GwGILiVbzstOKvhWl8+69yiBg=;
        h=Date:To:Cc:From:Subject:From;
        b=WPeFOotst7ofXGlp0sx1w5IXGAJEgbaxpBUb/170Ydwj//2Z6D8GfQSb2tlDxs0+6
         IY1J0ehiwZscMkrKLILJhZKqDKmfbwDqvUDeOJ2qAwT0R1RbHKxfZWoxhdZN1mFn/9
         zbRmYvI2NUYCbXTJY+5clc7s8Dt4XNDDM/ouYPqfPbf1hkFGkNe9Oq8eYZvXUHWDa2
         Zun/cGMBDUgbzAI5Nu0pdnWaKAKRZGU7yJMM9Nzyer4bx34/7xzVCU5zaqGoEmWdcL
         k2BqWu17H8O4nlCEP9qWtnd05Ihfam7NLXNuC8+zCSKzlTu8Ts5uNTwkLtUFmvYuZb
         eekypbPYM7e/Q==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PGRsN5946zlKp;
        Tue, 14 Feb 2023 11:45:28 -0500 (EST)
Message-ID: <52cf1b10-3dd0-fc20-3cb5-9cbf1f4b72bd@efficios.com>
Date:   Tue, 14 Feb 2023 11:45:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org,
        rp@svcs.cs.pdx.edu
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.14.0, 0.13.3, 0.12.5 [EOL]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a release announcement for the Userspace RCU project.

This is a set of releases, including the new 0.14 branch with the 0.14.0 
release, and bug fix releases for the 0.13 and 0.12 branches. The 0.12.5 
release is the last of the 0.12 branch, which reaches end of life with 
the release of 0.14.

Here are the new features introduced in urcu 0.14.0:

- C99 and C++11 are now the baseline requirements, as documented in
   README.md.

- Introduce public APIs for C++,

   An important point to consider: urcu/compiler.h needs to include
   <type_traits> in C++, which prevents including urcu/compiler.h
   from extern "C" code.

- Introduce new grace period polling APIs in urcu-memb,mb,signal,qsbr,bp
   flavors:

   struct urcu_gp_poll_state start_poll_synchronize_rcu(void);
   bool poll_state_synchronize_rcu(struct urcu_gp_poll_state state);

   This allow periodically polling to check if a started grace period has
   completed, and thus check for grace period completion and some other
   condition as well.

- rculfhash: introduce cds_lfht_node_init_deleted

   Allow initializing lfht node to "removed" state to allow querying
   whether the node is published in a hash table before it is added to
   the hash table and after it has been removed from the hash table.

- Disable signals in URCU background threads

   Applications using signalfd depend on signals being blocked in all
   threads of the process, otherwise threads with unblocked signals
   can receive them and starve the signalfd.

   While some threads in URCU do block signals (e.g. workqueue
   worker for rculfhash), the call_rcu, defer_rcu, and rculfhash
   partition_resize_helper threads do not.

   Always block all signals before creating threads, and only unblock
   SIGRCU when registering a urcu-signal thread. Restore the SIGRCU
   signal to its pre-registration blocked state on unregistration.

   For rculfhash, cds_lfht_worker_init can be removed, because its only
   effect is to block all signals except SIGRCU. Blocking all signals is
   already done by the workqueue code, and unbloking SIGRCU is now done
   by the urcu signal flavor thread regisration.

- Always use '__thread' for Thread local storage except on MSVC

   Use the GCC extension '__thread' [1] for Thread local storage on all C
   and C++ compilers except MSVC.

   While C11 and C++11 respectively offer '_Thread_local' and
   'thread_local' as potentialy faster implementations, they offer no
   guarantees of compatibility when used in a library interface which
   might be used by both C and C++ client code.

- Various test framework improvements.

- Wire up membarrier system call on Alpha. The only missing architecture
   without membarrier wired up is MIPS. https://bugs.lttng.org/issues/940


Here are the fixes introduced in urcu 0.14.0, 0.13.3 and 0.12.5:

- Fix: auto-resize hash table destroy deadlock

   Fix a deadlock for auto-resize hash tables when cds_lfht_destroy
   is called with RCU read-side lock held.

- Join call_rcu worker thread in call_rcu_data_free (eliminate leaks)

- Teardown default call_rcu worker on application exit

   Teardown the default call_rcu worker thread if there are no queued
   callbacks on process exit. This prevents leaking memory.

   Here is how an application can ensure graceful teardown of this
   worker thread:

   - An application queuing call_rcu callbacks should invoke
     rcu_barrier() before it exits.
   - When chaining call_rcu callbacks, the number of calls to
     rcu_barrier() on application exit must match at least the maximum
     number of chained callbacks.
   - If an application chains callbacks endlessly, it would have to be
     modified to stop chaining callbacks when it detects an application
     exit (e.g. with a flag), and wait for quiescence with rcu_barrier()
     after setting that flag.
   - The statements above apply to a library which queues call_rcu
     callbacks, only it needs to invoke rcu_barrier in its library
     destructor.

- Allow building on MSYS2

   Update cygwin libtool config in `configure.ac` to match MSYS2 build
   environments as well. MSYS2 is also a Windows build environment that
   produces DLLs.

Feedback is welcome!

Mathieu


Project website: https://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
