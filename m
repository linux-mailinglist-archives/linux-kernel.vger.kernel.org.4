Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C15268AB75
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 18:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBDRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 12:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBDRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 12:10:02 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1802831E0F;
        Sat,  4 Feb 2023 09:09:58 -0800 (PST)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 314H9h6r037810;
        Sun, 5 Feb 2023 02:09:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sun, 05 Feb 2023 02:09:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 314H9hMh037807
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Feb 2023 02:09:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
Date:   Sun, 5 Feb 2023 02:09:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Converting dev->mutex into dev->spinlock ?
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y96HiYcreb8jZIHi@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/05 1:27, Alan Stern wrote:
> On Sun, Feb 05, 2023 at 01:12:12AM +0900, Tetsuo Handa wrote:
>> On 2023/02/05 0:34, Alan Stern wrote:
>>>> A few of examples:
>>>>
>>>>   https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101
>>>
>>> It's hard to figure out what's wrong from looking at the syzbot report.  
>>> What makes you think it is connected with dev->mutex?
>>>
>>> At first glance, it seems that the ath6kl driver is trying to flush a 
>>> workqueue while holding a lock or mutex that is needed by one of the 
>>> jobs in the workqueue.  That's obviously never going to work, no matter 
>>> what sort of lockdep validation gets used.
>>
>> That lock is exactly dev->mutex where lockdep validation is disabled.
>> If lockdep validation on dev->mutex were not disabled, we can catch
>> possibility of deadlock before khungtaskd reports real deadlock as hung.
>>
>> Lockdep validation on dev->mutex being disabled is really annoying, and
>> I want to make lockdep validation on dev->mutex enabled; that is the
>> "drivers/core: Remove lockdep_set_novalidate_class() usage" patch.
> 
>> Even if it is always safe to acquire a child device's lock while holding
>> the parent's lock, disabling lockdep checks completely on device's lock is
>> not safe.
> 
> I understand the problem you want to solve, and I understand that it
> can be frustrating.  However, I do not believe you will be able to
> solve this problem.

That is a declaration that driver developers are allowed to take it for granted
that driver callback functions can behave as if dev->mutex is not held. 

Some developers test their changes with lockdep enabled, and believe that their
changes are correct because lockdep did not complain.
https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174 is an example.

We should somehow update driver core code to make it possible to keep lockdep
checks enabled on dev->mutex.

