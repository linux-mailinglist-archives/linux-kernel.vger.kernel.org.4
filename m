Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CBF64188E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 20:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLCTE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 14:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiLCTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 14:04:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C1D1D678
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 11:04:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A728960C22
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 19:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F72C433C1;
        Sat,  3 Dec 2022 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670094293;
        bh=3AwdSHXnpRZyvP1HR2jenkFii0Q4NqtArbfX1c3WRzQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KeLGHLpfE/7rC6NhVvL8cXjvMs/UBupXzr1dcTx2wAtrlCoPgLQ9iofEQOgpNEFSk
         3pJJBoP/tQOq7wIbckkvdw1e5qlnhBAJng5QwjkiPMi96o5TPFpa9qM/Ws7K9BWpTc
         RDm1wHnHYRoMA/15GWjAKsD6ywvJFFv50xy/zkkGXUPlOCRgGblmfv9DryxxqwTruK
         inhKlbLTBBEG+pGzm5mEOSgSZ0ScoG/URGyBj6yYoNqVIXWl290TRrbwJ2uGKz8HXC
         CBXDPKjwPnWUpJcUvRlsE1tAwLGW5BB+WL1aiIcQ99PA58eFch3HYCOwYf3WDb399b
         EWFpvIbTnv9MA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9A7425C03F8; Sat,  3 Dec 2022 11:04:52 -0800 (PST)
Date:   Sat, 3 Dec 2022 11:04:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
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
Subject: Re: [PATCH] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <20221203190452.GS4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
 <Y4jQC9ejAQqJFTo+@rowland.harvard.edu>
 <6abbb72eef6149eb842a3351ecea7af5@huawei.com>
 <Y4kMskpQGOvlPyYf@rowland.harvard.edu>
 <4905c14d2bc547a391d626416a20a2e9@huawei.com>
 <Y4pec7lfQHwmH4V/@rowland.harvard.edu>
 <bcacee1a2ce84123a664d783d108050e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcacee1a2ce84123a664d783d108050e@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 11:47:06AM +0000, Jonas Oberhauser wrote:
> 
> 
> -----Original Message-----
> From: Alan Stern [mailto:stern@rowland.harvard.edu] 
> Sent: Friday, December 2, 2022 9:22 PM
> 
> > > void *y[2];
> > > void *x[2] = { (void*)&y[1], (void*)&y[0] };
> > > 
> > > P0() {
> > >     void **t = (void**)(x[0]);
> 
> > Now t holds a pointer to y[1].
> 
> Unfortunately, this kind of inductive reasoning (arguing about what happens based on what happened "before") is not possible with memory models that allow OOTA; as you put it, one must allow for loads reading from stores that haven't happened yet.
> One such store (I promise!(*)) is a store to x[0] which writes &x[1]. Let's consider the alternative universe where we read from this future store, so now t holds a pointer to x[1].
> 
> > >     *t = (void*)(t-1);
> 
> > And now y[1] holds a pointer to y[0].
> 
> In our alternative universe, x[1] now holds a pointer to x[0].
> 
> 
> > > }
> > > P1() {
> > >     void **u = (void**)(x[1]);	
> 
> > Now u holds a pointer to y[0].
> 
> In our alternative universe, u holds the pointer to x[0] stored by P0().
> 
> > >     *u = (void*)(u+1);
> 
> > And now y[0] holds a pointer to y[1].
> 
> In our alternative universe, now x[0] holds a pointer to x[1]. Behold, the store I promised would happen!
> 
> > > }
> 
> > The contents of x[] never get changed, so there's no question about the values of t and u.
> 
> They might get changed, by the stores *t=... and *u=...
> 
> Have fun,
> Jonas
> 
> (*= because this example is provided free of charge, there is no actual promise, to the extent permitted by applicable law)

And another reason why I tend to err on marking more accesses rather
than marking fewer.  You never know when some "clever" compiler writer
might add a really strange optimization...

							Thanx, Paul
