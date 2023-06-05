Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2993D722F22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjFETEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjFETDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A5F1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685991774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=s5tdtHnLZvCMKkl37zUI2THLQyUAmR+6J6FU2qPBz0c=;
        b=e3K2b+Y4rof5RoelFbI42pzu62EeOPTvlobnK8uhEuwh8MqoazucwuS7erxOkpQOaz6/cD
        +tEVZvHPogARv0Z3WXOLGE2glVF6l6ODJ/kWqPX5AG0HCyFmRBTeMelWVc+V7oAn0yfgxU
        CgPaaUo8eBI4oOcyLMBk6HutDBqsZpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-8Sqk7QK3PfaL3ELpBOVU5A-1; Mon, 05 Jun 2023 15:02:51 -0400
X-MC-Unique: 8Sqk7QK3PfaL3ELpBOVU5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B326811E98;
        Mon,  5 Jun 2023 19:02:50 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31DB92026D49;
        Mon,  5 Jun 2023 19:02:50 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 33BE7400DF274; Mon,  5 Jun 2023 16:02:31 -0300 (-03)
Message-ID: <20230605185627.923698377@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 05 Jun 2023 15:56:27 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 0/3] vmstat bug fixes for nohz_full and isolated CPUs
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the following two problems:

1. A customer provided evidence indicating that a process
   was stalled in direct reclaim:

 - The process was trapped in throttle_direct_reclaim().
   The function wait_event_killable() was called to wait condition
   allow_direct_reclaim(pgdat) for current node to be true.
   The allow_direct_reclaim(pgdat) examined the number of free pages
   on the node by zone_page_state() which just returns value in
   zone->vm_stat[NR_FREE_PAGES].

 - On node #1, zone->vm_stat[NR_FREE_PAGES] was 0.
   However, the freelist on this node was not empty.

 - This inconsistent of vmstat value was caused by percpu vmstat on
   nohz_full cpus. Every increment/decrement of vmstat is performed
   on percpu vmstat counter at first, then pooled diffs are cumulated
   to the zone's vmstat counter in timely manner. However, on nohz_full
   cpus (in case of this customer's system, 48 of 52 cpus) these pooled
   diffs were not cumulated once the cpu had no event on it so that
   the cpu started sleeping infinitely.
   I checked percpu vmstat and found there were total 69 counts not
   cumulated to the zone's vmstat counter yet.

 - In this situation, kswapd did not help the trapped process.
   In pgdat_balanced(), zone_wakermark_ok_safe() examined the number
   of free pages on the node by zone_page_state_snapshot() which
   checks pending counts on percpu vmstat.
   Therefore kswapd could know there were 69 free pages correctly.
   Since zone->_watermark = {8, 20, 32}, kswapd did not work because
   69 was greater than 32 as high watermark.

 2. With a task that busy loops on a given CPU,
    the kworker interruption to execute vmstat_update
    is undesired and may exceed latency thresholds
    for certain applications.

First issue is solved by using _snapshot version of
the counters on allow_direct_reclaim.

Second issue is fixed by disabling periodic vmstat
updates for nohz_full CPUs.

Thanks to Aaron Tomlin for diagnosing issue 1 and writing
the initial patch series.


Performance details for the kworker interruption:

With workloads that are running on isolated cpus with nohz full mode to
shield off any kernel interruption. For example, a VM running a
time sensitive application with a 50us maximum acceptable interruption
(use case: soft PLC).

oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...

The example above shows an additional 7us for the

        oslat -> kworker -> oslat

switches. In the case of a virtualized CPU, and the vmstat_update
interruption in the host (of a qemu-kvm vcpu), the latency penalty
observed in the guest is higher than 50us, violating the acceptable
latency threshold.

The isolated vCPU can perform operations that modify per-CPU page counters,
for example to complete I/O operations:

      CPU 11/KVM-9540    [001] dNh1.  2314.248584: mod_zone_page_state <-__folio_end_writeback
      CPU 11/KVM-9540    [001] dNh1.  2314.248585: <stack trace>
 => 0xffffffffc042b083
 => mod_zone_page_state
 => __folio_end_writeback
 => folio_end_writeback
 => iomap_finish_ioend
 => blk_mq_end_request_batch
 => nvme_irq
 => __handle_irq_event_percpu
 => handle_irq_event
 => handle_edge_irq
 => __common_interrupt
 => common_interrupt
 => asm_common_interrupt
 => vmx_do_interrupt_nmi_irqoff
 => vmx_handle_exit_irqoff
 => vcpu_enter_guest
 => vcpu_run
 => kvm_arch_vcpu_ioctl_run
 => kvm_vcpu_ioctl
 => __x64_sys_ioctl
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe


v3: improve changelog		(Michal Hocko)
v2: use cpu_is_isolated         (Michal Hocko)
    opencode schedule_on_each_cpu (Michal Hocko)

 mm/vmscan.c |    2 +-
 mm/vmstat.c |   39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 5 deletions(-)



