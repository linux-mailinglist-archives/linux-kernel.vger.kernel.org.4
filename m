Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D51D641919
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLCUoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiLCUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:44:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1341B783
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 12:44:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C68DB8074C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 20:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12941C433C1;
        Sat,  3 Dec 2022 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670100246;
        bh=a6sSeO9Fi0kBAh8kX/DYgBkC7uzxBTpsrsgIgsKcnSs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=awbXa8im7Dxz5yyeU6Sy40ZKJil74E9cydPOcJl8eZJVs9cVljHIMiVcXduDK82/Q
         +Nrr6npx7gN2eyMIwqZTfowklWixgLrF87iIRq2KcE1vwztOHlkJIbqQwseSXXQ2/q
         N1fw5yoEnTfERgtDBjsKT0E7sAa5b4WpSUSw+oF9ep/brUQm9n0f3rxIQf+inPSe56
         qHBCROlhGU60FEfKkxE0az8SaRl8OvAC7ypjEXbbFux1DQ4tLseFZvh8Iqe0EMRvkZ
         rzv09oIpWI+cvmfDkZo+mg2SinMEDq9B0Je+LlJCyAs9Fdk4liQMg/P3h7ixEk/DzP
         +OyP5d79qaPvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B50715C115F; Sat,  3 Dec 2022 12:44:05 -0800 (PST)
Date:   Sat, 3 Dec 2022 12:44:05 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 03:34:20PM -0500, stern@rowland.harvard.edu wrote:
> On Sat, Dec 03, 2022 at 11:02:26AM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 03, 2022 at 11:58:36AM +0000, Jonas Oberhauser wrote:
> > > 
> > > 
> > > -----Original Message-----
> > > From: Boqun Feng [mailto:boqun.feng@gmail.com] 
> > > Sent: Friday, December 2, 2022 7:50 PM
> > 
> > > > I wonder is this patch a first step to solve the OOTA problem you reported in OSS:
> > > >	https://static.sched.com/hosted_files/osseu2022/e1/oss-eu22-jonas.pdf
> > > > If so maybe it's better to put the link in the commit log I think.
> > > 
> > > It's not directly related to that specific problem, it does solve some other OOTA issues though.
> > > If you think we should link to the talk, there's also a video with slightly more updated slides from the actual talk: https://www.youtube.com/watch?v=iFDKhIxKhoQ
> > > do you think I should link to both then?
> > 
> > It is not hard for me to add that in if people believe that it should be
> > included.  But default is lazy in this case.  ;-)
> 
> I don't think there's any need to mention that video in the commit log.  
> It's an introductory talk, and it's pretty safe to assume that anyone 
> reading the commit because they are interested in the LKMM in great 
> detail is already beyond the introductory level.
> 
> On the other hand, it wouldn't hurt to include a Link: tag to an 
> appropriate message in this email thread.  (I leave it up to Paul to 
> decide which message is most "appropriate" -- there may not be a good 
> candidate, because a lot of the messages were not CC'ed to LKML.)

For this approach, I would add this:

Link: https://lore.kernel.org/all/4262e55407294a5989e766bc4dc48293@huawei.com/

I could of course do both the extra paragraph -and- the Link:.  ;-)

Thoughts?

							Thanx, Paul
