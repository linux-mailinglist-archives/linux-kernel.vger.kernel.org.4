Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9EC64628A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLGUnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLGUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:43:22 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632B218BD;
        Wed,  7 Dec 2022 12:43:20 -0800 (PST)
Received: (Authenticated sender: alex@alexyzhang.dev)
        by mail.gandi.net (Postfix) with ESMTPSA id D4CB5E0002;
        Wed,  7 Dec 2022 20:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexyzhang.dev;
        s=gm1; t=1670445799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2N9hnmu56AlKFNM0m8698mHeE5RNpS8O5eMCSU1Yeqw=;
        b=SGMLJz1dBVEdAZ7W38DQGlw5LUdwQx+IPQTQg+fWFKk60lLU8I2FCWINXXb8C9rPN9rfqW
        6AHVOWaLMxEOT4mZ1XrpJ40eDtHIGgPJOC907Kjp4o9hQhARXKm+y3JgtgzKyRC63UaI7q
        yadISaGLTDVililEWOy/s7Ic2jOnufEv646WLOw021QTNAyfNt+Z5DFZG6e/4UmPiP1ulx
        eF0zIy6Vhw6iRTiExvXc6lcfkdV5lA+K1UZhDu9B7gZqYUHVPV8mRcCx8FZBkk4C0whfS7
        f5dfPCndwLB+H/x6EabqA9TBS72CViAAnRGRrjuUWCKgdcD9K7qu3yFx+3lhpA==
Message-ID: <63d1ea8f-ded9-ed6b-31d9-0d3b8d8cd998@alexyzhang.dev>
Date:   Wed, 7 Dec 2022 12:43:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/1] HID: uclogic: Add HID_QUIRK_HIDINPUT_FORCE quirk
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        openglfreak@googlemail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110174056.393697-1-jose.exposito89@gmail.com>
 <e1daf0a9-b699-affd-0d14-e46981733096@alexyzhang.dev>
 <nycvar.YFH.7.76.2211141509340.6045@cbobk.fhfr.pm>
 <d08049f2-443b-f769-cfde-629cdfb96fc0@alexyzhang.dev>
 <1dc9d0ba-4836-dfc6-8bf2-322ce3b5c24d@alexyzhang.dev>
 <Y5B0gwGZJ/PQyV4+@fedora>
Content-Language: en-US
From:   Alexander Zhang <alex@alexyzhang.dev>
In-Reply-To: <Y5B0gwGZJ/PQyV4+@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 3:09 AM, José Expósito wrote:
> Hi Alexander,
> 
> On Mon, Dec 05, 2022 at 04:49:10PM -0800, Alexander Zhang wrote:
>> Hello,
>>
>> On 11/19/22 11:01 PM, Alexander Zhang wrote:
>>> On 11/14/22 6:10 AM, Jiri Kosina wrote:
>>>> On Thu, 10 Nov 2022, Alexander Zhang wrote:
>>>>
>>>>> Hi José,
>>>>>
>>>>> On 11/10/22 9:40 AM, José Expósito wrote:
>>>>>> Hi everyone,
>>>>>>
>>>>>> About 3 months ago, Torge Matthies sent a patch fixing an issue with
>>>>>> his XP-Pen Star G640 [1].
>>>>>>
>>>>>> His patch changes the IS_INPUT_APPLICATION() macro to accept
>>>>>> HID_DG_DIGITIZER. However, it looks like it is not being merged because
>>>>>> of the possible side effects that changing that macro could generate.
>>>>>>
>>>>>> This patch aims to fix the same issue but using a more conservative
>>>>>> approach hoping that the bug can be fixed.
>>>>>>
>>>>>> Torge, Alexander, could you test it and confirm that it fixes your
>>>>>> issues, please?
>>>>>
>>>>> I tested the patch on commit 4bbf3422df78 and it fixes the issue.
>>>>
>>>> I will add
>>>>
>>>>      Tested-by: Alexander Zhang <alex@alexyzhang.dev>
>>>>
>>>> to the commit; please speak up if you disagree.
>>>
>>> I'm not sure if you're still waiting for a response from me but I'm fine
>>> with that.
>>
>> Is there something preventing this patch from being merged? I'm not very
>> familiar with the kernel development process.
> 
> The patch is already applied in the for-next branch, you can find it here:
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-next&id=3405a4beaaa8

I see, thank you very much!

Best,
Alexander Zhang
