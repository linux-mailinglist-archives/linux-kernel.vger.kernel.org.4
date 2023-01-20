Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE7E676168
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjATXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjATXTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:19:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397CE1B579
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:19:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D1F620DC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 23:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B21C433EF;
        Fri, 20 Jan 2023 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674256793;
        bh=yWD7ntNWcSE3R0lccAoklwR1EQkhDaJrjuoMjTFKiQk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AjR49bDOgiXhZ3bwiKM/nHN2YRPDdVvqIlcKEKCCVatqtstUKMo6sTAMlYYnfCbqm
         afIrFB4k9HwnElZnJm+IolIvWVNW5KN3M2hV842dEuMGmn/x371FLnDF+XQeo7dau9
         4bzouh5sLyZUSyjdeK6M00k1mMFhxWT8HcQFswVlkQsogz496JmKWLFenhQB6Ho1h9
         +GGQtPPRvFT9d3Pqi1l6QYk3B6ph3HrERKxr0s1xUodSmjdeSnm3Z3OY9JQ7vA2arW
         Oy2LH9Naf2lu8s2+gtE9zBZ2PPs3L6EsvSsZP8Te9Q+O+2iV7U8EJnX0hrIAe+On3e
         Fs835v02sM14Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B8E275C0DFC; Fri, 20 Jan 2023 15:19:52 -0800 (PST)
Date:   Fri, 20 Jan 2023 15:19:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20230120231952.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <c5902c18-e0cc-125e-c2f5-7971f0a7ce07@huaweicloud.com>
 <20230120153909.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <cc3686b3-b234-b0ee-4d2d-15f54da4331b@huaweicloud.com>
 <20230120213727.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <44a2c301-900e-90ea-4b21-e5264102e699@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a2c301-900e-90ea-4b21-e5264102e699@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:36:15PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/20/2023 10:37 PM, Paul E. McKenney wrote:
> > 
> > Just out of curiosity, are you [set] up to run LKMM locally at your end?
> 
> I don't know what exactly that means. I generally run it on wetware.
> But I sometimes ask Hernan to run Dat3M (on his machine) over all the litmus
> tests in your repo to spot any obvious problems with variations I consider.
> I don't think Dat3M is feature-complete with herd at the moment, just
> unbelievably faster. For example I think it ignores all flags in the cat
> files.
> Oh, I just remembered that I also installed herd7 recently to make sure that
> any patches I might send in satisfy herd7 syntax requirements (I think you
> called this diagnostic driven development?), but I haven't used it to really
> run anything.
> 
> Is it too obvious that my words usually aren't backed by cold machine logic?

Well, there was this in one of your messages from earlier today: "I'm not
going to get it right today, am I?"  And I freely confess that this led
me to suspect that you might not have been availing yourself of herd7's
opinion before posting.  ;-)

If you clone the Linux kernel source on a Linux system, the information
here should help you get started.  And we are of course here to help.

Your choice, just pointing out the option!

							Thanx, Paul
