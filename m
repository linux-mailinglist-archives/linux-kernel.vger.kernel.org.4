Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E2682903
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAaJhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjAaJhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:37:32 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671A2FCE7;
        Tue, 31 Jan 2023 01:37:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 92534604F5;
        Tue, 31 Jan 2023 10:37:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1675157826; bh=FtN4LMS8C9+3nz9zfUMZh9plV6iw9nUPLDBqeq51mBE=;
        h=Date:To:Cc:From:Subject:From;
        b=uOEAq8aLWgrNzRvF9QLqw7QJSGA+Fs7TDBtV4FPQmV2xxXe4i+/Nezm+JYGPw8T9G
         MYSJaaXFAGCfvKbp/+8vi25mAetYtUVPyHT6tNMrQf3J2knzLUlZkTwo0d5GzqSYrt
         H9cIx3HVLwH+tCG6hMZux6TkjCa7pWcyRWFVWdQ3f37WkcftXoiw4X+vmAKUYcDReb
         UCKyxKpLwm2v+FLPuDdZQfMjshasGItGjbK6EG6DRlZK53vAV5EXO/AI345g3wvN4S
         L9oYvZeu8EMsnle+h6MNXt2u4ouukIda8mq0VvjGZbUogAtynoXQI/2Q6xgYX0ndGk
         ZkCMj6XlaPyug==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BdyIDR776n-g; Tue, 31 Jan 2023 10:37:04 +0100 (CET)
Received: from [10.0.1.83] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id B242B604F3;
        Tue, 31 Jan 2023 10:37:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1675157824; bh=FtN4LMS8C9+3nz9zfUMZh9plV6iw9nUPLDBqeq51mBE=;
        h=Date:To:Cc:From:Subject:From;
        b=EX7nbdij7cszzqeF1vHyqDG2QVANaT73h07X2w+0UruKIjkMZ0AgWbXhZFCtkzgSs
         ntTA1ywFHsGqtBz++8QUCXotevZI4WF5uBH2OG/M+GUVi1Y/CBWlIAZoMLlYUhwaXy
         uYfUP6kOXZ25Wj+rtqxP/+xExEvFGv9jS7dwFV34A3/WjiTxHQFouc7+sC/ONoYAUM
         N3dAB27geg9AgPi550dfAmzKWXAqZB0qapui/xb7GRQDtU/UlM8J9DWMgTZXt5XPA3
         ejs3k1PLem9gwtqg3OFWs0ODSivcbBMEjQlT+PWNr+mqxhzNfKFwxbz7qFx7Kf0HuT
         xo+MN58O+LEhA==
Message-ID: <cdb562c5-040e-687f-a61f-4273fc356ff3@alu.unizg.hr>
Date:   Tue, 31 Jan 2023 10:36:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: INFO: memory leak in gpio device in 6.2-rc6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I came across this memory leak apparently in the GPIO device driver.
It is still present in 6.2-rc6 release candidate kernel (just ran kselftest).

This is a vanilla Torvalds tree kernel with MGLRU and KMEMLEAK (obviously)
enabled.

If you think this bug is significant, I can attempt the bug bisect in the
environment that triggered it (Lenovo LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
with BIOS M22KT49A from 11/10/2022 and AlmaLinux 8.7.

Here is the /sys/kernel/debug/kmemleak output:

unreferenced object 0xffff9e67ad71f160 (size 32):
   comm "gpio-sim.sh", pid 208926, jiffies 4372229685 (age 2101.564s)
   hex dump (first 32 bytes):
     67 70 69 6f 2d 73 69 6d 2e 30 2d 6e 6f 64 65 30  gpio-sim.0-node0
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<0000000098bf3d1b>] slab_post_alloc_hook+0x91/0x320
     [<00000000da3205c5>] __kmem_cache_alloc_node+0x1bf/0x2b0
     [<00000000aa51a58a>] __kmalloc_node_track_caller+0x55/0x140
     [<00000000bd682ecc>] kvasprintf+0x6b/0xd0
     [<00000000a3431d55>] kasprintf+0x4e/0x70
     [<00000000f52d2629>] gpio_sim_device_config_live_store+0x401/0x59d [gpio_sim]
     [<00000000673fc6df>] configfs_write_iter+0xcc/0x130
     [<000000001d5d0829>] vfs_write+0x2b4/0x3d0
     [<00000000d2336251>] ksys_write+0x61/0xe0
     [<00000000f7015bb1>] __x64_sys_write+0x1a/0x20
     [<000000008ac743d2>] do_syscall_64+0x58/0x80
     [<000000004d7b7d50>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
[root@pc-mtodorov marvin]#

Regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
