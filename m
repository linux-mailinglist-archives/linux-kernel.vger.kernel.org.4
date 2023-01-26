Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1939E67C634
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjAZIvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjAZIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:51:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB62194B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:51:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D869321B2B;
        Thu, 26 Jan 2023 08:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674723099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zhUKCEK410sVcblH9sTdY8t3/h5I9I8XF7De6bKLRfE=;
        b=Q8VEQb/Y0zSRA4hZPXDEYtdUxu+Pi/6wg24mVu7usqgL+xGcOXeXmv65m5qM9QL1OvzEUk
        7kIXlSt5NFZcoV6qUlwn4LHTo18uRV/j2o3vlu3vnJAZBI9ttnWU2zyxUYH/S5fIil7p1l
        8wcoVyKnGjk4GOFfHTyjJsHXUY0Rja0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B966A139B3;
        Thu, 26 Jan 2023 08:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mbRmKhs/0mNzRAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 26 Jan 2023 08:51:39 +0000
Date:   Thu, 26 Jan 2023 09:51:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9I/GymMEyOT3nYw@dhcp22.suse.cz>
References: <20230125005457.4139289-1-minchan@kernel.org>
 <Y9DigKf0w712t0OO@dhcp22.suse.cz>
 <Y9FacrcUIaLZq4DL@google.com>
 <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
 <Y9Fv9YnNn7bHvLkN@google.com>
 <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
 <Y9Grb2rggptkCu+n@google.com>
 <Y9I+3ZkWRdXdPBxg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9I+3ZkWRdXdPBxg@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-01-23 09:50:38, Michal Hocko wrote:
> On Wed 25-01-23 14:21:35, Minchan Kim wrote:
> > On Wed, Jan 25, 2023 at 10:37:59PM +0100, Michal Hocko wrote:
> > > On Wed 25-01-23 10:07:49, Minchan Kim wrote:
> > > > On Wed, Jan 25, 2023 at 06:07:00PM +0100, Michal Hocko wrote:
> > > > > On Wed 25-01-23 08:36:02, Minchan Kim wrote:
> > > > > > On Wed, Jan 25, 2023 at 09:04:16AM +0100, Michal Hocko wrote:
> > > > > > > On Tue 24-01-23 16:54:57, Minchan Kim wrote:
> > > > > > > > madvise LRU manipulation APIs need to scan address ranges to find
> > > > > > > > present pages at page table and provides advice hints for them.
> > > > > > > > 
> > > > > > > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > > > > > > shows the proactive reclaim efficiency so this patch adds those
> > > > > > > > two statistics in vmstat.
> > > > > > > > 
> > > > > > > > 	madvise_pgscanned, madvise_pghinted
> > > > > > > > 
> > > > > > > > Since proactive reclaim using process_madvise(2) as userland
> > > > > > > > memory policy is popular(e.g,. Android ActivityManagerService),
> > > > > > > > those stats are helpful to know how efficiently the policy works
> > > > > > > > well.
> > > > > > > 
> > > > > > > The usecase description is still too vague. What are those values useful
> > > > > > > for? Is there anything actionable based on those numbers? How do you
> > > > > > > deal with multiple parties using madvise resp. process_madvise so that
> > > > > > > their stats are combined?
> > > > > > 
> > > > > > The metric helps monitoing system MM health under fleet and experimental
> > > > > > tuning with diffrent policies from the centralized userland memory daemon.
> > > > > 
> > > > > That is just too vague for me to imagine anything more specific then, we
> > > > > have numbers and we can show them in a report. What does it actually
> > > > > mean that madvise_pgscanned is high. Or that pghinted / pgscanned is
> > > > > low (that you tend to manually reclaim sparse mappings)?
> > > > 
> > > > If that's low, it means the userspace daemon's current tune/policy are
> > > > inefficient or too aggressive since it is working on address spacess
> > > > of processes which don't have enough memory the hint can work(e.g.,
> > > > shared addresses, cold address ranges or some special address ranges like
> > > > VM_PFNMAP) so sometime, we can detect regression to find culprit or
> > > > have a chance to look into better ideas to improve.
> > > 
> > > Are you sure this is really meaningful metric? Just consider a large and
> > > sparsely populated mapping. This can be a perfect candidate for user
> > > space reclaim target (e.g. consider a mapping covering a large matrix
> > > or other similar data structure). pghinted/pgscanned would be really
> > > small while the reclaim efficiency could be quite high in that case,
> > > wouldn't it?
> > 
> > Why do you think it's efficient? It need to spend quite CPU cycle to
> > scan a few of pages to evict. I don't see it's efficient if it happens
> > quite a lot.
> 
> Because it doesn't really matter how many page tables you have to scan
> but how easily you can reclaim the memory behind that. Because it is the
> memory that matters. Just consider THP vs. 4k backed address ranges. You
> are going to scan much more for latter by design. That doesn't really
> mean that this is a worse candidate for reclaim and you should be only
> focusing on THP backed mappings. See?
> 
> I suspect you try to mimic pgscan/pgsteal effectivness metric on the

dang. I meant pgsteal/pgscan

> address space but that is a fundamentally different thing.

-- 
Michal Hocko
SUSE Labs
