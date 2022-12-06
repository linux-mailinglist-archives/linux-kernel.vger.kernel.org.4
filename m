Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9F644A35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiLFRUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFRUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:20:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF842326EB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670347186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=oqSDB742HqUWCzOCNxXgkF/RCQq7aa16e+ZMYwKk9CQ=;
        b=coxPFysZac9EJ4beb5Argvo7dKV7BBz41ne7aLV1eIeDxyKQvFdXmOI/1FMeYy4i/9oMKa
        7QxwBLdzQ4YjPxOKdVgL74hDXJV0HospOTI66smui7prwTZyyYeuTICzJdHiaQK6OJMfm9
        l+NT8EvZ4mLzAxBS3+ZouoAxUyUjrnQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-yvZuB-imMb2NDMf3abck9Q-1; Tue, 06 Dec 2022 12:19:42 -0500
X-MC-Unique: yvZuB-imMb2NDMf3abck9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37F0888646C;
        Tue,  6 Dec 2022 17:19:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB3C7492B05;
        Tue,  6 Dec 2022 17:19:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id BE41F409005D2; Tue,  6 Dec 2022 13:31:40 -0300 (-03)
Message-ID: <20221206161826.698593151@redhat.com>
User-Agent: quilt/0.66
Date:   Tue, 06 Dec 2022 13:18:26 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v9 0/5] Ensure quiet_vmstat() is called when the idle tick was stopped too
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

This patch series addresses the following two problems:

    1. A customer provided some evidence which indicates that
       the idle tick was stopped; albeit, CPU-specific vmstat
       counters still remained populated.

       Thus one can only assume quiet_vmstat() was not
       invoked on return to the idle loop. If I understand
       correctly, I suspect this divergence might erroneously
       prevent a reclaim attempt by kswapd. If the number of
       zone specific free pages are below their per-cpu drift
       value then zone_page_state_snapshot() is used to
       compute a more accurate view of the aforementioned
       statistic.  Thus any task blocked on the NUMA node
       specific pfmemalloc_wait queue will be unable to make
       significant progress via direct reclaim unless it is
       killed after being woken up by kswapd
       (see throttle_direct_reclaim())

    2. With a SCHED_FIFO task that busy loops on a given CPU,
       and kworker for that CPU at SCHED_OTHER priority,
       queuing work to sync per-vmstats will either cause that
       work to never execute, or stalld (i.e. stall daemon)
       boosts kworker priority which causes a latency
       violation


As seen previously, the trivial test program (i.e. attached at the end of
this cover letter) executed inside a KVM VM, was used to determine the
somewhat impact under vanilla and with the proposed changes. Firstly, the
mlock(2) and munlock(2) system calls was used solely to modify vmstat item
'NR_MLOCK'. In another scenario, the nanosleep(2) system call was used
several times to suspend execution for a period of time to approximately
compute the number of CPU-cycles in the idle code path. The following is an
average count of CPU-cycles across the aforementioned system calls and the
idle loop, respectively. I believe these results are negligible:

				  Vanilla                 Modified

  Cycles per idle loop            151858                  153258  (+1.0%)
  Cycles per syscall              8461                    8690    (+2.6%)


Any feedback would be appreciated. Thanks.


Changes since v8 [1]:
- For nohz_full CPUs, manage per-CPU vmstat flushing from CPU context
   (Frederic Weisbecker)
 
Changes since v7 [2]:
 - Added trivial helpers for modification and testing
   (Andrew Morton)
 - Modified comment since we do now cancel any delayed
   work if the tick is stopped in quiet_vmstat()
 - Moved check to ensure vmstat differentials do not
   remain if the tick is stopped on exiting to user-mode
   into a separate patch
   (Frederic Weisbecker)

Changes since v6 [3]:
 - Clean vmstat_dirty before differential sync loop
 - Cancel pending work if tick stopped
 - Do not queue work to remote CPU if tick stopped

Changes since v5 [4]:

 - Introduced __tick_nohz_user_enter_prepare()
 - Switched to EXPORT_SYMBOL_GPL()

