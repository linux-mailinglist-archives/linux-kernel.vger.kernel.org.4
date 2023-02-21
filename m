Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5E69E773
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBUSbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBUSbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:31:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F022A6C6;
        Tue, 21 Feb 2023 10:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HO/sO06nwJ3/iRAiyzjaJOZuTgokxo8tpPL41c5SK5Q=; b=Q9Cq6aHTWzEEGgoTNdY1hf3KLa
        o0WY13fylo6qvdOn0sdUEioo2h/AVFvjcp3k8pdsapV8O5ZxZkohUFFam7oaNfcOEXzBIdU18dNxv
        VR+LSOa43ZtTE9OYgrt15Kyik25w4RGnIYnfODOJcLk/EDneVLlmA21Gim7ib+5cG9ZScVmLW78pX
        eLGfOAfv6Aipb2fQaFMP9WEgPUeuOpUnZ8BDSmNuTsqbru4Al65Haw2qDGbTPUzLOmAkc+LdawiHE
        O0b3TNKJLALv8v5J8Y3W3pDEuLQb7y1T3bykAn/sN3lOz725fm1i2JGLU2LPtEk32zqPNE4P8motc
        BAWRvULA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUXPr-00Cp3B-UF; Tue, 21 Feb 2023 18:31:04 +0000
Date:   Tue, 21 Feb 2023 18:31:03 +0000
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
Message-ID: <Y/UN50hCaRe+8ZCg@casper.infradead.org>
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-5-dakr@redhat.com>
 <Y+/Xn11dfdn7SfBD@casper.infradead.org>
 <3bb02ec3-4d19-9135-cabc-26ed210f7396@redhat.com>
 <Y/ONYhyDCPEYH1ml@casper.infradead.org>
 <e43f6acc-175d-1031-c4a2-67a6f1741866@redhat.com>
 <Y/PZH/q2Xsr3od9m@casper.infradead.org>
 <Y/TXPasvkhtGiR+w@pollux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/TXPasvkhtGiR+w@pollux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 03:37:49PM +0100, Danilo Krummrich wrote:
> On Mon, Feb 20, 2023 at 08:33:35PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 20, 2023 at 06:06:03PM +0100, Danilo Krummrich wrote:
> > > On 2/20/23 16:10, Matthew Wilcox wrote:
> > > > This is why we like people to use the spinlock embedded in the tree.
> > > > There's nothing for the user to care about.  If the access really is
> > > > serialised, acquiring/releasing the uncontended spinlock is a minimal
> > > > cost compared to all the other things that will happen while modifying
> > > > the tree.
> > > 
> > > I think as for the users of the GPUVA manager we'd have two cases:
> > > 
> > > 1) Accesses to the manager (and hence the tree) are serialized, no lock
> > > needed.
> > > 
> > > 2) Multiple operations on the tree must be locked in order to make them
> > > appear atomic.
> > 
> > Could you give an example here of what you'd like to do?  Ideally
> > something complicated so I don't say "Oh, you can just do this" when
> > there's a more complex example for which "this" won't work.  I'm sure
> > that's embedded somewhere in the next 20-odd patches, but it's probably
> > quicker for you to describe in terms of tree operations that have to
> > appear atomic than for me to try to figure it out.
> > 
> 
> Absolutely, not gonna ask you to read all of that. :-)
> 
> One thing the GPUVA manager does is to provide drivers the (sub-)operations
> that need to be processed in order to fulfill a map or unmap request from
> userspace. For instance, when userspace asks the driver to map some memory
> the GPUVA manager calculates which existing mappings must be removed, split up
> or can be merged with the newly requested mapping.
> 
> A driver has two ways to fetch those operations from the GPUVA manager. It can
> either obtain a list of operations or receive a callback for each operation
> generated by the GPUVA manager.
> 
> In both cases the GPUVA manager walks the maple tree, which keeps track of
> existing mappings, for the given range in __drm_gpuva_sm_map() (only considering
> the map case, since the unmap case is a subset basically). For each mapping
> found in the given range the driver, as mentioned, either receives a callback or
> a list entry is added to the list of operations.
> 
> Typically, for each operation / callback one entry within the maple tree is
> removed and, optionally at the beginning and end of a new mapping's range, a
> new entry is inserted. An of course, as the last operation, there is the new
> mapping itself to insert.
> 
> The GPUVA manager delegates locking responsibility to the drivers. Typically,
> a driver either serializes access to the VA space managed by the GPUVA manager
> (no lock needed) or need to lock the processing of a full set of operations
> generated by the GPUVA manager.

OK, that all makes sense.  It does make sense to have the driver use its
own mutex and then take the spinlock inside the maple tree code.  It
shouldn't ever be contended.

> > > In either case the embedded spinlock wouldn't be useful, we'd either need an
> > > external lock or no lock at all.
> > > 
> > > If there are any internal reasons why specific tree operations must be
> > > mutually excluded (such as those you explain below), wouldn't it make more
> > > sense to always have the internal lock and, optionally, allow users to
> > > specify an external lock additionally?
> > 
> > So the way this works for the XArray, which is a little older than the
> > Maple tree, is that we always use the internal spinlock for
> > modifications (possibly BH or IRQ safe), and if someone wants to
> > use an external mutex to make some callers atomic with respect to each
> > other, they're free to do so.  In that case, the XArray doesn't check
> > the user's external locking at all, because it really can't know.
> > 
> > I'd advise taking that approach; if there's really no way to use the
> > internal spinlock to make your complicated updates appear atomic
> > then just let the maple tree use its internal spinlock, and you can
> > also use your external mutex however you like.
> > 
> 
> That sounds like the right thing to do.
> 
> However, I'm using the advanced API of the maple tree (and that's the reason
> why the above example appears a little more detailed than needed) because I
> think with the normal API I can't insert / remove tree entries while walking
> the tree, right?

Right.  The normal API is for simple operations while the advanced API
is for doing compound operations.

> As by the documentation the advanced API, however, doesn't take care of locking
> itself, hence just letting the maple tree use its internal spinlock doesn't
> really work - I need to take care of that myself, right?

Yes; once you're using the advanced API, you get to compose the entire
operation yourself.

> It feels a bit weird that I, as a user of the API, would need to lock certain
> (or all?) mas_*() functions with the internal spinlock in order to protect
> (future) internal features of the tree, such as the slab cache defragmentation
> you mentioned. Because from my perspective, as the generic component that tells
> it's users (the drivers) to take care of locking VA space operations (and hence
> tree operations) I don't have an own purpose of this internal spinlock, right?

You don't ... but we can't know that.

> Also I'm a little confused how I'd know where to take the spinlock? E.g. for
> inserting entries in the tree I use mas_store_gfp() with GFP_KERNEL.

Lockdep will shout at you if you get it wrong ;-)  But you can safely
take the spinlock before calling mas_store_gfp(GFP_KERNEL) because
mas_nomem() knows to drop the lock before doing a sleeping allocation.
Essentially you're open-coding mtree_store_range() but doing your own
thing in addition to the store.
