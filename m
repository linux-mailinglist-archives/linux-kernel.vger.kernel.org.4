Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0412069F7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjBVPXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBVPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:23:07 -0500
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9E91EFE1;
        Wed, 22 Feb 2023 07:23:04 -0800 (PST)
Received: from [10.2.12.86] (unknown [10.2.12.86])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id BB40418ADB0A;
        Wed, 22 Feb 2023 16:23:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1677079382; bh=6ys811cYe9j7H/i56BAUWtzK7RJRsX+4S+UzwtWhGDA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=LWa++/hHB80lVpGDpNIxFO2kO8iu/llMqR0MOHCBGq8rC0ywJMbq2I4tFRs+ABiz1
         BSHHRt4rkolh4gHHapqgFNlPtSnNRJvlXPSh6lpLUNZ5SihgcuR2dMW+hSS0gdNQW+
         5AUhKUwbGtEyC72I44hfRbJgCdjtcNn5T7oXxPn0=
Message-ID: <c11860ec-9c9f-4929-6d1b-0cc2ffa079d1@schinagl.nl>
Date:   Wed, 22 Feb 2023 16:23:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Content-Language: nl
From:   Olliver Schinagl <oliver@schinagl.nl>
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
 <54238ab7-b7c0-a3a3-38e9-f7879866fb3c@schinagl.nl>
 <20230219103112.GA4095@alpha.franken.de>
 <8bc77a68-ec04-863e-0c46-1ea442e392ee@schinagl.nl>
In-Reply-To: <8bc77a68-ec04-863e-0c46-1ea442e392ee@schinagl.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

I'm digging deeper into this and understand less of it :)

For one, we currently use both ioread32 (our timer driver for example) 
and ioread32be (our GPIO driver) and thus both variants of register 
access I would think without problems.

I also see that a few devices override? (is that possible at all) 
mangle-port.h, though I didn't dig into this too much, just noticed some 
other boards with those headers. Is this an option at all? just supply a 
SoC specific mangle-port.h?

Loonking at mangle-port.h (and only at the 32 bit case), basically, 
there's ioswabl and __mem_ioswabl that I should be concerned about. 
Grepping for those functions however, only yields me one result, where  
__relaxed_ioswabl gets defined to  __ioswabl, __mem_iosawbl is unused. 
Even more frustrating, is that git grep also doesn't find a user for 
__relaxed_ioswabl. I'm sure there's some non-greppable magic missing :) 
as the failures of setting this define of course are real.

So to further my search, how does this work then?

Olliver

On 19-02-2023 17:07, Olliver Schinagl wrote:
> Hey Thomas,
>
> On 19-02-2023 11:31, Thomas Bogendoerfer wrote:
>> On Sun, Feb 19, 2023 at 10:27:17AM +0100, Olliver Schinagl wrote:
>>> It's still odd though; as we do not have _anything_ PCI, but it
>>> SWAP_IO_SPACE causes the crash.
>> but something uses readX/write() calls. If you aren't using any driver
>> existing driver but only newly written dedicated for that SOC
>> you could use raw_read/raw_writeX() instead. These type of functions
>> are always using native endianess.
> Ok that is valueable information. I think currently the only driver
> (that I can think of right now) that we use 'off the shelf' is the uart
> driver, so I hope that's written cleanly :)
>
> As for readX/writeX, for sure that is being used, and I intended to
> refactor that while going to proper and clean drivers (the realtek
> support in openwrt is a big mess right now).
>
> So you say raw_readX, but what about ioread32 which I thought was preferred?
>
> I'll meanwhile read into what readX vs raw_readX to learn more with
> regards to endianess.
>
> Thank you so mcuh so far!
>
>>> What makes SWAP_IO_SPACE generic then? :)
>> als long as hardware presents memory used with readX/writeX is
>> seen as little endian independant from CPU endianess it's generic.
> 'little endian independent'? What does that mean, that the register maps
> follow the CPU endianess?
>
>> Thomas.
>>