Changes since v4 [5]:

 - Moved vmstat_dirty specific changes into a separate patch
   (Marcelo Tosatti)

Changes since v3 [6]:

 - Used EXPORT_SYMBOL() on tick_nohz_user_enter_prepare()
 - Replaced need_update()
 - Introduced CPU-specific variable namely vmstat_dirty
   and mark_vmstat_dirty()

[1]: https://lore.kernel.org/linux-mm/20220924152227.819815-1-atomlin@redhat.com/
[2]: https://lore.kernel.org/lkml/20220817191346.287594886@redhat.com/
[3]: https://lore.kernel.org/linux-mm/20220808194820.676246-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220801234258.134609-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220621172207.1501641-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/lkml/20220422193647.3808657-1-atomlin@redhat.com/


Aaron Tomlin (4):
  mm/vmstat: Add CPU-specific variable to track a vmstat discrepancy
  mm/vmstat: Use vmstat_dirty to track CPU-specific vmstat discrepancies
  tick/nohz_full: Ensure quiet_vmstat() is called on exit to user-mode
    when the idle tick is stopped
  tick/sched: Ensure quiet_vmstat() is called when the idle tick was
    stopped too

Marcelo Tosatti (1):
  mm/vmstat: Do not queue vmstat_update if tick is stopped

 include/linux/tick.h     |  5 ++-
 kernel/time/tick-sched.c | 18 ++++++++-
 mm/vmstat.c              | 80 +++++++++++++++++++++-------------------
 3 files changed, 62 insertions(+), 41 deletions(-)

-- 
2.37.1

--- test-vmstat-overhead.c ---

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include <string.h>

typedef unsigned long long cycles_t;
typedef unsigned long long usecs_t;
typedef unsigned long long u64;

#ifdef __x86_64__
#define DECLARE_ARGS(val, low, high)    unsigned long low, high
#define EAX_EDX_VAL(val, low, high)     ((low) | ((u64)(high) << 32))
#define EAX_EDX_ARGS(val, low, high)    "a" (low), "d" (high)
#define EAX_EDX_RET(val, low, high)     "=a" (low), "=d" (high)
#else
#define DECLARE_ARGS(val, low, high)    unsigned long long val
#define EAX_EDX_VAL(val, low, high)     (val)
#define EAX_EDX_ARGS(val, low, high)    "A" (val)
#define EAX_EDX_RET(val, low, high)     "=A" (val)
#endif

static inline unsigned long long __rdtscll(void)
{
        DECLARE_ARGS(val, low, high);

        asm volatile("cpuid; rdtsc" : EAX_EDX_RET(val, low, high));

        return EAX_EDX_VAL(val, low, high);
}

#define rdtscll(val) do { (val) = __rdtscll(); } while (0)

#define NRSYSCALLS 30000
#define NRSLEEPS   100000

void main(int argc, char *argv[])
{
	unsigned long a, b, cycles;
	int i, syscall = 0;
	void *page = malloc(4096);

	if (mlock(page, 4096))
		perror("mlock");
	if (munlock(page, 4096))
		perror("munlock");

	if (argc != 2) {
		printf("usage: %s {idle,syscall}\n", argv[0]);
		exit(1);
	}

        rdtscll(a);

	if (strncmp("idle", argv[1], 4) == 0)
		syscall = 0;
	else if (strncmp("syscall", argv[1], 7) == 0)
		syscall = 1;
	else {
		printf("usage: %s {idle,syscall}\n", argv[0]);
		exit(1);
	}
	
	if (syscall == 1) {
        	for (i = 0; i < NRSYSCALLS; i++) {
			if (mlock(page, 4096))
				perror("mlock");
			if (munlock(page, 4096))
				perror("munlock");
		}
	} else {
        	for (i = 0; i < NRSLEEPS; i++)
		 	usleep(10);
	}

        rdtscll(b);

        cycles = b - a;

	if (syscall == 1)
        	printf("cycles per syscall: %d\n", (b-a)/(NRSYSCALLS*2));
	else
		printf("cycles per idle loop: %d\n", (b-a)/NRSLEEPS);
}




