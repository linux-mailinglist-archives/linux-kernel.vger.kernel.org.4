Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1496A00AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjBWBgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjBWBgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:36:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0983028F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+JG1+kQ4CA3XXyr6PqDGRrx24SD/13lLGJOcUnu6X1M=; b=jR/GpYpSyNFz9kxg6zSaEOrxvx
        G/9wGKDje1D+wj64JDMqV7bS1mfNTjZcosy7vDphCWyx1EmBsQBN4UwroT1h0Jc2uUPfBKu7nucyD
        7fyshIG1AECFvqxyKzIn8L8UpzEi8qb+n6NAtZLV/KzrgoZT2qO2XgmAIh4IbG15ffs1X+VGiK8TX
        r6WiQl/tbbtcrdpsE3Ft38tr5p2/iOqPW5xgJz/7LMM+0nlEAmLpVzxqLmDuC11wBSIrcbCtNnl7p
        wAXjirl58dDlfGtAUgAnFYyAYChDEFOvnuErdu6Kd6zHt1oyfmHpIOLwvB328qSkLr3xSlIRaoeId
        ktAilC+w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV0WV-00Ef9N-31; Thu, 23 Feb 2023 01:35:51 +0000
Date:   Wed, 22 Feb 2023 17:35:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] shmem: add support to ignore swap
Message-ID: <Y/bC99QPYCFX9Ndd@bombadil.infradead.org>
References: <20230207025259.2522793-1-mcgrof@kernel.org>
 <20230207025259.2522793-3-mcgrof@kernel.org>
 <Y+HNL9RoP48tquGd@casper.infradead.org>
 <Y+PHPfiVS6EiTVl1@bombadil.infradead.org>
 <Y+PfqulG2wt0Y+Vr@casper.infradead.org>
 <CAJD7tkZnaphPCrOTMjb0uM7HHqwJESaauNZ6Q58+QP1290Zd4A@mail.gmail.com>
 <Y/a4/ktpxw/z7/PO@bombadil.infradead.org>
 <CAJD7tkYHHSaiZwU9Evu-4r5=4FjrmFc-=xMst63io-4AM9N6XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYHHSaiZwU9Evu-4r5=4FjrmFc-=xMst63io-4AM9N6XA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 05:04:32PM -0800, Yosry Ahmed wrote:
> On Wed, Feb 22, 2023 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Feb 08, 2023 at 12:33:37PM -0800, Yosry Ahmed wrote:
> > > On Wed, Feb 8, 2023 at 9:45 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Feb 08, 2023 at 08:01:01AM -0800, Luis Chamberlain wrote:
> > > > > On Tue, Feb 07, 2023 at 04:01:51AM +0000, Matthew Wilcox wrote:
> > > > > > On Mon, Feb 06, 2023 at 06:52:59PM -0800, Luis Chamberlain wrote:
> > > > > > > @@ -1334,11 +1336,15 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
> > > > > > >   struct shmem_inode_info *info;
> > > > > > >   struct address_space *mapping = folio->mapping;
> > > > > > >   struct inode *inode = mapping->host;
> > > > > > > + struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> > > > > > >   swp_entry_t swap;
> > > > > > >   pgoff_t index;
> > > > > > >
> > > > > > >   BUG_ON(!folio_test_locked(folio));
> > > > > > >
> > > > > > > + if (wbc->for_reclaim && unlikely(sbinfo->noswap))
> > > > > > > +         return AOP_WRITEPAGE_ACTIVATE;
> > > > > >
> > > > > > Not sure this is the best way to handle this.  We'll still incur the
> > > > > > oevrhead of tracking shmem pages on the LRU, only to fail to write them
> > > > > > out when the VM thinks we should get rid of them.  We'd be better off
> > > > > > not putting them on the LRU in the first place.
> > > > >
> > > > > Ah, makes sense, so in effect then if we do that then on reclaim
> > > > > we should be able to even WARN_ON(sbinfo->noswap) assuming we did
> > > > > everthing right.
> > > > >
> > > > > Hrm, we have invalidate_mapping_pages(mapping, 0, -1) but that seems a bit
> > > > > too late how about d_mark_dontcache() on shmem_get_inode() instead?
> > > >
> > > > I was thinking that the two calls to folio_add_lru() in mm/shmem.c
> > > > should be conditional on sbinfo->noswap.
> > > >
> > >
> > > Wouldn't this cause the folio to not show up in any lru lists, even
> > > the unevictable one, which may be a strange discrepancy?
> > >
> > > Perhaps we can do something like shmem_lock(), which calls
> > > mapping_set_unevictable(), which will make folio_evictable() return
> > > true and the LRUs code will take care of the rest?
> >
> > If shmem_lock() should take care of that is that because writepages()
> > should not happen or because we have that info->flags & VM_LOCKED stop
> > gap on writepages()? If the earlier then shouldn't we WARN_ON_ONCE()
> > if writepages() is called on info->flags & VM_LOCKED?
> >
> > While I see the value in mapping_set_unevictable() I am not sure I see
> > the point in using shmem_lock(). I don't see why we should constrain
> > noswap tmpfs option to RLIMIT_MEMLOCK
> >
> > Please correct me if I'm wrong but the limit seem to be designed for
> > files / IPC / unprivileged perf limits. On the contrary, we'd bump the
> > count for each new inode. Using shmem_lock() would  also complicate the
> > inode allocation on shmem as we'd have to unwind on failure from the
> > user_shm_lock(). It would also beg the question of when to capture a
> > ucount for an inode, should we just share one for the superblock at
> > shmem_fill_super() or do we really need to capture it at every single
> > inode creation? In theory we could end up with different limits.
> >
> > So why not just use mapping_set_unevictable() alone for this use case?
> 
> Sorry if I wasn't clear, I did NOT mean that we should use
> shmem_lock(), I meant that we do something similar to what
> shmem_lock() does and use mapping_set_unevictable() or similar.

Ah OK! Sure yeah I reviewed shmem_lock() usage and I don't think it
and its rtlimit baggage makes sense here so the only thing to do is
just mapping_set_unevictable().

> I think we just need to make sure that if we use
> mapping_set_unevictable() does not imply that shmem_lock() was used
> (i.e no code assumes that if the shmem mapping is unevictable then
> shmem_lock() was used).

The *other* stuff that shmem_lock() does is rlimit rlimit related
to RLIMIT_MEMLOCK, I can't think off hand why we'd confuse the two
use cases at the moment, but I'll give it another good luck with this
in mind.

I'll test what I have and post a v2 with the feedback received.

Thanks,

  Luis
