Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D746969BF61
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBSJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 04:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSJ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 04:27:21 -0500
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6C0CC0B;
        Sun, 19 Feb 2023 01:27:19 -0800 (PST)
Received: from [10.2.12.86] (unknown [10.2.12.86])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 85FDD18AC73F;
        Sun, 19 Feb 2023 10:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1676798837; bh=1AP+j3yxz5J7OVrfIgDZTsD4A5/8z0tFI3q2rbr+0Y8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=W8oglSuUDV/MI+wylGWwAShr52E4QNTg4IefULdXqvqiVOtZaX5lha883HsVkdyFP
         k+aqn08PPqZOIqzP1qll12L4Dyc3+uznjdFvgf6OiG+S6tzyVW4PN/rj1WKjVb8HvN
         YRmu/TCu93+UBLpICXwSYMnGX6wB1Lcyq0cbHqWY=
Message-ID: <54238ab7-b7c0-a3a3-38e9-f7879866fb3c@schinagl.nl>
Date:   Sun, 19 Feb 2023 10:27:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
 <af2cdad5-ee32-7956-cd77-2a18777a3857@schinagl.nl>
 <20230219090248.GE2924@alpha.franken.de>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20230219090248.GE2924@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-2023 10:02, Thomas Bogendoerfer wrote:
> On Fri, Feb 17, 2023 at 08:27:05PM +0100, Olliver Schinagl wrote:
>> It is the Realtek series of SoC, specifically in my case, the RTL9302b,
>> which doesn't have a PCI peripherial, at all :) Nor configured in the
>> devicetree, but of course generic_mips_kernel enables the drivers, which
>> should be noop. I don't see anything related to PCI during boot.
>>
>> Having said that, the RTL930x series take their heritage from the RTL819x
>> (and probably older) wifi SoC series from realtek, which did contain a PCIe
>> peripherial, as that is where the (external) wifi chip was connected too.
> I see, and you want to use the already existing wifi driver ?
Not at all, the rtl930x is a pure switch chip (10 serdes connecting to 
multiple PHY's yielding 24 - 48 (+ some SFP port) configurations, all 
without anything PCI related.
>
>>> Do you have a programmers manual for it,
>>> which contains details about the PCI bridge ?
>> If only. There are some (leaked) datasheets, that do contain the PCI
>> registers, mostly (obviously) the rtl819x datasheets. https://github.com/libc0607/Realtek_switch_hacking/blob/files/REALTEK-RTL8196E.pdf
>> is one such example that contains the PCIe registers.
> that's just the PCIe PHY part, but not the localbus<->PCIe bridge
> part. But if the wifi part of ypur SOC is directly connected to
> the localbus, having the some PCI register won't help anyway.
> I am afraid you need to go the route via extra Kconfig section.

It's still odd though; as we do not have _anything_ PCI, but it 
SWAP_IO_SPACE causes the crash.

So in that case, we'll wend up with a duplicate of generic_mips_kernel - 
SWAP_IO_SPACE, any suggestions of doing this cleanly in kconfig? copy 
pasting the whole shebang (and maintaining it) seems wasteful.

I suppose the chip is generic, except one thing makes it not generic :(


What makes SWAP_IO_SPACE generic then? :)

>
> Thomas.
>

