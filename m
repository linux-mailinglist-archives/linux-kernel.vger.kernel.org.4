Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84C64192D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 22:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLCVQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 16:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLCVQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 16:16:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320751AF1E
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 13:16:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 54EEACE06B2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 21:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ED9C433C1;
        Sat,  3 Dec 2022 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670102186;
        bh=JClI+hqQBxDJPUkuVfdgAO6Wo8XBZAzJBsktxJdP6s4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pe//bJeo3H2Vy6co4pd0ptzKPA6ddBfaZPQRSWLPDwZpAdmMj8c2dsSiZPH/epTTn
         txMdVuH8rLM3+uq08kQi+vCf5xN8Rw/26+v3a+sTM293YdxZCDmtB4DL1yVSco+fQo
         ANn2GVk3HeqAwho80cdqsBbuRuwH6HE9IwZwIYIIU+3dGQxFDlFa/g23LXdD4zvQr+
         VoJZ2WsB8bZbbuN+FsSkBpbBqKKhDwY5LSGXrmMha09oKQeRkddJXwXZv0qfmcO8L9
         WRIAFNCLf1DZgw5ma0u/MBXTinDWYlwvREKF6Qy6ocFbch1p/ErrE7oPJ8/WwqUqq+
         iuUqz9WuSqg/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C761B5C146D; Sat,  3 Dec 2022 13:16:25 -0800 (PST)
Date:   Sat, 3 Dec 2022 13:16:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
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
Message-ID: <20221203211625.GX4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4u28nH82tJJdTGD@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4u28nH82tJJdTGD@boqun-archlinux>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 12:52:02PM -0800, Boqun Feng wrote:
> On Sat, Dec 03, 2022 at 12:44:05PM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 03, 2022 at 03:34:20PM -0500, stern@rowland.harvard.edu wrote:
> > > On Sat, Dec 03, 2022 at 11:02:26AM -0800, Paul E. McKenney wrote:
> > > > On Sat, Dec 03, 2022 at 11:58:36AM +0000, Jonas Oberhauser wrote:
> > > > > 
> > > > > 
> > > > > -----Original Message-----
> > > > > From: Boqun Feng [mailto:boqun.feng@gmail.com] 
> > > > > Sent: Friday, December 2, 2022 7:50 PM
> > > > 
> > > > > > I wonder is this patch a first step to solve the OOTA problem you reported in OSS:
> > > > > >	https://static.sched.com/hosted_files/osseu2022/e1/oss-eu22-jonas.pdf
> > > > > > If so maybe it's better to put the link in the commit log I think.
> > > > > 
> > > > > It's not directly related to that specific problem, it does solve some other OOTA issues though.
> > > > > If you think we should link to the talk, there's also a video with slightly more updated slides from the actual talk: https://www.youtube.com/watch?v=iFDKhIxKhoQ
> > > > > do you think I should link to both then?
> > > > 
> > > > It is not hard for me to add that in if people believe that it should be
> > > > included.  But default is lazy in this case.  ;-)
> > > 
> > > I don't think there's any need to mention that video in the commit log.  
> > > It's an introductory talk, and it's pretty safe to assume that anyone 
> > > reading the commit because they are interested in the LKMM in great 
> > > detail is already beyond the introductory level.
> > > 
> > > On the other hand, it wouldn't hurt to include a Link: tag to an 
> > > appropriate message in this email thread.  (I leave it up to Paul to 
> > > decide which message is most "appropriate" -- there may not be a good 
> > > candidate, because a lot of the messages were not CC'ed to LKML.)
> > 
> > For this approach, I would add this:
> > 
> > Link: https://lore.kernel.org/all/4262e55407294a5989e766bc4dc48293@huawei.com/
> > 
> > I could of course do both the extra paragraph -and- the Link:.  ;-)
> > 
> > Thoughts?
> > 
> 
> I think only having Link: is fine ;-) And I agree with Alan, no need to
> mention that video.

Very good, I will add the Link: on the next rebase.

And I will even refrain from adding the URL of the infamous "why not
both" video to this email.  ;-)

							Thanx, Paul
