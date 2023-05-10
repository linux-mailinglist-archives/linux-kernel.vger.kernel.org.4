Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43EF6FE2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjEJRGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjEJRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:06:14 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14546A48
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:05:48 -0700 (PDT)
Date:   Wed, 10 May 2023 13:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683738323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GrulpR8Jk8I1VJ30mEIHHG5A641qEbjUevYoLi6mykE=;
        b=DIxk6gubmoIPUhJI3CwRDaDBI4vIDPMGHBpQtHtiUqVSuxYr5bbiQdzZMy2ZZU3cVBJMdI
        IC1b/F/DGqqYl8Fbri2cWdLlc6smYbGmVJUMoL/Bnn7DEes2eCxzJZskaHzwfFriagEpr1
        eIJJnqehmpcZh0H95qv2vPnyu2EY9Xs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: Re: [PATCH 2/2] bcache: Convert to lock_cmp_fn
Message-ID: <ZFvO0QfTUZyTXd4s@moria.home.lan>
References: <20230509195847.1745548-1-kent.overstreet@linux.dev>
 <20230509195847.1745548-2-kent.overstreet@linux.dev>
 <20230510130151.GL4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510130151.GL4253@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 03:01:51PM +0200, Peter Zijlstra wrote:
> On Tue, May 09, 2023 at 03:58:47PM -0400, Kent Overstreet wrote:
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Coly Li <colyli@suse.de>
> > ---
> >  drivers/md/bcache/btree.c | 23 ++++++++++++++++++++++-
> >  drivers/md/bcache/btree.h |  4 ++--
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> > index 147c493a98..569f48958b 100644
> > --- a/drivers/md/bcache/btree.c
> > +++ b/drivers/md/bcache/btree.c
> > @@ -559,6 +559,27 @@ static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
> >  	}
> >  }
> >  
> > +#define cmp_int(l, r)		((l > r) - (l < r))
> > +
> > +#ifdef CONFIG_PROVE_LOCKING
> > +static int btree_lock_cmp_fn(const struct lockdep_map *_a,
> > +			     const struct lockdep_map *_b)
> > +{
> > +	const struct btree *a = container_of(_a, struct btree, lock.dep_map);
> > +	const struct btree *b = container_of(_b, struct btree, lock.dep_map);
> > +
> > +	return -cmp_int(a->level, b->level) ?: bkey_cmp(&a->key, &b->key);
> > +}
> > +
> > +static void btree_lock_print_fn(const struct lockdep_map *map)
> > +{
> > +	const struct btree *b = container_of(map, struct btree, lock.dep_map);
> > +
> > +	printk(KERN_CONT " l=%u %llu:%llu", b->level,
> > +	       KEY_INODE(&b->key), KEY_OFFSET(&b->key));
> > +}
> > +#endif
> > +
> >  static struct btree *mca_bucket_alloc(struct cache_set *c,
> >  				      struct bkey *k, gfp_t gfp)
> >  {
> > @@ -572,7 +593,7 @@ static struct btree *mca_bucket_alloc(struct cache_set *c,
> >  		return NULL;
> >  
> >  	init_rwsem(&b->lock);
> > -	lockdep_set_novalidate_class(&b->lock);
> > +	lock_set_cmp_fn(&b->lock, btree_lock_cmp_fn, btree_lock_print_fn);
> >  	mutex_init(&b->write_lock);
> >  	lockdep_set_novalidate_class(&b->write_lock);
> 
> I can't help but notice you've got yet another novalidate_class usage
> here. What does it take to get rid of that?

this is a tricky one, because the correct lock ordering refers to
particular locks of different types; we take b->lock before
b->write_lock, for a given btree node.

And like b->lock, b->write_lock can be held simultaneously for multiple
nodes, with the same ordering that btree_lock_cmp_fn() defines.

Conceptually we'd need a lock_cmp_fn that can compare locks of different
types...

This patchset might be almost enough to do that, I'll give it a bit more
thought.
