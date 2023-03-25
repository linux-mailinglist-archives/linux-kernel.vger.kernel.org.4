Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BB6C8D7E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCYLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:33:56 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94372BBAB;
        Sat, 25 Mar 2023 04:33:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 526CE604F9;
        Sat, 25 Mar 2023 12:33:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679744032; bh=RlZgyi+tS7aRyxFWz64AEOKfAsmAVediC20jw5/LlwA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=GbzOIxq+Pi7pbAiYJ4lNIv2rtwm2cmSQwoB7YkaydHPQA/H62KcZjTu43lAofmOhD
         SAqy+4uSYBLJ+9Xvmm3xiV+hZfCBCM/gvjNnneCkvBb2PYaNi07idpVSWTq/vp4zIS
         NWfpxmtrIH3YGzglAkerbdad5DXeW5yTqmiU1r6B5v7BJDwIlSkY2ymSBSTiXbAwYc
         6o33j2kN50hFchnSXCn3AuW/392kY7k1K/44W2n3Tt63PqGP9v+u1ajjq68L59Eo7m
         4i/AVSVjAukTrkYu04rUZDa+XD9zKgUSRKvoKIN5k81Mc2Yq5QXWerD9eTbu/MlhG/
         l0qMGM4Sihv/w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dg4JcpiHd7Hz; Sat, 25 Mar 2023 12:33:49 +0100 (CET)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id E1044604EF;
        Sat, 25 Mar 2023 12:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679744029; bh=RlZgyi+tS7aRyxFWz64AEOKfAsmAVediC20jw5/LlwA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=pWHB1WcWAio4Cca04EgXjjOCTnp88e5KmDbFVP9YOxekjAi65skA8V82Di+DNQfDD
         TmRldqwcb4MJCFJT8A3IayG2+nleTii4UxqrIKusQRl/11iNztR8vK4j/tBCRmSDGk
         qBuS1JVXYdDY2qG2QlHXFFKNovownGfnNXHHK22lEjGd5/T5cXISI6ePj+CGsRGBo0
         I+Xn9HuAcEUhluRzRf1pLU9n2qiKlkG3BZzQh2mKVQ9cJ5V/jShA3O70eJCQEknxLF
         zdIo7PNdQAwNpx63YhiIl+SDtxyNuJoafDGrtsJR4SXmJzrvfc3NjAHrin1vAF3y1J
         UeDciLe9S+8xw==
