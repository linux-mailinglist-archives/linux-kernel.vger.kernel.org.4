Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B596E476E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDQMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjDQMTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:19:25 -0400
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD2E45;
        Mon, 17 Apr 2023 05:19:17 -0700 (PDT)
Received: from [192.168.0.22] (unknown [50.47.218.115])
        by endrift.com (Postfix) with ESMTPSA id 3D337A26F;
        Mon, 17 Apr 2023 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1681727094; bh=JA43lVo036H4z8mEHt/rfTldAIQx/mTNsK0w6tlee+k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kMLiwltEsxE0ltAmCKFbEYO+Vp8RHUvzM/aGQKLVz0EYFHTtGS3WnPNtGdSt+FJ7I
         r95LLzIpCj9e4P5Ng/uGvqqzw1ggX8yuO8mn3JOIHTdcgDwk65ZrZoZzQK15sk1SAf
         UEfr/Sn9CYAlHx2cheZfbg6RSOOxyYJr+zOZKyljjw7nF0o9734xNbBNAN08zVzwtF
         ACexDSPKnMykVph9fEVt9FHZMW0VsjdQCGgVegbY0iUkCzckBHldFyJ7uB4WXHJT6x
         pB27r5ER6DMWPYm4ku3S4fQnVA8v5Q96dGCv9vNiF2WjCGQWc2/Y9Khtua4oMfszsb
         CYyCnyyoAeFtA==
Message-ID: <38279d91-402c-7f8b-273d-0882a0567a0c@endrift.com>
Date:   Mon, 17 Apr 2023 03:24:52 -0700
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
From:   Vicki Pfau <vi@endrift.com>
In-Reply-To: <99794af0-7367-acff-357d-1cd4fa7f832e@hust.edu.cn>
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

Hi,

On 4/17/23 03:01, Dongliang Mu wrote:
> 
> On 2023/4/17 17:25, Dan Carpenter wrote:
>> On Fri, Apr 14, 2023 at 08:55:47PM +0800, Dongliang Mu wrote:
>>> In xpad_probe(), it does not allocate xpad->dev with input_dev type.
>>> Then, when it invokes dev_warn with 1st argument - &xpad->dev->dev, it
>>> would trigger GPF.
>> What is a call tree for this?  Actually I found it from the bug report.
>> drivers/input/joystick/xpad.c
>>    2034                  if (error)
>>    2035                          dev_warn(&xpad->dev->dev,
>>    2036                                   "unable to receive magic message: %d\n",
>>    2037                                   error);
>>    2038          }
> 

Sorry, this appears to be my code, and was merged recently after a few drafts with Dmitry. This code is sensitive to being moved and only affects some controllers, so I'm looking into if I can move it into after creation of the input_dev right now. It's something I'd already thought might be necessary, but I didn't find any evidence for it before. I'll try to get back to you on that soon.

> Hi Dan,
> 
> this only occurs in linux-next tree.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/input/joystick/xpad.c?n2053#n2053
> 
>>> Fix this by allocating xpad->dev, its error handling and cleanup
>>> operations in the remove function.
>>>
>>> Note that this crash does not have any reproducer, so the patch
>>> only passes compilation testing.
>> The xpad->dev = input_dev; already happens in xpad_init_input().  We
>> shouldn't allocate it twice.  I think the fix is to just use a different
>> device pointer for the dev_warn().  Why not use &xpad->intf->dev?
> 
> Yeah, the allocation and assignment is in the last part that I missed before. We have two choices to fix this issue:
> 
> 1. Change to another device pointer;
> 
> 2. Move the allocation and assignment to a previous code site;
> 
> If there is no other places dereferencing this pointer before the allocation and assignment, it's better to use the 1st one.
> 
> Let me craft a v2 patch.
> 
>>
>>> Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com
>> Could you use a Link tag to link to the bug report?
>> Link: https://groups.google.com/g/syzkaller-bugs/c/iMhTgpGuIbM
> Sure, no problem.
>>
>> This needs a Fixes tag.
>>
>> Fixes: db7220c48d8d ("Input: xpad - fix support for some third-party controllers")
>>
>> regards,
>> dan carpenter
>>

Vicki
