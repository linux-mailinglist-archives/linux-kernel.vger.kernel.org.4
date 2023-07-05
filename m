Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4468B747E99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjGEHvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjGEHvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC706130
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF1E61405
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209A2C433C7;
        Wed,  5 Jul 2023 07:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688543507;
        bh=hiSQzTdEd+n8hoH82AdmW4PYaVXoSKM5uDZ7FnPp654=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kN/C3bl0pjBAxjr01M6HlLjNUO06WPFYaB6P/1b8ZBcl01hg2pEJBc8yCAmCOogpq
         LGSijwSDYGBbwaLCkdBKH1gkLCRoYGXke8nsowxC/bdOt73pjbhWaL/24ZMpB7ZVnf
         LF2nxG+7SqOAdkAHCyLJAmchjEn34oYb0KmR+d6s=
Date:   Wed, 5 Jul 2023 08:51:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        x86@kernel.org
Subject: Re: [GIT PULL] Scope-based Resource Management for 6.5
Message-ID: <2023070522-marmalade-easily-3b98@gregkh>
References: <20230626125726.GU4253@hirez.programming.kicks-ass.net>
 <CAHk-=wjsb5gZTvhXofPCQthk48S9_bSGohXKU8x8XDnf7=bROw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjsb5gZTvhXofPCQthk48S9_bSGohXKU8x8XDnf7=bROw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 02:11:05PM -0700, Linus Torvalds wrote:
> On Mon, 26 Jun 2023 at 05:57, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Please consider pulling the SBRM infrastructure so that people can start
> > building upon it. Specifically Greg also wants to start using this soon.
> >
> > Once this lands, I'll start to trickle in the conversions I've done for
> > the next release.
> 
> So things are quiet (partly presumably due to July 4th in the US) and
> I've mostly emptied my merge window queue, so I've pulled this since I
> obviously was happy with the final syntax.
> 
> However, let's agree to not really use it for 6.5 yet, and consider it
> all purely infrastructure for the next release, and for testing it all
> out in linux-next etc.

Sounds good to me.

> We should probably also strive to avoid it for bug-fixes that end up
> going to stable. I'm sure this will all be backported to stable
> eventually, but I'd at least personally be happier if that started
> happening only after we actually have some more interaction with this.

Yeah, it will probably need to be backported to maybe 6.1.y if some real
bugfix needs it, but for all of the trivial "clean up the error path"
patches that we constantly get, we'll resist that for the stable tree if
they use the cleanup logic.  That might actually be a good thing overall
anyway.

> I hope - and expect - that the core compiler infrastructure should be
> stable due to C++ uses of destructors, but I also note that at least
> in the system headers I have, the only use of the __cleanup__
> attribute seems to be a very special pthread_cleanup_push() helper,
> and some (fairly minimal) glib use in the g_auto*() types.
> 
> So this attribute has been around forever, and the low-level
> functionality has presumably gotten a lot of testing, but at the same
> time it really looks like the C interface is somewhat limited in its
> use.
> 
> I did do a Debian core search on g_autoptr() use, and in the first ten
> pages, most uses seemed to be either comments or tests. But there are
> certainly *some* real users too.

systemd has been using it for a long time so the infrastructure has been
there and should be stable, but I'm sure we will find out if not.

thanks,

greg k-h
