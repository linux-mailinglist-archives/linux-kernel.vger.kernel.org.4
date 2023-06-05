Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F954722F23
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjFETEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjFETDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4717ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685991774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IAf4R5o0gQZjozbQ8tE/X+XgLQMuANKlfa1dzEwKui8=;
        b=Tt5gns3cK2TH3PU7w2gLIfATM2RrpHK/d1Sfdf0X8Vc6Kmc9YUIidfKVCeJiQ8lVW3Z7Cs
        5J/sVeEZRNZktqlFg6QoBrQ0YKs+HZRtxtZesF/Nh3t+RtZd6DCbNMYpu2qJEX/1Ln6lSw
        aYX2tV6UMJNMrxFXI4MnUCCXbkfF8AM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-z2HfVbExNb-4TD6HCY8g_Q-1; Mon, 05 Jun 2023 15:02:51 -0400
X-MC-Unique: z2HfVbExNb-4TD6HCY8g_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69CB38039B1;
        Mon,  5 Jun 2023 19:02:50 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3196240D1B61;
        Mon,  5 Jun 2023 19:02:50 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 39AF6400F7B4D; Mon,  5 Jun 2023 16:02:31 -0300 (-03)
Message-ID: <20230605190132.059270652@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 05 Jun 2023 15:56:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 2/3] vmstat: skip periodic vmstat update for isolated CPUs
References: <20230605185627.923698377@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

>From that POV the regular flushing can be postponed for CPUs that have
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
 


