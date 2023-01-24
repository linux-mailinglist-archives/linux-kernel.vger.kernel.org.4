Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7167A62D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAXWyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAXWyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:54:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6E43900
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:54:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8683E61383
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D6EC433EF;
        Tue, 24 Jan 2023 22:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674600889;
        bh=o4uL/Ie7bBAxgdc1EkRlmNDXqSGXOokKDmYGb35nUg8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O8+r9I2VRP4AnVr7kVaNG24QvG7zm4oYirm5+NrXMALDF1pCPBJSZSJtAPk+9l/Mz
         /1dev6jbRPQHKAOGxW/M3t9GJ+fGDv9wx/0XHWqBh6FPmGOaY8J2OPEC7B9I8Z0pZr
         wOwSSalBSqiThviI1uuRww7C+1rTWPL+XazPeXoji4Q/4zwoDm2pKZVl+97C0sm2IR
         3d7gh9gcNEnJPOgtVY9TgyPi6M8vCnDo1q1WwDnZ1w6kksFpTuqos1mJvzoend8II3
         nGTZ2VtaoCe116sgSviOVAsokc4gaQEO6O2704jJa92r/MKX36PhidSkIcAfHFchJw
         /rl+zRTSH95hg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C3865C1183; Tue, 24 Jan 2023 14:54:49 -0800 (PST)
Date:   Tue, 24 Jan 2023 14:54:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
Message-ID: <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8+8fH52iqQABYs2@andrea>
 <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
 <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
 <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 05:35:33PM -0500, Alan Stern wrote:
> On Tue, Jan 24, 2023 at 02:15:24PM -0800, Paul E. McKenney wrote:
> > > Ah, looking at the model now. Indeed it's forbidden, because in order to say
> > > that something is in co, there must not be a (resulting) cycle of co and
> > > barriers. But you'd get that here.  In the axiomatic model, this corresponds
> > > to saying Power's "prop | co" is acyclic. The same isn't true in LKMM. So
> > > that's probably why.
> > 
> > Which means that the RCU and SRCU implementations need to make (admittedly
> > small) guarantees that cannot be expressed in LKMM.  Which is in fact
> > what I was remembering, so I feel better now.
> > 
> > Not sure about the rest of you, though.  ;-)
> 
> Can you be more explicit?  Exactly what guarantees does the kernel 
> implementation make that can't be expressed in LKMM?

I doubt that I will be able to articulate it very well, but here goes.

Within the Linux kernel, the rule for a given RCU "domain" is that if
an event follows a grace period in pretty much any sense of the word,
then that event sees the effects of all events in all read-side critical
sections that began prior to the start of that grace period.

Here the senses of the word "follow" include combinations of rf, fr,
and co, combined with the various acyclic and irreflexive relations
defined in LKMM.

> And are these anything the memory model needs to worry about?

Given that several people, yourself included, are starting to use LKMM
to analyze the Linux-kernel RCU implementations, maybe it does.

Me, I am happy either way.

							Thanx, Paul
