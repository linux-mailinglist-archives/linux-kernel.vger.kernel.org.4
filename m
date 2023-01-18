Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34866720EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjARPQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjARPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:15:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BC84B4A1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:11:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13D313F7EB;
        Wed, 18 Jan 2023 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674054690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5em31WnKESBz5bbIwil8S7FpkwJxR7V2RuP1871EUeM=;
        b=aF9K1WliNn4BIZToV16V+ba3KzF5Cqki5ggfos+Ds0GGqWRtWrc2TWJvCr+t4u5QSjF+tT
        NYSQH8TPifIG5Z/5Vf46G8ULId0cwKhvRvgkHOwRIQap5qPbY6j323xyeLVQw80xnUCL7D
        OT91RzX1l7C3rZVWK1eDiXtmf09Usz4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9619139D2;
        Wed, 18 Jan 2023 15:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /UgCNSEMyGMufQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 15:11:29 +0000
Date:   Wed, 18 Jan 2023 16:11:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
Message-ID: <Y8gMISwBLVNLhsAq@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-13-surenb@google.com>
 <CAG48ez0RhQ6=W01brLUXDXqQxz2M1FEMNqd2OvL+LhcJQY=NqA@mail.gmail.com>
 <Y8fl8lqS4QHZO1gV@dhcp22.suse.cz>
 <CAG48ez0dCo6KHPJrjAra=2Hm9aTm_3ERwCN3j64p3T82xNWScg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0dCo6KHPJrjAra=2Hm9aTm_3ERwCN3j64p3T82xNWScg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-01-23 14:23:32, Jann Horn wrote:
> On Wed, Jan 18, 2023 at 1:28 PM Michal Hocko <mhocko@suse.com> wrote:
> > On Tue 17-01-23 19:02:55, Jann Horn wrote:
> > > +locking maintainers
> > >
> > > On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > > > instead of mmap_lock. Because there are cases when multiple VMAs need
> > > > to be exclusively locked during VMA tree modifications, instead of the
> > > > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > > > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > > > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > > > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > > > locked.
> > > [...]
> > > > +static inline void vma_read_unlock(struct vm_area_struct *vma)
> > > > +{
> > > > +       up_read(&vma->lock);
> > > > +}
> > >
> > > One thing that might be gnarly here is that I think you might not be
> > > allowed to use up_read() to fully release ownership of an object -
> > > from what I remember, I think that up_read() (unlike something like
> > > spin_unlock()) can access the lock object after it's already been
> > > acquired by someone else.
> >
> > Yes, I think you are right. From a look into the code it seems that
> > the UAF is quite unlikely as there is a ton of work to be done between
> > vma_write_lock used to prepare vma for removal and actual removal.
> > That doesn't make it less of a problem though.
> >
> > > So if you want to protect against concurrent
> > > deletion, this might have to be something like:
> > >
> > > rcu_read_lock(); /* keeps vma alive */
> > > up_read(&vma->lock);
> > > rcu_read_unlock();
> > >
> > > But I'm not entirely sure about that, the locking folks might know better.
> >
> > I am not a locking expert but to me it looks like this should work
> > because the final cleanup would have to happen rcu_read_unlock.
> >
> > Thanks, I have completely missed this aspect of the locking when looking
> > into the code.
> >
> > Btw. looking at this again I have fully realized how hard it is actually
> > to see that vm_area_free is guaranteed to sync up with ongoing readers.
> > vma manipulation functions like __adjust_vma make my head spin. Would it
> > make more sense to have a rcu style synchronization point in
> > vm_area_free directly before call_rcu? This would add an overhead of
> > uncontended down_write of course.
> 
> Something along those lines might be a good idea, but I think that
> rather than synchronizing the removal, it should maybe be something
> that splats (and bails out?) if it detects pending readers. If we get
> to vm_area_free() on a VMA that has pending readers, we might already
> be in a lot of trouble because the concurrent readers might have been
> traversing page tables while we were tearing them down or fun stuff
> like that.
> 
> I think maybe Suren was already talking about something like that in
> another part of this patch series but I don't remember...

This http://lkml.kernel.org/r/20230109205336.3665937-27-surenb@google.com?

-- 
Michal Hocko
SUSE Labs
