Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E450766616E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjAKRKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbjAKRJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A005B868
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673456902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IducYfddzH6lMplxq5YrX0OgBDUYvrG6JVse4EUppbE=;
        b=Ayzxx8Dpw4lk2haLG4gg3SYoVuwF3hLWexFsYjLpwV3H+IUsWJkK41QQzkSOtQkzdtbHNz
        21Q48iAGptpkO3704kt4iThT1uoctT173EDBBE6V4az8AdUKGYzjT2EsC22vi2rj9KC6OA
        IZDOLNtU5V/V9GwKme+TQNz46MN4Fvs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-h6Akq_tMN7yf2EHiQ2PiFw-1; Wed, 11 Jan 2023 12:08:06 -0500
X-MC-Unique: h6Akq_tMN7yf2EHiQ2PiFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E6463C4220B;
        Wed, 11 Jan 2023 17:08:05 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 100EBC0328F;
        Wed, 11 Jan 2023 17:08:05 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 8E81E401A035B; Wed, 11 Jan 2023 14:07:47 -0300 (-03)
Date:   Wed, 11 Jan 2023 14:07:47 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>, atomlin@atomlin.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v13 2/6] mm/vmstat: Use vmstat_dirty to track
 CPU-specific vmstat discrepancies
Message-ID: <Y77s4x5yC4O1OxTQ@tpad>
References: <20230105125218.031928326@redhat.com>
 <20230105125248.813825852@redhat.com>
 <b89a9828-d4e-9874-d482-dbb6cbe46@gentwo.de>
 <Y71XpnJGumySL9ej@lothringen>
 <7c2af941-42a9-a59b-6a20-b331a4934a3@gentwo.de>
 <Y73F4tbfxT6Kb9kZ@tpad>
 <60183179-3a28-6bf9-a6ab-8a8976f283d@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60183179-3a28-6bf9-a6ab-8a8976f283d@gentwo.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:42:18AM +0100, Christoph Lameter wrote:
> On Tue, 10 Jan 2023, Marcelo Tosatti wrote:
> 
> > > The basic primitives add a  lot of weight.
> >
> > Can't see any alternative given the necessity to avoid interruption
> > by the work to sync per-CPU vmstats to global vmstats.
> 
> this_cpu operations are designed to operate on a *single* value (a counter) and can
> be run on an arbitrary cpu, There is no preemption or interrupt
> disable required since the counters of all cpus will be added up at the
> end.
> 
> You want *two* values (the counter and the dirty flag) to be modified
> together and want to use the counters/flag to identify the cpu where
> these events occurred. this_cpu_xxx operations are not suitable for that
> purpose. You would need a way to ensure that both operations occur on the
> same cpu.

Which is either preempt_disable (CONFIG_HAVE_CMPXCHG_LOCAL case), or 
local_irq_disable (!CONFIG_HAVE_CMPXCHG_LOCAL case).

> > > > And the pre cpu atomic updates operations require the modification
> > > of multiple values. The operation
> > > cannot be "atomic" in that sense anymore and we need some other form of
> > > synchronization that can
> > > span multiple instructions.
> >
> >     So use this_cpu_cmpxchg() to avoid the overhead. Since we can no longer
> >     count on preremption being disabled we still have some minor issues.
> >     The fetching of the counter thresholds is racy.
> >     A threshold from another cpu may be applied if we happen to be
> >     rescheduled on another cpu.  However, the following vmstat operation
> >     will then bring the counter again under the threshold limit.
> >
> > Those small issues are gone, OTOH.
> 
> Well you could use this_cpu_cmpxchg128 to update a 64 bit counter and a
> flag at the same time. 

But then you transform the "per-CPU vmstat is dirty" bit (bool) into a 
number of flags that must be scanned (when returning to userspace).

Which increases the overhead of a fast path (return to userspace).

> Otherwise you will have to switch off preemption or
> interrupts when incrementing the counters and updating the dirty flag.
> 
> Thus you do not really need the this_cpu operations anymore. It would
> best to use a preempt_disable section and uuse C operators -- ++ for the
> counter and do regular assignment for the flag.

OK, can replace this_cpu operations with this_cpu_ptr + standard C operators 
(and in fact can do that for interrupt disabled functions as well, that
is CONFIG_HAVE_CMPXCHG_LOCAL not defined).

Is that it?

