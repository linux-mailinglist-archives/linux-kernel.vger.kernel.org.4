Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661F675F93
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjATVUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjATVUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:20:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869DBEC55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:20:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B1E06206E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFACC433D2;
        Fri, 20 Jan 2023 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674249637;
        bh=Yxu3NixxZ7KMRl7/GU6VsDiA6y9qJyUXAeTFwB6h9AE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bCzYcAibNMBXoH+zslduhUl95fBz2cz8XU3iesveBrq02b4Jv1hpsQvnxi9cL40Xo
         Seu/NbzhVOJdgAYRf1GBBgRimP7JeJIud6weJDaCsIJgKmQyy7S+Hj+S6KSlggYPF6
         dD1bj2PwXpHEzgssZ9OTsQbOd0aesJ2RlOnKxIbfvi2BPDsfNzErtMi9ueCFcJh8Oa
         SY1QS2PUpOuEDWImDtHzdCX8aJ9eOqsCB+s4VJat97YaaKq0a2PBz8YdMRCm+kLCW3
         hXpNpM7LDxe7x+W8I12QwxK1BFvDflyqC4Z5rYuWabZZ54EKV4gXzVBzrXUUPoPyeF
         Zzu9HbeobaBLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 117755C17DC; Fri, 20 Jan 2023 13:20:37 -0800 (PST)
Date:   Fri, 20 Jan 2023 13:20:37 -0800
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
Message-ID: <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <20230118200601.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
 <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:36:24PM -0500, Alan Stern wrote:
> On Fri, Jan 20, 2023 at 11:20:32AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 20, 2023 at 01:37:51PM -0500, Alan Stern wrote:
> > > srcu_read_unlock() does not need a full smp_mb().
> > 
> > That is quite possible, and that is what we are looking into.  And testing
> > thus far agrees with you.  But the grace-period ordering constraints
> > are quite severe, so this requires careful checking and severe testing.
> 
> If you're interested, I can provide a simple argument to show that the 
> Fundamental Law of RCU would continue to hold with only a release fence.  
> There is an added requirement: merely that synchronize_srcu() must have 
> an smp_mb() somewhere after its final read of the unlock counters -- 
> which your version of the algorithm already has.

Please!

For your amusement, here is a very informal argument that this is
the case:

https://docs.google.com/document/d/1xvwQzavmH474MBPAIBqVyvCrCcS5j2BpqhErPhRj7Is/edit?usp=sharing

See the "Read-Side Optimizations" section at the end.

							Thanx, Paul
