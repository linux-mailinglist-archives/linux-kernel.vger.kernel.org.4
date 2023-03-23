Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A686C6993
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjCWNdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjCWNd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D928E77
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679578363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D0+UIJf+hRDi9UkxorblNOIBkjDzSQBgUMEBtPodtXk=;
        b=RwyTdSHcizpTMHz99q5/rmDkziTqYWvNwtyX+yJ8fOqDICW7246rT1MDdZu6vKMvTMw6Jr
        QnlDCELbhe8A6ECPoFDw9O1bTH5zL/J378XzRFMXgfa6eDScRN/vQflsEGrRn8lCaFwgjg
        cC2vi9DQzepW9kbUz1gKCPOu+BD/VG4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-DZqokFX7OLmnTRvdk9qSNg-1; Thu, 23 Mar 2023 09:32:38 -0400
X-MC-Unique: DZqokFX7OLmnTRvdk9qSNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 064131C0A59C;
        Thu, 23 Mar 2023 13:32:36 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CDCDC15BA0;
        Thu, 23 Mar 2023 13:32:35 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id B193C403C40DA; Thu, 23 Mar 2023 10:32:15 -0300 (-03)
Date:   Thu, 23 Mar 2023 10:32:15 -0300
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
Message-ID: <ZBxU3zhd9+VBLwLD@tpad>
References: <ZBilM1JR2HKElIR1@dhcp22.suse.cz>
 <ZBiu8csaxB/zrOAS@tpad>
 <ZBrUruIsOjdaqiFv@dhcp22.suse.cz>
 <ZBrlKeZTsHgRW021@tpad>
 <ZBsEGMEfEI98Wpwq@dhcp22.suse.cz>
 <ZBsOx1abWfBTdGFl@tpad>
 <ZBwE8gUUxI+aKuAm@dhcp22.suse.cz>
 <ZBwvZkDXfCBuWMe8@tpad>
 <ZBxDXOjl5oV49gQH@dhcp22.suse.cz>
 <ZBxUZTgPz3VV3h9V@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxUZTgPz3VV3h9V@tpad>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:30:13AM -0300, Marcelo Tosatti wrote:
> On Thu, Mar 23, 2023 at 01:17:32PM +0100, Michal Hocko wrote:
> > On Thu 23-03-23 07:52:22, Marcelo Tosatti wrote:
> > > On Thu, Mar 23, 2023 at 08:51:14AM +0100, Michal Hocko wrote:
> > > > On Wed 22-03-23 11:20:55, Marcelo Tosatti wrote:
> > > > > On Wed, Mar 22, 2023 at 02:35:20PM +0100, Michal Hocko wrote:
> > > > [...]
> > > > > > > "Performance details for the kworker interruption:
> > > > > > > 
> > > > > > > oslat   1094.456862: sys_mlock(start: 7f7ed0000b60, len: 1000)
> > > > > > > oslat   1094.456971: workqueue_queue_work: ... function=vmstat_update ...
> > > > > > > oslat   1094.456974: sched_switch: prev_comm=oslat ... ==> next_comm=kworker/5:1 ...
> > > > > > > kworker 1094.456978: sched_switch: prev_comm=kworker/5:1 ==> next_comm=oslat ...
> > > > > > > 
> > > > > > > The example above shows an additional 7us for the
> > > > > > > 
> > > > > > >         oslat -> kworker -> oslat
> > > > > > > 
> > > > > > > switches. In the case of a virtualized CPU, and the vmstat_update
> > > > > > > interruption in the host (of a qemu-kvm vcpu), the latency penalty
> > > > > > > observed in the guest is higher than 50us, violating the acceptable
> > > > > > > latency threshold for certain applications."
> > > > > > 
> > > > > > Yes, I have seen that but it doesn't really give a wider context to
> > > > > > understand why those numbers matter.
> > > > > 
> > > > > OK.
> > > > > 
> > > > > "In the case of RAN, a MAC scheduler with TTI=1ms, this causes >100us
> > > > > interruption observed in a guest (which is above the safety
> > > > > threshold for this application)."
> > > > > 
> > > > > Is that OK?
> > > > 
> > > > This might be a sufficient information for somebody familiar with the
> > > > matter (not me). So no, not enough. We need to hear a more complete
> > > > story. 
> > > 
> > > Michal,
> > > 
> > > Please refer to 
> > > https://www.diva-portal.org/smash/get/diva2:541460/FULLTEXT01.pdf
> > > 
> > > 2.3 Channel Dependent Scheduling
> > > The purpose of scheduling is to decide which terminal will transmit data on which set
> > > of resource blocks with what transport format to use. The objective is to assign
> > > resources to the terminal such that the quality of service (QoS) requirement is fulfilled.
> > > Scheduling decision is taken every 1 ms by base station (termed as eNodeB) as the
> > > same length of Transmission Time Interval (TTI) in LTE system.
> > > 
> > > In general:
> > > 
> > > https://en.wikipedia.org/wiki/Real-time_computing
> > 
> > Thank you, but not something I was really asking for (repeatedly). I am
> > pretty aware of what RT computing is about. I am not really interested
> > in a generic fluff. I am asking about specific usecases you have in mind
> > when pushing these changes.
> >  
> > > For example, for the MAC scheduler processing must occur every 1ms,
> > > and a certain amount of computation takes place (and must finish before
> > > the next 1ms timeframe). A > 50us latency spike as observed by cyclictest
> > > is considered a "failure".
> > 
> > OK, you are claiming that much but you are not really filling up other
> > holes in your story. Let me just outline few questions I have. Your
> > measurements talk about 7us overhead the vmstat processing might add.
> > This is really far from > 50us above. 
> 
> 7us in the host, for the following sched_switch events:
> 
> 	oslat -> kworker
> 	kworker -> oslat
> 
> However, if the impact is for a virtualized application:
> 
> 	oslat, executing via qemu-vcpu process in the host.
> 
> 	oslat executing
> 	qemu-vcpu VM-EXIT
> 	qemu-vcpu -> kworker
> 	kworker -> qemu-vcpu
> 	qemu-vcpu VM-ENTRY
> 
> is much higher than the 7us (can be above 100us).

And nothing prevents this from happening:

 	oslat executing
 	qemu-vcpu VM-EXIT
 	qemu-vcpu -> kworker (in the host, to handle vmstat_update)
 	kworker -> qemu-vcpu
 	qemu-vcpu VM-ENTRY
	oslat -> kworker (in the guest, to handle vmstat_update)
	kworker -> oslat



