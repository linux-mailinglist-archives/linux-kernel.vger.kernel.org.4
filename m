Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC469C14D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 17:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBSQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 11:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjBSQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 11:07:33 -0500
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA8EF75F;
        Sun, 19 Feb 2023 08:07:28 -0800 (PST)
Received: from [10.2.12.48] (unknown [10.2.12.48])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 45D3C18AC8B2;
        Sun, 19 Feb 2023 17:07:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1676822847; bh=r54wKH88PSBWvoFFy3I942RexNyRq3XMd5VRL1NsvrU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=usVt0XxVR1C1hFd/urBb/NTxDETezOAB4xkeqY9NZG6rb27viqwo2ws+C5kB2dfVe
         K9xHI5x5tGO8yv21jWRv50ITzPK/toVaP8dhQkiPS5PtXiqU7R8CN5WuO/GP4sdzP4
         hkWSjH3eNXpKvGWUX/Z328bZqcPyKa6/Eu/CMYiE=
Message-ID: <8bc77a68-ec04-863e-0c46-1ea442e392ee@schinagl.nl>
Date:   Sun, 19 Feb 2023 17:07:34 +0100
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
 <af2cdad5-ee32-7956-cd77-2a18777a3857@schinagl.nl>
 <20230219090248.GE2924@alpha.franken.de>
 <54238ab7-b7c0-a3a3-38e9-f7879866fb3c@schinagl.nl>
 <20230219103112.GA4095@alpha.franken.de>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20230219103112.GA4095@alpha.franken.de>
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

Hey Thomas,

On 19-02-2023 11:31, Thomas Bogendoerfer wrote:
> On Sun, Feb 19, 2023 at 10:27:17AM +0100, Olliver Schinagl wrote:
>> It's still odd though; as we do not have _anything_ PCI, but it
>> SWAP_IO_SPACE causes the crash.
> 
> but something uses readX/write() calls. If you aren't using any driver
> existing driver but only newly written dedicated for that SOC
> you could use raw_read/raw_writeX() instead. These type of functions
> are always using native endianess.

Ok that is valueable information. I think currently the only driver 
(that I can think of right now) that we use 'off the shelf' is the uart 
driver, so I hope that's written cleanly :)

As for readX/writeX, for sure that is being used, and I intended to 
refactor that while going to proper and clean drivers (the realtek 
support in openwrt is a big mess right now).

So you say raw_readX, but what about ioread32 which I thought was preferred?

I'll meanwhile read into what readX vs raw_readX to learn more with 
regards to endianess.

Thank you so mcuh so far!

> 
>> What makes SWAP_IO_SPACE generic then? :)
> 
> als long as hardware presents memory used with readX/writeX is
> seen as little endian independant from CPU endianess it's generic.

'little endian independent'? What does that mean, that the register maps 
follow the CPU endianess?

> 
> Thomas.
> 
