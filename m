Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA7F6736AE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjASLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjASLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:24:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842A71F06
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:23:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D062D61B83
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307C8C433D2;
        Thu, 19 Jan 2023 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674127435;
        bh=3lFUHRnmz0TyXZNkO1Fe02t8bWD12XHGw6NMyyyfs+E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PGIRNk6apWydgW7CPWjKgc6/lCQ1ZLoDqT/l1uWYOdaCcqamXu0P4hGejg8zxxpDT
         WRna4WHuRtXM+07v3SnVNMOy1mPTNV4TwM2bJYXMBFqKZkQzds4NbrtRAsyyK8Fd/n
         2u2ZSGZh9LJuJ6ld3o0unloKvGgc9bhkyWtM2OWSBbX0v+IVrT+kMqXzGnuDMdooyl
         KMG4V4irkQHvyhSGX+pdCFwmGuVSkfOGs8Vuwo0g7VEv5s/2gerUl9x5JhxjDh0gOX
         UGpDIzUq/goE0LFFro58/7UOZoOiHkMSu2zwko9oPOFn1DALumBOg9iohBSSx6DsDo
         XAfb40UBRDMpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BDCF75C0623; Thu, 19 Jan 2023 03:23:54 -0800 (PST)
Date:   Thu, 19 Jan 2023 03:23:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20230119112354.GP2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8iom6Mjz9rCX42A@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8iom6Mjz9rCX42A@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 09:19:07PM -0500, Alan Stern wrote:
> On Wed, Jan 18, 2023 at 04:02:14PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 18, 2023 at 03:54:47PM -0500, Alan Stern wrote:
> > > How does this differ from srcu_read_lock() and srcu_read_unlock()?  And 
> > > how do the "up" and "down" parts figure into it? -- what is going up or 
> > > down?
> > 
> > Functionally and from a performance/scalability viewpoint, they
> > are identical to srcu_read_lock() and srcu_read_unlock().  The only
> > difference is that srcu_down_read() and srcu_up_read() lack the lockdep
> > machinery that complains when a matching pair of srcu_read_lock() and
> > srcu_read_unlock() are used from different tasks.
> 
> This makes me wonder if there's any need for srcu_down_read and 
> srcu_up_read at all.  Why not just use srcu_read_lock and 
> srcu_read_unlock, and remove the lockdep check?

Because the lockdep check is quite helpful in finding bugs in the
common case.

> > Within the implementation, nothing ever goes down, it is all
> > this_cpu_inc().  The "down" and "up" are by analogy to down() and up(),
> > where "down()" says acquire some rights to a resource and "up()" says
> > release those rights.
> 
> Another reason not to use those names.  If you insist on making these 
> operations distinct from srcu_read_lock and srcu_read_unlock, why not 
> borrow the "_get" and "_put" nomenclature used by the device core?  I 
> suspect more people would associate them with acquiring and releasing 
> rights to a resource.  (Although in this case it might be so clear 
> exactly what that resource is.)
> 
> > Wait, I can make "down" work.
> > 
> > A call to srcu_down_read() reduces the quantity computed by summing the
> > unlocks then subtracting the sum of the locks.  A call to srcu_up_read()
> > increases that same quantity.  ;-)
> 
> I can't honestly call that a resoundingly convincing argument.  :-)

It is exactly the same argument for the name of down() and up().  ;-)

And the analogy between mutex_lock() and down() on the one hand an
srcu_read_lock() and srcu_down_read() should be helpful as well.

							Thanx, Paul
