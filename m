Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB436D9F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbjDFRua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDFRu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F3E49CA;
        Thu,  6 Apr 2023 10:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC35960DF4;
        Thu,  6 Apr 2023 17:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC6DC433EF;
        Thu,  6 Apr 2023 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680803426;
        bh=N8h/IJ7vQs3LY2UE87u4CYmDFTFt5FQw7xX/wFLkIgg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CYWUCe4Y7g2BVX5eqHYLV40TSIcXpmdH4Sk4G/5UQah7nSIuPX0mIk9qHOFcwainr
         JJIaDmhCiTXfkm/Bko05DoxFDDLGIhiRkbkG6IZBvKz8rdugAicvqQX19/ku3bcuTF
         btcGrs8M1Y+OUp0LRNtjJc/qLztclhUI+xUzAHujP7WAf2XINA67RuCAcZ1o+5Olig
         MgE+6hoxHQKrhJ8b9dSkcNeGIySzlhcNF+f9XuWlKLgKN7uc5q9aA3ZMAj68nChFkF
         MxAszt2WtBaFhmCb8c/7/4z4K2IeYhqR387qxGVuJRhuN4gq0znSIyRaWH8JGRcxLJ
         5+F2ZZsT6zMvg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CCC4C15404B4; Thu,  6 Apr 2023 10:50:25 -0700 (PDT)
Date:   Thu, 6 Apr 2023 10:50:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Message-ID: <8da4b48a-820c-461f-9dc0-a5afaf335177@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230406001238.647536-1-qiang1.zhang@intel.com>
 <ZC5MoREk30MIt79u@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC5MoREk30MIt79u@pc636>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 06:37:53AM +0200, Uladzislau Rezki wrote:
> On Thu, Apr 06, 2023 at 08:12:38AM +0800, Zqiang wrote:
> > Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> > executed before kfree_rcu_monitor() to drain page cache, if the bnode
> > structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
> > page cache again in kfree_rcu_monitor(), this commit add a check
> > for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
> > if the krcp structure's->backoff_page_cache_fill is set, prevent page
> > cache growing.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 9cc0a7766fd2..f25430ae1936 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2907,6 +2907,8 @@ static inline bool
> >  put_cached_bnode(struct kfree_rcu_cpu *krcp,
> >  	struct kvfree_rcu_bulk_data *bnode)
> >  {
> > +	if (atomic_read(&krcp->backoff_page_cache_fill))
> > +		return false;
> >  	// Check the limit.
> >  	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
> >  		return false;
> > -- 
> > 2.32.0
> >
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you both!

One question, though.  Might it be better to instead modify the "for"
loop in fill_page_cache_func() to start at krcp->nr_bkv_objs instead
of starting at zero?  That way, we still provide a single page under
low-memory conditions, but provide rcu_min_cached_objs of them if memory
is plentiful.

Alternatively, if we really don't want to allow any pages at all under
low-memory conditions, shouldn't the fill_page_cache_func() set nr_pages
to zero (instead of the current 1) when the krcp->backoff_page_cache_fill
flag is set?  This would likely mean also breaking out of that loop if
krcp->backoff_page_cache_fill was set in the meantime (which happens
implicitly with Zqiang's patch).

Or am I missing something subtle here?

							Thanx, Paul
