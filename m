Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19A2700F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbjELTIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjELTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:08:08 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9136B59ED;
        Fri, 12 May 2023 12:08:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 4B3E26016E;
        Fri, 12 May 2023 21:08:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683918485; bh=olPRuHD47Mn/7ru/A/AU2wqJbQyl0hcJAZoJt24S8b0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n0amUuwxKfyl6u3w9Up9M9WEW8L1ktwEBk4ZeY9RHI0yfOMyO09yJAORw9idWWHe+
         Mj1/nwQuBysv8K42RqLjpGAYA45j+wnl/swlarBnb6Xn1vJa2FieUtklZv3iVOUYB8
         MOSuyD28Cu4G2js7K3z7Leac91uew8n2EahpaJQ9Bisc0vjRwa3pu5f2dFYT0s9IwU
         TYQ3NTo5Ee5RwqSchxC8GtxeW4ms8UGwosDqa/z0DpDK7UkCsVxoBJASNleVsJvLGn
         tMZCJqyor7hajgsyPBB005xqTLCgYiNsxFFD9rtoCSxzHoq9ro4W6O01MA25nBv4ni
         oy/+ZGyxJJTRg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wjCYGLiUAO0z; Fri, 12 May 2023 21:08:02 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 57AF66015F;
        Fri, 12 May 2023 21:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683918482; bh=olPRuHD47Mn/7ru/A/AU2wqJbQyl0hcJAZoJt24S8b0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SlNPyqe9ANF2mDBCUgIKRo9twyZ4/8XFVaX+KNR7gKreruAfFNpPK2+57LLLfj2Ly
         LIVwhjXd7elXMIgns87Yxl9plUphLoUgg9xrgqMCQSJ4/5dmeTffBLaC7sYgC9pVEe
         QRZm2oPPzux1FnqXuiUBke7Zdft7PmMutlE9hehTJW28dO1N1GNp9jErm0wADmDCHe
         rRfmOuvGKBnr0Giz61tpAHROwNApjSx/qExm87KwLJ7vrHSWcV0yJ14uLIbXkDd2/m
         J34+EEXp+iYaQAOBH8hBJYPeakVebJDKeIhKGay4wL3GCU0uQ0dr4hMs9qbsd9lIR3
         gebW6z6h4gdrA==
Message-ID: <32dc44cd-b559-78eb-56ef-f651a598b6fc@alu.unizg.hr>
Date:   Fri, 12 May 2023 21:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [BUG] Kmemleak, possibly hiddev_connect(), in 6.3.0+ torvalds
 tree commit gfc4354c6e5c2
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
References: <f64b17fa-d509-ad30-6e8d-e4c979818047@alu.unizg.hr>
 <2023050824-juiciness-catching-9290@gregkh>
 <2023050854-collage-dreamt-660c@gregkh>
 <c73471aa-522a-83a4-5614-506581604301@alu.unizg.hr>
 <2023050958-precut-vividly-94bf@gregkh>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023050958-precut-vividly-94bf@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg,

