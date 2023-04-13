Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B06E149B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDMSub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDMSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D27F8689;
        Thu, 13 Apr 2023 11:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C20464117;
        Thu, 13 Apr 2023 18:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE51DC433D2;
        Thu, 13 Apr 2023 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681411816;
        bh=PbL5LVxYWgnidihBNDKgX44XtLeAt25eZkCG+K3ymgA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kTBvfbHQelMgXq8VBR7p4b1anEo1Ef9sdSdLxYDbAdJgPZ+x8KDYjyYnk1dnOIqtA
         NmgF6kpadzpiOhKV6nXUq2bNxSTqaE1gkeMWeCGDfuHxPUFwPnpO+buUPmfUWKO0pE
         mr+DP+aAiCt3yH0ISNXg/DWwmT+8oZm2sGxE1mQa3W79gLP/XNIDzCsXgrhYrl9Q09
         KEhBh+iVipHLePO8M3wkThW+FewCWHBhhrxOXD6lx/NK9QIVbLOoJvMiThQQcHEme+
         j6eb/SL5MAhHeZehhECphAGTBg1oMhbRrSpTTty+JFLl32HGc0BcAg+O9ZKGmPIDLm
         eUwhm4stMFtAg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4FD9F15404B3; Thu, 13 Apr 2023 11:50:16 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:50:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/kvfree: Make fill page cache start from
 krcp->nr_bkv_objs
Message-ID: <56ffa1b8-578b-402c-86eb-2d3a05235896@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230412143127.1062367-1-qiang1.zhang@intel.com>
 <ZDfGPQfFhMdajJRC@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDfGPQfFhMdajJRC@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:07:09AM +0200, Uladzislau Rezki wrote:
> On Wed, Apr 12, 2023 at 10:31:27PM +0800, Zqiang wrote:
> > The fill_page_cache_func() is invoked and start from zero to
> > allocate nr_pages of page, if the kfree_rcu_work() executes before
> > the fill_page_cache_func(), the krcp->nr_bkv_objs is updated before
> > enter for-loop and equal to nr_pages, since the page is allocated
> > first, and then check the krcp->nr_bkv_objs in put_cached_bnode(),
> > this produces a meaningless __get_free_page() call, this commit
> > therefore make allocate page start from krcp->nr_bkv_objs and
> > check krcp->nr_bkv_objs before allocate page.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 41daae3239b5..dcb86f9f2dd6 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3223,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
> >  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
> >  		1 : rcu_min_cached_objs;
> >  
> > -	for (i = 0; i < nr_pages; i++) {
> > +	for (i = READ_ONCE(krcp->nr_bkv_objs); i < nr_pages; i++) {
> >  		bnode = (struct kvfree_rcu_bulk_data *)
> >  			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
> >  
> > -- 
> > 2.32.0
> > 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued and pushed, thank you both!

							Thanx, Paul
