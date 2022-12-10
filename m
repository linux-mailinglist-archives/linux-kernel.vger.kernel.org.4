Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D95649013
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 18:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLJR5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 12:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 12:57:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591D186C5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 09:57:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCCE7B808C3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 17:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4531FC433EF;
        Sat, 10 Dec 2022 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670695035;
        bh=5Ws1aQL6QPQqSAOO0eUHcvYnvjXe9hQx9E9/NlTm0ZQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G0G3p+a/WMRxdvtXhYIWNrOlfUdXZPBYzNZhd6tUT0QR8MrSmnTNeEkzmaQV0yOga
         ZYvRsMI+qryyM530aJaoSEKaWTUr7KwjCa++PVVuafgROQ989Bgd+BHIhvBzOZzqUD
         zhvDHhzklQ35pAnv8PSZmmdp3/uXNt5CKa2D26pYGZkYHhk/cdRvw9Y28YH6SvNli2
         Cjws0QE7iMYdEEOwKIP36KcNzOu4VOjgzqkqtGWPrlSq7Tatvq9AR2h5bKCbS54m0e
         pqkx6SPSmuZc3RR5KtAJ/f8BKjKKlcw+cwvo452kV3XZftWqy38KkHjW2Z1vwSlyBg
         J7k0IUA1S1fEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C989B5C095D; Sat, 10 Dec 2022 09:57:14 -0800 (PST)
Date:   Sat, 10 Dec 2022 09:57:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nolibc: add support for s390
Message-ID: <20221210175714.GE4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-3-svens@linux.ibm.com>
 <20221210090728.GB21743@1wt.eu>
 <yt9dmt7vtxf3.fsf@linux.ibm.com>
 <20221210093734.GE21743@1wt.eu>
 <yt9dilijtx5s.fsf@linux.ibm.com>
 <20221210094452.GF21743@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210094452.GF21743@1wt.eu>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2022 at 10:44:52AM +0100, Willy Tarreau wrote:
> On Sat, Dec 10, 2022 at 10:39:43AM +0100, Sven Schnelle wrote:
> > Willy Tarreau <w@1wt.eu> writes:
> > 
> > > On Sat, Dec 10, 2022 at 10:34:08AM +0100, Sven Schnelle wrote:
> > >> So it should be:
> > >> 
> > >> >> +#elif defined(__s390x__)
> > >> >> +#include "arch-s390.h"
> > >> 
> > >> I'm fine with both - either you fixing it up or me sending a v2.
> > >
> > > As you like. If you prefer to rename the file to s390x as your colleague
> > > suggested, I'll then ask you to send a v2. Otherwise either Paul or I can
> > > drop that 'x' in the #include.
> > 
> > Just drop the 'x'. Thanks! :)
> 
> OK will do, thank you!

And I have queued this series with Willy's acks on the first three and
the "x" removed from the '#include "arch-s390x.h"'.  This is on the -rcu
tree's "dev" branch.

But please double-check to make sure that I removed the correct "x"
and that there are not others that I missed!

							Thanx, Paul
