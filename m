Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D796B89BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCNEnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNEnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:43:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E616336;
        Mon, 13 Mar 2023 21:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A152DB815C6;
        Tue, 14 Mar 2023 04:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E66BC4339B;
        Tue, 14 Mar 2023 04:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678769016;
        bh=j0UbdKLqN7PL42qby+oAyPBxzwyH7KWgVYQ0X5bqS7o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HSgJGh+hQmqvJlnm/85VW0rC0EGTxwtt9+wIJoEQOxFjhqNZMBueE1B0LPX4AqrPH
         ntrOBeYLK8gDY3Yx+q1/tYOru5bU0rFZsxdcG6qNyR9xGya/UNa7HTdYtYXq6guDpP
         i+NnxOrzwbU515uVIh3rMm3NYLCBzVyEObNxIyBGgJMEKmCKxqCCG9obFd2IsxE5Ly
         1KHnJRvQDoTwemIchRGHRRACNiuI1RSsnvdB+77xP1A4OJmHNFSY84/jsEiDNC2gvo
         6nE8/SKHk5/bCpKqKWtylucj+/OISjqsztuHJeF9n3L+Po8HeByJCuPAbcBmZQQQ+N
         Poj22xw9dmyvQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C9F851540395; Mon, 13 Mar 2023 21:43:35 -0700 (PDT)
Date:   Mon, 13 Mar 2023 21:43:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rcu tree
Message-ID: <e6bc7d01-1889-4fa0-8ce5-80a10cdab2a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230314122922.43c81767@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314122922.43c81767@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:29:22PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> net/mac802154/scan.c: In function 'mac802154_scan_cleanup_locked':
> net/mac802154/scan.c:55:26: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
>    55 |         kfree_rcu(request);
>       |                          ^
> In file included from include/linux/rbtree.h:24,
>                  from include/linux/mm_types.h:11,
>                  from include/linux/buildid.h:5,
>                  from include/linux/module.h:14,
>                  from net/mac802154/scan.c:11:
> include/linux/rcupdate.h:984: note: macro "kfree_rcu" defined here
>   984 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>       | 
> net/mac802154/scan.c:55:9: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
>    55 |         kfree_rcu(request);
>       |         ^~~~~~~~~
>       |         kfree_skb
> net/mac802154/scan.c:55:9: note: each undeclared identifier is reported only once for each function it appears in
> net/mac802154/scan.c: In function 'mac802154_stop_beacons_locked':
> net/mac802154/scan.c:406:26: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
>   406 |         kfree_rcu(request);
>       |                          ^
> include/linux/rcupdate.h:984: note: macro "kfree_rcu" defined here
>   984 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>       | 
> net/mac802154/scan.c:406:9: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
>   406 |         kfree_rcu(request);
>       |         ^~~~~~~~~
>       |         kfree_skb
> drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_dereg_mr':
> drivers/infiniband/sw/rxe/rxe_mr.c:734:21: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
>   734 |         kfree_rcu(mr);
>       |                     ^
> In file included from include/linux/rculist.h:11,
>                  from include/linux/dcache.h:8,
>                  from include/linux/fs.h:8,
>                  from include/linux/highmem.h:5,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/bio.h:10,
>                  from include/linux/libnvdimm.h:14,
>                  from drivers/infiniband/sw/rxe/rxe_mr.c:7:
> include/linux/rcupdate.h:984: note: macro "kfree_rcu" defined here
>   984 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
>       | 
> drivers/infiniband/sw/rxe/rxe_mr.c:734:9: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
>   734 |         kfree_rcu(mr);
>       |         ^~~~~~~~~
>       |         kfree_skb
> drivers/infiniband/sw/rxe/rxe_mr.c:734:9: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   62a2ac23b35f ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")
> 
> I have used the rcu tree from next-20230310 for today.

Please accept my apologies -- I left out that revert.  I have pushed
out an rcu/next including it.

But I guess we now know for sure that this revert is still needed.  :-/

							Thanx, Paul
