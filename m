Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396D96458B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLGLOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLGLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:13:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFAABE20
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:12:45 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B37C1FD92;
        Wed,  7 Dec 2022 11:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670411564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2B7N6L1xZkCiPp+FI0HS2JcHcGZloPrSJs+7ZuAmjw=;
        b=bqVezed1DPMiJVorXj0Yp3CeDYlY0sb3SIZYt5VP009KwUwiXKMDur3XxjLX6DSkz7GbEW
        N6I6VuH5/3VdfhGgQocTJAPKMd20zrJdAaIrus3tcGGgyS8eMpwut7zNWyrBmpkOik8OV7
        AA8PEoQVR7EiHuS7Rtg3Pst63ZR4vAk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7D81E134CD;
        Wed,  7 Dec 2022 11:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 36TsGyx1kGOQJAAAGKfGzw
        (envelope-from <mhocko@suse.com>); Wed, 07 Dec 2022 11:12:44 +0000
Date:   Wed, 7 Dec 2022 12:12:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered
 systems
Message-ID: <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz>
References: <20221206023406.3182800-1-almasrymina@google.com>
 <Y48zlaimOb/wr8qd@dhcp22.suse.cz>
 <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
 <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz>
 <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-12-22 17:55:58, Mina Almasry wrote:
> On Tue, Dec 6, 2022 at 11:55 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 06-12-22 08:06:51, Mina Almasry wrote:
> > > On Tue, Dec 6, 2022 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 05-12-22 18:34:05, Mina Almasry wrote:
> > > > > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > > > reclaim"") enabled demotion in memcg reclaim, which is the right thing
> > > > > to do, however, it introduced a regression in the behavior of
> > > > > try_to_free_mem_cgroup_pages().
> > > > >
> > > > > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> > > > > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> > > > > of the cgroup should reduce by nr_pages. The callers expect
> > > > > try_to_free_mem_cgroup_pages() to also return the number of pages
> > > > > reclaimed, not demoted.
> > > > >
> > > > > However, what try_to_free_mem_cgroup_pages() actually does is it
> > > > > unconditionally counts demoted pages as reclaimed pages. So in practice
> > > > > when it is called it will often demote nr_pages and return the number of
> > > > > demoted pages to the caller. Demoted pages don't lower the memcg usage,
> > > > > and so try_to_free_mem_cgroup_pages() is not actually doing what the
> > > > > callers want it to do.
> > > > >
> > > > > Various things work suboptimally on memory tiered systems or don't work
> > > > > at all due to this:
> > > > >
> > > > > - memory.high enforcement likely doesn't work (it just demotes nr_pages
> > > > >   instead of lowering the memcg usage by nr_pages).
> > > > > - try_charge_memcg() will keep retrying the charge while
> > > > >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
> > > > >   making any room for the charge.
> > > >
> > > > This has been brought up during the review https://lore.kernel.org/all/YoYTEDD+c4GT0xYY@dhcp22.suse.cz/
> > > >
> > >
> > > Ah, I did indeed miss this. Thanks for the pointer. However I don't
> > > understand this bit from your email (sorry I'm probably missing
> > > something):
> > >
> > > "I suspect this is rather unlikely situation, though. The last tear
> > > (without any fallback) should have some memory to reclaim most of
> > > the time."
> > >
> > > Reading the code in try_charge_memcg(), I don't see the last retry for
> > > try_to_free_mem_cgroup_pages() do anything special. My concern here is
> > > that try_charge_memcg() calls try_to_free_mem_cgroup_pages()
> > > MAX_RECLAIM_RETRIES times. Each time that call may demote pages and
> > > report back that it was able to 'reclaim' memory, but the charge keeps
> > > failing because the memcg reclaim didn't actually make room for the
> > > charge. What happens in this case? My understanding is that the memcg
> > > oom-killer gets wrongly invoked.
> >
> > The memcg reclaim shrinks from all zones in the allowed zonelist. In
> > general from all nodes. So unless the lower tier is outside of this
> > zonelist then there is a zone to reclaim from which cannot demote.
> > Correct?
> >
> 
> Ah, thanks for pointing this out. I did indeed miss that the memcg
> reclaim tries to apply pressure equally to all the nodes. With some
> additional testing I'm able to see what you said: there could be no
> premature oom kill invocation because generally the memcg reclaim will
> find some pages to reclaim from lower tier nodes.
> 
> I do find that the first call to try_to_free_mem_cgroup_pages()
> sometimes will mostly demote and not do much reclaim. I haven't been
> able to fully track the cause of that down but I suspect that the
> first call in my test will find most of the cgroup's memory on top
> tier nodes. However we do retry a bunch of times before we invoke oom,
> and in my testing subsequent calls will find plenty of memory in the
> lower tier nodes that it can reclaim. I'll update the commit message
> in the next version.

In the past we used to break out early from the memcg reclaim if the
reclaim target has been completed - see 1ba6fc9af35b ("mm: vmscan: do
not share cgroup iteration between reclaimers"). But I do not see early
break from the reclaim anywhere anymore so the precise nr_reclaimed
tracking shouldn't make a lot of difference. There are cases where we
really have hard time to find proper candidates and need to dip into
hogher reclaim priorities though.

Anyway a proper nr_reclaimed tracking should be rather straightforward
but I do not expect to make a big difference in practice

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 026199c047e0..1b7f2d8cb128 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1633,7 +1633,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	LIST_HEAD(ret_folios);
 	LIST_HEAD(free_folios);
 	LIST_HEAD(demote_folios);
-	unsigned int nr_reclaimed = 0;
+	unsigned int nr_reclaimed = 0, nr_demoted = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
 	struct swap_iocb *plug = NULL;
@@ -2065,8 +2065,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	}
 	/* 'folio_list' is always empty here */
 
-	/* Migrate folios selected for demotion */
-	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
+	/*
+	 * Migrate folios selected for demotion.
+	 * Do not consider demoted pages to be reclaimed for the memcg reclaim
+	 * because no charges are really freed during the migration. Global
+	 * reclaim aims at releasing memory from nodes/zones so consider
+	 * demotion to reclaim memory.
+	 */
+	nr_demoted += demote_folio_list(&demote_folios, pgdat);
+	if (!cgroup_reclaim(sc))
+		nr_reclaimed += nr_demoted;
+
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
 		/* Folios which weren't demoted go back on @folio_list for retry: */

[...]
> > Either I am missing something or I simply do not understand why you are
> > hooked into nodemask so much. Why cannot we have a simple rule that
> > only global reclaim considers demotions as nr_reclaimed?
> >
> 
> Thanks. I think this approach would work for most callers. My issue
> here is properly supporting the recently added nodes= arg[1] to
> memory.reclaim. If the user specifies all nodes or provides no arg,
> I'd like to treat it as memcg reclaim which doesn't count demotions.
> If the user provides the top tier nodes, I would like to count
> demotions as this interface is the way to trigger proactive demotion
> from top tier nodes.

Sorry to repeat myself but nodemask doesn't really make any difference.
The reclaim should only count pages which really free memory in the
domain. Even if you demote to a node outside of the given nodemask then
the charge stays with the existing memcg so it is rather dubious to
count it as a reclaimed page. Or do I still miss what you are trying to
achieve?

-- 
Michal Hocko
SUSE Labs
