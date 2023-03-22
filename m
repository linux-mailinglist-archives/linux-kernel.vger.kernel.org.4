Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6B6C4745
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCVKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCVKNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:13:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3840072AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:13:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E1CE121B45;
        Wed, 22 Mar 2023 10:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679479982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqEzHI7CsoF2HtxRsuwP9+5W2QuYHXY8VrSFADFSMLM=;
        b=nTml06VeJDqK9PEr/pRjJsAJ13bkHpV7QyzOi3MENEr+VHVAZfGLpu7kGmaBJDt56cpijR
        XFCxNyk/Y+5V0PanR6I9OwVkyv1QVrxosPmUVQVW9B8jXleMxpxNNu3STvpHnpzJoXVLIA
        +QRg5R4/1vUhgJI0ZuXXbspr/NhFqOE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC5C7138E9;
        Wed, 22 Mar 2023 10:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yuIuKq7UGmT5CQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 22 Mar 2023 10:13:02 +0000
Date:   Wed, 22 Mar 2023 11:13:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZBrUruIsOjdaqiFv@dhcp22.suse.cz>
References: <20230320180332.102837832@redhat.com>
 <ZBilM1JR2HKElIR1@dhcp22.suse.cz>
 <ZBiu8csaxB/zrOAS@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBiu8csaxB/zrOAS@tpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-03-23 16:07:29, Marcelo Tosatti wrote:
> On Mon, Mar 20, 2023 at 07:25:55PM +0100, Michal Hocko wrote:
> > On Mon 20-03-23 15:03:32, Marcelo Tosatti wrote:
> > > This patch series addresses the following two problems:
> > > 
> > > 1. A customer provided evidence indicating that a process
> > >    was stalled in direct reclaim:
> > > 
> > This is addressed by the trivial patch 1.
> > 
> > [...]
> > >  2. With a task that busy loops on a given CPU,
> > >     the kworker interruption to execute vmstat_update
> > >     is undesired and may exceed latency thresholds
> > >     for certain applications.
> > 
> > Yes it can but why does that matter?
> 
> It matters for the application that is executing and expects
> not to be interrupted.

Those workloads shouldn't enter the kernel in the first place, no?
Otherwise the in kernel execution with all the direct or indirect
dependencies (e.g. via locks) can throw any latency expectations off the
window.

> > > By having vmstat_shepherd flush the per-CPU counters to the
> > > global counters from remote CPUs.
> > > 
> > > This is done using cmpxchg to manipulate the counters,
> > > both CPU locally (via the account functions),
> > > and remotely (via cpu_vm_stats_fold).
> > > 
> > > Thanks to Aaron Tomlin for diagnosing issue 1 and writing
> > > the initial patch series.
> > > 
> > > 
> > > Performance details for the kworker interruption:
> > > 
> > > oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> > > oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> > > oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> > > kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> > >  
> > > The example above shows an additional 7us for the
> > > 
> > >         oslat -> kworker -> oslat
> > > 
> > > switches. In the case of a virtualized CPU, and the vmstat_update
> > > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > > observed in the guest is higher than 50us, violating the acceptable
> > > latency threshold for certain applications.
> > 
> > I do not think we have ever promissed any specific latency guarantees
> > for vmstat. These are statistics have been mostly used for debugging
> > purposes AFAIK. I am not aware of any specific user space use case that
> > would be latency sensitive. Your changelog doesn't go into details there
> > either.
> 
> There is a class of workloads for which response time can be
> of interest. MAC scheduler is an example:
> 
> https://par.nsf.gov/servlets/purl/10090368

Yes, I am not disputing low latency workloads in general. I am just
saying that you haven't really established a very sound justification
here. Of course there are workloads which do not want to conflict with
any in kernel house keeping. Those have to be configured and implemented
very carefully though. Vmstat as such should not collide with those
workloads as long as they do not interact with the kernel in a way
counters are updated. Is this hard or impossible to avoid? 

I can imagine that those workloads have an start up sequence where the
kernel is involved and counters updated so that deferred flushing could
interfere with the later and latency sensitive phase. Is that a real
problem in practice? Please tell us much more why we need to make the
vmstat code more complex.

Thanks!
-- 
Michal Hocko
SUSE Labs
