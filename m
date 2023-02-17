Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6310E69B30A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBQT1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:27:11 -0500
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B053EE4;
        Fri, 17 Feb 2023 11:27:07 -0800 (PST)
Received: from [10.2.12.48] (unknown [10.2.12.48])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 8723C18ABE4B;
        Fri, 17 Feb 2023 20:27:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1676662025; bh=iOx6C7ybj2S6QilTwfMWfskolVyYi9blvJ/GTVN3Ibg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=T2XCyzjINsstE8nmSL1DdJc0ZxWsj2fOnWRLlbGlSMC7e3RDi8/iLn5edlOFmW8kI
         cL/t+7X6yKPf7QnsGRTdq0g+7IS4gsgz1Ygcz+H7xSoWpoc2OYmMiJ/D0qJ1stSCgI
         O/9godzde+D/9loNMCACqQpplMUNZU/PxsTdVWfE=
Message-ID: <af2cdad5-ee32-7956-cd77-2a18777a3857@schinagl.nl>
Date:   Fri, 17 Feb 2023 20:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Content-Language: nl
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Sander Vanheule <sander@svanheule.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230115121922.6359-1-sander@svanheule.net>
 <20230127162755.GB6090@alpha.franken.de>
 <46724036-fabf-7bae-41f8-1e95c5f1db5c@schinagl.nl>
 <20230205161929.GD4459@alpha.franken.de>
 <f9c1be9c-478e-55e8-ad34-370641181015@schinagl.nl>
 <20230217173708.GA14134@alpha.franken.de>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20230217173708.GA14134@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

On 17-02-2023 18:37, Thomas Bogendoerfer wrote:
> On Sun, Feb 05, 2023 at 07:33:46PM +0100, Olliver Schinagl wrote:
>>> I always thought that SWAP_IO_SPACE is needed for big endian, but
>>> looking at arch/mips/Kconfig I see a lot of SWAP_IO_SPACE for pure
>>> little endian machines. I need to dig deeper to understand why.
>> Thank you!
> 
> and the reason why this works is simple, CONFIG_SWAP_IO_SPACE is a nop
> for little endian.

That makes life easy :p

> 
>>> such a change would defeat the generic part of GENERIC_MIPS_KERNEL,
>>> because it will then only work on REALTEC_SOC and nothing else.
>> Ignoring the potential incorrect detail here, obviously I would prefer to
>> use the GENERIC_MIPS_KERNEL, but having to copy the whole config just to
>> leave out that one option also is kinda meh. So i'm hoping we can find a
>> solution of course :)
> 
> what SOC is this exactly ?

It is the Realtek series of SoC, specifically in my case, the RTL9302b, 
which doesn't have a PCI peripherial, at all :) Nor configured in the 
devicetree, but of course generic_mips_kernel enables the drivers, which 
should be noop. I don't see anything related to PCI during boot.

Having said that, the RTL930x series take their heritage from the 
RTL819x (and probably older) wifi SoC series from realtek, which did 
contain a PCIe peripherial, as that is where the (external) wifi chip 
was connected too.

> Do you have a programmers manual for it,
> which contains details about the PCI bridge ?

If only. There are some (leaked) datasheets, that do contain the PCI 
registers, mostly (obviously) the rtl819x datasheets. 
https://github.com/libc0607/Realtek_switch_hacking/blob/files/REALTEK-RTL8196E.pdf 
is one such example that contains the PCIe registers.

> Most of the PCI bridges
> used for MIPS contain a bit to select the endianess of the access
> to PCI spaces. If there is such a config just changing the current
> setting, should solve your problem.

I really want to solve this obviously, but without the PCI registers ... 
It could be that those registers DO exist of course!

I'll double check tomorrow, where abouts booting fails, what driver is 
the last to output anything to give a hint to where things are failing...

> 
> If this isn't possible you could use something similair to the
> INGENIC approach, which could use a generic kernel but also an
> customized kernel. And in such a customized kernel it should be
> possible to remove SWAP_IO_SPACE.

Yeah, I just disabled that flag; I'll look into INGENIC in more detail, 
but would hope we can do this in a clean way, because without the flag, 
generic_mips_kernel works fine ...

Olliver

> 
> Thomas.
> 
