Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8546C321D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCUM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCUM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC1446B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679403480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IA0s4cewAQV8rPDVtTlrJMqtApl2LJJvORTtv+RulJQ=;
        b=J7BkxqCgjuN2CxK0FkkmAO/Sz9OoP70MJkbH2T2uelYkvEcD6vAojtMdIElYqBI8IIfJS3
        N/LGFIebTZHFwASD2iQfgOTD40C1ZE+ioSQNeY8v3p10kQjioan+JHpW3HcNDU279QxMhz
        Dsu8yOwm74eEMgwYxfQ3tLpEiq9bNeg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-o9LOOsT4MpqKUpRkQeraZA-1; Tue, 21 Mar 2023 08:57:55 -0400
X-MC-Unique: o9LOOsT4MpqKUpRkQeraZA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82EC01C01B3A;
        Tue, 21 Mar 2023 12:57:54 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DC0A492C13;
        Tue, 21 Mar 2023 12:57:54 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0075D400DEA0A; Mon, 20 Mar 2023 16:07:29 -0300 (-03)
Date:   Mon, 20 Mar 2023 16:07:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <ZBiu8csaxB/zrOAS@tpad>
References: <20230320180332.102837832@redhat.com>
 <ZBilM1JR2HKElIR1@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBilM1JR2HKElIR1@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:25:55PM +0100, Michal Hocko wrote:
> On Mon 20-03-23 15:03:32, Marcelo Tosatti wrote:
> > This patch series addresses the following two problems:
> > 
> > 1. A customer provided evidence indicating that a process
> >    was stalled in direct reclaim:
> > 
> This is addressed by the trivial patch 1.
> 
> [...]
> >  2. With a task that busy loops on a given CPU,
> >     the kworker interruption to execute vmstat_update
> >     is undesired and may exceed latency thresholds
> >     for certain applications.
> 
> Yes it can but why does that matter?

It matters for the application that is executing and expects
not to be interrupted.

> > By having vmstat_shepherd flush the per-CPU counters to the
> > global counters from remote CPUs.
> > 
> > This is done using cmpxchg to manipulate the counters,
> > both CPU locally (via the account functions),
> > and remotely (via cpu_vm_stats_fold).
> > 
> > Thanks to Aaron Tomlin for diagnosing issue 1 and writing
> > the initial patch series.
> > 
> > 
> > Performance details for the kworker interruption:
> > 
> > oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> > oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> > oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> > kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> >  
> > The example above shows an additional 7us for the
> > 
> >         oslat -> kworker -> oslat
> > 
> > switches. In the case of a virtualized CPU, and the vmstat_update
> > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > observed in the guest is higher than 50us, violating the acceptable
> > latency threshold for certain applications.
> 
> I do not think we have ever promissed any specific latency guarantees
> for vmstat. These are statistics have been mostly used for debugging
> purposes AFAIK. I am not aware of any specific user space use case that
> would be latency sensitive. Your changelog doesn't go into details there
> either.

There is a class of workloads for which response time can be
of interest. MAC scheduler is an example:

https://par.nsf.gov/servlets/purl/10090368

Thanks!

