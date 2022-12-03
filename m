Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F47641911
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLCUki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLCUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:40:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB217E06
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 12:40:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CDD260BD3
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 20:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F80C433D6;
        Sat,  3 Dec 2022 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670100032;
        bh=5x9goMj3ddiVFXs77tq1IPKAlFLBkfJKotzqz6MsJn8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B/sMehKwyYYABxUEY3kF3BTbEvVFLqt6yNoz1tRVMaLNV4qJaBj+tnA3rv8WnU2ZS
         i1R1LrVoh9y+Psf2Lv1MtUoJ07SFQkTWhp8VaTHbu3+mdACVA+dz76TPGbPQxgdNi9
         NERI0aqWQXNtCIxYbNYio7InZJrUh98pMNwvv6KzqCMHqA96i38lIj2CJLVF/dXVDk
         oB71dw7buZvg9X0lyRg7oBmwCW0bKcCEwg5ksx07Zyq0JI03VTGAStUVAFeYfc+l2/
         8enP8QfmLJcGUytmd9dMnNnQh1g4MBUwd3bruyZpBsL1aO+ch+r9ZhaLU8ZfHST+gf
         +y/FFplGUxY1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5AFB85C115F; Sat,  3 Dec 2022 12:40:32 -0800 (PST)
Date:   Sat, 3 Dec 2022 12:40:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
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
Message-ID: <20221203204032.GV4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uuJS6dAuRT7t6r@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4uuJS6dAuRT7t6r@boqun-archlinux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 12:14:29PM -0800, Boqun Feng wrote:
> On Sat, Dec 03, 2022 at 11:02:26AM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 03, 2022 at 11:58:36AM +0000, Jonas Oberhauser wrote:
> > > 
> > > 
> > > -----Original Message-----
> > > From: Boqun Feng [mailto:boqun.feng@gmail.com] 
> > > Sent: Friday, December 2, 2022 7:50 PM
> > > 
> > > > > Reviewed-by: Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > > s/Reviewed-by: Reviewed-by:/Reviewed-by:^2 to save some space ? ;-)
> > > 
> > > 
> > > Oh, I didn't know I'm allowed to compress things like that! Can I use ² as well to save another character?
> > 
> > Heh!  I might miss that, and who knows?  The bots might think that "²"
> > was the first letter of your name.  ;-)
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
> > 
> 
> I brought this up because, as we recently experience in RCU code, we
> need answers of "why we did this?" to the future us ;-)
> 
> I agree with Alan, this seems like a good idea, but having some big
> picture of why we do this may be better.

Fair enough!

How about something like this as a new paragraph at the end of
the commit log?

						Thanx, Paul

------------------------------------------------------------------------

For more on LKMM and dependencies, please see this Open Source Summit
talk:  https://www.youtube.com/watch?v=iFDKhIxKhoQ
