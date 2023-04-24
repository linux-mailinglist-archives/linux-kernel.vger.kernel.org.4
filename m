Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE46ED39C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjDXRgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjDXRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2D900E;
        Mon, 24 Apr 2023 10:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56A562770;
        Mon, 24 Apr 2023 17:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DA6C433D2;
        Mon, 24 Apr 2023 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682357754;
        bh=aLtMvp4ULEMd8pl1Q8wn1UwIesflr0PbMKXka8Q/Qb0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=flz29u61LJHfAaR/NpMlAxxSBgcG5GROzPKresGaqDLCRMs+SS6vVJnbQS+rD4DBz
         BdsrjZNTXOIk97UXe6c6uMpok/gxUhU9kghbm/9HXINqh5HlcZi6Zz7LbtgB6WAJkW
         na84K40jnXAnAwB4UWAony876EhDMjLj0aamWYkluoZl9aZH6DDA/5o+yVtfVjYErV
         a04kpt6U9tj60ldPyCJSUVqoiizRn8fX17oUHuJLLgqvjMt7S6GXgE0p58igl3qziy
         PjsiKDPSBvDzlXT7Pqs4hf+sGwllEPX1gV4z22vOKBPrpL/4tCXuuGIRF3caH0zBre
         CyiNWjsj0C7vw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AE7F115404E7; Mon, 24 Apr 2023 10:35:53 -0700 (PDT)
Date:   Mon, 24 Apr 2023 10:35:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kvfree: Make drain_page_cache() call return
 directly if cache is disabled
Message-ID: <4281adc2-ebb9-4595-9b21-e773bda35f7b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230418122702.1378299-1-qiang1.zhang@intel.com>
 <ZEEcsyn27ssrdfh6@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEEcsyn27ssrdfh6@pc636>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 01:06:27PM +0200, Uladzislau Rezki wrote:
> On Tue, Apr 18, 2023 at 08:27:02PM +0800, Zqiang wrote:
> > If the rcu_min_cached_objs is set to zero at boot params, the
> > krcp->page_cache_work will not be triggered to fill page cache,
> > and the put_cached_bnode() also does not fill page cache, this
> > also means the krcp->bkvcache is always empty, so not need to
> > acquire unnecessary krcp->lock to get page from krcp->bkvcache,
> > this commit therefore make drain_page_cache() return directly if
> > the rcu_min_cached_objs is zero.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 93faf9f5c58f..00620a2117de 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2924,6 +2924,9 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
> >  	struct llist_node *page_list, *pos, *n;
> >  	int freed = 0;
> >  
> > +	if (!rcu_min_cached_objs)
> > +		return 0;
> > +
> >  	raw_spin_lock_irqsave(&krcp->lock, flags);
> >  	page_list = llist_del_all(&krcp->bkvcache);
> >  	WRITE_ONCE(krcp->nr_bkv_objs, 0);
> > -- 
> > 2.32.0
> > 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued for further testing and review, thank you both!

						Thanx, Paul
