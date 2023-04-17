Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69E26E4731
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjDQMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:11:09 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A876B9034;
        Mon, 17 Apr 2023 05:10:38 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:34f3:1550:a448:b8c8] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33HBFNXM017083-33HBFNXN017083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 17 Apr 2023 19:15:25 +0800
Message-ID: <f0618995-7d1f-50a6-8729-e64db9df104b@hust.edu.cn>
Date:   Mon, 17 Apr 2023 19:15:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
To:     Vicki Pfau <vi@endrift.com>, Dan Carpenter <error27@gmail.com>
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
 <69fc3a73-f18b-0268-6431-1b8b6aeed8ff@endrift.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <69fc3a73-f18b-0268-6431-1b8b6aeed8ff@endrift.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/17 19:07, Vicki Pfau wrote:
>
> On 4/17/23 03:33, Dongliang Mu wrote:
>> On 2023/4/17 18:24, Vicki Pfau wrote:
>>> Hi,
>>>
>>> On 4/17/23 03:01, Dongliang Mu wrote:
>>>> On 2023/4/17 17:25, Dan Carpenter wrote:
>>>>> On Fri, Apr 14, 2023 at 08:55:47PM +0800, Dongliang Mu wrote:
>>>>>> In xpad_probe(), it does not allocate xpad->dev with input_dev type.
>>>>>> Then, when it invokes dev_warn with 1st argument - &xpad->dev->dev, it
>>>>>> would trigger GPF.
>>>>> What is a call tree for this?  Actually I found it from the bug report.
>>>>> drivers/input/joystick/xpad.c
>>>>>      2034                  if (error)
>>>>>      2035                          dev_warn(&xpad->dev->dev,
>>>>>      2036                                   "unable to receive magic message: %d\n",
>>>>>      2037                                   error);
>>>>>      2038          }
>>> Sorry, this appears to be my code, and was merged recently after a few drafts with Dmitry. This code is sensitive to being moved and only affects some controllers, so I'm looking into if I can move it into after creation of the input_dev right now. It's something I'd already thought might be necessary, but I didn't find any evidence for it before. I'll try to get back to you on that soon.
>> If this is necessary, we can change it with another device pointer. Otherwise, we need to move it after the allocation and assignment. Or move the allocation and assignment before which is not suggested.
>>
>> Thanks for your reply. Do I need to submit a v2 patch? Or you will take care of it?
> I'll take care of it. I have a patch prepared, but I need to do a bit more testing before I can confirm it doesn't break one specific controller. I'll try to file it as soon as possible. Do you have a timeframe you need this by?
You can follow your own plan since I am an enthusiast who discovers and 
patches security vulnerabilities, instead of reply on the functionability.
>
>> Dongliang Mu
>>
>>>> Hi Dan,
>>>>
>>>> this only occurs in linux-next tree.
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/input/joystick/xpad.c?n2053#n2053
>>>>
>>>>>> Fix this by allocating xpad->dev, its error handling and cleanup
>>>>>> operations in the remove function.
>>>>>>
>>>>>> Note that this crash does not have any reproducer, so the patch
>>>>>> only passes compilation testing.
>>>>> The xpad->dev = input_dev; already happens in xpad_init_input().  We
>>>>> shouldn't allocate it twice.  I think the fix is to just use a different
>>>>> device pointer for the dev_warn().  Why not use &xpad->intf->dev?
>>>> Yeah, the allocation and assignment is in the last part that I missed before. We have two choices to fix this issue:
>>>>
>>>> 1. Change to another device pointer;
>>>>
>>>> 2. Move the allocation and assignment to a previous code site;
>>>>
>>>> If there is no other places dereferencing this pointer before the allocation and assignment, it's better to use the 1st one.
>>>>
>>>> Let me craft a v2 patch.
>>>>
>>>>>> Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
>>>>> Could you use a Link tag to link to the bug report?
>>>>> Link: https://groups.google.com/g/syzkaller-bugs/c/iMhTgpGuIbM
>>>> Sure, no problem.
>>>>> This needs a Fixes tag.
>>>>>
>>>>> Fixes: db7220c48d8d ("Input: xpad - fix support for some third-party controllers")
>>>>>
>>>>> regards,
>>>>> dan carpenter
>>>>>
>>> Vicki
> Vicki
