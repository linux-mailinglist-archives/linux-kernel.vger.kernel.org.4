Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D00718A40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjEaTgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaTgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA7126;
        Wed, 31 May 2023 12:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B4B9637F7;
        Wed, 31 May 2023 19:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D38C433EF;
        Wed, 31 May 2023 19:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685561790;
        bh=qHIcBF1UUrBu0YMyCJL7nMbd4386Zetm4Fs3GDt140g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lpaJ/cA/CjMFz6VvrBKwuY1rSsrV8AVruZm55I2ucjWQEBydhP9NtwZEzbJiHOjxi
         zXFwWhGkfWdglbiydndOp1AsUPRnawqjY4PTEoL11Owp7KwUu8p8sHA8oElut3LEiF
         LMh6tS8PArcC6w6tt7BOwyYxR042GASziExwFozU=
Date:   Wed, 31 May 2023 20:36:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v1] docs: handling-regressions: rework section about
 fixing procedures
Message-ID: <2023053113-flakily-tipoff-ef5b@gregkh>
References: <6971680941a5b7b9cb0c2839c75b5cc4ddb2d162.1684139586.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6971680941a5b7b9cb0c2839c75b5cc4ddb2d162.1684139586.git.linux@leemhuis.info>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 10:40:48AM +0200, Thorsten Leemhuis wrote:
> This basically rewrites the 'Prioritize work on fixing regressions'
> section of Documentation/process/handling-regressions.rst for various
> reasons. Among them: some things were too demanding, some didn't align
> well with the usual workflows, and some apparently were not clear enough
> -- and of course a few things were missing that would be good to have in
> there.
> 
> Linus for example recently stated that regressions introduced during the
> past year should be handled similarly to regressions from the current
> cycle, if it's a clear fix with no semantic subtlety. His exact
> wording[1] didn't fit well into the text structure, but the author tried
> to stick close to the apparent intention.
> 
> It was a noble goal from the original author to state "[prevent
> situations that might force users to] continue running an outdated and
> thus potentially insecure kernel version for more than two weeks after a
> regression's culprit was identified"; this directly led to the goal "fix
> regression in mainline within one week, if the issue made it into a
> stable/longterm kernel", because the stable team needs time to pick up
> and prepare a new release. But apparently all that was a bit too
> demanding.
> 
> That "one week" target for example doesn't align well with the usual
> habits of the subsystem maintainers, which normally send their fixes to
> Linus once a week; and it doesn't align too well with stable/longterm
> releases either, which often enter a -rc phase on Mondays or Tuesdays
> and then are released two to three days later. And asking developers to
> create, review, and mainline fixes within one week might be too much to
> ask for in general. Hence tone the general goal down to three weeks and
> use an approach that better aligns with the usual merging and release
> habits.
> 
> While at it, also make the rules of thumb a bit easier to follow by
> grouping them by topic (e.g. generic things, timing, procedures, ...).
> 
> Also add text for a few cases where recent discussions showed they need
> covering. Among them are multiple points that better explain the
> relations to stable and longterm kernels and the team that manages them;
> they and the group seperators are the primary reason why this whole
> section sadly grew somewhat in the rewrite.
> 
> The group about those relations led to one addition the author came up
> with without any precedent from Linus: the text now tells developers to
> add a stable tag for any regression that made it into a proper mainline
> release during the past 12 months. This is meant to ensure the stable
> team will definitely notice any fixes for recent regressions. That
> includes those introduced shortly before a new mainline release and
> found right after it; without such a rule the stable team might miss the
> fix, which then would only reach users after weeks or months with later
> releases.
> 
> Note, the aspect "Do not consider regressions from the current cycle as
> something that can wait till the cycle's end [...]" might look like an
> addition, but was kinda was in the old text as well -- but only
> indirectly. That apparently was too subtle, as many developers seem to
> assume waiting till the end of the cycle is fine (even for build
> fixes).
> 
> In practice this was especially problematic when a cause of a regression
> made it into a proper release (either directly or through a backport). A
> revert performed by Linus shortly before the 6.3 release illustrated
> that[2], as the developer of the culprit had been willing to revert the
> culprit about three weeks earlier already -- but didn't do so when a fix
> came into sight and a maintainer suggested it can wait. Due to that the
> issue in the end plagued users of 6.2.y at least two weeks longer than
> necessary, as the fix in the end didn't become ready in time. This issue
> in fact could have been resolved one or two additional weeks earlier, if
> the developer had reverted the culprit shortly after it had been
> identified (which even the old version of the text suggest to do in such
> cases).
> 
> [1] https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/
> 
> [2] https://lore.kernel.org/all/CAHk-=wgD98pmSK3ZyHk_d9kZ2bhgN6DuNZMAJaV0WTtbkf=RDw@mail.gmail.com/
> 
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Greg KH <gregkh@linuxfoundation.org>
> CC: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
