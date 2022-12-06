Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EA0644CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLFTzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiLFTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:55:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007E391DE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 11:55:29 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97DED1FE79;
        Tue,  6 Dec 2022 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670356528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iEox6MaDJCRQHTbBLV2elh9SmK3bgMhm18jSIo7IF7M=;
        b=qjTE0IIIN2h0ey3SOC2ay4L+WoKvkauQ2aCMLVZexI3oAxUXur23zvHHjq9pMWH3fGc4HW
        gADSnuVQubPXw3NcEnjP2bGANdrroKzTSM943p5vudkmLAXsjuu2pclPGvLNFzvbPZDnFy
        abB7z9007skEhjvMlqA00j7SuZjkvBc=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 73DD413326;
        Tue,  6 Dec 2022 19:55:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1qFgEjCej2PLRwAAGKfGzw
        (envelope-from <mhocko@suse.com>); Tue, 06 Dec 2022 19:55:28 +0000
Date:   Tue, 6 Dec 2022 20:55:27 +0100
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
Message-ID: <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz>
References: <20221206023406.3182800-1-almasrymina@google.com>
 <Y48zlaimOb/wr8qd@dhcp22.suse.cz>
 <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-12-22 08:06:51, Mina Almasry wrote:
> On Tue, Dec 6, 2022 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 05-12-22 18:34:05, Mina Almasry wrote:
> > > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > reclaim"") enabled demotion in memcg reclaim, which is the right thing
> > > to do, however, it introduced a regression in the behavior of
> > > try_to_free_mem_cgroup_pages().
> > >
> > > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> > > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> > > of the cgroup should reduce by nr_pages. The callers expect
> > > try_to_free_mem_cgroup_pages() to also return the number of pages
> > > reclaimed, not demoted.
> > >
> > > However, what try_to_free_mem_cgroup_pages() actually does is it
> > > unconditionally counts demoted pages as reclaimed pages. So in practice
> > > when it is called it will often demote nr_pages and return the number of
> > > demoted pages to the caller. Demoted pages don't lower the memcg usage,
> > > and so try_to_free_mem_cgroup_pages() is not actually doing what the
> > > callers want it to do.
> > >
> > > Various things work suboptimally on memory tiered systems or don't work
> > > at all due to this:
> > >
> > > - memory.high enforcement likely doesn't work (it just demotes nr_pages
> > >   instead of lowering the memcg usage by nr_pages).
> > > - try_charge_memcg() will keep retrying the charge while
> > >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
> > >   making any room for the charge.
> >
> > This has been brought up during the review https://lore.kernel.org/all/YoYTEDD+c4GT0xYY@dhcp22.suse.cz/
> >
> 
> Ah, I did indeed miss this. Thanks for the pointer. However I don't
> understand this bit from your email (sorry I'm probably missing
> something):
> 
> "I suspect this is rather unlikely situation, though. The last tear
> (without any fallback) should have some memory to reclaim most of
> the time."
> 
> Reading the code in try_charge_memcg(), I don't see the last retry for
> try_to_free_mem_cgroup_pages() do anything special. My concern here is
> that try_charge_memcg() calls try_to_free_mem_cgroup_pages()
> MAX_RECLAIM_RETRIES times. Each time that call may demote pages and
> report back that it was able to 'reclaim' memory, but the charge keeps
> failing because the memcg reclaim didn't actually make room for the
> charge. What happens in this case? My understanding is that the memcg
> oom-killer gets wrongly invoked.

The memcg reclaim shrinks from all zones in the allowed zonelist. In
general from all nodes. So unless the lower tier is outside of this
zonelist then there is a zone to reclaim from which cannot demote.
Correct?

> > > - memory.reclaim has a wonky interface. It advertises to the user it
> > >   reclaims the provided amount but it will actually often demote that
> > >   amount.
> > >
> > > There may be more effects to this issue.
> > >
> > > To fix these issues I propose shrink_folio_list() to only count pages
> > > demoted from inside of sc->nodemask to outside of sc->nodemask as
> > > 'reclaimed'.
> >
> > Could you expand on why the node mask matters? From the charge point of
> > view it should be completely uninteresting as the charge remains.
> >
> > I suspect we really need to change to reclaim metrics for memcg reclaim.
> > In the memory balancing reclaim we can indeed consider demotions as a
> > reclaim because the memory is freed in the end but for the memcg reclaim
> > we really should be counting discharges instead. No demotion/migration will
> > free up charges.
> 
> I think what you're describing is exactly what this patch aims to do.
> I'm proposing an interface change to shrink_folio_list() such that it
> only counts demoted pages as reclaimed iff sc->nodemask is provided by
> the caller and the demotion removed pages from inside sc->nodemask to
> outside sc->nodemask. In this case:
> 
> 1. memory balancing reclaim would pass sc->nodemask=nid to
> shrink_folio_list() indicating that it should count pages demoted from
> sc->nodemask as reclaimed.
> 
> 2. memcg reclaim would pass sc->nodemask=NULL to shrink_folio_list()
> indicating that it is looking for reclaim across all nodes and no
> demoted pages should count as reclaimed.
> 
> Sorry if the commit message was not clear. I can try making it clearer
> in the next version but it's already very long.

Either I am missing something or I simply do not understand why you are
hooked into nodemask so much. Why cannot we have a simple rule that
only global reclaim considers demotions as nr_reclaimed?

-- 
Michal Hocko
SUSE Labs
