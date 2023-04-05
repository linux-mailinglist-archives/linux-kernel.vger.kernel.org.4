Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE86D8AD4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjDEW72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjDEW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:59:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21E82681;
        Wed,  5 Apr 2023 15:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71F7E6413B;
        Wed,  5 Apr 2023 22:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F0FC433D2;
        Wed,  5 Apr 2023 22:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680735564;
        bh=Ye1zE1pfeCNslE1DbHpdJQQZ3qQUU7wDAn8jX7EwPvI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cUzqGtmnfdKOw6ti5CfBJN2L0VUyGVraaH9vavCsAsESExMrM+4W8+y6Ae+bRK82u
         +DNb4mAsMeQbEyqenluQ32RNw+CjvjikiIlbe6ekE5pJQvsqTF8pwgUlRJgUuz+t15
         nRNX+IWyghRDIRj3lQ7VB/QWRwY6jo/CFAAkJGryc+gtDY3JeV9Vh7IL79THvNSlf6
         zJfwnnv/n2Z/Fn9/8J7HAx3TYGKfC2djP1Oj6tA8Mt+XbdnSXAFUlU/q5h4G8Nqb65
         QNXCIAbysqcc5BfkeVp5TcRSsF3zFf5r9xF4morDJLuWFVfmSYcehm7gTRgvTV8jNY
         YeG/0+BmD9/Zg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 627A515404B4; Wed,  5 Apr 2023 15:59:24 -0700 (PDT)
Date:   Wed, 5 Apr 2023 15:59:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ziwei Dai <ziwei.dai@unisoc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rcu tree
Message-ID: <66b7fceb-0a9d-42c1-987f-1ac6c857d987@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230406083619.65dee33a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406083619.65dee33a@canb.auug.org.au>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 08:36:19AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   acdc79917d65 ("rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period")
> 
> Fixes tag
> 
>   Fixes: 0392bebebf26 ("rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 
> Maybe you meant:
> 
> Fixes: 0392bebebf26 ("rcu: Add multiple in-flight batches of kfree_rcu() work")

Hello, Stephen,

There is currently some debate as to exactly which commit(s) introduced
the bug, which will hopefully come to a conclusion before tomorrow's
-next.  If they do not, I will use your correction as a placeholder.

Just for completeness, the current other two candidates (which appear
quite plausible to me) are these:

Fixes: 34c881745549 ("rcu: Support kfree_bulk() interface in kfree_rcu()")
Fixes: 5f3c8d620447 ("rcu/tree: Maintain separate array for vmalloc ptrs")

Ziwei Dai, what are your thoughts on this?  This is from a mainline
perspective, my guess being that your investigation involved some other
Linux-kernel tree.

							Thanx, Paul
