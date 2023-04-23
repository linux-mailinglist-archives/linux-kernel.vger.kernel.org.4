Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021426EBC4B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDWBer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDWBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E8268C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682213636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLOVOny8O2dWoMM2WOsk22I7C/agD8h9lmOtwFfKMYA=;
        b=bxsY+pLLqrkt5b+NCo5e9YsV6NAD1jJ/9bJu2vBLjQa23aAQkJeqUyvv1t76xW9D4fc48a
        uqsru10I0UU2yqm3/5yqYrvE+pRpfSkUtyuliVecOGr2xXyPjQ86Rv2u0TJNeTDdNc5SFD
        ZPIYO24Qk/iVPSgHkTPS6zq2vIWKE4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-kAiGWq3jMReOV2txbgZ6zQ-1; Sat, 22 Apr 2023 21:33:50 -0400
X-MC-Unique: kAiGWq3jMReOV2txbgZ6zQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAB7D85C064;
        Sun, 23 Apr 2023 01:33:49 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B62F2023163;
        Sun, 23 Apr 2023 01:33:49 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 748114039CABD; Sat, 22 Apr 2023 22:10:02 -0300 (-03)
Date:   Sat, 22 Apr 2023 22:10:02 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZESFas7tX9W/yfha@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
 <ZEAYQBJmVwsjpjGY@tpad>
 <ZED6eS2VEqZUvc4I@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZED6eS2VEqZUvc4I@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 10:40:25AM +0200, Michal Hocko wrote:
> On Wed 19-04-23 13:35:12, Marcelo Tosatti wrote:
> [...]
> > This is a burden for application writers and for system configuration.
> 
> Yes. And I find it reasonable to expect that burden put there as there
> are non-trivial requirements for those workloads anyway. It is not
> out-of-the-box thing, right?

See below.

> > Or it could be done automatically (from outside of the application).
> > Which is what is described and implemented here:
> > 
> > https://lore.kernel.org/lkml/20220204173537.429902988@fedora.localdomain/
> > 
> > "Task isolation is divided in two main steps: configuration and
> > activation.
> > 
> > Each step can be performed by an external tool or the latency
> > sensitive application itself. util-linux contains the "chisol" tool
> > for this purpose."
> 
> I cannot say I would be a fan of prctl interfaces in general but I do
> agree with the overal idea to forcing a quiescent state on a set of
> CPUs.

This has been avoided with success so far.

> > But not only that, the second thing is:
> > 
> > "> Another important point is this: if an application dirties
> > > its own per-CPU vmstat cache, while performing a system call,
> > 
> > Or while handling a VM-exit from a vCPU.
> 
> Do you have any specific examples on this?

Interrupt handling freeing a page. 

handle_access_fault             (ARM64) ->
handle_changed_spte_acc_track   (x86)   -> kvm_set_pfn_accessed -> kvm_set_page_accessed -> mark_page_accessed ->
                                           folio_mark_accessed -> folio_activate -> folio_activate_fn ->
                                           lruvec_add_folio -> update_lru_size -> __update_lru_size ->
                                            __mod_zone_page_state(&pgdat->node_zones[zid],
                                                                  NR_ZONE_LRU_BASE + lru, nr_pages);


The other option would be to _FORBID_ use of  __mod_zone_page_state in certain code sections.

> > This are, in my mind, sufficient reasons to discard the "flush per-cpu
> > caches" idea. This is also why i chose to abandon the prctrl interface
> > patchset.
> > 
> > > and a vmstat sync event is triggered on a different CPU, you'd have to:                                                             
> > >                                                                                                                                     
> > > 1) Wait for that CPU to return to userspace and sync its stats
> > > (unfeasible).
> > >
> > > 2) Queue work to execute on that CPU (undesirable, as that causes
> > > an interruption).
> > >
> > > 3) Remotely sync the vmstat for that CPU."
> > 
> > So the only option is to remotely sync vmstat for the CPU
> > (unless you have a better suggestion).
> 
> `echo 1 > /proc/sys/vm/stat_refresh' achieves essentially the same
> without any kernel changes.

It is unsuitable. You'd have to guarantee that, by the time you return
from the write() system call to that file, there has been no other 
mod_zone_page_state call. For example, no interrupt 
or exception that frees or allocates a page through rmqueue 
(NR_FREE_PAGES counter), or that bounce_end_io cannot be called 
(since it calls dec_zone_page_state).

It has been used internally as a workaround, but it is not reliable.

> But let me repeat, this is not just about vmstats. Just have a look at
> other queue_work_on users. You do not want to handy pick each and every
> one and do so in the future as well.

The ones that are problematic are being fixed for sometime now. For example:

commit 2de79ee27fdb52626ac4ac48ec6d8d52ba6f9047
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Thu Sep 10 23:33:18 2020 +0200

    net: try to avoid unneeded backlog flush

    flush_all_backlogs() may cause deadlock on systems
    running processes with FIFO scheduling policy.

    The above is critical in -RT scenarios, where user-space
    specifically ensure no network activity is scheduled on
    the CPU running the mentioned FIFO process, but still get
    stuck.

    This commit tries to address the problem checking the
    backlog status on the remote CPUs before scheduling the
    flush operation. If the backlog is empty, we can skip it.

    v1 -> v2:
     - explicitly clear flushed cpu mask - Eric

    Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>


And it has been a normal process so far.

I think what needs to be done is to avoid new queue_work_on() 
users from being introduced in the tree (the number of
existing ones is finite and can therefore be fixed).

