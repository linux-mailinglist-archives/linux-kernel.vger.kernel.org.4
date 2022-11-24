Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000106374E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiKXJNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKXJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:13:13 -0500
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD1910B40F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:13:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=zelin.deng@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VVaTOuf_1669281177;
Received: from alinux-host.hz.ali.com(mailfrom:zelin.deng@linux.alibaba.com fp:SMTPD_---0VVaTOuf_1669281177)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 17:13:06 +0800
From:   Zelin Deng <zelin.deng@linux.alibaba.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: [PATCH 0/2] Map initrd as encrypted when relocating if SME is enabled
Date:   Thu, 24 Nov 2022 17:12:44 +0800
Message-Id: <20221124091246.4957-1-zelin.deng@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found an issue on SME enabled AMD machine when initrd is relocated if
it was located in e820 reserved area.
For example key dmesg output:
...
[mem 0x000000005aafe000-0x000000006005ffff] reserved //e820 mapping
Move RAMDISK from [mem 0x5aafe000-0x5ccd5167] //relocate_initrd()
...

Early initrd will be copied by copy_from_early_mem() which will clear
encrypted pgprot flag as initrd source address is not in kernel usable
area. As initrd has been encrypted at earlier stage, encrypted data is
copied, which leads new initrd cannot be unpacked, then rootfs cannot be
mounted.
dmesg output:
...
[   11.296725] Trying to unpack rootfs image as initramfs...
[   11.302127] Initramfs unpacking failed: invalid magic at start of compressed archive
...
[   16.698152] /dev/root: Can't open blockdev
[   16.702255] VFS: Cannot open root device "PARTUUID=0ad58d87-05c7-43f8-b147-93140ad315e5" or unknown-block(0,0): error -6
[   16.713114] Please append a correct "root=" boot option; here are the available partitions:
[   16.721462] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[   16.729716] CPU: 9 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc5-next-20221114 #3
[   16.737099] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, BIOS RYM1008B 01/19/2022
[   16.745175] Call Trace:
[   16.747623]  <TASK>
[   16.749727]  dump_stack_lvl+0x38/0x4c
[   16.753393]  panic+0xfb/0x28a
[   16.771999]  ? _printk+0x4c/0x52
[   16.775224]  mount_block_root+0x143/0x1dd
[   16.779237]  prepare_namespace+0x13f/0x16e
[   16.783334]  kernel_init_freeable+0x15a/0x164
[   16.787687]  ? __pfx_kernel_init+0x10/0x10
[   16.791785]  kernel_init+0x1a/0x130
[   16.795268]  ret_from_fork+0x29/0x50
[   16.798840]  </TASK>

To fix this issue, early initrd must be mapped as encrypted when it is
being relocated.

Zelin Deng (2):
  mm/early_ioremap.c: Always build early_memremap_prot() in x86
  x86/setup: Preserve _ENC flag when initrd is being relocated

 arch/x86/Kconfig                    |  1 +
 arch/x86/kernel/setup.c             | 30 ++++++++++++++++++++++++++++-
 include/asm-generic/early_ioremap.h |  6 ------
 mm/early_ioremap.c                  | 21 --------------------
 4 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.27.0

