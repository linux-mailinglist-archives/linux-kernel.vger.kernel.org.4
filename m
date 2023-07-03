Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E867456FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGCILH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGCILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:11:05 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1661BC;
        Mon,  3 Jul 2023 01:11:03 -0700 (PDT)
Received: from [167.98.27.226] (helo=[10.35.6.111])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qGEeB-001yr9-Kb; Mon, 03 Jul 2023 09:10:59 +0100
Message-ID: <988325dc-79ff-6a8d-9fb5-7f2a167cf37b@codethink.co.uk>
Date:   Mon, 3 Jul 2023 09:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: net: macb: sparse warning fixes
Content-Language: en-GB
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, claudiu.beznea@microchip.com
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
 <66f00ffc-571b-86b3-5c35-b9ce566cc149@microchip.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <66f00ffc-571b-86b3-5c35-b9ce566cc149@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 14:16, Nicolas Ferre wrote:
> Hi Ben,
> 
> On 22/06/2023 at 15:05, Ben Dooks wrote:
>> These are 3 hopefully easy patches for fixing sparse errors due to
>> endian-ness warnings. There are still some left, but there are not
>> as easy as they mix host and network fields together.
>>
>> For example, gem_prog_cmp_regs() has two u32 variables that it does
>> bitfield manipulation on for the tcp ports and these are __be16 into
>> u32, so not sure how these are meant to be changed. I've also no hardware
>> to test on, so even if these did get changed then I can't check if it is
>> working pre/post change.
> 
> Do you know if there could be any impact on performance (even if limited)?

There shouldn't be, these are either constants so should be compile time
sorted or they are just using the swap code the wrong way round... same
values, just the wrong endian markers going in/out.

The only device with a macb I've got is an unmatched, so don't even know
if I can test any of this.

The filter code I would like to get some feedback on, as I didn't want
to do any modifications without being able to test.

> Best regards,
>    Nicolas
> 
>> Also gem_writel and gem_writel_n, it is not clear if both of these are
>> meant to be host order or not.
>>
>> Ben Dooks (3):
>>    net: macb: check constant to define and fix __be32 warnings
>>    net: macb: add port constant to fix __be16 warnings
>>    net: macb: fix __be32 warnings in debug code
>>
>>   drivers/net/ethernet/cadence/macb_main.c | 25 +++++++++++++-----------
>>   1 file changed, 14 insertions(+), 11 deletions(-)
> 

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

