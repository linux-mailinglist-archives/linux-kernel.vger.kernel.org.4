Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DF6A470E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjB0QdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjB0QdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:33:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7327B9019;
        Mon, 27 Feb 2023 08:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 054D560EC7;
        Mon, 27 Feb 2023 16:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5904CC433EF;
        Mon, 27 Feb 2023 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677515579;
        bh=f1Fr1fYw7pvtqZ1yiDOXJkxWTORO3SixZD7z4JnWmWo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=goIy9zdms5dQt0ZE53OyEZD85rc3qdoi+foOuHwHcyqwJqqNliGRFMAxth2fJ5ReV
         FdyS/gWaKw1YYhTWRVeZ5U75yTDkCJ4Kn+4OmMsHiTSNCjYIq3UnTY+gL0v18jTIEJ
         j4cXsyxhTVH7bQ7EsGcrl88Knw3Nl1x6A9/RwScb3V794iE1P+mWMRs1ivK4DEPcL4
         Ze01n5MGBG4lbyCW4xuglIzOVtZ5BDnFUNfhXUsN4GsPRvPh3oR6CU/dC5q8yWn35K
         YhesXa+Xffl+QcbFjTYAYu79TKhqbiMyM9oHd6FEEu0Jr1zEI0888J2LdHhRdAL6/8
         PYiIAB70WcvJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E45CC5C0267; Mon, 27 Feb 2023 08:32:58 -0800 (PST)
Date:   Mon, 27 Feb 2023 08:32:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        contact@pgazz.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
Message-ID: <20230227163258.GF2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
 <20230227103257.4b99b6fb@gandalf.local.home>
 <CAEXW_YT6_cSaEODPu3HLWUB5kJhs6U=CQrQ4v4ODKtk-D+Bzug@mail.gmail.com>
 <CAABZP2zZHQ22MPsWkPZ5kPW5SNDPt0mT37xw3f4VNLeBsxRPvw@mail.gmail.com>
 <20230227111626.463b8f85@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227111626.463b8f85@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:16:26AM -0500, Steven Rostedt wrote:
> On Tue, 28 Feb 2023 00:11:51 +0800
> Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> 
> > > Yes certainly, the rcu_head is allocated on the caller side so it
> > > could have been trampled while the callback was still in flight.  
> > Thank you all for your guidance, I learned a lot during this process
> > >  
> > > > OR it could be a bug with RCU if the synchronize_rcu() ended before the
> > > > grace periods have finished.  
> > Thanks again.
> > 
> > By the way, the syzkaller on my local machine has been running for 8
> > hours, only three bugs reported[1][2][3], but they don't seem to be
> > related to Sanan's original report.
> > Maybe there are some configuration mismatches between us.The test
> > continues,  I will report to you once I have any new discovery.
> 
> Note, the above races (either bug, the one that tramples on something in
> RCU flight, or a synchronize_sched() returning early) may be extremely hard
> to hit. It could have been the planets were lined up just right to hit the
> bug, and won't happen for another 27,000 years.

Which turns into once per week or two across a million-system fleet.  ;-)

Not that I know of any fleets running syzkaller...

							Thanx, Paul
