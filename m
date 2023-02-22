Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAE69FB76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBVSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBVSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D041B43
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677091560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eduuzSnrAu5kVmtbI7dBj0Z029emQG/MM+x0iQ4aOiY=;
        b=HSZHczq4bKX2nu0Djcj+rQZ8KqSttpRb1POXblOKND/qX3WLbrkO7U3fSjkAhp+hP/DUdF
        TwZcQFS877oJEOefMtiuq7f6wgzzFgdIEPWLxY6xpc6lZsnhvWQNWzFQWmwXUG3lvKmGs0
        fA1qNXwg3AyMxUmTbUgn2hVmeDTgT4s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-eBgiWNJwM7SSs_bILo0DMA-1; Wed, 22 Feb 2023 13:42:46 -0500
X-MC-Unique: eBgiWNJwM7SSs_bILo0DMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24FEB857A93;
        Wed, 22 Feb 2023 18:42:45 +0000 (UTC)
Received: from fedora (unknown [10.22.8.233])
        by smtp.corp.redhat.com (Postfix) with SMTP id 522634024CA1;
        Wed, 22 Feb 2023 18:42:38 +0000 (UTC)
Date:   Wed, 22 Feb 2023 15:42:37 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/4] sched/task: Add the put_task_struct_atomic_safe
 function
Message-ID: <20230222184237.hkfznxm3ts3gye2i@fedora>
References: <20230120150246.20797-1-wander@redhat.com>
 <20230120150246.20797-2-wander@redhat.com>
 <20230123163002.GB6268@redhat.com>
 <CAAq0SUk1vfNDuzGbXNftgW4wq4PC_EzMhpq4E=RBQNkOB3f4YQ@mail.gmail.com>
 <xhsmhbkmkdla4.mognet@vschneid.remote.csb>
 <CAAq0SUnUH6DEjwEs2RxRCtkTU121JXpdsV_rZky1d0Bo04=fiQ@mail.gmail.com>
 <8632d9c6-7ec7-c3aa-f9e7-fa63cc82f6ae@redhat.com>
 <20230217200437.551ad7c2@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217200437.551ad7c2@nowhere>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 08:04:37PM +0100, luca abeni wrote:
> Hi all,
> 
> On Fri, 17 Feb 2023 14:35:22 -0300
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
> > On 1/30/23 08:49, Wander Lairson Costa wrote:
> > >> Another thing, if you look at release_task_stack(), it either
> > >> caches the outgoing stack for later use, or frees it via RCU
> > >> (regardless of PREEMPT_RT). Perhaps we could follow that and just
> > >> always punt the freeing of the task struct to RCU?
> > >>  
> > > That's a point. Do you mean doing that even for !PREEMPT_RT?
> > >   
> > 
> > It seems that Luca Abeni (in Cc) is hitting the bug in the non-rt
> > kernel with SCHED_DEADLINE...
> > 
> > adding him to the thread.
> 
> Thanks Daniel for adding me.
> 
> I triggered this "BUG: Invalid wait context" with a 5.15.76 kernel,
> without PREEMPT_RT. I can reproduce it easily on a KVM-based VM; if
> more information or tests are needed, let me know.
> 

Does it happen in linux-6.1 or linux-6.2?

> 
> 			Luca
> 

