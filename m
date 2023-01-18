Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4085867194D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjARKls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjARKjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:39:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC53666FBA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:43:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 858B02107A;
        Wed, 18 Jan 2023 09:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674035001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwj2L+9GHMXRMvC0PXKAy4Vi7OOq14XSvOdqanVYA8Y=;
        b=oQppwSHRZn9nA7psyaLGFQs/n7yu4DC1JHVfljgHkXtLq+DOkvXYVpC0pxpoUjYBm0HTcS
        BkONlwtTDH8AHIFUQOLXiSJJ2S7HX+NBVrdprdVQ79j6ABRRpBWxtQ58jldQ8maq5weOoW
        FQcHNE9i90gdNQSHN34UWvlnl2fB3Is=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5923C139D2;
        Wed, 18 Jan 2023 09:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eEGoFDm/x2OYPwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 09:43:21 +0000
Date:   Wed, 18 Jan 2023 10:43:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 26/41] kernel/fork: assert no VMA readers during its
 destruction
Message-ID: <Y8e/N1m+YGFmxy+L@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-27-surenb@google.com>
 <Y8bB3TFLQV2HJZQ+@dhcp22.suse.cz>
 <CAJuCfpH8-wNiPXQcS=0j-Ex7iMqoBkUhjSN8QiAvq6FdXudRGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH8-wNiPXQcS=0j-Ex7iMqoBkUhjSN8QiAvq6FdXudRGQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-01-23 17:53:00, Suren Baghdasaryan wrote:
> On Tue, Jan 17, 2023 at 7:42 AM 'Michal Hocko' via kernel-team
> <kernel-team@android.com> wrote:
> >
> > On Mon 09-01-23 12:53:21, Suren Baghdasaryan wrote:
> > > Assert there are no holders of VMA lock for reading when it is about to be
> > > destroyed.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  include/linux/mm.h | 8 ++++++++
> > >  kernel/fork.c      | 2 ++
> > >  2 files changed, 10 insertions(+)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 594e835bad9c..c464fc8a514c 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -680,6 +680,13 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> > >       VM_BUG_ON_VMA(vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq), vma);
> > >  }
> > >
> > > +static inline void vma_assert_no_reader(struct vm_area_struct *vma)
> > > +{
> > > +     VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock) &&
> > > +                   vma->vm_lock_seq != READ_ONCE(vma->vm_mm->mm_lock_seq),
> > > +                   vma);
> >
> > Do we really need to check for vm_lock_seq? rwsem_is_locked should tell
> > us something is wrong on its own, no? This could be somebody racing with
> > the vma destruction and using the write lock. Unlikely but I do not see
> > why to narrow debugging scope.
> 
> I wanted to ensure there are no page fault handlers (read-lockers)
> when we are destroying the VMA and rwsem_is_locked(&vma->lock) alone
> could trigger if someone is concurrently calling vma_write_lock(). But
> I don't think we expect someone to be write-locking the VMA while we

That would be UAF, no?

> are destroying it, so you are right, I'm overcomplicating things here.
> I think I can get rid of vma_assert_no_reader() and add
> VM_BUG_ON_VMA(rwsem_is_locked(&vma->lock)) directly in
> __vm_area_free(). WDYT?

Yes, that adds some debugging. Not sure it is really necessary buyt it
is VM_BUG_ON so why not.
-- 
Michal Hocko
SUSE Labs
