Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A163F649291
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 06:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLKFvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 00:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLKFvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 00:51:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5EB11A3F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:51:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D8E60C99
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B9AC433D2;
        Sun, 11 Dec 2022 05:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670737903;
        bh=p55epON05fys6NYDYae8VRlCk4Zvu+PXp1OzYvGtatk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t8hQvCsdbzQjFFZ83evUCifSDtflQ+1LReh17WScg7oAJsQs+gw/ugAY0q+vXJKD/
         c+dwQSbdnrnavRAKnEuDglBP0VmjlFKLGLj/zEQFvQTOfGrELQhEtBGg+eoShLMM0A
         dkBG2YwW5MnU2ZzTAZ/kBkCw4uA9oQTyxvISdHqTFdNIjlU6Y6BgyxPvxM1zMWs3XR
         EjO4aW5U2rZsjKR/spW4IlaFSzcsYcEgAbzFH0UqUidI2Gb9SX/XX/mESyY5zLs6ZS
         c06uUTUW5eRr4UrEqu/f8W2CDyWBdy1AVqJ4nv1Y1Jbht7OHPMeAtvegkItlmVRpd8
         GJWOy3STLib6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 14E575C095D; Sat, 10 Dec 2022 21:51:43 -0800 (PST)
Date:   Sat, 10 Dec 2022 21:51:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nolibc: add support for s390
Message-ID: <20221211055143.GG4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-3-svens@linux.ibm.com>
 <20221210090728.GB21743@1wt.eu>
 <yt9dmt7vtxf3.fsf@linux.ibm.com>
 <20221210093734.GE21743@1wt.eu>
 <yt9dilijtx5s.fsf@linux.ibm.com>
 <20221210094452.GF21743@1wt.eu>
 <20221210175714.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <20221210220504.GA23585@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210220504.GA23585@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 11:05:04PM +0100, Willy Tarreau wrote:
> On Sat, Dec 10, 2022 at 09:57:14AM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 10, 2022 at 10:44:52AM +0100, Willy Tarreau wrote:
> > > On Sat, Dec 10, 2022 at 10:39:43AM +0100, Sven Schnelle wrote:
> > > > Willy Tarreau <w@1wt.eu> writes:
> > > > 
> > > > > On Sat, Dec 10, 2022 at 10:34:08AM +0100, Sven Schnelle wrote:
> > > > >> So it should be:
> > > > >> 
> > > > >> >> +#elif defined(__s390x__)
> > > > >> >> +#include "arch-s390.h"
> > > > >> 
> > > > >> I'm fine with both - either you fixing it up or me sending a v2.
> > > > >
> > > > > As you like. If you prefer to rename the file to s390x as your colleague
> > > > > suggested, I'll then ask you to send a v2. Otherwise either Paul or I can
> > > > > drop that 'x' in the #include.
> > > > 
> > > > Just drop the 'x'. Thanks! :)
> > > 
> > > OK will do, thank you!
> > 
> > And I have queued this series with Willy's acks on the first three and
> > the "x" removed from the '#include "arch-s390x.h"'.  This is on the -rcu
> > tree's "dev" branch.
> > 
> > But please double-check to make sure that I removed the correct "x"
> > and that there are not others that I missed!
> 
> Just checked, looks good to me, many thanks Paul!

Whew!  And thank you for checking!

							Thanx, Paul
