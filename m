Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86076E466C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDQL2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjDQL1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:27:11 -0400
X-Greylist: delayed 1032 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 04:26:09 PDT
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB425255;
        Mon, 17 Apr 2023 04:26:09 -0700 (PDT)
Received: from [192.168.0.22] (unknown [50.47.218.115])
        by endrift.com (Postfix) with ESMTPSA id 1CC7DA270;
        Mon, 17 Apr 2023 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1681729649; bh=de2yKnAwsU9431FBx3POLOHI3HNYYKnkxcSV1WxNjjE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kKBPWCTao7pOECwQzAAvGKsYg7sScrXZD0tvf4ngHL4djt5tV0/I/luuGV0ayK0qs
         oTMfMnW+RoLF494HuxuAaqCPPx4fGDzFJQ74FM9DL+sIcBPxSH13ndfaAGmREdiZyc
         hVhwr8sWoGA/h4330zuqpLl9o7YIS1w8Ww6AUs2XUB0bzy04kzG8+CGNACVxl0RJfK
         SdY0j31SfYdegjh+oinB7SmolxQbopl7RCeJnPgpEoG8/MCt4qjF0pgOoV+21OOFfw
         1WFpV1SzELe9qvy/YQsqolUqOgYWOgcxLegjeM/o89Z8INaa5xuEqrhIgEOtbvkm4Y
         DUs6+A0q6oM6w==
Message-ID: <69fc3a73-f18b-0268-6431-1b8b6aeed8ff@endrift.com>
Date:   Mon, 17 Apr 2023 04:07:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>, Dan Carpenter <error27@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Nate Yocom <nate@yocom.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        John Butler <radon86dev@gmail.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        Christopher Crockett <chaorace@gmail.com>,
        Santosh De Massari <s.demassari@gmail.com>,
        hust-os-kernel-patches@googlegroups.com,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414125603.686123-1-dzm91@hust.edu.cn>
 <c3e0823b-2b03-4dab-b7cb-a8bc5151f0b1@kili.mountain>
 <99794af0-7367-acff-357d-1cd4fa7f832e@hust.edu.cn>
 <38279d91-402c-7f8b-273d-0882a0567a0c@endrift.com>
 <57577302-8d18-231f-062b-b1d262720943@hust.edu.cn>
From:   Vicki Pfau <vi@endrift.com>
In-Reply-To: <57577302-8d18-231f-062b-b1d262720943@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/23 03:33, Dongliang Mu wrote:
>
> On 2023/4/17 18:24, Vicki Pfau wrote:
>> Hi,
>>
>> On 4/17/23 03:01, Dongliang Mu wrote:
>>> On 2023/4/17 17:25, Dan Carpenter wrote:
>>>> On Fri, Apr 14, 2023 at 08:55:47PM +0800, Dongliang Mu wrote:
>>>>> In xpad_probe(), it does not allocate xpad->dev with input_dev type.
>>>>> Then, when it invokes dev_warn with 1st argument - &xpad->dev->dev, it
>>>>> would trigger GPF.
>>>> What is a call tree for this?  Actually I found it from the bug report.
>>>> drivers/input/joystick/xpad.c
>>>>     2034                  if (error)
>>>>     2035                          dev_warn(&xpad->dev->dev,
>>>>     2036                                   "unable to receive magic message: %d\n",
>>>>     2037                                   error);
>>>>     2038          }
>> Sorry, this appears to be my code, and was merged recently after a few drafts with Dmitry. This code is sensitive to being moved and only affects some controllers, so I'm looking into if I can move it into after creation of the input_dev right now. It's something I'd already thought might be necessary, but I didn't find any evidence for it before. I'll try to get back to you on that soon.
>
> If this is necessary, we can change it with another device pointer. Otherwise, we need to move it after the allocation and assignment. Or move the allocation and assignment before which is not suggested.
>
> Thanks for your reply. Do I need to submit a v2 patch? Or you will take care of it?

I'll take care of it. I have a patch prepared, but I need to do a bit more testing before I can confirm it doesn't break one specific controller. I'll try to file it as soon as possible. Do you have a timeframe you need this by?

>
> Dongliang Mu
>
>>> Hi Dan,
>>>
>>> this only occurs in linux-next tree.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/input/joystick/xpad.c?n2053#n2053
>>>
>>>>> Fix this by allocating xpad->dev, its error handling and cleanup
>>>>> operations in the remove function.
>>>>>
>>>>> Note that this crash does not have any reproducer, so the patch
>>>>> only passes compilation testing.
>>>> The xpad->dev = input_dev; already happens in xpad_init_input().  We
>>>> shouldn't allocate it twice.  I think the fix is to just use a different
>>>> device pointer for the dev_warn().  Why not use &xpad->intf->dev?
>>> Yeah, the allocation and assignment is in the last part that I missed before. We have two choices to fix this issue:
>>>
>>> 1. Change to another device pointer;
>>>
>>> 2. Move the allocation and assignment to a previous code site;
>>>
>>> If there is no other places dereferencing this pointer before the allocation and assignment, it's better to use the 1st one.
>>>
>>> Let me craft a v2 patch.
>>>
>>>>> Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
>>>> Could you use a Link tag to link to the bug report?
>>>> Link: https://groups.google.com/g/syzkaller-bugs/c/iMhTgpGuIbM
>>> Sure, no problem.
>>>> This needs a Fixes tag.
>>>>
>>>> Fixes: db7220c48d8d ("Input: xpad - fix support for some third-party controllers")
>>>>
>>>> regards,
>>>> dan carpenter
>>>>
>> Vicki
Vicki
