Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC476FA137
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjEHHlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjEHHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:40:59 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C361B0;
        Mon,  8 May 2023 00:40:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5A8D360161;
        Mon,  8 May 2023 09:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683531653; bh=LcsRoVzy2DsfLxqYmDIf21xsrKudxm9I91adDGLAktY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kpkbbbhysbx7FV4r4GiMggC8S1aYH1cojJpKgwLbFwSBOmBYMLxTqAm2BHKhcVAah
         o0vFAPc1vSafkN2TZC3csVTiF6i+YLCeBZZ4pZ4+pRuFsPN3/2HOy7svI5r04iuXdk
         Rcl+InBsuzzR8f9hUfv69sh9c0VHYwRuWMM5JcQT28aBflvW2HwpWDuNhybCunMLHK
         7kBgAa9YVYw1ATlRuUeFlXuYDHfOmr/4GMpudA7lpexe4wFTeqnlgQ55llNPE07Wq8
         YCGoSCVH2MJQXqOZUG2LFAXysoOGKmzhAhIdojMAWGPiGzVLAvYS0YnNZGXZnHlsHA
         QahDqaKbVfLgA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FxHpJaKemVL8; Mon,  8 May 2023 09:40:50 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 7AF3360173;
        Mon,  8 May 2023 09:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683531648; bh=LcsRoVzy2DsfLxqYmDIf21xsrKudxm9I91adDGLAktY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kllWp5gmJ4eJtIj26EGwrYCvMrhQkydfHbZwwwqsM/HcXj54ba7RaDjLu3naLfdxq
         60FZijE5iX7CrqK0S8/Vv7c7XUvyb+UqgdY96jOBrpEvf3yizyVQK7N8WIlStbyC7j
         pjEVVT5LnQUhzhmj4FV0cIVh53w8rDp0umNu0hbQ0usYZJp7PvTBON/Pe9gyLvstdk
         EdMtnIUXWcZiINrIF2WtcUbf/cXC/iZv5G/UgnyN+CGfqh3yz1DdGaoy/bFitVJRKx
         a6aHqhvGaxvFb+Ee7F88phLr9BQ8xxnSLtu2HoO2Ls+EGVPkEmz2l7Z75znhBOe+x6
         wXguearYfSlDA==
Message-ID: <30daba6b-e264-5141-221f-5daed103b4ce@alu.unizg.hr>
Date:   Mon, 8 May 2023 09:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] Kmemleak, possibly hiddev_connect(), in 6.3.0+ torvalds
 tree commit gfc4354c6e5c2
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
References: <f64b17fa-d509-ad30-6e8d-e4c979818047@alu.unizg.hr>
 <2023050824-juiciness-catching-9290@gregkh>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023050824-juiciness-catching-9290@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 08:51, Greg Kroah-Hartman wrote:
> On Mon, May 08, 2023 at 08:30:07AM +0200, Mirsad Goran Todorovac wrote:
>> Hi,
>>
>> There seems to be a kernel memory leak in the USB keyboard driver.
>>
>> The leaked memory allocs are 96 and 512 bytes.
>>
>> The platform is Ubuntu 22.04 LTS on a assembled AMD Ryzen 9 with X670E PG
>> Lightning mobo,
>> and Genius SlimStar i220 GK-080012 keyboard.
>>
>> (Logitech M100 HID mouse is not affected by the bug.)
>>
>> BIOS is:
>>
>>       *-firmware
>>            description: BIOS
>>            vendor: American Megatrends International, LLC.
>>            physical id: 0
>>            version: 1.21
>>            date: 04/26/2023
>>            size: 64KiB
>>
>> The kernel is 6.3.0-torvalds-<id>-13466-gfc4354c6e5c2.
>>
>> The keyboard is recognised as Chicony:
>>
>>                   *-usb
>>                        description: Keyboard
>>                        product: CHICONY USB Keyboard
>>                        vendor: CHICONY
>>                        physical id: 2
>>                        bus info: usb@5:2
>>                        logical name: input35
>>                        logical name: /dev/input/event4
>>                        logical name: input35::capslock
>>                        logical name: input35::numlock
>>                        logical name: input35::scrolllock
>>                        logical name: input36
>>                        logical name: /dev/input/event5
>>                        logical name: input37
>>                        logical name: /dev/input/event6
>>                        logical name: input38
>>                        logical name: /dev/input/event8
>>                        version: 2.30
>>                        capabilities: usb-2.00 usb
>>                        configuration: driver=usbhid maxpower=100mA
>> speed=1Mbit/s
>>
>> The bug is easily reproduced by unplugging the USB keyboard, waiting about a
>> couple of seconds,
>> and then reconnect and scan for memory leaks twice.
>>
>> The kmemleak log is as follows [edited privacy info]:
>>
>> root@hostname:/home/username# cat /sys/kernel/debug/kmemleak
>> unreferenced object 0xffff8dd020037c00 (size 96):
>>    comm "systemd-udevd", pid 435, jiffies 4294892550 (age 8909.356s)
>>    hex dump (first 32 bytes):
>>      5d 8e 4e b9 ff ff ff ff 00 00 00 00 00 00 00 00 ].N.............
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>    backtrace:
>>      [<ffffffffb81a74be>] __kmem_cache_alloc_node+0x22e/0x2b0
>>      [<ffffffffb8127b6e>] kmalloc_trace+0x2e/0xa0
>>      [<ffffffffb87543d9>] class_create+0x29/0x80
>>      [<ffffffffb8880d24>] usb_register_dev+0x1d4/0x2e0
> 
> As the call to class_create() in this path is now gone in 6.4-rc1, can
> you retry that release to see if this is still there or not?

Certainly, but probably not before 6 PM UTC+02.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

"What’s this thing suddenly coming towards me very fast? Very very fast.
... I wonder if it will be friends with me?"
