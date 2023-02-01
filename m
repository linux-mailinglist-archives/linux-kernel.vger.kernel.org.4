Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262406786F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjAWUAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjAWUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:00:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD023311
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:00:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 272B9218F2;
        Mon, 23 Jan 2023 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674504024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9umLbK138jo14qJ7E8MIOxomDS0h8eCmJZ+29QkDcwY=;
        b=tQ2EbAB5Pd9IPcZYKmKts4B7J9zBmGbFLnwbQQcjVLR9/1l2Nv5AqZ8GvPV0PD1fIOGfKy
        xp3I2aoV4vH56nWiCeF20k9hV8vuvOqVOb8DbURfrSSv5EeFT3E0K+tsowMHdS8b+xmH+Z
        mpFeUtCeqYd1GQVKlV65hKfD5gOl90E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F08A51357F;
        Mon, 23 Jan 2023 20:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 47MxOlfnzmN/aAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 23 Jan 2023 20:00:23 +0000
Date:   Mon, 23 Jan 2023 21:00:23 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
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
Message-ID: <Y87nVydD7oF9BGMb@dhcp22.suse.cz>
References: <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz>
 <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
 <Y868Fadajv27QMXh@dhcp22.suse.cz>
 <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
 <Y87A2CEKAugfgfHC@dhcp22.suse.cz>
 <CAJuCfpGJRZATfc8eUurvV5kGkSNkG=vK=sfwJbU72PESOyATSw@mail.gmail.com>
 <Y87QjHH2aDG5XCGv@casper.infradead.org>
 <Y87djZwQpXazRd00@dhcp22.suse.cz>
 <Y87gY7fhi5OJ35WQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87gY7fhi5OJ35WQ@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-01-23 19:30:43, Matthew Wilcox wrote:
> On Mon, Jan 23, 2023 at 08:18:37PM +0100, Michal Hocko wrote:
> > On Mon 23-01-23 18:23:08, Matthew Wilcox wrote:
> > > On Mon, Jan 23, 2023 at 09:46:20AM -0800, Suren Baghdasaryan wrote:
> > [...]
> > > > Yes, batching the vmas into a list and draining it in remove_mt() and
> > > > exit_mmap() as you suggested makes sense to me and is quite simple.
> > > > Let's do that if nobody has objections.
> > > 
> > > I object.  We *know* nobody has a reference to any of the VMAs because
> > > you have to have a refcount on the mm before you can get a reference
> > > to a VMA.  If Michal is saying that somebody could do:
> > > 
> > > 	mmget(mm);
> > > 	vma = find_vma(mm);
> > > 	lock_vma(vma);
> > > 	mmput(mm);
> > > 	vma->a = b;
> > > 	unlock_vma(mm, vma);
> > > 
> > > then that's something we'd catch in review -- you obviously can't use
> > > the mm after you've dropped your reference to it.
> > 
> > I am not claiming this is possible now. I do not think we want to have
> > something like that in the future either but that is really hard to
> > envision. I am claiming that it is subtle and potentially error prone to
> > have two different ways of mass vma freeing wrt. locking. Also, don't we
> > have a very similar situation during last munmaps?
> 
> We shouldn't have two ways of mass VMA freeing.  Nobody's suggesting that.
> There are two cases; there's munmap(), which typically frees a single
> VMA (yes, theoretically, you can free hundreds of VMAs with a single
> call which spans multiple VMAs, but in practice that doesn't happen),
> and there's exit_mmap() which happens on exec() and exit().

This requires special casing remove_vma for those two different paths
(exit_mmap and remove_mt).  If you ask me that sounds like a suboptimal
code to even not handle potential large munmap which might very well be
a rare thing as you say. But haven't we learned that sooner or later we
will find out there is somebody that cares afterall? Anyway, this is not
something I care about all that much. It is just weird to special case
exit_mmap, if you ask me. Up to Suren to decide which way he wants to
go. I just really didn't like the initial implementation of batching
based on a completely arbitrary batch limit and lazy freeing.
-- 
Michal Hocko
SUSE Labs
