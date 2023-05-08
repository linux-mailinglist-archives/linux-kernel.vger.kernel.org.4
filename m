Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4886FA029
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjEHGwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEHGwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6539DA5DE;
        Sun,  7 May 2023 23:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CADB861F40;
        Mon,  8 May 2023 06:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF37DC433EF;
        Mon,  8 May 2023 06:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683528723;
        bh=M/Q12ygS5Lrso8R9nyop81hg2ZlhKYBSdWRe3nCpEIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1wCHauNi5QLiaRL7SmSfre0aQrIAGFFqov50dna9lXBk/7pSoVI9eRnBXwZzMdrQ
         /VScc7UusH7//9LI82fHs10l9D48+fBVNESueKcztNFHd/1jgNNCSBjbKBWKgcnyTm
         4gnThDjhSUMZr8ar7DRis3JjAu82X5vIRqvMFs7I=
Date:   Mon, 8 May 2023 08:51:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [BUG] Kmemleak, possibly hiddev_connect(), in 6.3.0+ torvalds
 tree commit gfc4354c6e5c2
Message-ID: <2023050824-juiciness-catching-9290@gregkh>
References: <f64b17fa-d509-ad30-6e8d-e4c979818047@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f64b17fa-d509-ad30-6e8d-e4c979818047@alu.unizg.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 08:30:07AM +0200, Mirsad Goran Todorovac wrote:
> Hi,
> 
> There seems to be a kernel memory leak in the USB keyboard driver.
> 
> The leaked memory allocs are 96 and 512 bytes.
> 
> The platform is Ubuntu 22.04 LTS on a assembled AMD Ryzen 9 with X670E PG
> Lightning mobo,
> and Genius SlimStar i220 GK-080012 keyboard.
> 
> (Logitech M100 HID mouse is not affected by the bug.)
> 
> BIOS is:
> 
>      *-firmware
>           description: BIOS
>           vendor: American Megatrends International, LLC.
>           physical id: 0
>           version: 1.21
>           date: 04/26/2023
>           size: 64KiB
> 
> The kernel is 6.3.0-torvalds-<id>-13466-gfc4354c6e5c2.
> 
> The keyboard is recognised as Chicony:
> 
>                  *-usb
>                       description: Keyboard
>                       product: CHICONY USB Keyboard
>                       vendor: CHICONY
>                       physical id: 2
>                       bus info: usb@5:2
>                       logical name: input35
>                       logical name: /dev/input/event4
>                       logical name: input35::capslock
>                       logical name: input35::numlock
>                       logical name: input35::scrolllock
>                       logical name: input36
>                       logical name: /dev/input/event5
>                       logical name: input37
>                       logical name: /dev/input/event6
>                       logical name: input38
>                       logical name: /dev/input/event8
>                       version: 2.30
>                       capabilities: usb-2.00 usb
>                       configuration: driver=usbhid maxpower=100mA
> speed=1Mbit/s
> 
> The bug is easily reproduced by unplugging the USB keyboard, waiting about a
> couple of seconds,
> and then reconnect and scan for memory leaks twice.
> 
> The kmemleak log is as follows [edited privacy info]:
> 
> root@hostname:/home/username# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8dd020037c00 (size 96):
>   comm "systemd-udevd", pid 435, jiffies 4294892550 (age 8909.356s)
>   hex dump (first 32 bytes):
>     5d 8e 4e b9 ff ff ff ff 00 00 00 00 00 00 00 00 ].N.............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>   backtrace:
>     [<ffffffffb81a74be>] __kmem_cache_alloc_node+0x22e/0x2b0
>     [<ffffffffb8127b6e>] kmalloc_trace+0x2e/0xa0
>     [<ffffffffb87543d9>] class_create+0x29/0x80
>     [<ffffffffb8880d24>] usb_register_dev+0x1d4/0x2e0

As the call to class_create() in this path is now gone in 6.4-rc1, can
you retry that release to see if this is still there or not?

thanks,

greg k-h
