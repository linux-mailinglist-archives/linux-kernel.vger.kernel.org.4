Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267D699C67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBPSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBPSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412074E5DD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:36:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B1A62074
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF67AC433D2;
        Thu, 16 Feb 2023 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676572589;
        bh=DtkaLL8BSRD3/dzYQBRNj9VnhYvYcu1rYrlfhiiB934=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=alPZVCoxG0eWM7tBpqqZ+yfhCE8I3NIJXzNreYf30iA48iG2ZMTt2NqugfNXC3bEb
         GvI+wS31Z2PI/QyGVZQcV5LTmoBx0wf2lqQ5ZNloMm0f7jbyXQvnv+3mqlgxr4Nvyz
         dWNlF989hEULM4fdhZsVjQTD4MQAPhNwR/uE4Ffups8O63qdGIi9dicAwRvma7oQw/
         eD/FlDr2GEXDpX0OKH9o5WbVYTWe/Q/+abyhX1Y2Mm5zf0MssM59qRmDICWPM8XLpc
         p8dD9b9TpWLqnUDfRCN4tMKz+I4GMf8b89kU9If9lvKxWhsofMBFa99Fb8kceCxpbC
         bgKiuSM/u7qyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 21C305C0AC7; Thu, 16 Feb 2023 10:36:26 -0800 (PST)
Date:   Thu, 16 Feb 2023 10:36:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: select CONFIG_CONSTRUCTORS
Message-ID: <20230216183626.GR2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230215091503.1490152-1-arnd@kernel.org>
 <CANpmjNNz+zuV5LpWj5sqeR1quK4GcumgQjjDbNx2m+jzeg_C7w@mail.gmail.com>
 <78b2ed7d-2585-479f-98b1-ed2574a64cb8@app.fastmail.com>
 <20230215224218.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNNz30RQMfX0Bv+hobdUp+k_jHwH2WniQj4g+b48tsoR9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNz30RQMfX0Bv+hobdUp+k_jHwH2WniQj4g+b48tsoR9Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 08:00:00AM +0100, Marco Elver wrote:
> On Wed, 15 Feb 2023 at 23:42, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Feb 15, 2023 at 10:48:11AM +0100, Arnd Bergmann wrote:
> > > On Wed, Feb 15, 2023, at 10:25, Marco Elver wrote:
> > > > On Wed, 15 Feb 2023 at 10:15, Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > > Looks like KASAN does select CONSTRUCTORS already, so KCSAN should as well.
> > > >
> > > > Do you have a tree to take this through, or should it go through -rcu
> > > > as usual for KCSAN patches?
> > >
> > > I don't have a tree for taking these build fixes, so it would be good if you could forward it as appropriate.
> >
> > Queued and pushed, thank you both!
> >
> > Is this ready for the upcoming merge window, or would you rather that
> > I hold off until the v6.4 merge window?  (I am tempted to treat this
> > as a bug fix, thus sending it earlier rather than later, but figured I
> > should ask.)
> 
> I'd consider it a bug fix. If it survives the usual -next exposure, no
> harm in sending it as a fix.

It passed overnight tests, so I have sent it along to -next.  If there
are no issues, I will push it by the end of this coming week (which is
the first weke of the merge window).

							Thanx, Paul
