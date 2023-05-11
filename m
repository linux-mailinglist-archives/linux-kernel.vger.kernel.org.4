Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4DE6FF966
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbjEKSNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbjEKSNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:13:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456EE902C;
        Thu, 11 May 2023 11:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0E046507C;
        Thu, 11 May 2023 18:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358DFC433D2;
        Thu, 11 May 2023 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683828770;
        bh=Sq4O3A014qAbsBC1RgkEKaAWBs984WKm27JafM6ZmC0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qjzajRdy4KUUdZkl1bo/+cn2xFpFSA7PrzDz8hZvIsNcuYoo54JxXrD4uPrQcov0w
         ibbDWdSDa/Tmrneh3lyrZ8vUbMBXOunY+CGz253cIwU9x/2NHz6HSfv7ivYO+GeMp0
         IGKs9J3XF68jyd94nSoA0bXhccAOqlni7A9KdLSftzdTDrJIEBLhh4twxVCIiZAsrP
         zVqPGD5BbO9TppmQmvif8ZzROwI0YflF6UmpB/cvIXZuIejRbv3Cqu784F/nwXjcYH
         3rPoqvDos9b7+myS+uVx+/OWTsdXkEItDSNb+PZkhmr2AxVPNVzYA+7atd/t0mJL9o
         dnfaoBICJ/KwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D4E31CE0FED; Thu, 11 May 2023 11:12:49 -0700 (PDT)
Date:   Thu, 11 May 2023 11:12:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/6] Torture-test updates for v6.5
Message-ID: <04718ebd-8579-42c1-ade6-1928e98e83c8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
 <CAEXW_YTuDQPqsVYz8X-rCau1RSpUR9HBSmq+H8imHB0424Do6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTuDQPqsVYz8X-rCau1RSpUR9HBSmq+H8imHB0424Do6A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:48:21PM -0700, Joel Fernandes wrote:
> On Wed, May 10, 2023 at 10:12 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Hello!
> >
> > This series contains torture-test and torture-test-scripting updates
> > for v6.5:
> >
> > 1.      Add long_hold to adjust lock-hold delays.
> >
> > 2.      Correct name of use_softirq module parameter.
> >
> > 3.      rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup(),
> >         courtesy of Qiuxu Zhuo.
> >
> > 4.      rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading
> >         rcuscale, courtesy of Qiuxu Zhuo.
> >
> > 5.      doc/rcutorture: Add description of rcutorture.stall_cpu_block,
> >         courtesy of Zqiang.
> >
> > 6.      Remove duplicated argument -enable-kvm for ppc64, courtesy of
> >         Zhouyi Zhou.
> 
> Other than the small nits I mentioned, this series LGTM. Feel free to add:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I will do 1-4 and 6 right on my next rebase, and 5 once we come to
agreement.

							Thanx, Paul

>  - Joel
> 
> 
> >
> >                                                 Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> >  b/Documentation/admin-guide/kernel-parameters.txt                  |   12
> >  b/kernel/locking/locktorture.c                                     |   51 +-
> >  b/kernel/rcu/rcuscale.c                                            |  194 +++++-----
> >  b/tools/testing/selftests/rcutorture/bin/functions.sh              |    2
> >  b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot |    2
> >  b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot       |    2
> >  kernel/rcu/rcuscale.c                                              |    5
> >  7 files changed, 137 insertions(+), 131 deletions(-)
