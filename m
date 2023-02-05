Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7644C68B136
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 19:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjBESdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 13:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBESdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 13:33:53 -0500
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484691B543;
        Sun,  5 Feb 2023 10:33:48 -0800 (PST)
Received: from [10.2.12.48] (unknown [10.2.12.48])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 6FC4718A6B88;
        Sun,  5 Feb 2023 19:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1675622026; bh=flygFw1+6D6/NcNi9Xf1aRduEli+GgsdUt9qq0j34vQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WPzbHwQ7UXsSIg/YPyUqhe/EsDWQl9L6BUPG+rBsTdpUSFuFU9XunPvrYYgHLqOWJ
         JmzsPCi+d7h2Ryg1XbWybDk4kNN2IMgNNH2E6cvRUV3YbNpoULmxefEx6g5Od1//9u
         lgHElyEM+qfCH9zcpsGPG3GHJ93V7oLZ6g/dnRHk=
Message-ID: <f9c1be9c-478e-55e8-ad34-370641181015@schinagl.nl>
Date:   Sun, 5 Feb 2023 19:33:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Sander Vanheule <sander@svanheule.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230115121922.6359-1-sander@svanheule.net>
 <20230127162755.GB6090@alpha.franken.de>
 <46724036-fabf-7bae-41f8-1e95c5f1db5c@schinagl.nl>
 <20230205161929.GD4459@alpha.franken.de>
Content-Language: nl
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20230205161929.GD4459@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

On 05-02-2023 17:19, Thomas Bogendoerfer wrote:
> On Sat, Jan 28, 2023 at 03:39:59PM +0100, Olliver Schinagl wrote:
>> Thanks Thomas, may I take this moment to poke you about a nother issue I
>> don't quite understand how to resolve/figure out.
>>
>>
>> I made the realtek target work with the GENERIC_MIPS_KERNEL, but only if I
>> disable SWAP_IO_SPACE[0].
> 
> is this little endian or big endian ?
The kernel config currently states Big Endian

> 
>> While I could act all smart and ask what this is for, I better ask, why is
>> this concidered 'generic'. The comment in mangle-port [1] mentions 'sane
>> hardware'. I don't know what is considered sane here, as the number of
>> targets following generic mips seem to be around 5.
> 
> I always thought that SWAP_IO_SPACE is needed for big endian, but
> looking at arch/mips/Kconfig I see a lot of SWAP_IO_SPACE for pure
> little endian machines. I need to dig deeper to understand why.
Thank you!

> 
>> So any pointers (other then doing SWAP_IO_SPACE if !REALTEK_SOC, which I
>> have now) would be appreciated
> 
> such a change would defeat the generic part of GENERIC_MIPS_KERNEL,
> because it will then only work on REALTEC_SOC and nothing else.
Ignoring the potential incorrect detail here, obviously I would prefer 
to use the GENERIC_MIPS_KERNEL, but having to copy the whole config just 
to leave out that one option also is kinda meh. So i'm hoping we can 
find a solution of course :)

Olliver

> 
> Thomas.
> 
