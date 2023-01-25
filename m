Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B267BEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjAYViG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbjAYViD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:38:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB1F1C32B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:38:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D7E611F8BE;
        Wed, 25 Jan 2023 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674682680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IfU2fRaD+ujd2GlK5fTH5FbMvr0yQ81EIpL8auwwld0=;
        b=Ga8o88o2bV/RDOqBLtubC6S2qs90xKIwq44jGUMIK75wBhw5q2uhRKLBykCbRvpNnM7sEO
        eYe2zX/bRmvlkNMchYth1XZg5kWL2ECi+aQeA28cTDFStaflpRFOE4PYDcL5NL6OOwNIgh
        sNMOxV+wetMV9ZMIiUsjwhWYF8TFl4c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB6671358F;
        Wed, 25 Jan 2023 21:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H/ncKjih0WNwIQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 25 Jan 2023 21:38:00 +0000
Date:   Wed, 25 Jan 2023 22:37:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9GhNxqfjTEAFr5V@dhcp22.suse.cz>
References: <20230125005457.4139289-1-minchan@kernel.org>
 <Y9DigKf0w712t0OO@dhcp22.suse.cz>
 <Y9FacrcUIaLZq4DL@google.com>
 <Y9FhtBbnlNxAZAS4@dhcp22.suse.cz>
 <Y9Fv9YnNn7bHvLkN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Fv9YnNn7bHvLkN@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-01-23 10:07:49, Minchan Kim wrote:
> On Wed, Jan 25, 2023 at 06:07:00PM +0100, Michal Hocko wrote:
> > On Wed 25-01-23 08:36:02, Minchan Kim wrote:
> > > On Wed, Jan 25, 2023 at 09:04:16AM +0100, Michal Hocko wrote:
> > > > On Tue 24-01-23 16:54:57, Minchan Kim wrote:
> > > > > madvise LRU manipulation APIs need to scan address ranges to find
> > > > > present pages at page table and provides advice hints for them.
> > > > > 
> > > > > Likewise pg[scan/steal] count on vmstat, madvise_pg[scanned/hinted]
> > > > > shows the proactive reclaim efficiency so this patch adds those
> > > > > two statistics in vmstat.
> > > > > 
> > > > > 	madvise_pgscanned, madvise_pghinted
> > > > > 
> > > > > Since proactive reclaim using process_madvise(2) as userland
> > > > > memory policy is popular(e.g,. Android ActivityManagerService),
> > > > > those stats are helpful to know how efficiently the policy works
> > > > > well.
> > > > 
> > > > The usecase description is still too vague. What are those values useful
> > > > for? Is there anything actionable based on those numbers? How do you
> > > > deal with multiple parties using madvise resp. process_madvise so that
> > > > their stats are combined?
> > > 
> > > The metric helps monitoing system MM health under fleet and experimental
> > > tuning with diffrent policies from the centralized userland memory daemon.
> > 
> > That is just too vague for me to imagine anything more specific then, we
> > have numbers and we can show them in a report. What does it actually
> > mean that madvise_pgscanned is high. Or that pghinted / pgscanned is
> > low (that you tend to manually reclaim sparse mappings)?
> 
> If that's low, it means the userspace daemon's current tune/policy are
> inefficient or too aggressive since it is working on address spacess
> of processes which don't have enough memory the hint can work(e.g.,
> shared addresses, cold address ranges or some special address ranges like
> VM_PFNMAP) so sometime, we can detect regression to find culprit or
> have a chance to look into better ideas to improve.

Are you sure this is really meaningful metric? Just consider a large and
sparsely populated mapping. This can be a perfect candidate for user
space reclaim target (e.g. consider a mapping covering a large matrix
or other similar data structure). pghinted/pgscanned would be really
small while the reclaim efficiency could be quite high in that case,
wouldn't it?
-- 
Michal Hocko
SUSE Labs
