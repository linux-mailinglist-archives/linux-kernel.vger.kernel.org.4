Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DD76A244A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBXWcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBXWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:32:40 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB386F424;
        Fri, 24 Feb 2023 14:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7pfPhFb9Abefaj3AkxuqqLW6wL9VXDuOKUbk//Xa6rk=; b=e10cEM3HHzdnOfb1LDJBEirtQ9
        ZZccVJ/VDKVTbEBz7TMyEcwK3xC8OspeQc+gpGeqjArzkN6yXZnWjeHbDMKWjutblJQIW6p2imfP/
        6Kzy6B6duaSteM7qEBPPDaSFIYDegIwd0XxDxPDl3xn/kZ2ToJdmKXvsGMvvpn1rvkJMq90LVLTd6
        rrI1InhoN7hVSwB/L0U4ZZ8N02IJEe5mSbe/3rmWBFm3UetasaeUhsEZuQ1i2AZH8bYt0aF01IZOJ
        S9k5taV4XnqULaL2XglDr92f7jZL3Rsyqd4g0TZ6/GuHbDtMbvmlo9j0W89gEvW4uu9fmApfjVeTz
        yo38dMmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVgbq-00C89f-2w;
        Fri, 24 Feb 2023 22:32:11 +0000
Date:   Fri, 24 Feb 2023 22:32:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
Message-ID: <Y/k66v01i5z3kFMG@ZenIV>
References: <Y/iywbFbiUAA6ZD3@kroah.com>
 <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 01:30:58PM -0800, Linus Torvalds wrote:
> On Fri, Feb 24, 2023 at 1:24 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >         default SERIAL_8250
> 
> Hmm. Looking around, it seems to be a pattern. I'm not convinced any
> of them are really valid, except probably the ones that aren't about
> specific drivers, but about base support (like the "SERIAL_8250_DMA"
> one).
> 
> I also do get the feeling that the base "SERIAL_8250" feature might be
> better off as a _selected_ option, rather than a "ask if you want it".
> I think we've ended up with that SERIAL_8250 being a base option
> mainly for historical reasons (ie it was part of the original PC/AT
> base specs, and then later it has become a "base driver for a lot of
> random cards".
> 
> It's probably most legacy by now - it's a long time since I saw a
> serial port being used outside of management ports, and even those are
> often ethernet these days.

Serial console is hard to replace - sure, netconsole can take care of
the printk side of things, but the things like "boot with init=/bin/sh
and try to recover using that" are occasionally useful; same for "drop
into shell on initramfs and use that to poke around"...  What do you
use that kind of situations?  Not a rethorical question - I would be
really happy to know alternative variants for that; IME it's not
needed often (thankfully), but when it's needed it's really useful
to have...
