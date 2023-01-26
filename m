Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362B167D2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjAZRLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjAZRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:11:17 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C974915C81
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:10:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so2372061pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHSxHTN/xxsSqL1X6+bbClQ0gPOZ5UgPl/bWkZa4aoI=;
        b=fU4OqxdOfzhOFI2T9roAZ/91c5Mds5p9COSMAU5dKwBdUdNzl8gPvVSXMFfG9Q1+fE
         eKUs8QFwj/haRH4w1c12B1xpXSKEsRDdQhcfP4QD+2hfYhTA6HKaVv5tDRVIPulPdfZf
         xyaT378l85JJBbfG+hauZm4oKu1XfYR2v1os5c+DEYF5xmvLVqbC33thFAKd1Iy0WKIY
         GiAALlfVMxA33XMc3DhKKfXIVYTEmBso+cXCNMWA5eHbIPk0XrUUS8P89/G12P745nn1
         AAUxXCcyebKwSPWheeKZLnZitpdUfTaaY4Maog98lKEJ0SlUNEfqjGCIe+drYVFf7wun
         4Neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHSxHTN/xxsSqL1X6+bbClQ0gPOZ5UgPl/bWkZa4aoI=;
        b=VEkF0r4qceMUT1LIb980vrscm7vn8HDzVjHP5OqwyeLx/ocTkrP4A028PUNIsdA0xE
         XtSMO4CXsHyH5Ekh/1nCaCq3Xu4hrBrTIi2F7ZmjJDvB1m2tf4qAACf0fhGQ9FpAAkV8
         /urbmV+fKAWZgNW7NC2xswZF0R1BZhF6n54FAGjGsUBEY1uUsfNhN4ZtDt8joegrD140
         S6/s3FxZerQ73IuXkQy76HUcLwsLuQO+koNnSndLynwHYf6x9lzGDgDgAwX+bf2/vaTI
         uuXyIHV88hTCvSp9n4Uql5BZ1cLhaskrzhRoRvwi1evxhTAYysQ7tPV7GGz+2P5R97Dj
         UWEA==
X-Gm-Message-State: AFqh2kpkWmtf2oH3O5TgZdE9yxJ68dyz+sU6R5YCTpLXOnEcVE9b0SO6
        NhD7Rczx30beHBAFAK7rhJfuyzsvMOw=
X-Google-Smtp-Source: AMrXdXtNg42Md2CR5I1OgvQN07SpRon515/tJPdMycmoCckatTyTyjuhc1j0ySgxbSFt5zJte1R51g==
X-Received: by 2002:a17:903:2306:b0:194:7b59:bfe4 with SMTP id d6-20020a170903230600b001947b59bfe4mr54751382plh.54.1674753049158;
        Thu, 26 Jan 2023 09:10:49 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9ca6:45a6:69fe:a468])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b00190c6518e30sm1201667plg.243.2023.01.26.09.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:10:48 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 26 Jan 2023 09:10:46 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/madvise: add vmstat statistics for
 madvise_[cold|pageout]
Message-ID: <Y9K0Fn9MFPAgJjlM@google.com>
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:50:37AM +0100, Michal Hocko wrote:
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

I really don't follow your claim here. Efficiency is input vs output.
For the those advices, input is number of scanned ptes vs. number of
hinted pages.
If you keep need to scan the sparsed huge address range to reclaim just
a few of pages, that's really inefficient.
If you keep hinting to the non-populated-page, already swapped-out and
hint-cannot-work address ranges, that's really inefficient.

What do you see the problem here? What exactly do you mean "how easily"
from your context?

> memory that matters. Just consider THP vs. 4k backed address ranges. You
> are going to scan much more for latter by design. That doesn't really
> mean that this is a worse candidate for reclaim and you should be only
> focusing on THP backed mappings. See?

I don't understand your point here. The stat doesn't aim to make such
decision. If THP page shows the good yield from the efficienty above,
that's good. If 4K page shows the bad yield, should we focus on THP
pages? How could you conclude such decision from the stat?

The stat just sees the current health of the system and find something
regressed/improved compared to old to intitiate further investigation.

> 
> I suspect you try to mimic pgscan/pgsteal effectivness metric on the
> address space but that is a fundamentally different thing.

I don't see anything different, fundamentally.
