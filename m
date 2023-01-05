Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73265EB40
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjAEM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjAEM52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194611178
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672923404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1jRVhGgkDfo2ov1sfU3sfMBRbJJBvfhXQvqYKuO2EBo=;
        b=isV9MBQOYqmEQRkBRYvJHKEbn60U/gS7iHRPONvEXAznvjQxxl8DcSSKc/bJEHvWecVDIO
        y+ZfJYp5pPUYcID1n5ToJzqEJYYifmqujPzLMEBe2Iodv7kNrAi2Ya6aih1nMDn/Z2vaSB
        rv8CEW6VpzEOT/4I7n3VeGaahlA13so=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-2bHDPxFwOV-e2Z5Hia4oTA-1; Thu, 05 Jan 2023 07:56:41 -0500
X-MC-Unique: 2bHDPxFwOV-e2Z5Hia4oTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFA778028B0;
        Thu,  5 Jan 2023 12:56:40 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37BD82166B30;
        Thu,  5 Jan 2023 12:56:40 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 936C2405026BF; Thu,  5 Jan 2023 09:54:47 -0300 (-03)
Message-ID: <20230105125218.031928326@redhat.com>
User-Agent: quilt/0.66
Date:   Thu, 05 Jan 2023 09:52:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@atomlin.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v13 0/6] Ensure quiet_vmstat() is called when returning to userpace and when idle tick is stopped
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Changes since v12 [1]:
- Protect vmstat cmpxchg and vmstat dirty bit write 
  by disabling preemption (Frederic Weisbecker)

Changes since v11 [2]:
- Switch back to this_cpu_write/read when appropriate
   (Frederic Weisbecker)
- Avoid ifdeffery in the middle of functions
   (Frederic Weisbecker)
- Clarify down_prep callback comment
   (Frederic Weisbecker)
- Move new Kconfig option close to CPU_ISOLATION option
   (Frederic Weisbecker)

Changes since v10 [3]:
- Close cpu hotplug race with nohz_full CPUs
   (Frederic Weisbecker)

Changes since v9 [4]:
- Add config to enable/disable syncing when returning to userspace
   (Frederic Weisbecker)
- Add missing signed-off-by
   (Frederic Weisbecker)
- Use proper CPU value when skipping nohz_full CPUs
   (Frederic Weisbecker)
- Use this_cpu_ptr when appropriate
   (Frederic Weisbecker)
- Improve changelogs
   (Frederic Weisbecker)
- For stat_refresh sysfs file: avoid queueing work on CPU if stats are clean

Changes since v8 [5]:
- For nohz_full CPUs, manage per-CPU vmstat flushing from CPU context
   (Frederic Weisbecker)
 
Changes since v7 [6]:
 - Added trivial helpers for modification and testing
   (Andrew Morton)
 - Modified comment since we do now cancel any delayed
   work if the tick is stopped in quiet_vmstat()
 - Moved check to ensure vmstat differentials do not
   remain if the tick is stopped on exiting to user-mode
   into a separate patch
   (Frederic Weisbecker)

Changes since v6 [7]:
 - Clean vmstat_dirty before differential sync loop
 - Cancel pending work if tick stopped
 - Do not queue work to remote CPU if tick stopped

Changes since v5 [8]:

 - Introduced __tick_nohz_user_enter_prepare()
 - Switched to EXPORT_SYMBOL_GPL()

Changes since v4 [9]:

 - Moved vmstat_dirty specific changes into a separate patch
   (Marcelo Tosatti)

Changes since v3 [10]:

 - Used EXPORT_SYMBOL() on tick_nohz_user_enter_prepare()
 - Replaced need_update()
 - Introduced CPU-specific variable namely vmstat_dirty
   and mark_vmstat_dirty()

[1]: https://lore.kernel.org/linux-mm/20230104133459.5yaflf3yicpmhbbh@ava.usersys.com/T/
[2]: https://lore.kernel.org/lkml/20221223144150.GA79369@lothringen/T/
[3]: https://lore.kernel.org/linux-mm/20221216194904.075275493@redhat.com/T/
[4]: https://lore.kernel.org/lkml/20221214131839.GE1930067@lothringen/t/
[5]: https://lore.kernel.org/linux-mm/20220924152227.819815-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/lkml/20220817191346.287594886@redhat.com/
[7]: https://lore.kernel.org/linux-mm/20220808194820.676246-1-atomlin@redhat.com/
[8]: https://lore.kernel.org/lkml/20220801234258.134609-1-atomlin@redhat.com/
[9]: https://lore.kernel.org/lkml/20220621172207.1501641-1-atomlin@redhat.com/
[10]: https://lore.kernel.org/lkml/20220422193647.3808657-1-atomlin@redhat.com/


Aaron Tomlin (4):
  mm/vmstat: Add CPU-specific variable to track a vmstat discrepancy
  mm/vmstat: Use vmstat_dirty to track CPU-specific vmstat discrepancies
  tick/nohz_full: Ensure quiet_vmstat() is called on exit to user-mode
    when the idle tick is stopped
  tick/sched: Ensure quiet_vmstat() is called when the idle tick was
    stopped too

Marcelo Tosatti (2):
  mm/vmstat: Do not queue vmstat_update if tick is stopped
  mm/vmstat: avoid queueing work item if cpu stats are clean


 include/linux/tick.h     |    5 +-
 include/linux/vmstat.h   |    4 -
 init/Kconfig             |   13 +++++
 kernel/time/tick-sched.c |   20 ++++++++-
 mm/vmstat.c              |  223 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 5 files changed, 214 insertions(+), 51 deletions(-)


