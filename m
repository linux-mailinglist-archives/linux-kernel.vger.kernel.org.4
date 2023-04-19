Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623746E7C28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjDSORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjDSORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D717CC6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681913784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qY/7Ww3ksokf5xA87dySpBXMx7ItXCgllwSeJ2NZDd0=;
        b=SFZmYL/TMDQl6Z/gbUXz6nGcr1Kxh05KYQg4MGHJ/hwUlfPSYV0T7mBs4Sr+gMBe7tSFZL
        472Qk6W2il9scoiq3vzxEnj/M2dFX9JpDmT1V9aca9ljjgMAS7W7SyCof421yrUHQLBYkB
        zX9SwTtQShnNGZhc8duRNaQUMvInUtw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-RUOePQYSOJeqyFrH69TAtQ-1; Wed, 19 Apr 2023 10:16:22 -0400
X-MC-Unique: RUOePQYSOJeqyFrH69TAtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA4DF1C0A594;
        Wed, 19 Apr 2023 14:16:21 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C98A1121314;
        Wed, 19 Apr 2023 14:16:21 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id DA248400DED28; Wed, 19 Apr 2023 10:48:03 -0300 (-03)
Date:   Wed, 19 Apr 2023 10:48:03 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZD/xE6kR4RSOvUlR@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 02:24:01PM +0200, Frederic Weisbecker wrote:
> Le Wed, Apr 19, 2023 at 08:59:28AM -0300, Marcelo Tosatti a écrit :
> > On Wed, Apr 19, 2023 at 08:29:47AM -0300, Marcelo Tosatti wrote:
> > > On Wed, Apr 19, 2023 at 08:14:09AM -0300, Marcelo Tosatti wrote:
> > > > This was tried before:
> > > > https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/
> > > > 
> > > > My conclusion from that discussion (and work) is that a special system
> > > > call:
> > > > 
> > > > 1) Does not allow the benefits to be widely applied (only modified
> > > > applications will benefit). Is not portable across different operating systems. 
> > > > 
> > > > Removing the vmstat_work interruption is a benefit for HPC workloads, 
> > > > for example (in fact, it is a benefit for any kind of application, 
> > > > since the interruption causes cache misses).
> > > > 
> > > > 2) Increases the system call cost for applications which would use
> > > > the interface.
> > > > 
> > > > So avoiding the vmstat_update update interruption, without userspace 
> > > > knowledge and modifications, is a better than solution than a modified
> > > > userspace.
> > > 
> > > Another important point is this: if an application dirties
> > > its own per-CPU vmstat cache, while performing a system call,
> > 
> > Or while handling a VM-exit from a vCPU.
> > 
> > This are, in my mind, sufficient reasons to discard the "flush per-cpu
> > caches" idea. This is also why i chose to abandon the prctrl interface
> > patchset.
> 
> If you're running your isolated workloads on guests, which sounds quite
> challenging but I guess you guys managed, I'd expect that VMEXITs are
> absolutely out of question while the task runs critical code, so I'm not
> sure why you would care. I guess not only your guests but also your hosts
> run nohz_full, right?

The answer is: there are VM-exits. For example to write MSRs to program
LAPIC timer.

Yes both host and guest are nohz_full (but for example, cyclictest 
or a PLC program can call nanosleep in the guest which translate to 
MSR writes to program LAPIC timer which is a VM-exit).

> I can't tell if the prctl solution which quiesces everything is the solution
> for you, I don't know well enough your workloads, but I would expect that
> the pattern is as follows:
> 
> 1) Arrange for full isolation (no more interrupts/exceptions/VMEXITs)

Yes, this in the general scheme. Full isolation is automated by
tuned (realtime-virtual-host/realtime-virtual-guest profiles).

There are VM-exits in our use-case.
There might be use-cases where interrupts are desired.

For more details:
https://www.youtube.com/watch?v=SyhfctYqjc8

> 2) Run critical code
> 3) Optionally do something once you're done
> 
> If vmstat is going to be the only thing to wait for on 1), then the remote
> solution looks good enough (although I leave that to -mm guys as I'm too
> clueless about those matters), 

I am mostly clueless too, but i don't see a problem with the proposed
patch (and no one has pointed any problem either).

> if there is more to be expected, I guess the
> quiescing prctl (or whatever syscall) is something to consider.
> 
> Thanks.

I don't know of anything else to consider ATM, and for all cases we have
analyzed so far there has always been the possibility to do the work remotely,
via RCU or some other locking scheme, rather than requiring the application
to be modified (which decreases the number of userspace applications that
can benefit).




