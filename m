Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A936F03A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbjD0Js4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243343AbjD0Jsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:48:53 -0400
Received: from outbound-smtp43.blacknight.com (outbound-smtp43.blacknight.com [46.22.139.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019C92
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:48:51 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp43.blacknight.com (Postfix) with ESMTPS id B4F1E232A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:48:49 +0100 (IST)
Received: (qmail 6189 invoked from network); 27 Apr 2023 09:48:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Apr 2023 09:48:49 -0000
Date:   Thu, 27 Apr 2023 10:48:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
Message-ID: <20230427094847.fmj4ju4spwkawtez@techsingularity.net>
References: <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com>
 <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com>
 <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
 <20230426100918.ku32k6mqoogsnijn@techsingularity.net>
 <ZEk/uVlbX2wWgagN@casper.infradead.org>
 <CAD=FV=UyLf9GLz7xJyzhW2V_JycwUppwGfe7th17f_KXmMGOqw@mail.gmail.com>
 <ZEmXH1FpOgT/u6/j@casper.infradead.org>
 <CAD=FV=Xkg6XgSL0VVVUMm+8xQ65oDgKoTgG0qHY7ALBE3xhCmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xkg6XgSL0VVVUMm+8xQ65oDgKoTgG0qHY7ALBE3xhCmg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 02:39:56PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Apr 26, 2023 at 2:27???PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Apr 26, 2023 at 01:46:58PM -0700, Doug Anderson wrote:
> > > On Wed, Apr 26, 2023 at 8:14???AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > I'm not generally a fan of lock-with-timeout approaches.  I think the
> > > > rationale for this one makes sense, but we're going to see some people
> > > > try to use this for situations where it doesn't make sense.
> > >
> > > Although it won't completely prevent the issue, I could add a comment
> >
> > People don't read comments.
> 
> Agreed, it's just better than nothing...
> 

It also acts as something to point to if an ill-advised use of
trylock_timeout was used.

> 
> > > > Hm.  If the problem is that we want to wait for the lock unless the
> > > > lock is being held for I/O, we can actually tell that in the caller.
> > > >
> > > >         if (folio_test_uptodate(folio))
> > > >                 folio_lock(folio);
> > > >         else
> > > >                 folio_trylock(folio);
> > > >
> > > > (the folio lock isn't held for writeback, just taken and released;
> > > > if the folio is uptodate, the folio lock should only be taken for a
> > > > short time; if it's !uptodate then it's probably being read)
> > >
> > > The current place in patch #3 where I'm using folio_lock_timeout()
> > > only calls it if a folio_trylock() already failed [2]. So I guess the
> > > idea would be that if the trylock failed and folio_test_uptodate()
> > > returns 0 then we immediately fail, otherwise we call the unbounded
> > > folio_trylock()?
> >
> > Looking at the actual code, here's what I'd do:
> >
> > +++ b/mm/migrate.c
> > @@ -1156,6 +1156,14 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
> >                 if (current->flags & PF_MEMALLOC)
> >                         goto out;
> >
> > +               /*
> > +                * In "light" mode, we can wait for transient locks (eg
> > +                * inserting a page into the page table), but it's not
> > +                * worth waiting for I/O.
> > +                */
> > +               if (mode == MIGRATE_SYNC_LIGHT && !folio_test_uptodate(folio))
> > +                       goto out;
> > +
> >                 folio_lock(src);
> >         }
> >         locked = true;
> >
> > > I put some traces in and ran my test and it turns out that in every
> > > case (except one) where the tre initial folio_trylock() failed I saw
> > > folio_test_uptodate() return 0. Assuming my test case is typical, I
> > > think that means that coding it with folio_test_uptodate() is roughly
> > > the same as just never waiting at all for the folio lock in the
> > > SYNC_LIGHT case. In the original discussion of my v1 patch people
> > > didn't like that idea. ...so I think that for now I'm going to keep it
> > > with the timeout flow.
> >
> > I think that means that your specific test is generally going to
> > exercise the case where the lock is held because we're waiting for I/O.
> > That's exactly what you set it up to produce, after all!  But it won't
> > affect the cases where the folio lock is being held for other reasons,
> > which your testcase is incredibly unlikely to produce.
> 
> Sure, I'm happy to do it like you say. Do you have any suggestions for
> the similar lock_buffer() case, or are you OK w/ the timeout there?
> 
> Mel: do you have any comments? In your previous response [1] you
> seemed to indicate that you thought that short waits for read were a
> good idea.
> 

I have no objection and it's worth trying the patch against your test
case although note that short-lived locks may still be skipped (but that's
ok). Either kcompactd still waits for minutes on folio lock or it does not.
The potential downside is that kcompactd skips candidates that it shouldn't
have which will manifest as a drop in compaction efficiency that will be
difficult to detect. With Johannes' compaction series in the mix though,
it's more likely we'll notice a drop in efficiency in the short term.

I prefer the uptodate check a lot more than "spin rather than sleep on this
lock". Spinning is surprisingly difficult to get right (see all the changes
and subsequent fixes that went into mutexes or the changes in "polling
on the way to idle" logic in cpuidle), it also occupies CPU time when a
system is already under stress and it's not a great fit for this specific
case. The timeout is currently specified in ticks and ticking for 1-4ms on
common kernel configs is a *long* time from a scheduler perspective even
if it's a non-issue for MM which sometimes deals with time frames suitable
for slow storage. It's even worse if there is no preemption point and even
if there was, it hits potential hazards with CFS dealing with the fairness
of a useless spinning task vs tasks trying to do real work.  Of course
the spin time could be based on cond_resched or a timeout in nanoseconds
but cond_resched is a random timeout and picking a specific timeout is
difficult and will attract negative attention eventually. My MM hat says
"ah, it'll be fine" and my scheduler hat says "uhhh, don't do that".

Matthew's suggestion on checking uptodate is a good one. If he's right,
the problem goes away. If the problem still persists, I am willing to bet
that it's mitigated a lot *and* it becomes interesting to find out why a
!uptodate page could take a very long time to lock because it's possibly
revealing another real bug. If the idea does not work at all, the timeout
patch still exists, add to the changelog why checking uptodate doesn't
work and Linus spelled out clearly why it should be ok in this specific
case even if we have to watch out for bad users of the new interface.

-- 
Mel Gorman
SUSE Labs
