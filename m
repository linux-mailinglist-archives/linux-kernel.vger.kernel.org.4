Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8756A33C9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBZT7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:59:08 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C216339
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:59:05 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31QJwibP008362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Feb 2023 14:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677441529; bh=sUDNujaHfUqZ8bjP9HuWhvva7+VEbIW3Zww8AIVTgtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=U0g3nrxbwhModARiSgwYYoCAvHxED2XBpVYNdpkDDmekIh5GDte8nIxUPQ7pxRpvV
         eOjL1IS5x0OGFkKHLEJ8+9Ulestd3B1qoSgNWhr4rPMebY/HSSrLL/daGMlV7Jce3d
         Mjh1daVESQQKWgP2gXOaNChOupoLGbcbKV1EZXFt0oRkvktTfqq2e+OHqKYOVt5hH8
         KHlmc1rZN7C8/yyK4WzAo1rLkfVuocqWNsUk1M8aMh4LZ+WhVfC8gA8QRRspQZUAKo
         /S4gu9XivmDxj3ishPxE+7hpRRO7VoZCikWs1TprbQ/qN2JEDbjNTt2RfBUpjte+Ws
         xLstb0dU2FXhQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A014315C5823; Sun, 26 Feb 2023 14:58:44 -0500 (EST)
Date:   Sun, 26 Feb 2023 14:58:44 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
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
Message-ID: <Y/u59FFG+ID0OAbg@mit.edu>
References: <Y/iywbFbiUAA6ZD3@kroah.com>
 <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
 <Y/qcXOxTVHTNDQbY@mit.edu>
 <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 06:14:11PM -0800, Linus Torvalds wrote:
> On Sat, Feb 25, 2023 at 3:40 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > For what it's worth, in the VM world (e.g., qemu, AWS, GCP, Azure,
> > Linode, etc.)  serial consoles are quite common way of debugging VM's,
> > and as an emergency login path when the networking has been screwed up
> > for some reason....
> 
> Everybody seems to be missing the point.
> 
> We don't make new drivers "default y" (or, in this case, "default SERIAL_8250".
> 
> It does not matter ONE WHIT if you have a serial device in your
> machine. If your old driver was enabled and worked for you and you
> used it daily, that is ENTIRELY IMMATERIAL to a new driver, even if
> that new driver then happens to use some of the same infrastructure as
> the old one did.

Oh, agreed, I wasn't responding to that part of your message.  New
serial drivers should never be enabled by default.

I was responding to your musing about whether it still made sense to
enable the COM1/2/3/4 serial ports by default on x86.  It's true that
on desktops COM1/2/3/4 serial ports are rarely used, and some other
boards might not even have them any more.  But for x86 VM's, they are
used quite a lot.

Cheers,

				- Ted
