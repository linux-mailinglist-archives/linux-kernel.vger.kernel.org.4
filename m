Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A07564F204
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiLPTxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiLPTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:53:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F23659B9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671220360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=pNk6isseu9BDePDMqOicfhc0+1gcdt8ubPeHs74nJ0A=;
        b=ehAWVYWDxwtUTQSysgzWYmzKxAuyVu1qS1bCjp+4R6sRWKlp1XEiemUK/lIWUlkkz6S9DS
        jAIkyGhCLmBq8MNaV1qxplfUzYo1uIXnmOpI3KrxRbewoIBCzaELNU+UyqVyv4O0oHnUQd
        3/3pb/ZD7Ci4nIcAUnRJFZtg8yoMIwI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-C3835TzZONe2twDDAUsusQ-1; Fri, 16 Dec 2022 14:52:37 -0500
X-MC-Unique: C3835TzZONe2twDDAUsusQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49BAE2805583;
        Fri, 16 Dec 2022 19:52:36 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67A2140C2004;
        Fri, 16 Dec 2022 19:52:35 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id C112E405151AA; Fri, 16 Dec 2022 16:52:10 -0300 (-03)
Message-ID: <20221216194540.202752779@redhat.com>
User-Agent: quilt/0.66
Date:   Fri, 16 Dec 2022 16:45:40 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v10 0/6] Ensure quiet_vmstat() is called when returning to userpace and when idle tick is stopped
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Changes since v9 [1]:
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

Changes since v8 [2]:
- For nohz_full CPUs, manage per-CPU vmstat flushing from CPU context
   (Frederic Weisbecker)
 
Changes since v7 [3]:
 - Added trivial helpers for modification and testing
   (Andrew Morton)
 - Modified comment since we do now cancel any delayed
   work if the tick is stopped in quiet_vmstat()
 - Moved check to ensure vmstat differentials do not
   remain if the tick is stopped on exiting to user-mode
   into a separate patch
   (Frederic Weisbecker)

Changes since v6 [4]:
 - Clean vmstat_dirty before differential sync loop
 - Cancel pending work if tick stopped
 - Do not queue work to remote CPU if tick stopped

Changes since v5 [5]:

 - Introduced __tick_nohz_user_enter_prepare()
 - Switched to EXPORT_SYMBOL_GPL()

Changes since v4 [6]:

 - Moved vmstat_dirty specific changes into a separate patch
   (Marcelo Tosatti)

Changes since v3 [7]:

 - Used EXPORT_SYMBOL() on tick_nohz_user_enter_prepare()
 - Replaced need_update()
 - Introduced CPU-specific variable namely vmstat_dirty
   and mark_vmstat_dirty()

[1]: https://lore.kernel.org/lkml/20221214131839.GE1930067@lothringen/t/
[2]: https://lore.kernel.org/linux-mm/20220924152227.819815-1-atomlin@redhat.com/
[3]: https://lore.kernel.org/lkml/20220817191346.287594886@redhat.com/
[4]: https://lore.kernel.org/linux-mm/20220808194820.676246-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220801234258.134609-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/lkml/20220621172207.1501641-1-atomlin@redhat.com/
[7]: https://lore.kernel.org/lkml/20220422193647.3808657-1-atomlin@redhat.com/


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

 include/linux/tick.h     |    5 ++-
 include/linux/vmstat.h   |    4 +-
 kernel/time/tick-sched.c |   19 ++++++++++++-
 mm/Kconfig               |   13 +++++++++
 mm/vmstat.c              |  156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 5 files changed, 145 insertions(+), 52 deletions(-)


