Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A617273FD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjFHBMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFHBMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6E269F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686186705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mdQ0lF7C7zgaRMoTdeqNXNG4mPlYrnhL6rmrdXZfaoI=;
        b=XZmp0ACewuoRonIncg5Uzv8nIIX0l73ii6rj0oYTpleAgsyAl+F0lpq8hZme1AYS9MpXo7
        rOfjs8R4t8IUMKCVdDjKa2SAeqDswcPMTrL/B7EFLDqwLR4pAooyzuLqbSIptLGpkym0Xh
        YVkuPuGdryIm35U3OPg4sG8ehmiK2Tc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-y1ZFZL7DPKeBSvgVD9UArA-1; Wed, 07 Jun 2023 21:11:42 -0400
X-MC-Unique: y1ZFZL7DPKeBSvgVD9UArA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D75D5185A78E;
        Thu,  8 Jun 2023 01:11:41 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A20F6403367;
        Thu,  8 Jun 2023 01:11:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id C29CC40E16DC2; Wed,  7 Jun 2023 17:28:07 -0300 (-03)
Date:   Wed, 7 Jun 2023 17:28:07 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] vmstat: skip periodic vmstat update for isolated CPUs
Message-ID: <ZIDoV/zxFKVmQl7W@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Problem: The interruption caused by vmstat_update is undesirable
for certain applications.

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

In kernel users of vmstat counters either require the precise value and
they are using zone_page_state_snapshot interface or they can live with
an imprecision as the regular flushing can happen at arbitrary time and
cumulative error can grow (see calculate_normal_threshold).

>>From that POV the regular flushing can be postponed for CPUs that have                                                                                                                                                                                        
been isolated from the kernel interference without critical
infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
for all isolated CPUs to avoid interference with the isolated workload.

Suggested by Michal Hocko.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v3: improve changelog		(Michal Hocko)
v2: use cpu_is_isolated		(Michal Hocko)

Index: linux-vmstat-remote/mm/vmstat.c
===================================================================
--- linux-vmstat-remote.orig/mm/vmstat.c
+++ linux-vmstat-remote/mm/vmstat.c
@@ -28,6 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
+#include <linux/sched/isolation.h>
 
 #include "internal.h"
 
@@ -2022,6 +2023,20 @@ static void vmstat_shepherd(struct work_
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
 
+		/*
+		 * In kernel users of vmstat counters either require the precise value and
+		 * they are using zone_page_state_snapshot interface or they can live with
+		 * an imprecision as the regular flushing can happen at arbitrary time and
+		 * cumulative error can grow (see calculate_normal_threshold).
+		 *
+		 * From that POV the regular flushing can be postponed for CPUs that have
+		 * been isolated from the kernel interference without critical
+		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
+		 * for all isolated CPUs to avoid interference with the isolated workload.
+		 */
+		if (cpu_is_isolated(cpu))
+			continue;
+
 		if (!delayed_work_pending(dw) && need_update(cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
 



