Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3099764B578
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiLMMwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiLMMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:52:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211A1AA2E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:52:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 628BDB811B9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6367C433D2;
        Tue, 13 Dec 2022 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670935946;
        bh=YDbdK/6Mmdgi3to1CDFzj3V50/m14VqpiVePGSRQyu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dod63C9BETC3Bmw/6LnQYjUNny6Og/QnogfDFw0MACXguAWg7RIYEYDxj7cpEThhn
         jZB1CvyNa9LXdkdJ7/GgZYm21C98ST4IPnbTA3F3h97Khx8zClFGxZvXuehxarVB1i
         hmSiHWJbghTNUeFqY5s3Q/M+54VLxaSBXPep8zrACRAPSPylb7WdrlLIt+001HdgSL
         Fer5UweSQieBPj5WV2YrXJ+z8UHJH4q9Ku56H3SJRvgHPFcRWg7gYuOmo4/MB3xSjt
         2+5HVBntJVGw60VrSLUSK7QJWUYPzBvBhq++OduVys2INUH7ac8aqYihJzEv/xh/pV
         VhMUNibZZ9jkg==
Date:   Tue, 13 Dec 2022 12:52:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Subject: Re: [GIT PULL] arm64 updates for 6.2
Message-ID: <20221213125219.GC5719@willie-the-truck>
References: <20221209112500.GA3116@willie-the-truck>
 <CAHk-=wj-8gKB5SG0w_M2fK0KYyhZbNzDZ1W9H5pmisWzJ0XJEw@mail.gmail.com>
 <20221213121118.GB5719@willie-the-truck>
 <CAMj1kXFf0CYxL28T65WxXUbTwZHJET5Az+oDSxO04zsvkJqwSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFf0CYxL28T65WxXUbTwZHJET5Az+oDSxO04zsvkJqwSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 01:36:09PM +0100, Ard Biesheuvel wrote:
> On Tue, 13 Dec 2022 at 13:11, Will Deacon <will@kernel.org> wrote:
> > Ard -- do you think we could tweak the patching so that we patch the push
> > and the pop together (e.g. by tracking the two locations on a per-frame
> > basis and postponing the text poking until just before we return from
> > scs_handle_fde_frame())?
> >
> 
> The push and the pop are not necessarily balanced (there may be more
> than one pop for each push), and the opcode we look for
> (DW_CFA_negate_ra_state) may occur in places which are not actually a
> pop, so tracking these is not as straight-forward as this.

Duh, yes, of course. You only _execute_ one of the pops for a given run
through the function, but there could be numerous return points. So my
idea doesn't work at all :)

> What we could do is track the push and the first pop on a first pass,
> and if we don't encounter any unexpected opcodes, patch the push and
> do a second pass starting from the first pop. Or just simply run it
> twice and do no patching the first time around (the DWARF frames are
> not very big)

Doing a dry-run first sounds fairly easy to implement, so it would probably
be a good starting point. It also means that if anybody complains about the
overhead, then we can get them to work on doing it at build time instead!

Will