On 09. 05. 2023. 04:59, Greg Kroah-Hartman wrote:
> On Tue, May 09, 2023 at 01:51:35AM +0200, Mirsad Goran Todorovac wrote:
>>
>>
>> On 08. 05. 2023. 16:01, Greg Kroah-Hartman wrote:
>>> On Mon, May 08, 2023 at 08:51:55AM +0200, Greg Kroah-Hartman wrote:
>>>> On Mon, May 08, 2023 at 08:30:07AM +0200, Mirsad Goran Todorovac wrote:
>>>>> Hi,
>>>>>
>>>>> There seems to be a kernel memory leak in the USB keyboard driver.
>>>>>
>>>>> The leaked memory allocs are 96 and 512 bytes.
>>>>>
>>>>> The platform is Ubuntu 22.04 LTS on a assembled AMD Ryzen 9 with X670E PG
>>>>> Lightning mobo,
>>>>> and Genius SlimStar i220 GK-080012 keyboard.
>>>>>
>>>>> (Logitech M100 HID mouse is not affected by the bug.)
>>>>>
>>>>> BIOS is:
>>>>>
>>>>>        *-firmware
>>>>>             description: BIOS
>>>>>             vendor: American Megatrends International, LLC.
>>>>>             physical id: 0
>>>>>             version: 1.21
>>>>>             date: 04/26/2023
>>>>>             size: 64KiB
>>>>>
>>>>> The kernel is 6.3.0-torvalds-<id>-13466-gfc4354c6e5c2.
>>>>>
>>>>> The keyboard is recognised as Chicony:
>>>>>
>>>>>                    *-usb
>>>>>                         description: Keyboard
>>>>>                         product: CHICONY USB Keyboard
>>>>>                         vendor: CHICONY
>>>>>                         physical id: 2
>>>>>                         bus info: usb@5:2
>>>>>                         logical name: input35
>>>>>                         logical name: /dev/input/event4
>>>>>                         logical name: input35::capslock
>>>>>                         logical name: input35::numlock
>>>>>                         logical name: input35::scrolllock
>>>>>                         logical name: input36
>>>>>                         logical name: /dev/input/event5
>>>>>                         logical name: input37
>>>>>                         logical name: /dev/input/event6
>>>>>                         logical name: input38
>>>>>                         logical name: /dev/input/event8
>>>>>                         version: 2.30
>>>>>                         capabilities: usb-2.00 usb
>>>>>                         configuration: driver=usbhid maxpower=100mA
>>>>> speed=1Mbit/s
>>>>>
>>>>> The bug is easily reproduced by unplugging the USB keyboard, waiting about a
>>>>> couple of seconds,
>>>>> and then reconnect and scan for memory leaks twice.
>>>>>
>>>>> The kmemleak log is as follows [edited privacy info]:
>>>>>
>>>>> root@hostname:/home/username# cat /sys/kernel/debug/kmemleak
>>>>> unreferenced object 0xffff8dd020037c00 (size 96):
>>>>>     comm "systemd-udevd", pid 435, jiffies 4294892550 (age 8909.356s)
>>>>>     hex dump (first 32 bytes):
>>>>>       5d 8e 4e b9 ff ff ff ff 00 00 00 00 00 00 00 00 ].N.............
>>>>>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>>>>     backtrace:
>>>>>       [<ffffffffb81a74be>] __kmem_cache_alloc_node+0x22e/0x2b0
>>>>>       [<ffffffffb8127b6e>] kmalloc_trace+0x2e/0xa0
>>>>>       [<ffffffffb87543d9>] class_create+0x29/0x80
>>>>>       [<ffffffffb8880d24>] usb_register_dev+0x1d4/0x2e0
>>>>
>>>> As the call to class_create() in this path is now gone in 6.4-rc1, can
>>>> you retry that release to see if this is still there or not?
>>>
>>> No, wait, it's still there, I was looking at a development branch of
>>> mine that isn't sent upstream yet.  And syzbot just reported the same
>>> thing:
>>> 	https://lore.kernel.org/r/00000000000058d15f05fb264013@google.com
>>>
>>> So something's wrong here, let me dig into it tomorrow when I get a
>>> chance...
>>
>> If this could help, here is the bisect of the bug (I could not discern what
>> could possibly be wrong):
>>
>> user@host:~/linux/kernel/linux_torvalds$ git bisect log
>> git bisect start
>> # bad: [ac9a78681b921877518763ba0e89202254349d1b] Linux 6.4-rc1
>> git bisect bad ac9a78681b921877518763ba0e89202254349d1b
>> # good: [c9c3395d5e3dcc6daee66c6908354d47bf98cb0c] Linux 6.2
>> git bisect good c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
>> # good: [85496c9b3bf8dbe15e2433d3a0197954d323cadc] Merge branch
>> 'net-remove-some-rcu_bh-cruft'
>> git bisect good 85496c9b3bf8dbe15e2433d3a0197954d323cadc
>> # good: [b68ee1c6131c540a62ecd443be89c406401df091] Merge tag 'scsi-misc' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
>> git bisect good b68ee1c6131c540a62ecd443be89c406401df091
>> # bad: [888d3c9f7f3ae44101a3fd76528d3dd6f96e9fd0] Merge tag 'sysctl-6.4-rc1'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux
>> git bisect bad 888d3c9f7f3ae44101a3fd76528d3dd6f96e9fd0
>> # good: [34b62f186db9614e55d021f8c58d22fc44c57911] Merge tag
>> 'pci-v6.4-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
>> git bisect good 34b62f186db9614e55d021f8c58d22fc44c57911
>> # good: [34da76dca4673ab1819830b4924bb5b436325b26] Merge tag
>> 'for-linus-2023042601' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
>> git bisect good 34da76dca4673ab1819830b4924bb5b436325b26
>> # good: [97b2ff294381d05e59294a931c4db55276470cb5] Merge tag
>> 'staging-6.4-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
>> git bisect good 97b2ff294381d05e59294a931c4db55276470cb5
>> # good: [2025b2ca8004c04861903d076c67a73a0ec6dfca] mcb-lpc: Reallocate
>> memory region to avoid memory overlapping
>> git bisect good 2025b2ca8004c04861903d076c67a73a0ec6dfca
>> # bad: [d06f5a3f7140921ada47d49574ae6fa4de5e2a89] cdx: fix build failure due
>> to sysfs 'bus_type' argument needing to be const
>> git bisect bad d06f5a3f7140921ada47d49574ae6fa4de5e2a89
>> # good: [dcfbb67e48a2becfce7990386e985b9c45098ee5] driver core: class: use
>> lock_class_key already present in struct subsys_private
>> git bisect good dcfbb67e48a2becfce7990386e985b9c45098ee5
>> # bad: [6f14c02220c791d5c46b0f965b9340c58f3d503d] driver core: create
>> class_is_registered()
>> git bisect bad 6f14c02220c791d5c46b0f965b9340c58f3d503d
>> # good: [2f9e87f5a2941b259336c7ea6c5a1499ede4554a] driver core: Add a
>> comment to set_primary_fwnode() on nullifying
>> git bisect good 2f9e87f5a2941b259336c7ea6c5a1499ede4554a
>> # bad: [02fe26f25325b547b7a31a65deb0326c04bb5174] firmware_loader: Add debug
>> message with checksum for FW file
>> git bisect bad 02fe26f25325b547b7a31a65deb0326c04bb5174
>> # good: [884f8ce42ccec9d0bf11d8bf9f111e5961ca1c82] driver core: class:
>> implement class_get/put without the private pointer.
>> git bisect good 884f8ce42ccec9d0bf11d8bf9f111e5961ca1c82
>> # bad: [3f84aa5ec052dba960baca4ab8a352d43d47028e] base: soc: populate
>> machine name in soc_device_register if empty
>> git bisect bad 3f84aa5ec052dba960baca4ab8a352d43d47028e
>> # bad: [7b884b7f24b42fa25e92ed724ad82f137610afaf] driver core: class.c:
>> convert to only use class_to_subsys
>> git bisect bad 7b884b7f24b42fa25e92ed724ad82f137610afaf
>> # first bad commit: [7b884b7f24b42fa25e92ed724ad82f137610afaf] driver core:
>> class.c: convert to only use class_to_subsys
>> user@host:~/linux/kernel/linux_torvalds$
> 
> This helps a lot, thanks.  I got the reference counting wrong somewhere
> in here, I thought I tested this better, odd it shows up now...
> 
> I'll try to work on it this week.
> 
> thanks,
> 
> greg k-h

Not at all!

I hope you had better luck because this part of code still looks to me 
like hieroglyphs.

Linux kernel rose to 10.9M lines, and it would take me thirty years to
just read it once, 1000 lines a day ... 6.7M lines are "just drivers".

# find . -name '*.c' -o -name '*.h' -print0 | wc --files0-from -
10913623 35587483 631377958 total
# find drivers -name '*.c' -o -name '*.h' -print0 | wc --files0-from -
6705084 19985060 495162001 total

Best regards,
Mirsad
