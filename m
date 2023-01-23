Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786E96782C2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjAWRRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjAWRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:16:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91573302A2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:16:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3D803368D;
        Mon, 23 Jan 2023 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674494169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3QyA5tV4ij54OKFg/BSxirkicwOIIF6CWUxZDpWF10=;
        b=AtlDpGDrQS1l2ngKwtZOdy5knRnagGprgIgeJGZtYrGHv/G2od26NO/Jhh/7oIBqPIt+AA
        XefbkiDdmsnw/lJQV+n5YOC0LH4k7estyyE+NkwdWuEjSwEqN7BvYH1bKZmG+856FRNra+
        UPnPGPgvws6jda5Y10QPR9iVNdL1XGI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99BA61357F;
        Mon, 23 Jan 2023 17:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pqYEJdnAzmNEFQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 23 Jan 2023 17:16:09 +0000
Date:   Mon, 23 Jan 2023 18:16:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
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
Message-ID: <Y87A2CEKAugfgfHC@dhcp22.suse.cz>
References: <CAJuCfpF20nuP6Meib9h7NVrJv+wybYS==vZFQXxUW6n-ir9bvQ@mail.gmail.com>
 <Y8rGJq8LvX2C+Cr7@casper.infradead.org>
 <20230120170815.yuylbs27r6xcjpq5@revolver>
 <CAJuCfpH4o-iCmzdUcYD9bKieJ6-k-MZYLuHFhH+bN9yE07sibw@mail.gmail.com>
 <Y8rQNj5dVyuxRBOf@casper.infradead.org>
 <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz>
 <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
 <Y868Fadajv27QMXh@dhcp22.suse.cz>
 <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-01-23 09:07:34, Suren Baghdasaryan wrote:
> On Mon, Jan 23, 2023 at 8:55 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 23-01-23 08:22:53, Suren Baghdasaryan wrote:
> > > On Mon, Jan 23, 2023 at 1:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 20-01-23 09:50:01, Suren Baghdasaryan wrote:
> > > > > On Fri, Jan 20, 2023 at 9:32 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > [...]
> > > > > > The page fault handler (or whatever other reader -- ptrace, proc, etc)
> > > > > > should have a refcount on the mm_struct, so we can't be in this path
> > > > > > trying to free VMAs.  Right?
> > > > >
> > > > > Hmm. That sounds right. I checked process_mrelease() as well, which
> > > > > operated on mm with only mmgrab()+mmap_read_lock() but it only unmaps
> > > > > VMAs without freeing them, so we are still good. Michal, do you agree
> > > > > this is ok?
> > > >
> > > > Don't we need RCU procetions for the vma life time assurance? Jann has
> > > > already shown how rwsem is not safe wrt to unlock and free without RCU.
> > >
> > > Jann's case requires a thread freeing the VMA to be blocked on vma
> > > write lock waiting for the vma real lock to be released by a page
> > > fault handler. However exit_mmap() means mm->mm_users==0, which in
> > > turn suggests that there are no racing page fault handlers and no new
> > > page fault handlers will appear. Is that a correct assumption? If so,
> > > then races with page fault handlers can't happen while in exit_mmap().
> > > Any other path (other than page fault handlers), accesses vma->lock
> > > under protection of mmap_lock (for read or write, does not matter).
> > > One exception is when we operate on an isolated VMA, then we don't
> > > need mmap_lock protection, but exit_mmap() does not deal with isolated
> > > VMAs, so out of scope here. exit_mmap() frees vm_area_structs under
> > > protection of mmap_lock in write mode, so races with anything other
> > > than page fault handler should be safe as they are today.
> >
> > I do not see you talking about #PF (RCU + vma read lock protected) with
> > munmap. It is my understanding that the latter will synchronize over per
> > vma lock (along with mmap_lock exclusive locking). But then we are back
> > to the lifetime guarantees, or do I miss anything.
> 
> munmap() or any VMA-freeing operation other than exit_mmap() will free
> using call_rcu(), as implemented today. The suggestion is to free VMAs
> directly, without RCU grace period only when done from exit_mmap().

OK, I have clearly missed that. This makes more sense but it also adds
some more complexity and assumptions - a harder to maintain code in the
end. Whoever wants to touch this scheme in future would have to
re-evaluate all of them. So, I would just avoid that special casing if
that is feasible.

Dealing with the flood of call_rcu during exit_mmap is a trivial thing
to deal with as proposed elsewhere (just batch all of them in a single
run). This will surely add some more code but at least the locking would
consistent.
-- 
Michal Hocko
SUSE Labs
