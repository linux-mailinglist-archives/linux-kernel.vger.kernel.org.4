Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5F764188C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 20:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLCTCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 14:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiLCTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 14:02:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9961BE86
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 11:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 552A3B807E5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 19:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E84C433C1;
        Sat,  3 Dec 2022 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670094147;
        bh=8dkLM7M1P2wZj0MlM9RjgcTcPtk8HlDDb1lmRYvte4w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R52709+kB7Ix490kdmBH+LTiTRF+OuF0ddO2roWUDKO/fTNuxDTt82Op7If+yAUst
         dHVtJwhgnClbve7h0/+tJrY2PkoLek8dcMqtNH6X1Vu8VBrXwviY6eGgASSes7V8+B
         VmJ/aHbNCsnRefZ4e7nwVI4rL/ewmX6ZrufJ5eSco2SsM/1Hff+FwnyiFeIarji1Y/
         lgsC0nStHMaQfOahtzNw+cU5AhrjbYBifGMLWC2bsONVNB9yYtwoeFb1TVe+/YEPWu
         WbDKXdHyPHIszzepBq54ZWuscOizzkg+f+whMpSDP8oRhUph5ex0LHAERj+h3CZ/1L
         3kTHqxG1+dG8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ADE895C03F8; Sat,  3 Dec 2022 11:02:26 -0800 (PST)
Date:   Sat, 3 Dec 2022 11:02:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4262e55407294a5989e766bc4dc48293@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 11:58:36AM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Boqun Feng [mailto:boqun.feng@gmail.com] 
> Sent: Friday, December 2, 2022 7:50 PM
> 
> > > Reviewed-by: Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> 
> > s/Reviewed-by: Reviewed-by:/Reviewed-by:^2 to save some space ? ;-)
> 
> 
> Oh, I didn't know I'm allowed to compress things like that! Can I use ² as well to save another character?

Heh!  I might miss that, and who knows?  The bots might think that "²"
was the first letter of your name.  ;-)

> > I wonder is this patch a first step to solve the OOTA problem you reported in OSS:
> >	https://static.sched.com/hosted_files/osseu2022/e1/oss-eu22-jonas.pdf
> > If so maybe it's better to put the link in the commit log I think.
> 
> It's not directly related to that specific problem, it does solve some other OOTA issues though.
> If you think we should link to the talk, there's also a video with slightly more updated slides from the actual talk: https://www.youtube.com/watch?v=iFDKhIxKhoQ
> do you think I should link to both then?

It is not hard for me to add that in if people believe that it should be
included.  But default is lazy in this case.  ;-)

							Thanx, Paul
