Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E3D69D05C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBTPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjBTPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:12:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1AB1E5F6;
        Mon, 20 Feb 2023 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R45rWVDfeg/NXvIZZQJXvpN6fKHMsg4sVZQNWSB6afw=; b=fHlB0hMuyDt761o7r7F3Cu95v/
        WEGj8cgCOqkhOwtPqJX9Jn2aS/ny+0AEsv2qKCTCup+n6nqlxSESxS42BSUB47NMj+HADdfGyvrgS
        r6jamhtkfYxE+MFTAhvOsV0h3/Wnn+IRgBvovAZQWN7dHzEzcmRdZoeH9K/nPlLFsB7osuFh4nRQD
        Vs2gcZ/BGbQlsYCmj+6p/x5fXnF0FVlDwKyAF3S//MMqkxbhVrIrNQxWZahYTSZwKdeLNM8GY0zLc
        6B/9XksckKXyDHzHeoyZ0f0NDDVyInks4a+yI3xYDI5lKQMQBBn4hzBFHVD/oqHDPBZABN4AFTrkg
        9nKzCr1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU7oA-00BoaW-Kl; Mon, 20 Feb 2023 15:10:27 +0000
Date:   Mon, 20 Feb 2023 15:10:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
        corbet@lwn.net, nouveau@lists.freedesktop.org, ogabbay@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, boris.brezillon@collabora.com,
        bskeggs@redhat.com, tzimmermann@suse.de, Liam.Howlett@oracle.com,
        bagasdotme@gmail.com, christian.koenig@amd.com,
        jason@jlekstrand.net
Subject: Re: [PATCH drm-next v2 04/16] maple_tree: add flag MT_FLAGS_LOCK_NONE
Message-ID: <Y/ONYhyDCPEYH1ml@casper.infradead.org>
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-5-dakr@redhat.com>
 <Y+/Xn11dfdn7SfBD@casper.infradead.org>
 <3bb02ec3-4d19-9135-cabc-26ed210f7396@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb02ec3-4d19-9135-cabc-26ed210f7396@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 03:00:59PM +0100, Danilo Krummrich wrote:
> On 2/17/23 20:38, Matthew Wilcox wrote:
> > On Fri, Feb 17, 2023 at 02:44:10PM +0100, Danilo Krummrich wrote:
> > > Generic components making use of the maple tree (such as the
> > > DRM GPUVA Manager) delegate the responsibility of ensuring mutual
> > > exclusion to their users.
> > > 
> > > While such components could inherit the concept of an external lock,
> > > some users might just serialize the access to the component and hence to
> > > the internal maple tree.
> > > 
> > > In order to allow such use cases, add a new flag MT_FLAGS_LOCK_NONE to
> > > indicate not to do any internal lockdep checks.
> > 
> > I'm really against this change.
> > 
> > First, we really should check that users have their locking right.
> > It's bitten us so many times when they get it wrong.
> 
> In case of the DRM GPUVA manager, some users might serialize the access to
> the GPUVA manager and hence to it's maple tree instances, e.g. through the
> drm_gpu_scheduler. In such a case ensuring to hold a lock would be a bit
> pointless and I wouldn't really know how to "sell" this to potential users
> of the GPUVA manager.

This is why we like people to use the spinlock embedded in the tree.
There's nothing for the user to care about.  If the access really is
serialised, acquiring/releasing the uncontended spinlock is a minimal
cost compared to all the other things that will happen while modifying
the tree.

> > Second, having a lock allows us to defragment the slab cache.  The
> > patches to do that haven't gone anywhere recently, but if we drop the
> > requirement now, we'll never be able to compact ranges of memory that
> > have slabs allocated to them.
> > 
> 
> Not sure if I get that, do you mind explaining a bit how this would affect
> other users of the maple tree, such as my use case, the GPUVA manager?

When we want to free a slab in order to defragment memory, we need
to relocate all the objects allocated within that slab.  To do that
for the maple tree node cache, for each node in this particular slab,
we'll need to walk up to the top of the tree and lock it.  We can then
allocate a new node from a different slab, change the parent to point
to the new node and drop the lock.  After an RCU delay, we can free the
slab and create a larger contiguous block of memory.

As I said, this is somewhat hypothetical in that there's no current
code in the tree to reclaim slabs when we're trying to defragment
memory.  And that's because it's hard to do.  The XArray and maple
tree were designed to make it possible for their slabs.
