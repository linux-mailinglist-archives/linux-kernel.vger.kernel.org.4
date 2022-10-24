Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F660BAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiJXUj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiJXUi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:38:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9012CE07;
        Mon, 24 Oct 2022 11:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C82D6B81217;
        Mon, 24 Oct 2022 15:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32611C433B5;
        Mon, 24 Oct 2022 15:44:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lyQUYKNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666626254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWvLZVRYvZmjhg91idBo+8bsezBsd/7oKi65yYsjjjI=;
        b=lyQUYKNLZmfHXqbLgJhp2zs5CgYl/THxLkwKN8y76FZMui/YKgF3Fu9tmZ9SD2R0nxC2LG
        cJVcvEkJGelF/HxUtoAlXbtkWLJ5LCHlYmpvFjE9qMsrBoxze15kcO0xo+aaHDWHsvXIVh
        4Xp5IcJoSad4gf1xt8ZHW55faDVCWKw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 659a5d2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 24 Oct 2022 15:44:14 +0000 (UTC)
Date:   Mon, 24 Oct 2022 17:44:09 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Message-ID: <Y1ayyS/7b5qnySi3@zx2c4.com>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 11:33:39AM -0600, Jason A. Donenfeld wrote:
> Hi Linus,
> 
> On Thu, Oct 20, 2022 at 11:15 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Can we please try to collect these all in one place?
> >
> > I see that Andrew picked up the original one for -mm, but I think it
> > would be better if we had one specific place for all of this (one
> > branch) to collect it all.
> 
> Sure. Andrew can drop it from -mm, and I'll collect everything in:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/log/?h=unsigned-char&r
> 
> And I'll ask Stephen to add that branch to -next.

So, as discussed, I'm doing this, and it's in -next now. And as a
result, we're getting warnings and such that I am fixing one by one.
Progress, good.

But it occurs to me that most of these bugs are not in
architecture-specific code like the x86 p4_event_bind one from last
week. That means I'll be submitting these as *fixes* during 6.1, since
they're broken on some architecture already, rather than waiting to
submit them to you via my unsigned-char tree in 6.2.

Just FYI.

Jason
