Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A76EF1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbjDZKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbjDZKJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:09:25 -0400
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CC03C39
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:09:22 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 145C822D7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:09:21 +0100 (IST)
Received: (qmail 9114 invoked from network); 26 Apr 2023 10:09:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Apr 2023 10:09:20 -0000
Date:   Wed, 26 Apr 2023 11:09:18 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
Message-ID: <20230426100918.ku32k6mqoogsnijn@techsingularity.net>
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230422051858.1696-1-hdanton@sina.com>
 <CAD=FV=XAJnWL8YHok8RcgR8aK5igKfvE2iD7aW7Rpr4cDVJedQ@mail.gmail.com>
 <20230425010917.1984-1-hdanton@sina.com>
 <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAD=FV=XWuQoaGZG_Tm8AqGAsqGSAa822bNw3Dp2QnmR40npURw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 07:19:48AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Apr 24, 2023 at 6:09???PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > On 24 Apr 2023 09:56:58 -0700 Douglas Anderson <dianders@chromium.org>
> > > On Fri, Apr 21, 2023 at 10:19=E2=80=AFPM Hillf Danton <hdanton@sina.com> wrote:
> > > > If kcompactd is waken
> > > > up by kswapd, waiting for slow IO is the right thing to do.
> > >
> > > I don't have enough intuition here, so I'm happy to take others'
> > > advice here. I guess my thought was that kcompactd is explicitly not
> > > using the full "sync" and instead choosing the "sync light". To me
> > > that means we shouldn't block for _too_ long.
> >
> > Take a look at another case of lock wait [1].
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com/
> 
> So is this an explicit NAK on this approach, then? It still feels
> worthwhile to me given the current kcompactd design where there is a
> single thread that's in charge of going through and cleaning up all of
> memory. Any single pags isn't _that_ important for kcompactd to deal
> with and it's nice not to block the whole task's ability to make
> progress. kcompactd is already very much designed in this model (which
> is why SYNC_LIGHT exists in the first place) and that's why my patch
> series was relatively simple/short. That being said, if people really
> don't think I should pursue this then I won't send another version and
> we can drop it.

I don't consider it to be an explicit NAK but lets
cc Linus because it's a valid question. Linus, the patch is
https://lore.kernel.org/lkml/20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid/
asnd it's adding folio_lock_timeout which in older terms is a
lock_page_timout. The intended use is kcompactd doing out-of-line
compaction (like kswapd does out-of-line reclaim) to try lock a page in
MIGRATE_SYNC_LIGHT mode but if it cannot be locked quickly then give up
and move on to another migration candidate. The MIGRATE_SYNC_LIGHT is
expected to incur some delays while trying to make forward progress and
the overall problem is that kcompactd can sometimes stall for many seconds
and sometimes minutes on one page.

The reason I don't consider this patch a NAK candidate is that this is not
conditional locking as such because no special action is taken if the lock
cannot be acquired. In the referenced mail, I think the context for the IO
NOWAIT stuff is "try lock and if that fails, delegate the work to an async
context". That is not necessarily a universal win and it's potentially
complex. It's not a universal win because it's unknown how long it would
take to acquire the lock and it may be a short enough period to be cheaper
than the setup_for_async+context_switch+completion handler. If that happens
often enough in a short window then delegation may be slower overall than
doing the work synchronously. It's potentially complex because the setup
for async handling and completion needs code that must be maintained.

The kcompactd case using folio_lock_timeout is different. If the lock
fails, it's not being explicitly delegated to another context, the page
is simply ignored and kcompactd moves on. Fair enough, another context
may end up migrating the same page in direct compaction or kcompactd
at a later time but there is no complex setup for that and it's not
explicit delegation. It's vaguely similar to how shrink_folio_list()
calls folio_trylock and if that fails, keep the page on the LRU for a
future attempt with the main difference being that some time is spent on
trylock. This is *also* not necessarily a universal win because kcompactd
could find a suitable migration candidate quicker by a plain trylock but
that's what MIGRATE_ASYNC is for, MIGRATE_SYNC_LIGHT is expected to delay
for short periods of time when MIGRATE_ASYNC fails and the problem being
solved is the folio lock taking minutes to acquire.

-- 
Mel Gorman
SUSE Labs
