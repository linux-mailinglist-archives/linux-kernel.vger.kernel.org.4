Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A964710540
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240137AbjEYFU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbjEYFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:20:06 -0400
Received: from out-30.mta1.migadu.com (out-30.mta1.migadu.com [95.215.58.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2AD4EFA
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 22:08:02 -0700 (PDT)
Date:   Thu, 25 May 2023 01:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684991280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d6WQ9TaAjYlC3Hw4sqFmSGpRq5ot1EQ0nvfKj79dNbI=;
        b=aZ+hcMQtBHEz8YPaBeJ2z0GfrElZdaUcqe0fylpBdqCRnIk6TXjyBZFQHlFkZ6QmuFjrBU
        5RV28KpUlaTJ6GqaA5v+Zbo9kUMMmGa9xUqlFxRZew0kvqFLhdnfI+iRRsMSLZZvfkAWTf
        QTBbRYl0ZL4TIQUe1Og1JujMQBdawYs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: Re: [PATCH 2/2] bcache: Convert to lock_cmp_fn
Message-ID: <ZG7tGKYM3zq5MG7v@moria.home.lan>
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

A locking rework, probably switching bcache to six locks.

I'd rather prioritize getting bcachefs merged and then working on an
upgrade path from bcache -> bcahcefs so we can depracate bcache,
though...
