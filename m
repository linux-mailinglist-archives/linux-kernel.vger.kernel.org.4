Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217B36CBD30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjC1LNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC1LNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:13:42 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9777AB4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:13:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A425F60503;
        Tue, 28 Mar 2023 13:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680002016; bh=I3tFezEZvZX4Xdw5MZDm0hFqH34BbGEX2pOEVyHB1r0=;
        h=Date:To:From:Subject:From;
        b=JjPJ2m09CIS0f65YJUqYKu+xD4X/ceQufSxtlsKPQJQPVu3o1nq2zXgE4/eCtvBo5
         n5LogTxEAik0DfrN/iXMVcNZtZuIrFzkvjm4Bb2XyiyPH63wx+r+rGXJITyxT9Bp6Q
         d7EsLl58EMukVCSpcC35y2WJVUpAXhH7sTUCD+Eq4gAfrNrON68zCK/BawONScnCUD
         4c15Y7DlzYdg0sWiHVr4Wqmen2Euvqd+dk1CVB96/NX9yFalfqLNhMR/tpvs2wcK0p
         Trx3mVoEjoeIDAH1skr9LtQllpXBHkv/HSeQ/r7Nx+efwSW347dtZ2qNguTJGaDIRs
         j6CupvFpmj97g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TCzyvDnmIaOu; Tue, 28 Mar 2023 13:13:34 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id ED72F60502;
        Tue, 28 Mar 2023 13:13:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680002014; bh=I3tFezEZvZX4Xdw5MZDm0hFqH34BbGEX2pOEVyHB1r0=;
        h=Date:To:From:Subject:From;
        b=oR76mfTXlBa6XIKi5DpS63e6xMzRHme2szj9ELzQJrpi/MFgH8r3hOR8oMHiAfzer
         YcMkrrfIFk6xqhDg36Ie/rCFn4HMeHaUX2ujzVhKVVGOswkjAVrSuVJwBzAAZkKgCA
         3nxXa3GScM6AuhJV0MFx4uHLuOFNhypFbtzp0UlxP11uzfuPNe6TEmD+O57weTFU9M
         Yi3lGxjMMsq6LauFB7/Yl529PObrYztb/a2NERW1zSKR1KDgDN0nyzZ6vVZ/Nn5IIj
         LH4DkyhgRZ+ZMorVbnGIQjbB8kbdK4r/IjQhAoPZsFA6B0pHtbkxASkKuQDC0WebC/
         iHyf9EKscF5wg==
Message-ID: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
Date:   Tue, 28 Mar 2023 13:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, hr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [BUG] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is another kernel memory leak report, just as I thought we have done with
them by the xhci patch by Mathias.

The memory leaks were caught on an AlmaLinux 8.7 (CentOS) fork system, running
on a Lenovo desktop box (see lshw.txt) and the newest Linux kernel 6.3-rc4 commit
g3a93e40326c8 with Mathias' patch for a xhci systemd-devd triggered leak.

         See: <20230327095019.1017159-1-mathias.nyman@linux.intel.com> on LKML.

This leak is also systemd-devd triggered, except for the memstick_check() leaks
which I was unable to bisect due to the box not booting older kernels (work in
progress).

