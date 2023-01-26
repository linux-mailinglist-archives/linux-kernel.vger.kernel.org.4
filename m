Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F167D5CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjAZT7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:59:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04BE410A3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:58:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D18C21F27;
        Thu, 26 Jan 2023 19:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674763138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rl/hw552+8svihkogaE9maykA/H/DKtQPsTNVH2CGCA=;
        b=FuGqEXvcZobAesX4+RcKzhqrBFTZ2UN7p/Z7ReOejmAaiNElJHoAhxmY/v5k7zHaonXiA6
        8HAXi7MaMSuZ4KiMf0/aQOMcMOWz1fO3ZxGAuNm8TXfQnEitpccuQi7BpupZUPNWzfgCWC
        ONk7gI7PBX3d09E2HUBA7EGGE51dJX8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5687A139B3;
        Thu, 26 Jan 2023 19:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Owc7FILb0mMTLQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 26 Jan 2023 19:58:58 +0000
Date:   Thu, 26 Jan 2023 20:58:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9LbgUDVnSBazIYW@dhcp22.suse.cz>
References: <20230125005457.4139289-1-minchan@kernel.org>
 <Y9DigKf0w712t0OO@dhcp22.suse.cz>
 <Y9FacrcUIaLZq4DL@google.com>
 <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
 <Y9Fv9YnNn7bHvLkN@google.com>
 <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
 <Y9Grb2rggptkCu+n@google.com>
 <Y9I+3ZkWRdXdPBxg@dhcp22.suse.cz>
 <Y9K0Fn9MFPAgJjlM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9K0Fn9MFPAgJjlM@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-01-23 09:10:46, Minchan Kim wrote:
> On Thu, Jan 26, 2023 at 09:50:37AM +0100, Michal Hocko wrote:
[...]
> > I suspect you try to mimic pgscan/pgsteal effectivness metric on the
> > address space but that is a fundamentally different thing.
> 
> I don't see anything different, fundamentally.

OK, this really explains our disconnect here. Your metric reports
nr_page_tables (nr_scanned) and number of aged and potentially reclaimed
pages. You do not know whether that reclaim was successful. So you
effectively learn how many pages have already been unmapped before your
call. Can this be sometimes useful? Probably yes. Does it say anything
about the reclaim efficiency? I do not think so. You could have hit
pinned pages or countless other conditions why those pages couldn't have
been reclaimed and they have stayed mapped after madvise call.

pgsteal tells you how many pages from those scanned have been reclaimed.
See the difference?

Also I do not find information about how many non-present ptes have
been scann super interesting. Sure that is a burnt time as well but to
me it would be much more valuable information to see how many of those
resident could have been actually reclaimed. Because that tells whether
your reclaim target was a good choice and IMHO that is a valuable
information for user space memory reclaim agent.

Again consider a large sparsely mapped memory but mostly inactive memory
and a condensed active one with the same rss. The reclaim could have
been successful for the former while not on the latter. Your matric
would give a rather misleading numbers, don't you think?
-- 
Michal Hocko
SUSE Labs
