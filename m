Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8336729F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjARVGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjARVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:06:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5985EF9B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A78E761985
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023EAC433D2;
        Wed, 18 Jan 2023 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674076002;
        bh=HW/mdSWQSPYCTnuR5bMli1zWuIuU/FaraXxxcfaSjlE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B+rRVevPcxeDlD+WDvbFAbfswWm5YAH+HaDPsI/OyX5vueSCd/RFTRMIQsvhYQQXd
         wsYOkzcLgfqsfg9qIEu++6HhIDmWRD4yWKCM8CJVJZpS5cLbZfhdzj2qJBfacCWsTk
         u/5wLcZW6IZtyc0KavM1cRR2NKU2VJSdZmRTQIR7wfJD+z/QDUEYzlKkPuVgFj+4Ds
         KuECUl0MQ8qdMase3/yhp6YEos/ZnTXSg4OF8tzPszedzcn07y5e40REaDM+IZwX41
         YNptR34+36cDQpUTyZoslameRv1M1ouWsY0M7VURW5x8IToIo8Z9ZxkogQlAmU06JL
         sJWWzM6rCztEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 930885C0920; Wed, 18 Jan 2023 13:06:41 -0800 (PST)
Date:   Wed, 18 Jan 2023 13:06:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <s9joober@gmail.com>
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
Message-ID: <20230118210641.GK2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230116190652.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8WjmTFnqbAnS1Pz@rowland.harvard.edu>
 <20230116221357.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8aKlNY4Z0z2Yqs0@andrea>
 <20230117151416.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8bFMgDSUZymXUsS@rowland.harvard.edu>
 <20230117174308.GK2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8cBypKx4gM3wBJa@rowland.harvard.edu>
 <20230118035041.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <73ff21ef-44fa-2dbf-cae0-f74077875502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73ff21ef-44fa-2dbf-cae0-f74077875502@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 08:57:22PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/18/2023 4:50 AM, Paul E. McKenney wrote:
> > On Tue, Jan 17, 2023 at 03:15:06PM -0500, Alan Stern wrote:
> > > On Tue, Jan 17, 2023 at 09:43:08AM -0800, Paul E. McKenney wrote:
> > > > On Tue, Jan 17, 2023 at 10:56:34AM -0500, Alan Stern wrote:
> > > > > Isn't it true that the current code will flag srcu-bad-nesting if a
> > > > > litmus test has non-nested overlapping SRCU read-side critical sections?
> > > > Now that you mention it, it does indeed, flagging srcu-bad-nesting.
> > > > 
> > > > Just to see if I understand, different-values yields true if the set
> > > > contains multiple elements with the same value mapping to different
> > > > values.  Or, to put it another way, if the relation does not correspond
> > > > to a function.
> > > As I understand it, given a relation r (i.e., a set of pairs of events),
> > > different-values(r) returns the sub-relation consisting of those pairs
> > > in r for which the value associated with the first event of the pair is
> > > different from the value associated with the second event of the pair.
> > OK, so different-values(r) is different than (r \ id) because the
> > former operates on values and the latter on events?
> 
> I think you can say that (if you allow yourself to be a little bit loose
> with words, as I allow myself to be, much to the chagrin of Alan :) :( :)).

Well, Alan's insistance on rigor has keep LKMM out of trouble more times
than I can count.  ;-)

> If you had a .value functional relation that relates every event to the
> value of that event, then
>    different-values(r) = r \ .value ; .value^-1
> i.e., it relates events x and y iff: 1) r relates x and y, and 2) the value
> of x is not equal to the value of y.
> 
> You could write this as
>    different-values(r) = r \ .value ; value-id ; .value^-1
> where value-id is like id but for values, i.e., relates every value v to
> itself.
> 
> You could say that this difference operates on the values of the events,
> rather than on the events itself.
> In contrast,
>     r \ id
> works directly on the events and relates x and y iff: 1) r relates x and y,
> and 2) the event x is not equal to the event y.
> 
> In this sense I think your characterization is appropriate.

It looks to be "different domain values", but maybe I should just run
some experiments.  ;-)

							Thanx, Paul
