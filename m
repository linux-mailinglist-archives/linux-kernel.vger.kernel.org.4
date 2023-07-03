Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9A77454C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGCFTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCFTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:19:02 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D991B0;
        Sun,  2 Jul 2023 22:19:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A9CA660171;
        Mon,  3 Jul 2023 07:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688361539; bh=YrRwssvEZf7TEjeYffqKvvPzOJpbpuQXW2iU38aXF1Y=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=CkGyc98cih6y1+GqDH4Sq4aZWeuJYIzAn2XgUJ1tivrJNXuwGA1fUwdjpgEfzXX4C
         gYaJ5An1Ep/XtzGBwiZdRhTV2VMpfrIGUx3dZVEh3TELCRUHXYgCE6C6I8tW3JlqRA
         lMvHL8MjN6+rvCOs+x/pagm6NjZ3W5RnFTgHqztEY4BieK+X3frE+vR1eU6f5MvR7G
         NjCuLj1i2shhc8XiNzcNQhuY0raFB7MNumWHNax/q+5Zc2QIU3OrATyw/6Ek+hz1Ie
         yTjuIjyVIcbIRCB5bX45G1317okBlP9gDrOxRqKd1YXuMOiQFlUK0ccSxfR2RT5gSs
         V6ji2o2HejKcw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 87-Kur6UvLhF; Mon,  3 Jul 2023 07:18:57 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 1F10A60173;
        Mon,  3 Jul 2023 07:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688361537; bh=YrRwssvEZf7TEjeYffqKvvPzOJpbpuQXW2iU38aXF1Y=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=J8a7mj3/pI57LDpgBwNlMtIZiRmAmiZhSz/AIY89EcSCVOwPBbGlzmPjd0Y+EoMDp
         rpet5V5QZ2+IicQZQ/YzTU+Wg0V+y6ii1cXUpna00aL+R7YZPVTiD0SQdzPr22LgH6
         Jz8kqxscTLwtKQQxQctJn7/3RwJxn0U87PixpOPY5jdtiMio2HAWLgNoz7g98ocDjS
         RA/m6aMb3yUnfFZRhzQWe70vY+xeT1Hw9pQ48yPanrxS2I3Q/lHdtUCVxlfip2NK8+
         PdbXNUdQVS8VLAJIugaXKghXvBKDrKdvNKpL57p6RE38zzIhnoUkrsBsGYwGn4UCK8
         pMgtqXG2KebcA==
Message-ID: <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
Date:   Mon, 3 Jul 2023 07:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
To:     Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me> <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
 <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net>
Content-Language: en-US
In-Reply-To: <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 05:58, Guenter Roeck wrote:
> On 7/2/23 20:26, Guenter Roeck wrote:
>> On 7/2/23 20:20, Kees Cook wrote:
>>> On Mon, Jul 03, 2023 at 08:44:37AM +0700, Bagas Sanjaya wrote:
>>>> On Sun, Jul 02, 2023 at 06:36:12PM +0200, Mirsad Goran Todorovac wrote:
>>>>> Hi,
>>>>>
>>>>> After new git pull the kernel in Torvalds tree with default debug config
>>>>> failed to boot with error that occurs prior to mounting filesystems, so there
>>>>> is no log safe for the screenshot(s) here:
>>>>>
>>>>> [1] https://domac.alu.unizg.hr/~mtodorov/linux/crashes/2023-07-02/
>>>>>
>>>>> Bisect shows the first bad commit is 2d47c6956ab3 (v6.4-rc2-1-g2d47c6956ab3):
>>>>>
>>>>> # good: [98be618ad03010b1173fc3c35f6cbb4447ee2b07] Merge tag 'Smack-for-6.5' of https://github.com/cschaufler/smack-next
>>>>> git bisect good 98be618ad03010b1173fc3c35f6cbb4447ee2b07
>>>>> # bad: [f4a0659f823e5a828ea2f45b4849ea8e2dd2984c] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
>>>>> git bisect bad f4a0659f823e5a828ea2f45b4849ea8e2dd2984c
>>>>> .
>>>>> .
>>>>> .
>>>>> # bad: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
>>>>> git bisect bad 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c
>>>>> # first bad commit: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
>>>>>
>>>>> The architecture is Ubuntu 22.04 with lshw and config give in the attachment.
>>>>
>>>> Can you show early kernel log (something like dmesg)?
>>>>
>>>> Anyway, I'm adding it to regzbot:
>>>>
>>>> #regzbot ^introduced: 2d47c6956ab3c8
>>>> #regzbot title: Linux kernel fails to boot due to UBSAN_BOUNDS tightening
>>>
>>> I'm confused. Commit 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c isn't in the v6.4
>>> tree... it's only in Linus's ToT.
>>>
>>
>> In ToT:
>>
>> $ git describe 2d47c6956ab3
>> v6.4-rc2-1-g2d47c6956ab3
>>
>> $ git describe --contains 2d47c6956ab3
>> next-20230616~2^2~51
>> $ git describe --contains --match 'v*' 2d47c6956ab3
>> fatal: cannot describe '2d47c6956ab3c8b580a59d7704aab3e2a4882b6c'
>>
>> "git describe" always shows the parent tree, which I guess was based on
>> v6.4-rc2.
>>
> 
> Ah, sorry, I didn't realize that the subject claims that the problem
> would be in 6.4.1. That indeed does not match the bisect results.

I apologise for confusion. In fact, I have cloned the Torvalds tree after
6.4.1 was released, but I actually cloned the Torvalds tree, not the 6.4.1
from the stable branch as the Subject line might have misled.

But I think the text explained that the Torvalds tree was cloned
and the method:

] After new git pull the kernel in Torvalds tree with default debug config
] failed to boot with error that occurs prior to mounting filesystems, so there
] is no log safe for the screenshot(s) here:

I will try to be more consistent and precise the next time.

Sorry again for the confusion.

I am right now cloning directly from the Torvalds tree for the third time
and with the Ubuntu generic production kernel and the result is the same:
crash in boot for 2d47c6956ab3.

Best regards,
Mirsad Todorovac