unreferenced object 0xffff88ad12392710 (size 96):
   comm "systemd-udevd", pid 735, jiffies 4294896759 (age 2257.568s)
   hex dump (first 32 bytes):
     53 65 72 69 61 6c 50 6f 72 74 31 41 64 64 72 65  SerialPort1Addre
     73 73 2c 33 46 38 2f 49 52 51 34 3b 5b 4f 70 74  ss,3F8/IRQ4;[Opt
   backtrace:
     [<ffffffffae8fb26c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffffae902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffffae8773c9>] __kmalloc_node_track_caller+0x59/0x180
     [<ffffffffae866a1a>] kstrdup+0x3a/0x70
     [<ffffffffc0d839aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
     [<ffffffffc0d83b64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
     [<ffffffffc0d842b1>] tlmi_probe+0x591/0xba0 [think_lmi]
     [<ffffffffc051dc53>] wmi_dev_probe+0x163/0x230 [wmi]
     [<ffffffffaef987eb>] really_probe+0x17b/0x3d0
     [<ffffffffaef98ad4>] __driver_probe_device+0x84/0x190
     [<ffffffffaef98c14>] driver_probe_device+0x24/0xc0
     [<ffffffffaef98ed2>] __driver_attach+0xc2/0x190
     [<ffffffffaef95ab1>] bus_for_each_dev+0x81/0xd0
     [<ffffffffaef97c62>] driver_attach+0x22/0x30
     [<ffffffffaef97354>] bus_add_driver+0x1b4/0x240
     [<ffffffffaef9a0a2>] driver_register+0x62/0x120
unreferenced object 0xffff88ad0845a840 (size 64):
   comm "systemd-udevd", pid 735, jiffies 4294896783 (age 2257.488s)
   hex dump (first 32 bytes):
     55 53 42 50 6f 72 74 41 63 63 65 73 73 2c 45 6e  USBPortAccess,En
     61 62 6c 65 64 3b 5b 4f 70 74 69 6f 6e 61 6c 3a  abled;[Optional:
   backtrace:
     [<ffffffffae8fb26c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffffae902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffffae8773c9>] __kmalloc_node_track_caller+0x59/0x180
     [<ffffffffae866a1a>] kstrdup+0x3a/0x70
     [<ffffffffc0d839aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
     [<ffffffffc0d83b64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
     [<ffffffffc0d842b1>] tlmi_probe+0x591/0xba0 [think_lmi]
     [<ffffffffc051dc53>] wmi_dev_probe+0x163/0x230 [wmi]
     [<ffffffffaef987eb>] really_probe+0x17b/0x3d0
     [<ffffffffaef98ad4>] __driver_probe_device+0x84/0x190
     [<ffffffffaef98c14>] driver_probe_device+0x24/0xc0
     [<ffffffffaef98ed2>] __driver_attach+0xc2/0x190
     [<ffffffffaef95ab1>] bus_for_each_dev+0x81/0xd0
     [<ffffffffaef97c62>] driver_attach+0x22/0x30
     [<ffffffffaef97354>] bus_add_driver+0x1b4/0x240
     [<ffffffffaef9a0a2>] driver_register+0x62/0x120
unreferenced object 0xffff88ad069f5e40 (size 64):
   comm "systemd-udevd", pid 735, jiffies 4294896822 (age 2257.332s)
   hex dump (first 32 bytes):
     55 53 42 42 49 4f 53 53 75 70 70 6f 72 74 2c 45  USBBIOSSupport,E
     6e 61 62 6c 65 64 3b 5b 4f 70 74 69 6f 6e 61 6c  nabled;[Optional
   backtrace:
     [<ffffffffae8fb26c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffffae902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffffae8773c9>] __kmalloc_node_track_caller+0x59/0x180
     [<ffffffffae866a1a>] kstrdup+0x3a/0x70
     [<ffffffffc0d839aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
     [<ffffffffc0d83b64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
     [<ffffffffc0d842b1>] tlmi_probe+0x591/0xba0 [think_lmi]
     [<ffffffffc051dc53>] wmi_dev_probe+0x163/0x230 [wmi]
     [<ffffffffaef987eb>] really_probe+0x17b/0x3d0
     [<ffffffffaef98ad4>] __driver_probe_device+0x84/0x190
     [<ffffffffaef98c14>] driver_probe_device+0x24/0xc0
     [<ffffffffaef98ed2>] __driver_attach+0xc2/0x190
     [<ffffffffaef95ab1>] bus_for_each_dev+0x81/0xd0
     [<ffffffffaef97c62>] driver_attach+0x22/0x30
     [<ffffffffaef97354>] bus_add_driver+0x1b4/0x240
     [<ffffffffaef9a0a2>] driver_register+0x62/0x120
[snip]

Please see build config and the more verbose debug output at the URL:

https://domac.alu.hr/~mtodorov/linux/bugreports/driver_register/

I hope this helps someone.

This one is way too complex to even attempt guessing what went wrong,
with my current knowledge of the Linux kernel internals.

Please contact me for any additional required information.

As usual, I have Cc:-ed all maintainers as per get_maintainers.pl script.

Thank you very much for your patience.

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
