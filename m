Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4931764B4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiLMMML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbiLMML7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:11:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369115FFF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:11:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E329614B8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657F7C433F1;
        Tue, 13 Dec 2022 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670933484;
        bh=YZA2yIOIriN/9Ssu5tc207gmhOIAB7Lv6gAfd0usWG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoHPDUVy4i37eFmvO0xW/SA4Aqfysnx4kTkB+vsR7Ewz+0qScMYPgpdnJxK2IZVZ+
         Vil1yjm/W8KzPaSAo67HA48iW9vq3I4EVXHz3psT2DyiRwweHeTwN2InVtpxiBEitb
         D8cIuZQBsAbcRhZ1BT9oUjr/vui3ajT/dDiParHBG/7vd1a/igjDgwPnSQ7qlt4/yF
         oKA++2S1eGIuZ/xHWZLozkHUFARPhg2S8pspqTUs+r158k39PdW1khDOmqxekqaO3k
         ttUvgB5UXMNIc1dMQ70BLs+E1TXbWa+YpHmANJtx2Tf8uYWSy3Jm76JOQHG2wApZIp
         kmQEhshJGgquw==
Date:   Tue, 13 Dec 2022 12:11:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org, ardb@kernel.org
Subject: Re: [GIT PULL] arm64 updates for 6.2
Message-ID: <20221213121118.GB5719@willie-the-truck>
References: <20221209112500.GA3116@willie-the-truck>
 <CAHk-=wj-8gKB5SG0w_M2fK0KYyhZbNzDZ1W9H5pmisWzJ0XJEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-8gKB5SG0w_M2fK0KYyhZbNzDZ1W9H5pmisWzJ0XJEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[+Ard]

On Mon, Dec 12, 2022 at 10:05:07AM -0800, Linus Torvalds wrote:
> On Fri, Dec 9, 2022 at 3:25 AM Will Deacon <will@kernel.org> wrote:
> >
> > Dynamic SCS:
> >         * Support for dynamic shadow call stacks to allow switching at
> >           runtime between Clang's SCS implementation and the CPU's
> >           pointer authentication feature when it is supported (complete
> >           with scary DWARF parser!)
> 
> I've pulled this thing, but this part makes me nervous. There's some
> bad history with debug information not being 100% reliable probably
> simply because it gets very little correctness testing.

Hey, I did use the word "scary"! This is, at least, very easy to back
out (it's effectively an optimisation) if the DWARF info ends up being
too unreliable and causes issues in practice. We're also only looking
at .eh_frame here, which should hopefully get a lot more correctness
testing when compared to the .debug sections due to exception unwinding.

> It might be worth thinking about at least verifying the information
> using something like objtool, so that you at least catch problem cases
> at *build* time rather than runtime.

Checking that the DWARF data looks sensible at build time isn't a bad
idea, but see below as I think we can probably still produce a functional
kernel Image in this case.

> For example, that whole
> 
>     default:
>         pr_err("unhandled opcode: %02x in FDE frame %lx\n",
> opcode[-1], (uintptr_t)frame);
>         return -ENOEXEC;
> 
> really makes me go "this should have been verified at build time, it's
> much too late to notice now that you don't understand the dwarf data".

This isn't actually as bad as it looks -- the patching operation here
only kicks in on CPUs which do not implement the pointer authentication
instructions (i.e. where the CPU executes these as NOPs). Therefore, if
patching bails out half way due to the "unhandled opcode" above, we
should be ok, albeit missing some SCS coverage. I say "should" because
if we fail within a frame after patching in the SCS "push" but before
patching in the "pop", then we'd end up with a corrupt SCS pointer.

Ard -- do you think we could tweak the patching so that we patch the push
and the pop together (e.g. by tracking the two locations on a per-frame
basis and postponing the text poking until just before we return from
scs_handle_fde_frame())?

Will
