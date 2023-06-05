Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CB9722EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjFES2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjFES2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC7EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685989669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F0XqFQBSCQ12L8mv/otKopJp+8rvCqAHqXXt9iU32Q8=;
        b=DFhKpvOOapCSMNauQX2DeV0UNogWmjUaPRnJzJ0A+e9kdqSbij3QiXzXapcDkZBXQ5GbW2
        CqZoCYairNxkYRSfgtqzHgeCOV/FXd7fuDavDhAtpC/W2tjNMi6JOsOEbuFwpWFdGb5lgE
        hPirvdtb4jN+LPhGEfsg4KmSfklHGAA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-RrofEaTzMMyit1VcQkYoSg-1; Mon, 05 Jun 2023 14:27:48 -0400
X-MC-Unique: RrofEaTzMMyit1VcQkYoSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C4211C07543;
        Mon,  5 Jun 2023 18:27:47 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5740940D1B61;
        Mon,  5 Jun 2023 18:27:47 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 11129400E7185; Mon,  5 Jun 2023 14:35:56 -0300 (-03)
Date:   Mon, 5 Jun 2023 14:35:56 -0300
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
Message-ID: <ZH4c/MqHoWiA0PaQ@tpad>
References: <20230602185757.110910188@redhat.com>
 <20230602190115.521067386@redhat.com>
 <ZH2VDaF9uODTqAfV@dhcp22.suse.cz>
 <ZH33BI9//tAbLvz5@tpad>
 <ZH4FhQ5Lh6xFBjyz@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4FhQ5Lh6xFBjyz@dhcp22.suse.cz>
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

On Mon, Jun 05, 2023 at 05:55:49PM +0200, Michal Hocko wrote:
> > The example above shows an additional 7us for the
> > 
> >         oslat -> kworker -> oslat
> > 
> > switches. In the case of a virtualized CPU, and the vmstat_update
> > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > observed in the guest is higher than 50us, violating the acceptable
> > latency threshold.
> > 
> > The isolated vCPU can perform operations that modify per-CPU page counters,
> > for example to complete I/O operations:
> > 
> >       CPU 11/KVM-9540    [001] dNh1.  2314.248584: mod_zone_page_state <-__folio_end_writeback
> >       CPU 11/KVM-9540    [001] dNh1.  2314.248585: <stack trace>
> >  => 0xffffffffc042b083
> >  => mod_zone_page_state
> >  => __folio_end_writeback
> >  => folio_end_writeback
> >  => iomap_finish_ioend
> >  => blk_mq_end_request_batch
> >  => nvme_irq
> >  => __handle_irq_event_percpu
> >  => handle_irq_event
> >  => handle_edge_irq
> >  => __common_interrupt
> >  => common_interrupt
> >  => asm_common_interrupt
> >  => vmx_do_interrupt_nmi_irqoff
> >  => vmx_handle_exit_irqoff
> >  => vcpu_enter_guest
> >  => vcpu_run
> >  => kvm_arch_vcpu_ioctl_run
> >  => kvm_vcpu_ioctl
> >  => __x64_sys_ioctl
> >  => do_syscall_64
> >  => entry_SYSCALL_64_after_hwframe
> 
> OK, this is really useful. It is just not really clear whether the IO
> triggered here is from the guest or it a host activity.

Guest initiated I/O, since the host CPU is isolated.

