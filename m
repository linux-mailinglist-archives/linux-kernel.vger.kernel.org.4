Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315B46A0D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjBWPyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBWPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:54:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D1521E1;
        Thu, 23 Feb 2023 07:54:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3F5EB81A2C;
        Thu, 23 Feb 2023 15:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C060C433D2;
        Thu, 23 Feb 2023 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677167655;
        bh=0igkCLN8UIKJ+cS/Hik80+ovdbMq4awNwBfAghEIzLI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JTvI/mjqp8sxYZzFfOT/Nc5dCpnMV236H2yjhmUpss6FTlodJnd85LQ78JK3v0pJE
         NHMCynh6Oop8yVtNRjkPeR0KAiqZn5+gkCv/g8kn4iQKJhfJVt/69IFep9Ol1ZkYYQ
         pUZYriqjosqxuDAKvcWGBU5TcUvkTRPKyKkZpeCF189h2aQs4PLBctNhsggp3yr2uJ
         ayarw6aUDIX2CucLCi7t5NCulWn47tIsd2yzU+GaHeAPoKQcy87fIYAZMShRXdf+03
         J0z+VuL0ojAVlgEBhZILHE1xxY93JrvBsBbws+jCmS46mx/RdbmYy11PLfYX8dv3Sn
         msG1ZX3LyIksA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1EF7C5C0DBB; Thu, 23 Feb 2023 07:54:15 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:54:15 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        pablo@netfilter.org
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230223155415.GA2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <Y/df4xtTQ14w/2m4@lothringen>
 <IA1PR11MB6171CE257AC58265B8B7CC9889AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR11MB6171CE257AC58265B8B7CC9889AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 02:29:42PM +0000, Zhuo, Qiuxu wrote:
> > From: Frederic Weisbecker <frederic@kernel.org>
> > Sent: Thursday, February 23, 2023 8:45 PM
> > To: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Cc: LKML <linux-kernel@vger.kernel.org>; RCU <rcu@vger.kernel.org>; Paul
> > E . McKenney <paulmck@kernel.org>; Oleksiy Avramchenko
> > <oleksiy.avramchenko@sony.com>; Jens Axboe <axboe@kernel.dk>; Philipp
> > Reisner <philipp.reisner@linbit.com>; Bryan Tan <bryantan@vmware.com>;
> > Steven Rostedt <rostedt@goodmis.org>; Eric Dumazet
> > <edumazet@google.com>; Bob Pearson <rpearsonhpe@gmail.com>; Ariel
> > Levkovich <lariel@nvidia.com>; Theodore Ts'o <tytso@mit.edu>; Julian
> > Anastasov <ja@ssi.bg>
> > Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
> > k[v]free_rcu_mightsleep()
> > 
> > On Wed, Feb 01, 2023 at 04:08:06PM +0100, Uladzislau Rezki (Sony) wrote:
> > > This small series is based on Paul's "dev" branch. Head is
> > > 6002817348a1c610dc1b1c01ff81654cdec12be4
> > > it renames a single argument of k[v]free_rcu() to its new
> > k[v]free_rcu_mightsleep() name.
> > >
> > > 1.
> > > The problem is that, recently we have run into a precedent when a user
> > > intended to give a second argument to kfree_rcu() API but forgot to do
> > > it in a code so a call became as a single argument of kfree_rcu() API.
> > >
> > > 2.
> > > Such mistyping can lead to hidden bags where sleeping is forbidden.
> > >
> > > 3.
> > > _mightsleep() prefix gives much more information for which contexts it
> > > can be used for.
> > >
> > > Uladzislau Rezki (Sony) (13):
> > >   rcu/kvfree: Add kvfree_rcu_mightsleep() and kfree_rcu_mightsleep()
> > >   drbd: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
> > >   misc: vmw_vmci: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
> > >   tracing: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
> > >   lib/test_vmalloc.c: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
> > >   net/sysctl: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
> > >   RDMA/rxe: Rename kfree_rcu() to kfree_rcu_mightsleep()
> > >   net/mlx5: Rename kfree_rcu() to kfree_rcu_mightsleep()
> > >   ext4/super: Rename kfree_rcu() to kfree_rcu_mightsleep()
> > >   ipvs: Rename kfree_rcu() to kfree_rcu_mightsleep()
> > >   rcuscale: Rename kfree_rcu() to kfree_rcu_mightsleep()
> > >   doc: Update whatisRCU.rst
> > >   rcu/kvfree: Eliminate k[v]free_rcu() single argument macro
> > 
> > Hi,
> > 
> > Not sure if you guys noticed but on latest rcu/dev:
> > 
> > net/netfilter/ipvs/ip_vs_est.c: In function ‘ip_vs_stop_estimator’:
> > net/netfilter/ipvs/ip_vs_est.c:552:15: error: macro "kfree_rcu" requires 2
> > arguments, but only 1 given
> >    kfree_rcu(td);
> >                ^
> > net/netfilter/ipvs/ip_vs_est.c:552:3: error: ‘kfree_rcu’ undeclared (first use in
> > this function); did you mean ‘kfree_skb’?
> >    kfree_rcu(td);
> >    ^~~~~~~~~
> >    kfree_skb
> > net/netfilter/ipvs/ip_vs_est.c:552:3: note: each undeclared identifier is
> > reported only once for each function it appears in
> 
> Hi Frederic Weisbecker,
> 
> I encountered the same build error as yours. 
> Per the discussion link below, the fix for this build error by Uladzislau Rezki will be picked up by some other maintainer's branch?
> @Paul E . McKenney, please correct me if my understanding is wrong. 😊
> 
>     https://lore.kernel.org/rcu/Y9qc+lgR1CgdszKs@salvia/

Pablo and Julian, how are things coming with that patch?

							Thanx, Paul
