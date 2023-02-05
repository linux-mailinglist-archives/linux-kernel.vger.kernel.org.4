Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1F968B0EC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBEQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBEQTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:19:46 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DADD5900E;
        Sun,  5 Feb 2023 08:19:44 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pOhjy-0000RS-03; Sun, 05 Feb 2023 17:19:42 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id EDE31C265A; Sun,  5 Feb 2023 17:19:29 +0100 (CET)
Date:   Sun, 5 Feb 2023 17:19:29 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Sander Vanheule <sander@svanheule.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Message-ID: <20230205161929.GD4459@alpha.franken.de>
References: <20230115121922.6359-1-sander@svanheule.net>
 <20230127162755.GB6090@alpha.franken.de>
 <46724036-fabf-7bae-41f8-1e95c5f1db5c@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46724036-fabf-7bae-41f8-1e95c5f1db5c@schinagl.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 03:39:59PM +0100, Olliver Schinagl wrote:
> Thanks Thomas, may I take this moment to poke you about a nother issue I
> don't quite understand how to resolve/figure out.
> 
> 
> I made the realtek target work with the GENERIC_MIPS_KERNEL, but only if I
> disable SWAP_IO_SPACE[0].

is this little endian or big endian ? 

> While I could act all smart and ask what this is for, I better ask, why is
> this concidered 'generic'. The comment in mangle-port [1] mentions 'sane
> hardware'. I don't know what is considered sane here, as the number of
> targets following generic mips seem to be around 5.

I always thought that SWAP_IO_SPACE is needed for big endian, but
looking at arch/mips/Kconfig I see a lot of SWAP_IO_SPACE for pure
little endian machines. I need to dig deeper to understand why.

> So any pointers (other then doing SWAP_IO_SPACE if !REALTEK_SOC, which I
> have now) would be appreciated

such a change would defeat the generic part of GENERIC_MIPS_KERNEL,
because it will then only work on REALTEC_SOC and nothing else. 

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
