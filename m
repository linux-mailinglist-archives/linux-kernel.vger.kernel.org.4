Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8C67BE25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbjAYVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAYVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:23:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA4345887
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEBB3B81BBC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 21:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596C2C433EF;
        Wed, 25 Jan 2023 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674681809;
        bh=QCdGrqD8UJo5cxOQpPF6bRpNm6pMH/vyFxkiVJ5VPCg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IABr23uypQNWfOhj8d1ld9CkCkPKVIpclY6Iy6suARflOuu6fb9RpDQ3npQXObrRp
         bSCXWeUBwo8uOPGCXVJeoTPzs8U8jTOE09j30+zu+u+TP5MTPonByHBQzDOQ2t2MWU
         1JPoswwx7xo4valcXnEzK4NjH3ehvx6wtIffIw0Zjru1Qbd/FBs34s6UfxllrXPGlT
         DNggAbvC+Pcf6Ng/8uINUZCSqs09S/2aFm2WRM3fXQAgJVcZjkT8nYJCfKa4SHaUZ4
         RBLNdUESlVnrnUkFrWVegW+j67Q2DaszFSbe9F+FeKjhXKqJ9uusGEUHjinQjtbRNr
         wXTm1g8mRiqww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01C065C0865; Wed, 25 Jan 2023 13:23:28 -0800 (PST)
Date:   Wed, 25 Jan 2023 13:23:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <20230125212328.GP2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GSuzHFdRfLeAAp@andrea>
 <f9f7a9b0-23c8-587f-61a9-ca4b0950ad1b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f7a9b0-23c8-587f-61a9-ca4b0950ad1b@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:10:32PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/25/2023 9:36 PM, Andrea Parri wrote:
> > > > Why do you want the implementation to forbid it?  The pattern of the
> > > > litmus test resembles 3+3W, and you don't care whether the kernel allows
> > > > that pattern.  Do you?
> > > Jonas asked a similar question, so I am answering you both here.
> > > 
> > > With (say) a release-WRITE_ONCE() chain implementing N+2W for some
> > > N, it is reasonably well known that you don't get ordering, hardware
> > > support otwithstanding.  After all, none of the Linux kernel, C, and C++
> > > memory models make that guarantee.  In addition, the non-RCU barriers
> > > and accesses that you can use to create N+2W have been in very wide use
> > > for a very long time.
> > > 
> > > Although RCU has been in use for almost as long as those non-RCU barriers,
> > > it has not been in wide use for anywhere near that long.  So I cannot
> > > be so confident in ruling out some N+2W use case for RCU.
> > Did some archeology...  the pattern, with either RCU sync plus a release
> > or with two full fences plus a release, was forbidden by "ancient LKMM":
> > the relevant changes were described in
> > 
> >    https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/WeakModel.html#Coherence%20Point%20and%20RCU
> > 
> >    Andrea
> 
> Fascinating! It says there "But the weak model allows it, as required" --
> what does "as required" mean? Just "as required by dropping the constraint"?

"As required by our reluctance to support it, given that all use cases
we have seen are traps for the unwary."

> Is there still a notion of "strong model" and "weak model", or was the
> strong model dropped?

The strong model was dropped.  The differences between them were
eventually small enough that it did not make sense to maintain two models.

							Thanx, Paul
