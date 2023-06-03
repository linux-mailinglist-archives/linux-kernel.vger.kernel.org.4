Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE9E72139C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 00:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFCWMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 18:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFCWMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 18:12:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BC180
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 15:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D37261AFA
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84544C433EF;
        Sat,  3 Jun 2023 22:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685830320;
        bh=jpeH9rx2zZzB4RiHqV0kksbiAHU3D6F5ouScc/FkzC0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ifkCQljpGrgjmq+X9MiykgcRX9Inzphx0outp5C0ouf9NClda7WyK4Iwvr8ZTQ3tW
         psq+ByEkH5GjAYDrNb5xWVDuozR84+U+Qoo8hHQPmDK0xwiTYMCJrYpZzZoQeAgGoL
         wl1wR27DogwAURFzYbnE2toQvOQa8jjnKUocYUR1H8pbfG/SLzldwJ4sZaVUk4fHqE
         N5YLWNLdc8Kzd2E1NR7RX3c0siHC9DQ55pfJGeDUWhcP/t356ejT8HnRIBzglkjK6B
         rXaKgLilUzMCQ0WmgGCl8LeKv8GtnvUgFqigOTvvYR/pcxspFEMHJS7832dM/feCQf
         COEXUFms3xp/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0C3EFCE1B88; Sat,  3 Jun 2023 15:12:00 -0700 (PDT)
Date:   Sat, 3 Jun 2023 15:12:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] torture: Add lock_torture_writer_fifo module param
Message-ID: <eab0825c-28ef-4ae4-aac7-e3dad4bc4de4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230602220221.600774-1-jstultz@google.com>
 <20230602220221.600774-2-jstultz@google.com>
 <c2415658-de0e-4497-889a-d5401cbc134a@paulmck-laptop>
 <zzteweboj3hmif5akuxxokyvu6truhy3ygh6w5nwb26zxjlqgs@uqzxhzx3eim7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zzteweboj3hmif5akuxxokyvu6truhy3ygh6w5nwb26zxjlqgs@uqzxhzx3eim7>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 10:34:14AM -0700, Davidlohr Bueso wrote:
> On Sat, 03 Jun 2023, Paul E. McKenney wrote:
> 
> > On Fri, Jun 02, 2023 at 10:02:10PM +0000, John Stultz wrote:
> > > From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > 
> > > Modifies locktorture writer to run as RT task.
> > > 
> > > To use it:
> > > insmod /lib/modules/torture.ko random_shuffle=1 lock_torture_writer_fifo=1
> > >                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3
> > > 
> > > This patch has been helpful to uncover issues with the proxy-execution
> > > seires.
> > > 
> > > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Cc: kernel-team@android.com
> > > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > [jstultz: Include header change to build, reword commit message]
> > > Signed-off-by: John Stultz <jstultz@google.com>
> > 
> > Queued and pushed, thank you all!
> 
> Both look good to me. Feel free to add my:
> 
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul
