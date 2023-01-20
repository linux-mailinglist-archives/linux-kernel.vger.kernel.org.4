Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B077675FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjATVk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:40:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247E64F344
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:40:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F8F62093
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F466C433EF;
        Fri, 20 Jan 2023 21:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674250856;
        bh=t6cCzOyUtRE4Sv+OM5VqdeIXfQyGfsPKwTULAq1p5/g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p1Y6XrFGH3a99aaKrRy97Tji5dsHti1uTGRbs5aQBjMY2gAFRvDUvkbq1y6JQGkJ9
         FLg8OnuHSjB2kUQQ7jJmQB9lxcJR1n5U5la8hxLQkRwVgFlCH1T1ZlfmInQafv/FFe
         mFPggckIt+hXrlmkKWy2pmklNkL/WMeo3TU9bkVezsrJ/WUyb28l0l2TKL8tJZbTb7
         l2kIUME+P8YIIDpP0tON4F7lRHfTfcEzar9brNuJ+Ylz4RPIPPpg9TpWbbi7untD0o
         xAMyQKM7lbkQyL/8AcU9VXQ1OjZ7Vq0mCxJXuwqx9UiLvEO/zj6i32xp1+KC7/QRVM
         7V50ABW+zZHow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A79C15C08A4; Fri, 20 Jan 2023 13:40:55 -0800 (PST)
Date:   Fri, 20 Jan 2023 13:40:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
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
Message-ID: <20230120214055.GY2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230120035521.GA319650@paulmck-ThinkPad-P17-Gen-1>
 <126e32b7-caa7-0a1e-4589-885aef7c5a39@huaweicloud.com>
 <fbbd5a65-7f93-ba5e-d8a6-236d9af43c47@huaweicloud.com>
 <20230120153242.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <f2ee717f-586f-7ffe-7729-64c88ab36cad@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2ee717f-586f-7ffe-7729-64c88ab36cad@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:56:36PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/20/2023 4:32 PM, Paul E. McKenney wrote:
> > On Fri, Jan 20, 2023 at 01:51:01PM +0100, Jonas Oberhauser wrote:
> > > I'm not going to get it right today, am I?
> > Believe me, I know that feeling!  Open-source development is therefore
> > an extremely good character-building exercise.  At least that is what
> > I keep telling myself.  ;-)
> 
> "Calvin, go do something you hate! Being miserable builds character!"

Heh!  There is the school of thought that says that if children
automatically did everything that they needed to do, they would not
need parents.  Now about adults doing what they need to do, myself
included...  ;-)

> > > +let srcu-rscs = ([Srcu-lock] ; (data ; [~ Srcu-unlock] ; rfe) * ; data ;
> > > [Srcu-unlock]) & loc
> > > 
> > > I see now that I copied the format from your message but without realizing
> > > the original had a `|` where I have a `;`.
> > > I hope this version is finally right and perhaps more natural than the (data
> > > | rf) version, considering rf can't actually appear in most places and this
> > > more closely matches carry-dep;data.
> > > But of course feel free to use
> > > +let srcu-rscs = ([Srcu-lock] ; (data  | [~ Srcu-unlock] ; rf)+ ;
> > > [Srcu-unlock]) & loc
> > > instead if you prefer.
> > 
> > The reason for favoring "rf" over "rfe" is the possibility of a litmus
> > test where the process containing the srcu_down_read() sometimes but
> > not always also has the matching srcu_up_read().  Perhaps a pair of "if"
> > statements control which process does the matching srcu_up_read().
> 
> If you put the redefinition of data early enough to affect this definition,
> the rfi option should be covered by the carry-dep in the redefinition of
> data, so I left it out.

For right now, I will favor obviousness over minimalism, but for the
real patch, I will let Alan decide what makes the most sense.  I am
sure that you will not be shy about letting him know of your thoughts
on the matter.  ;-)

							Thanx, Paul

> > And thank you!!!
> 
> always ;-)
> 
> jonas
> 
