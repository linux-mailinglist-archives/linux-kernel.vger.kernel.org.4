Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAF728774
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjFHSp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjFHSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:45:26 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D603E2D74
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:45:18 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6260e771419so5177326d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686249918; x=1688841918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vB1ola4E25oLoCTIaa0hZ2bCKEZyZNPX8kWPehiyVw8=;
        b=QyYiglSuM6pfS/XYtSqOVAeCLqbULZey2IGYw6NDTVuF4d4pFXmQPAomMQSeLGpQ76
         zmXaEGlXqnAvgUkfwk1BtThj5hm3fRmDgaHojc2IHEHs5gmG8S98LebzUFxlwb72UuzF
         zB2lQA464bh/1WsiDq90PVQYMBttECP0AbRMDqRtzv8aZPyyGJfYI0dxCe1PA3jpY43g
         Gi/jN32iMlD6csqkxr0JJkZLI40tKqsacMKBayzwHkl/05UQeR97/ZxqS7GTzYatkXYA
         tP5haPX5ZKd8GAyh87TlRnoqMzItj/BvoWgTfUxjY3mfdjidZQwnLOrE9R8lyXjU8gsQ
         WOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686249918; x=1688841918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB1ola4E25oLoCTIaa0hZ2bCKEZyZNPX8kWPehiyVw8=;
        b=FgrUSZ41q49+jVOWby6pWX7utJ2aAUVHIOcevn1mNxI+HLFON1VQ+kMkRXmnZHIfiD
         ZOjowR33+C9tf5YC04cke1gMQjf0lzZ/e3CHp/m4QKeViM93OTXrhnoBcsFKzIE9wchr
         E8LPHQAx30GUbsFNST0SqlyjLaff7Ae+jNyJYhwR9xciLa/IAwuTCL+Z/MbRLSH/goMo
         BaZ4GaQBDbHxPpTurI15bfhs4l2pBEkWJDRFuENs+BaM22U/t5vPCWF/qCWWNS6vNRBw
         J1Q1cqLJoe0tW0TmeJXpipZ3b5xFrq3dJRUG6Nw/ZSrCfSZU1SPv27pqErhAamnXvDyT
         ac+g==
X-Gm-Message-State: AC+VfDwAmwre92/HM1N83JdYQyeZrJuaRCHafVdwQMyHiHrhXTN82vGK
        gd2KhjuEkB7nrK48XxfaNrBHzw==
X-Google-Smtp-Source: ACHHUZ4RGfCjbZ/Eww4hIR8wUeuQovzbHX1r3YXBGPpdAJEG1NRD5nknwVZUKoJJ6MdTAJYBPMF/Vg==
X-Received: by 2002:a05:6214:20eb:b0:626:f35:ab95 with SMTP id 11-20020a05621420eb00b006260f35ab95mr2350120qvk.17.1686249917969;
        Thu, 08 Jun 2023 11:45:17 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id kr30-20020a0562142b9e00b00626286e41ccsm589592qvb.77.2023.06.08.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:45:17 -0700 (PDT)
Date:   Thu, 8 Jun 2023 14:45:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <20230608184516.GA356779@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-2-cerasuolodomenico@gmail.com>
 <20230608165250.GG352940@cmpxchg.org>
 <20230608170459.GH352940@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608170459.GH352940@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:05:00PM -0400, Johannes Weiner wrote:
> On Thu, Jun 08, 2023 at 12:52:51PM -0400, Johannes Weiner wrote:
> > On Tue, Jun 06, 2023 at 04:56:05PM +0200, Domenico Cerasuolo wrote:
> > > @@ -584,14 +601,70 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
> > >  	return NULL;
> > >  }
> > >  
> > > +static int zswap_shrink(struct zswap_pool *pool)
> > > +{
> > > +	struct zswap_entry *lru_entry, *tree_entry = NULL;
> > > +	struct zswap_header *zhdr;
> > > +	struct zswap_tree *tree;
> > > +	int swpoffset;
> > > +	int ret;
> > > +
> > > +	/* get a reclaimable entry from LRU */
> > > +	spin_lock(&pool->lru_lock);
> > > +	if (list_empty(&pool->lru)) {
> > > +		spin_unlock(&pool->lru_lock);
> > > +		return -EINVAL;
> > > +	}
> > > +	lru_entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
> > > +	list_del_init(&lru_entry->lru);
> > > +	zhdr = zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_MM_RO);
> > > +	tree = zswap_trees[swp_type(zhdr->swpentry)];
> > > +	zpool_unmap_handle(pool->zpool, lru_entry->handle);
> > > +	/*
> > > +	 * Once the pool lock is dropped, the lru_entry might get freed. The
> > > +	 * swpoffset is copied to the stack, and lru_entry isn't deref'd again
> > > +	 * until the entry is verified to still be alive in the tree.
> > > +	 */
> > > +	swpoffset = swp_offset(zhdr->swpentry);
> > > +	spin_unlock(&pool->lru_lock);
> > > +
> > > +	/* hold a reference from tree so it won't be freed during writeback */
> > > +	spin_lock(&tree->lock);
> > > +	tree_entry = zswap_entry_find_get(&tree->rbroot, swpoffset);
> > > +	if (tree_entry != lru_entry) {
> > > +		if (tree_entry)
> > > +			zswap_entry_put(tree, tree_entry);
> > > +		spin_unlock(&tree->lock);
> > > +		return -EAGAIN;
> > > +	}
> > > +	spin_unlock(&tree->lock);
> > > +
> > > +	ret = zswap_writeback_entry(pool->zpool, lru_entry->handle);
> > > +
> > > +	spin_lock(&tree->lock);
> > > +	if (ret) {
> > > +		spin_lock(&pool->lru_lock);
> > > +		list_move(&lru_entry->lru, &pool->lru);
> > > +		spin_unlock(&pool->lru_lock);
> > > +	}
> > > +	zswap_entry_put(tree, tree_entry);
> > 
> > On re-reading this, I find the lru_entry vs tree_entry distinction
> > unnecessarily complicated. Once it's known that the thing coming off
> > the LRU is the same thing as in the tree, there is only "the entry".
> > 
> > How about 'entry' and 'tree_entry', and after validation use 'entry'
> > throughout the rest of the function?
> 
> Even better, safe the tree_entry entirely by getting the reference
> from the LRU already, and then just search the tree for a match:
> 
> 	/* Get an entry off the LRU */
> 	spin_lock(&pool->lru_lock);
> 	entry = list_last_entry();
> 	list_del(&entry->lru);
> 	zswap_entry_get(entry);
> 	spin_unlock(&pool->lru_lock);
> 
> 	/* Check for invalidate() race */
> 	spin_lock(&tree->lock);
> 	if (entry != zswap_rb_search(&tree->rbroot, swpoffset)) {
> 		ret = -EAGAIN;
> 		goto put_unlock;
> 	}
> 	spin_unlock(&tree->lock);

Eh, brainfart. It needs the tree lock to bump the ref, of course.

But this should work, right?

 	/* Check for invalidate() race */
 	spin_lock(&tree->lock);
 	if (entry != zswap_rb_search(&tree->rbroot, swpoffset)) {
 		ret = -EAGAIN;
 		goto unlock;
 	}
	zswap_entry_get(entry);
 	spin_unlock(&tree->lock);