Message-ID: <651c0500-2b84-d938-fdc2-45e92b322b38@alu.unizg.hr>
Date:   Sat, 25 Mar 2023 12:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: BUG: drivers/usb/host/xhci: memleak in alloc from
 xhci_disable_usb3_lpm_timeout()
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>
References: <24263902-c9b3-ce29-237b-1c3d6918f4fe@alu.unizg.hr>
In-Reply-To: <24263902-c9b3-ce29-237b-1c3d6918f4fe@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 03. 2023. 12:27, Mirsad Goran Todorovac wrote:
> Hi all!
> 
> Here are again the good news and the bad news:
> 
> BAD:  another kernel memory leak detected (one more to hunt down and fix)
> GOOD: another kernel memory leak detected (one less unaccounted for)
> 
> I tried to make some fun, but maintainers are busy folks, so let's get down
> to business:
> 
> ---
> Nine (9) new systemd-udevd kernel memory leaks occurred (unable to reproduce).
> 
> The platform is Ubuntu 22.10 with (relatively recent) systemd 251.4-1ubuntu7.1
> on LENOVO_MT_82H8_BU_idea_FM_IdeaPad 3 15ITL6 with BIOS GGCN51WW from 11/16/2022.
> 
> The symptom (/sys/kernel/debug/kmemleak output):
> 
> unreferenced object 0xffff909698ff9280 (size 64):
>   comm "systemd-udevd", pid 436, jiffies 4294893239 (age 6287.088s)
>   hex dump (first 32 bytes):
>     e0 51 bb 99 96 90 ff ff 00 00 00 00 00 00 00 00  .Q..............
>     40 5b bb 99 96 90 ff ff 00 00 00 00 00 00 00 00  @[..............
>   backtrace:
>     [<ffffffffb29de94c>] slab_post_alloc_hook+0x8c/0x320
>     [<ffffffffb29e5107>] __kmem_cache_alloc_node+0x1c7/0x2b0
>     [<ffffffffb2962f3b>] kmalloc_node_trace+0x2b/0xa0
>     [<ffffffffb31af2ec>] xhci_alloc_command+0x7c/0x1b0
>     [<ffffffffb31af451>] xhci_alloc_command_with_ctx+0x21/0x70
>     [<ffffffffb31a8a3e>] xhci_change_max_exit_latency+0x2e/0x1c0
>     [<ffffffffb31a8c5b>] xhci_disable_usb3_lpm_timeout+0x7b/0xb0
>     [<ffffffffb31457a7>] usb_disable_link_state+0x57/0xe0
>     [<ffffffffb3145f46>] usb_disable_lpm+0x86/0xc0
>     [<ffffffffb3145fc1>] usb_unlocked_disable_lpm+0x31/0x60
>     [<ffffffffb3155db6>] usb_disable_device+0x136/0x250
>     [<ffffffffb3156b23>] usb_set_configuration+0x583/0xa70
>     [<ffffffffb3164c6d>] usb_generic_driver_disconnect+0x2d/0x40
>     [<ffffffffb3158612>] usb_unbind_device+0x32/0x90
>     [<ffffffffb3022295>] device_remove+0x65/0x70
>     [<ffffffffb3023903>] device_release_driver_internal+0xc3/0x140
> unreferenced object 0xffff909699bb5b40 (size 32):
>   comm "systemd-udevd", pid 436, jiffies 4294893239 (age 6287.088s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     50 5b bb 99 96 90 ff ff 50 5b bb 99 96 90 ff ff  P[......P[......
>   backtrace:
>     [<ffffffffb29de94c>] slab_post_alloc_hook+0x8c/0x320
>     [<ffffffffb29e5107>] __kmem_cache_alloc_node+0x1c7/0x2b0
>     [<ffffffffb2962f3b>] kmalloc_node_trace+0x2b/0xa0
>     [<ffffffffb31af364>] xhci_alloc_command+0xf4/0x1b0
>     [<ffffffffb31af451>] xhci_alloc_command_with_ctx+0x21/0x70
>     [<ffffffffb31a8a3e>] xhci_change_max_exit_latency+0x2e/0x1c0
>     [<ffffffffb31a8c5b>] xhci_disable_usb3_lpm_timeout+0x7b/0xb0
>     [<ffffffffb31457a7>] usb_disable_link_state+0x57/0xe0
>     [<ffffffffb3145f46>] usb_disable_lpm+0x86/0xc0
>     [<ffffffffb3145fc1>] usb_unlocked_disable_lpm+0x31/0x60
>     [<ffffffffb3155db6>] usb_disable_device+0x136/0x250
>     [<ffffffffb3156b23>] usb_set_configuration+0x583/0xa70
>     [<ffffffffb3164c6d>] usb_generic_driver_disconnect+0x2d/0x40
>     [<ffffffffb3158612>] usb_unbind_device+0x32/0x90
>     [<ffffffffb3022295>] device_remove+0x65/0x70
>     [<ffffffffb3023903>] device_release_driver_internal+0xc3/0x140
> unreferenced object 0xffff909699bb51e0 (size 32):
>   comm "systemd-udevd", pid 436, jiffies 4294893239 (age 6287.088s)
>   hex dump (first 32 bytes):
>     02 00 00 00 20 04 00 00 00 a0 ff 98 96 90 ff ff  .... ...........
>     00 a0 ff 18 01 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffffb29de94c>] slab_post_alloc_hook+0x8c/0x320
>     [<ffffffffb29e5107>] __kmem_cache_alloc_node+0x1c7/0x2b0
>     [<ffffffffb2962f3b>] kmalloc_node_trace+0x2b/0xa0
>     [<ffffffffb31ad86e>] xhci_alloc_container_ctx+0x7e/0x140
>     [<ffffffffb31af469>] xhci_alloc_command_with_ctx+0x39/0x70
>     [<ffffffffb31a8a3e>] xhci_change_max_exit_latency+0x2e/0x1c0
>     [<ffffffffb31a8c5b>] xhci_disable_usb3_lpm_timeout+0x7b/0xb0
>     [<ffffffffb31457a7>] usb_disable_link_state+0x57/0xe0
>     [<ffffffffb3145f46>] usb_disable_lpm+0x86/0xc0
>     [<ffffffffb3145fc1>] usb_unlocked_disable_lpm+0x31/0x60
>     [<ffffffffb3155db6>] usb_disable_device+0x136/0x250
>     [<ffffffffb3156b23>] usb_set_configuration+0x583/0xa70
>     [<ffffffffb3164c6d>] usb_generic_driver_disconnect+0x2d/0x40
>     [<ffffffffb3158612>] usb_unbind_device+0x32/0x90
>     [<ffffffffb3022295>] device_remove+0x65/0x70
>     [<ffffffffb3023903>] device_release_driver_internal+0xc3/0x140
> .
> .
> .
> 
> Please find the config, lshw output and complete /sys/kernel/debug/kmemleak
> output here:
> 
> https://domac.alu.unizg.hr/~mtodorov/linux/bugreports/systemd-udevd/kmemleak.log
> 
> https://domac.alu.unizg.hr/~mtodorov/linux/bugreports/systemd-udevd/lshw.txt
> https://domac.alu.unizg.hr/~mtodorov/linux/bugreports/systemd-udevd/config-6.3.0-rc3-kobj-rlse-00317-g65aca32efdcb
> 
> The systemd issue tracker said they accept issues only for the most recent 253 and
> 252, 251.4 seems too old for them despite being issued on May 21, 2022
> (Source: https://github.com/systemd/systemd/releases).
> 
> It is not that I want to dump this on Linux kernel developers, but I felt
> like it is a kernel memory leak problem rather than a bug in systemd-udevd.
> 
> Of course, my hunch might be wrong ...
> 
> As per Code of Conduct, I have checked for the developers and maintainers with
> scripts/get_maintainers.pl.

By the Murphy's Law, it appears that I forgot the most impotant thing:
the kernel is 6.3-rc+ commit 65aca32efdcb from Torvalds tree, with
KMEMLEAK, CONFIG_DEBUG_{KOBJECT|KOBJECT_RELEASE} enabled.

Have a nice day.

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

