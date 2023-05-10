Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769666FDE31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbjEJNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbjEJNB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:01:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA2E4C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WFzzgXzRd8f7zve/fPO1zumAJWWcmn3mTJxPCv++wJ0=; b=CKwtn4MKjvhWLDizMJonglUPWO
        bPeFRlhiJbiIe8QBR4ipq7lDpa88v4/oC2IQL5pGQ/pxo2JiwdTieLvX663N4WoFWO6KYjnZ0lZZa
        QPFgDmRPl4+SN/MRs1GmiCB+oOxPVUFhJMdWhQHT1tJTIpz/fSH4JwW+joe1HYugccE/P4O11oqb7
        gJskY+/5dSI7z1wIs3rW9vR3lLQHMvgVCLzMRhoyR/qOkT/qRhnl20CWcUJfDKSBaiz/7GfCrULSN
        veI0I3kNnJQJrp5rhJAkPd8PzO4XCW7pH5b0h9CVaOY5PeHztuGuzbPhbu89nodfjb3ROMHZdBwlJ
        hh96gXZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwjS5-00GHnt-GR; Wed, 10 May 2023 13:01:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A390300023;
        Wed, 10 May 2023 15:01:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B651C2350E467; Wed, 10 May 2023 15:01:51 +0200 (CEST)
Date:   Wed, 10 May 2023 15:01:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: Re: [PATCH 2/2] bcache: Convert to lock_cmp_fn
Message-ID: <20230510130151.GL4253@hirez.programming.kicks-ass.net>
References: <20230509195847.1745548-1-kent.overstreet@linux.dev>
 <20230509195847.1745548-2-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509195847.1745548-2-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 03:58:47PM -0400, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/btree.c | 23 ++++++++++++++++++++++-
>  drivers/md/bcache/btree.h |  4 ++--
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 147c493a98..569f48958b 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -559,6 +559,27 @@ static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
>  	}
>  }
>  
> +#define cmp_int(l, r)		((l > r) - (l < r))
> +
> +#ifdef CONFIG_PROVE_LOCKING
> +static int btree_lock_cmp_fn(const struct lockdep_map *_a,
> +			     const struct lockdep_map *_b)
> +{
> +	const struct btree *a = container_of(_a, struct btree, lock.dep_map);
> +	const struct btree *b = container_of(_b, struct btree, lock.dep_map);
> +
> +	return -cmp_int(a->level, b->level) ?: bkey_cmp(&a->key, &b->key);
> +}
> +
> +static void btree_lock_print_fn(const struct lockdep_map *map)
> +{
> +	const struct btree *b = container_of(map, struct btree, lock.dep_map);
> +
> +	printk(KERN_CONT " l=%u %llu:%llu", b->level,
> +	       KEY_INODE(&b->key), KEY_OFFSET(&b->key));
> +}
> +#endif
> +
>  static struct btree *mca_bucket_alloc(struct cache_set *c,
>  				      struct bkey *k, gfp_t gfp)
>  {
> @@ -572,7 +593,7 @@ static struct btree *mca_bucket_alloc(struct cache_set *c,
>  		return NULL;
>  
>  	init_rwsem(&b->lock);
> -	lockdep_set_novalidate_class(&b->lock);
> +	lock_set_cmp_fn(&b->lock, btree_lock_cmp_fn, btree_lock_print_fn);
>  	mutex_init(&b->write_lock);
>  	lockdep_set_novalidate_class(&b->write_lock);

I can't help but notice you've got yet another novalidate_class usage
here. What does it take to get rid of that?
