Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C9C67E0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjA0JtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjA0Js7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:48:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83D410436
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:48:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7405421DED;
        Fri, 27 Jan 2023 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674812906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8X2UbSqEMAYQsV8/oQi4jk1jubZSrLGTBcrMPBmpUlo=;
        b=YOcWEnmjimXPZgjkDz5KEOBjRHuAETZkIqiFYLZzzaNHIZpQcyQElRvpXSypp4KHceElaB
        8NXbSU1/sECUuLRCPXRiJfVUMuRlgVOFnSxSXWSbwIIlkd5Ds9AQvuR2XN3+Jpo3WHMSCe
        1kAOLmpLtepwsmJD1XnHRTcNKHapk/w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5412C138E3;
        Fri, 27 Jan 2023 09:48:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GzFiEuqd02OWJgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 27 Jan 2023 09:48:26 +0000
Date:   Fri, 27 Jan 2023 10:48:25 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9Od6ccvXujj+YJ/@dhcp22.suse.cz>
References: <Y9DigKf0w712t0OO@dhcp22.suse.cz>
 <Y9FacrcUIaLZq4DL@google.com>
 <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
 <Y9Fv9YnNn7bHvLkN@google.com>
 <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
 <Y9Grb2rggptkCu+n@google.com>
 <Y9I+3ZkWRdXdPBxg@dhcp22.suse.cz>
 <Y9K0Fn9MFPAgJjlM@google.com>
 <Y9LbgUDVnSBazIYW@dhcp22.suse.cz>
 <Y9MWC8xh8gOKDrUU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9MWC8xh8gOKDrUU@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-01-23 16:08:43, Minchan Kim wrote:
> On Thu, Jan 26, 2023 at 08:58:57PM +0100, Michal Hocko wrote:
> > On Thu 26-01-23 09:10:46, Minchan Kim wrote:
> > > On Thu, Jan 26, 2023 at 09:50:37AM +0100, Michal Hocko wrote:
> > [...]
> > > > I suspect you try to mimic pgscan/pgsteal effectivness metric on the
> > > > address space but that is a fundamentally different thing.
> > > 
> > > I don't see anything different, fundamentally.
> > 
> > OK, this really explains our disconnect here. Your metric reports
> > nr_page_tables (nr_scanned) and number of aged and potentially reclaimed
> > pages. You do not know whether that reclaim was successful. So you
> > effectively learn how many pages have already been unmapped before your
> > call. Can this be sometimes useful? Probably yes. Does it say anything
> > about the reclaim efficiency? I do not think so. You could have hit
> > pinned pages or countless other conditions why those pages couldn't have
> > been reclaimed and they have stayed mapped after madvise call.
> > 
> > pgsteal tells you how many pages from those scanned have been reclaimed.
> > See the difference?
> 
> That's why my previous version kept counting exact number of reclaimed/
> deactivated pages but I changed mind since I observed majority of failure
> happened from already-paged-out ranges and shared pages rather than minor
> countless other conditions in real practice. Without finding present pages,
> the mavise hints couldn't do anything from the beginning and that's the
> major cost we are facing.

I cannot really comment on your user space reclaim policy but I would
have expected that you at least check for rss before trying to use
madvise on the range. Learning that from the operation sounds like a
suboptimal policy to me.

> Saing again, I don't think the global stat could cover all the minor
> you are insisting and I agree tracepoint could do better jobs to pinpoint
> root causes but the global stat still have a role to provides basic ground
> to sense abnormal and guides us moving next steps with easier interface/
> efficient way.

I hate to repeat myself but the more we discuss this the more I am
convinced that vmstat is a bad fit. Sooner or later you end up realizing
that nr_reclaimed/nr_scanned is insufficient metric because you would
need to learn more anout those reclaim failures. Really what you want is
to have a tracepoint with a full reclaim metric and grow monitoring tooling
around that. This will deal with the major design flaw of global stat
mentioned ealier (that you cannot attribute specific stats to the
corresponding madvise caller).
-- 
Michal Hocko
SUSE Labs
