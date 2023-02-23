Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DA6A08CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjBWMpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjBWMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:45:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F75254547;
        Thu, 23 Feb 2023 04:45:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC96D616C3;
        Thu, 23 Feb 2023 12:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1CDC433EF;
        Thu, 23 Feb 2023 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677156326;
        bh=QpPG3+Wu8ccorWaPBkI2z+kiKU4dfGwptAwsUJaAVZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHR4HxJj2PVLEM8O1gdbgIS/jVbfAba9wOTqooV1gXPY+1wELF/0tew9a2eiLAB9t
         PlEIB+agjJ+I5JNv/5qFi44O7aEMTmhs9snDnjxKxPEBElaZx+ycmv3DRbGTvIzNAZ
         dbs44meiT/1as2fAU0dyRwCqYcKIXmKq8NWrvMmh2uQRP6FtnhplrJzqUmsS4q+mDT
         maqD/2miTdl7B/FTNPAmfFEYdD74Y6v0TQsxsLoedhur+FORiiNsYoky5OppoNt4g4
         vqNF/hG4FCSfdeQW5B70yPnKclRfG1FIUXlOjZWK5iHJM31Z1aD5o0t3RPJIFiHdpp
         epLrOeCowMHFQ==
Date:   Thu, 23 Feb 2023 13:45:23 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <Y/df4xtTQ14w/2m4@lothringen>
References: <20230201150815.409582-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:08:06PM +0100, Uladzislau Rezki (Sony) wrote:
> This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
> it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
> 
> 1.
> The problem is that, recently we have run into a precedent when
> a user intended to give a second argument to kfree_rcu() API but
> forgot to do it in a code so a call became as a single argument
> of kfree_rcu() API.
> 
> 2.
> Such mistyping can lead to hidden bags where sleeping is forbidden.
> 
> 3.
> _mightsleep() prefix gives much more information for which contexts
> it can be used for.
> 
> Uladzislau Rezki (Sony) (13):
>   rcu/kvfree: Add kvfree_rcu_mightsleep() and kfree_rcu_mightsleep()
>   drbd: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
>   misc: vmw_vmci: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
>   tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
>   lib/test_vmalloc.c: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
>   net/sysctl: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
>   RDMA/rxe: Rename kfree_rcu() to kfree_rcu_mightsleep()
>   net/mlx5: Rename kfree_rcu() to kfree_rcu_mightsleep()
>   ext4/super: Rename kfree_rcu() to kfree_rcu_mightsleep()
>   ipvs: Rename kfree_rcu() to kfree_rcu_mightsleep()
>   rcuscale: Rename kfree_rcu() to kfree_rcu_mightsleep()
>   doc: Update whatisRCU.rst
>   rcu/kvfree: Eliminate k[v]free_rcu() single argument macro

Hi,

Not sure if you guys noticed but on latest rcu/dev:

net/netfilter/ipvs/ip_vs_est.c: In function ‘ip_vs_stop_estimator’:
net/netfilter/ipvs/ip_vs_est.c:552:15: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
   kfree_rcu(td);
               ^
net/netfilter/ipvs/ip_vs_est.c:552:3: error: ‘kfree_rcu’ undeclared (first use in this function); did you mean ‘kfree_skb’?
   kfree_rcu(td);
   ^~~~~~~~~
   kfree_skb
net/netfilter/ipvs/ip_vs_est.c:552:3: note: each undeclared identifier is reported only once for each function it appears in


Thanks.
