Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3A675B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjATRdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjATRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:33:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67EADBDD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2jkEwjOPyig34Xw2pt9DR8sA0x9KlwAW9Pppxnavdp0=; b=lxP195rXKeUf+jhr9nRw80er1N
        J2dgNGuhipPvd8ZmycUNsS6QhSFMWnbTFSR4+UK0chqH19q9nDIYqbgFi1isgl6IOZbxS+cQLhQFA
        lDn+sRScuzzCEYM2VpxSY0QdAvGnqyh8pG1eRaL5X9lFokCtki2EDBh8XyTs17oz3udjhQBwDZNqA
        cwcCA6sczrDp6V3seeFnEO3RtVzrDIioI2+YMX3FBSgovFmakKFMkVIgIPoGNcELTSEuxk+iAXl0I
        nXTkkv437nvT4sQ8Q3So4N66udy9Ji6Oe0B5GknD8lCpl46KLKb/aWSQYfUJ96FeBaC7fIK5qdcvF
        XMM/6C2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIvFm-002GbQ-8r; Fri, 20 Jan 2023 17:32:38 +0000
Date:   Fri, 20 Jan 2023 17:32:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in
 vm_area_free
Message-ID: <Y8rQNj5dVyuxRBOf@casper.infradead.org>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz>
 <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz>
 <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
 <CAJuCfpF20nuP6Meib9h7NVrJv+wybYS==vZFQXxUW6n-ir9bvQ@mail.gmail.com>
 <Y8rGJq8LvX2C+Cr7@casper.infradead.org>
 <20230120170815.yuylbs27r6xcjpq5@revolver>
 <CAJuCfpH4o-iCmzdUcYD9bKieJ6-k-MZYLuHFhH+bN9yE07sibw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH4o-iCmzdUcYD9bKieJ6-k-MZYLuHFhH+bN9yE07sibw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:17:46AM -0800, Suren Baghdasaryan wrote:
> On Fri, Jan 20, 2023 at 9:08 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > * Matthew Wilcox <willy@infradead.org> [230120 11:50]:
> > > On Fri, Jan 20, 2023 at 08:45:21AM -0800, Suren Baghdasaryan wrote:
> > > > On Fri, Jan 20, 2023 at 8:20 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > On Fri, Jan 20, 2023 at 12:52 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Thu 19-01-23 10:52:03, Suren Baghdasaryan wrote:
> > > > > > > On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > >
> > > > > > > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > > > > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > > > > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > > > > > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > > > > > > > a list and free them in groups using one call_rcu() call per group.
> > > > > > > >
> > > > > > > > After some more clarification I can understand how call_rcu might not be
> > > > > > > > super happy about thousands of callbacks to be invoked and I do agree
> > > > > > > > that this is not really optimal.
> > > > > > > >
> > > > > > > > On the other hand I do not like this solution much either.
> > > > > > > > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > > > > > > > much with processes with a huge number of vmas either. It would still be
> > > > > > > > in housands of callbacks to be scheduled without a good reason.
> > > > > > > >
> > > > > > > > Instead, are there any other cases than remove_vma that need this
> > > > > > > > batching? We could easily just link all the vmas into linked list and
> > > > > > > > use a single call_rcu instead, no? This would both simplify the
> > > > > > > > implementation, remove the scaling issue as well and we do not have to
> > > > > > > > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> > > > > > >
> > > > > > > Yes, I agree the solution is not stellar. I wanted something simple
> > > > > > > but this is probably too simple. OTOH keeping all dead vm_area_structs
> > > > > > > on the list without hooking up a shrinker (additional complexity) does
> > > > > > > not sound too appealing either.
> > > > > >
> > > > > > I suspect you have missed my idea. I do not really want to keep the list
> > > > > > around or any shrinker. It is dead simple. Collect all vmas in
> > > > > > remove_vma and then call_rcu the whole list at once after the whole list
> > > > > > (be it from exit_mmap or remove_mt). See?
> > > > >
> > > > > Yes, I understood your idea but keeping dead objects until the process
> > > > > exits even when the system is low on memory (no shrinkers attached)
> > > > > seems too wasteful. If we do this I would advocate for attaching a
> > > > > shrinker.
> > > >
> > > > Maybe even simpler, since we are hit with this VMA freeing flood
> > > > during exit_mmap (when all VMAs are destroyed), we pass a hint to
> > > > vm_area_free to batch the destruction and all other cases call
> > > > call_rcu()? I don't think there will be other cases of VMA destruction
> > > > floods.
> > >
> > > ... or have two different call_rcu functions; one for munmap() and
> > > one for exit.  It'd be nice to use kmem_cache_free_bulk().
> >
> > Do we even need a call_rcu on exit?  At the point of freeing the VMAs we
> > have set the MMF_OOM_SKIP bit and unmapped the vmas under the read lock.
> > Once we have obtained the write lock again, I think it's safe to say we
> > can just go ahead and free the VMAs directly.
> 
> I think that would be still racy if the page fault handler found that
> VMA under read-RCU protection but did not lock it yet (no locks are
> held yet). If it's preempted, the VMA can be freed and destroyed from
> under it without RCU grace period.

The page fault handler (or whatever other reader -- ptrace, proc, etc)
should have a refcount on the mm_struct, so we can't be in this path
trying to free VMAs.  Right?
