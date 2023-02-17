Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AAF69B1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBQRhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBQRhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:37:33 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 980EA6FF0A;
        Fri, 17 Feb 2023 09:37:24 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pT4fh-0003ix-00; Fri, 17 Feb 2023 18:37:21 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2A77EC28A6; Fri, 17 Feb 2023 18:37:08 +0100 (CET)
Date:   Fri, 17 Feb 2023 18:37:08 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Sander Vanheule <sander@svanheule.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Message-ID: <20230217173708.GA14134@alpha.franken.de>
References: <20230115121922.6359-1-sander@svanheule.net>
 <20230127162755.GB6090@alpha.franken.de>
 <46724036-fabf-7bae-41f8-1e95c5f1db5c@schinagl.nl>
 <20230205161929.GD4459@alpha.franken.de>
 <f9c1be9c-478e-55e8-ad34-370641181015@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c1be9c-478e-55e8-ad34-370641181015@schinagl.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 07:33:46PM +0100, Olliver Schinagl wrote:
> > I always thought that SWAP_IO_SPACE is needed for big endian, but
> > looking at arch/mips/Kconfig I see a lot of SWAP_IO_SPACE for pure
> > little endian machines. I need to dig deeper to understand why.
> Thank you!

and the reason why this works is simple, CONFIG_SWAP_IO_SPACE is a nop
for little endian.

> > such a change would defeat the generic part of GENERIC_MIPS_KERNEL,
> > because it will then only work on REALTEC_SOC and nothing else.
> Ignoring the potential incorrect detail here, obviously I would prefer to
> use the GENERIC_MIPS_KERNEL, but having to copy the whole config just to
> leave out that one option also is kinda meh. So i'm hoping we can find a
> solution of course :)

what SOC is this exactly ? Do you have a programmers manual for it,
which contains details about the PCI bridge ? Most of the PCI bridges
used for MIPS contain a bit to select the endianess of the access
to PCI spaces. If there is such a config just changing the current
setting, should solve your problem.

If this isn't possible you could use something similair to the
INGENIC approach, which could use a generic kernel but also an
customized kernel. And in such a customized kernel it should be
possible to remove SWAP_IO_SPACE.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
