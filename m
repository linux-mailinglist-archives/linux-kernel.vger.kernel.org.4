Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E0658BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiL2Kq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiL2Kqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:46:49 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0001274D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:46:47 -0800 (PST)
Received: from [192.168.0.2] (ip5f5ae935.dynamic.kabel-deutschland.de [95.90.233.53])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 00A7360027FCF;
        Thu, 29 Dec 2022 11:46:43 +0100 (CET)
Message-ID: <03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de>
Date:   Thu, 29 Dec 2022 11:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>, coreboot@coreboot.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: memcpy: detected field-spanning write (size 168) of single field
 "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Running Linux v6.2-rc1+ on a motherboard using coreboot as firmware, the 
warning below is shown.

```
[    1.630244] ------------[ cut here ]------------
[    1.630249] memcpy: detected field-spanning write (size 168) of 
single field "&device->entry" at 
drivers/firmware/google/coreboot_table.c:103 (size 8)
[    1.630299] WARNING: CPU: 1 PID: 150 at 
drivers/firmware/google/coreboot_table.c:103 
coreboot_table_probe+0x1ea/0x210 [coreboot_table]
[    1.630307] Modules linked in: coreboot_table(+) sg binfmt_misc fuse 
ipv6 autofs4
[    1.630316] CPU: 1 PID: 150 Comm: systemd-udevd Not tainted 
6.2.0-rc1-00097-gaebfba447cae #407
[    1.630318] Hardware name: ASUS F2A85-M_PRO/F2A85-M_PRO, BIOS 
4.18-4-gb3dd5af9c5 12/28/2022
[    1.630320] RIP: 0010:coreboot_table_probe+0x1ea/0x210 [coreboot_table]
[    1.630326] Code: 08 00 00 00 4c 89 c6 4c 89 04 24 48 c7 c2 50 81 60 
c0 48 c7 c7 98 81 60 c0 4c 89 4c 24 08 c6 05 ab 1e 00 00 01 e8 e1 ca 47 
d3 <0f> 0b 4c 8b 4c 24 08 4c 8b 04 24 e9 35 ff ff ff 41 be ea ff ff ff
[    1.630329] RSP: 0018:ffffb409c046fc30 EFLAGS: 00010286
[    1.630332] RAX: 0000000000000000 RBX: ffffb409c0175018 RCX: 
0000000000000000
[    1.630334] RDX: 0000000000000001 RSI: ffffffff94222bcd RDI: 
00000000ffffffff
[    1.630336] RBP: ffff937a44a06c00 R08: 0000000000000000 R09: 
00000000ffffdfff
[    1.630338] R10: ffffb409c046fad8 R11: ffffffff9452a948 R12: 
0000000000000000
[    1.630339] R13: ffffb409c0175000 R14: 0000000000000000 R15: 
ffff937a40beb410
[    1.630341] FS:  0000000000000000(0000) GS:ffff937abb500000(0063) 
knlGS:00000000f7f43800
[    1.630343] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[    1.630345] CR2: 00000000f7e3c2cf CR3: 00000001046de000 CR4: 
00000000000406e0
[    1.630347] Call Trace:
[    1.630348]  <TASK>
[    1.630351]  platform_probe+0x3f/0xa0
[    1.630357]  really_probe+0xe1/0x390
[    1.630361]  ? pm_runtime_barrier+0x50/0x90
[    1.630365]  __driver_probe_device+0x78/0x180
[    1.630369]  driver_probe_device+0x1e/0x90
[    1.630372]  __driver_attach+0xd2/0x1c0
[    1.630375]  ? __pfx___driver_attach+0x10/0x10
[    1.630378]  bus_for_each_dev+0x78/0xc0
[    1.630382]  bus_add_driver+0x1a9/0x200
[    1.630385]  driver_register+0x8f/0xf0
[    1.630387]  ? __pfx_init_module+0x10/0x10 [coreboot_table]
[    1.630392]  coreboot_table_driver_init+0x2d/0xff0 [coreboot_table]
[    1.630397]  do_one_initcall+0x44/0x220
[    1.630401]  ? kmalloc_trace+0x25/0x90
[    1.630405]  do_init_module+0x4c/0x1f0
[    1.630409]  __do_sys_finit_module+0xb4/0x130
[    1.630413]  __do_fast_syscall_32+0x6f/0xf0
[    1.630418]  do_fast_syscall_32+0x2f/0x70
[    1.630421]  entry_SYSCALL_compat_after_hwframe+0x71/0x79
[    1.630425] RIP: 0023:0xf7f49549
[    1.630428] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 
07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 cd 0f 05 cd 
80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
[    1.630430] RSP: 002b:00000000ffa7bbbc EFLAGS: 00200292 ORIG_RAX: 
000000000000015e
[    1.630433] RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 
00000000f7f28e09
[    1.630434] RDX: 0000000000000000 RSI: 00000000568cb4c0 RDI: 
000000005689fc50
[    1.630436] RBP: 0000000000000000 R08: 00000000ffa7bbbc R09: 
0000000000000000
[    1.630437] R10: 0000000000000000 R11: 0000000000200292 R12: 
0000000000000000
[    1.630439] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[    1.630442]  </TASK>
[    1.630443] ---[ end trace 0000000000000000 ]---
```

Another user reported this with Linux 6.1.1 in the Arch Linux forum [1].


Kind regards,

Paul


[1]: https://bbs.archlinux.org/viewtopic.php?id=282245
      "6.1.1-arch1-1 - dmesg"
