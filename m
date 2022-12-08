Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E8646A22
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiLHIJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:09:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919E55A97
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:09:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97FBC2075E;
        Thu,  8 Dec 2022 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670486980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6HuzxxK1R5LWZiX2Ry1QA4a/oTdpKiXcJsN1wfL8/4=;
        b=iNWSrfntGjAMT0fkfWVxQ3zKRHO5wRDAm28xHnmTDcW+rll/wk7LJLDYvhG2jUEehAE1ah
        ozgpzedy9wg/LeC+STFaVFTVlLkBJoTBFni5WkfYOnB26NpuFc59i0w1jW5DI/2hlW7xzT
        0Jx0W42wQDYBg3BwKryIr0+KKJvq/F8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 79FC5138E0;
        Thu,  8 Dec 2022 08:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id soQnG8SbkWPbGwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 08 Dec 2022 08:09:40 +0000
Date:   Thu, 8 Dec 2022 09:09:39 +0100
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
Message-ID: <Y5Gbwwp7AlFiltuu@dhcp22.suse.cz>
References: <20221206023406.3182800-1-almasrymina@google.com>
 <Y48zlaimOb/wr8qd@dhcp22.suse.cz>
 <CAHS8izMKz_JtN-P7BTHydE2x2rmSg5-JRoHgaDCdCHV-S0YLJw@mail.gmail.com>
 <Y4+eLyl8HQNZS5ot@dhcp22.suse.cz>
 <CAHS8izOW70Eb7RRePQv6SP8hW3iUnAcPSD=aOY+aMu=6ReEtHQ@mail.gmail.com>
 <Y5B1K5zAE0PkjFZx@dhcp22.suse.cz>
 <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izMKK107wVFSJvg36nQ=WzXd8_cjYBtR0p47L+XLYUSsqA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-12-22 13:43:55, Mina Almasry wrote:
> On Wed, Dec 7, 2022 at 3:12 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Anyway a proper nr_reclaimed tracking should be rather straightforward
> > but I do not expect to make a big difference in practice
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 026199c047e0..1b7f2d8cb128 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1633,7 +1633,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >         LIST_HEAD(ret_folios);
> >         LIST_HEAD(free_folios);
> >         LIST_HEAD(demote_folios);
> > -       unsigned int nr_reclaimed = 0;
> > +       unsigned int nr_reclaimed = 0, nr_demoted = 0;
> >         unsigned int pgactivate = 0;
> >         bool do_demote_pass;
> >         struct swap_iocb *plug = NULL;
> > @@ -2065,8 +2065,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >         }
> >         /* 'folio_list' is always empty here */
> >
> > -       /* Migrate folios selected for demotion */
> > -       nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> > +       /*
> > +        * Migrate folios selected for demotion.
> > +        * Do not consider demoted pages to be reclaimed for the memcg reclaim
> > +        * because no charges are really freed during the migration. Global
> > +        * reclaim aims at releasing memory from nodes/zones so consider
> > +        * demotion to reclaim memory.
> > +        */
> > +       nr_demoted += demote_folio_list(&demote_folios, pgdat);
> > +       if (!cgroup_reclaim(sc))
> > +               nr_reclaimed += nr_demoted;
> > +
> >         /* Folios that could not be demoted are still in @demote_folios */
> >         if (!list_empty(&demote_folios)) {
> >                 /* Folios which weren't demoted go back on @folio_list for retry: */
> >
> > [...]
> 
> Thank you again, but this patch breaks the memory.reclaim nodes arg
> for me. This is my test case. I run it on a machine with 2 memory
> tiers.
> 
> Memory tier 1= nodes 0-2
> Memory tier 2= node 3
> 
>     mkdir -p /sys/fs/cgroup/unified/test
>     cd /sys/fs/cgroup/unified/test
>     echo $$ > cgroup.procs
>     head -c 500m /dev/random > /tmp/testfile
>     echo $$ > /sys/fs/cgroup/unified/cgroup.procs
>     echo "1m nodes=0-2" > memory.reclaim
> 
> In my opinion the expected behavior is for the kernel to demote 1mb of
> memory from nodes 0-2 to node 3.
> 
> Actual behavior on the tip of mm-unstable is as expected.
> 
> Actual behavior with your patch cherry-picked to mm-unstable is that
> the kernel demotes all 500mb of memory from nodes 0-2 to node 3, and
> returns -EAGAIN to the user. This may be the correct behavior you're
> intending, but it completely breaks the use case I implemented the
> nodes= arg for and listed on the commit message of that change.

Yes, strictly speaking the behavior is correct albeit unexpected. You
have told the kernel to _reclaim_ that much memory but demotion are
simply aging handling rather than a reclaim if the demotion target has a
lot of memory free. This would be the case without any nodemask as well
btw.

I am worried this will popping up again and again. I thought your nodes
subset approach could deal with this but I have overlooked one important
thing in your patch. The user provided nodemask controls where to
reclaim from but it doesn't constrain demotion targets. Is this
intentional? Would it actually make more sense to control demotion by
addint demotion nodes into the nodemask?

-- 
Michal Hocko
SUSE Labs
