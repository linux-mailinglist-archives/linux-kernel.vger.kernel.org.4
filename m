Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5835722BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjFEPrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjFEPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DDB10EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685979938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ffbC5GLRZjhG3fHjx3VH+5QhPEpL5jEzUeB4tiW2aU=;
        b=ZSGQWP+oJqdpWwv63efI5m45XNvifDeBkUZSPWNtMUsUVvHZCrWKZIbOnEpS766yxsztLA
        rx1DPDUX6m/pT7J9F/+Kdcz0biem39n7pim3oJXJ4JHfqtCUZpt6tmZSn3qsb6H+sAPoJo
        fH0BUcZ5RvgtwHbk70Fcg/qHqeHe/yM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-oqc--MSvPQuc3YKlDpeDfw-1; Mon, 05 Jun 2023 11:45:35 -0400
X-MC-Unique: oqc--MSvPQuc3YKlDpeDfw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E445101A52C;
        Mon,  5 Jun 2023 15:45:34 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AE5848205E;
        Mon,  5 Jun 2023 15:45:34 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id D62B3401030EC; Mon,  5 Jun 2023 11:53:56 -0300 (-03)
Date:   Mon, 5 Jun 2023 11:53:56 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/3] vmstat: skip periodic vmstat update for nohz full
 CPUs
Message-ID: <ZH33BI9//tAbLvz5@tpad>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.521067386@redhat.com>
 <ZH2VDaF9uODTqAfV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH2VDaF9uODTqAfV@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:55:57AM +0200, Michal Hocko wrote:
> On Fri 02-06-23 15:57:59, Marcelo Tosatti wrote:
> > The interruption caused by vmstat_update is undesirable 
> > for certain aplications:
> > 
> > oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> > oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> > oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> > kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> > 
> > The example above shows an additional 7us for the
> > 
> >        	oslat -> kworker -> oslat
> > 
> > switches. In the case of a virtualized CPU, and the vmstat_update  
> > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > observed in the guest is higher than 50us, violating the acceptable
> > latency threshold.
> 
> I personally find the above problem description insufficient. I have
> asked several times and only got piece by piece information each time.
> Maybe there is a reason to be secretive but it would be great to get at
> least some basic expectations described  and what they are based on.

There is no reason to be secretive. 

> 
> E.g. workloads are running on isolated cpus with nohz full mode to
> shield off any kernel interruption. Yet there are operations that update
> counters (like mlock, but not mlock alone) that update per cpu counters
> that will eventually get flushed and that will cause some interference.
> Now the host/guest transition and intereference. How that happens when
> the guest is running on an isolated and dedicated cpu?

Follows the updated changelog. Does it contain the information
requested ?

----

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

> > Skip periodic updates for nohz full CPUs. Any callers who
> > need precise values should use a snapshot of the per-CPU
> > counters, or use the global counters with measures to 
> > handle errors up to thresholds (see calculate_normal_threshold).
> 
> I would rephrase this paragraph. 
> In kernel users of vmstat counters either require the precise value and
> they are using zone_page_state_snapshot interface or they can live with
> an imprecision as the regular flushing can happen at arbitrary time and
> cumulative error can grow (see calculate_normal_threshold).

> >From that POV the regular flushing can be postponed for CPUs that have
> been isolated from the kernel interference withtout critical
> infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
> for all isolated CPUs to avoid interference with the isolated workload.
> 
> > Suggested by Michal Hocko.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

OK, updated comment, thanks.

