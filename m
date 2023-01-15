Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41966AF76
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 06:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjAOFPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 00:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjAOFPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 00:15:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A9B749
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 21:15:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F77B60C49
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 05:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754E5C433D2;
        Sun, 15 Jan 2023 05:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673759710;
        bh=5vmQysSRGG1JUqC3uVHCOcQOj4MJv2E4/ezNrwKibCo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ONRCTXuY07WWcnn8AvLRpgxBuDM3vM3+U/0mY3vG1rAT7EpIE/eJEYqmZDMkVLW7I
         W6j5eo4MTq/bONWgrW45harvntcwgGgiIG/5FjxqnlPJNEjVlf7YnXg4ACA1X5wppJ
         BGSJyKe+TKOSqAxr/AbS1H3EVKr3dWAYE9dOLNO432fgFmLcI+tlBMRvj4x1s/BeaN
         TFHfD24wnJc+Fgi2yScNHfvOnRC2RFU3lLanCFOOSbdPNVP6fDVkFDI26WFaHJUiy3
         DiGKWV3mQdR8TuFk01AWh1qoAFeIKkHy4P7v0jUIDvLoDxysPtckcOX8htMn+QGXt9
         Ah1QVaSt+WiQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 138FA5C1109; Sat, 14 Jan 2023 21:15:10 -0800 (PST)
Date:   Sat, 14 Jan 2023 21:15:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
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
Message-ID: <20230115051510.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77QbG9lVXX9/B87@rowland.harvard.edu>
 <4c1abc7733794519ad7c5153ae8b58f9@huawei.com>
 <Y8GGmstFlgg91RMp@rowland.harvard.edu>
 <20230113200706.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230113203241.GA2958699@paulmck-ThinkPad-P17-Gen-1>
 <136d019d8c8049f6b737627df830e66f@huawei.com>
 <20230114175343.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230114181537.GA493203@paulmck-ThinkPad-P17-Gen-1>
 <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8MOOrrHntA9TyUk@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 03:19:06PM -0500, Alan Stern wrote:
> On Sat, Jan 14, 2023 at 10:15:37AM -0800, Paul E. McKenney wrote:
> > Nevertheless, here is the resulting .bell fragment:
> > 
> > ------------------------------------------------------------------------
> > 
> > (* Compute matching pairs of Srcu-lock and Srcu-unlock *)
> > let srcu-rscs = ([Srcu-lock] ; data ; [Srcu-unlock]) & loc
> > 
> > (* Validate nesting *)
> > flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> > flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> > 
> > (* Check for use of synchronize_srcu() inside an RCU critical section *)
> > flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> > 
> > (* Validate SRCU dynamic match *)
> > flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> 
> I forgot to mention...  An appropriate check for one srcu_read_lock() 
> matched to more than one srcu_read_unlock() would be something like 
> this:
> 
> flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-unlocks

I have added this, thank you!

> Alan
> 
> PS: Do you agree that we should change the names of the first two flags 
> above to unbalanced-srcu-lock and unbalanced-srcu-unlock, respectively 
> (and similarly for the rcu checks)?  It might help to be a little more 
> specific about how the locking is wrong when we detect an error.

I have made this change, again, thank you!

But I also added this:

flag empty srcu-rscs as no-srcu-readers

And it is always flagged.  So far, I have not found any sort of relation
that connects Srcu-lock to Srcu-unlock other than po.  I tried data,
ctrl, addr, rf, rfi, and combinations thereof.

What am I missing here?

							Thanx, Paul
