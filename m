Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7C638150
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 00:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKXXVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 18:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXXVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 18:21:40 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D8685A00
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 15:21:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=zelin.deng@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VVcQp4A_1669332094;
Received: from 192.168.1.5(mailfrom:zelin.deng@linux.alibaba.com fp:SMTPD_---0VVcQp4A_1669332094)
          by smtp.aliyun-inc.com;
          Fri, 25 Nov 2022 07:21:35 +0800
Message-ID: <f4a8462f-62e3-433d-9b84-6b2dd070854c@linux.alibaba.com>
Date:   Fri, 25 Nov 2022 07:21:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Map initrd as encrypted when relocating if SME is
 enabled
To:     Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
References: <20221124091246.4957-1-zelin.deng@linux.alibaba.com>
 <763b73a4-55b6-2cd3-02e9-1086d36cf270@amd.com>
From:   Zelin Deng <zelin.deng@linux.alibaba.com>
In-Reply-To: <763b73a4-55b6-2cd3-02e9-1086d36cf270@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/24 22:26, Tom Lendacky 写道:
> On 11/24/22 03:12, Zelin Deng wrote:
>> I found an issue on SME enabled AMD machine when initrd is relocated if
>> it was located in e820 reserved area.
>> For example key dmesg output:
>> ...
>> [mem 0x000000005aafe000-0x000000006005ffff] reserved //e820 mapping
>> Move RAMDISK from [mem 0x5aafe000-0x5ccd5167] //relocate_initrd()
>> ...
>>
>> Early initrd will be copied by copy_from_early_mem() which will clear
>> encrypted pgprot flag as initrd source address is not in kernel usable
>> area. As initrd has been encrypted at earlier stage, encrypted data is
>> copied, which leads new initrd cannot be unpacked, then rootfs cannot be
>> mounted.
>
> This is actually a bug in Grub where the kernel and initrd was moved 
> out of loader_code/data and into runtime_service_code/data. This 
> commit has since been reverted because it goes against the UEFI 
> specification. It was a small window, but the bad version was picked 
> up by some distros. No need for a kernel change, please update your 
> version of Grub.
>
> Thanks,
> Tom
>
Hi Tom,

Thank you for clarification, I will update my grub and try again.

Thanks,

Zelin Deng

>> dmesg output:
>> ...
>> [   11.296725] Trying to unpack rootfs image as initramfs...
>> [   11.302127] Initramfs unpacking failed: invalid magic at start of 
>> compressed archive
>> ...
>> [   16.698152] /dev/root: Can't open blockdev
>> [   16.702255] VFS: Cannot open root device 
>> "PARTUUID=0ad58d87-05c7-43f8-b147-93140ad315e5" or 
>> unknown-block(0,0): error -6
>> [   16.713114] Please append a correct "root=" boot option; here are 
>> the available partitions:
>> [   16.721462] Kernel panic - not syncing: VFS: Unable to mount root 
>> fs on unknown-block(0,0)
>> [   16.729716] CPU: 9 PID: 1 Comm: swapper/0 Not tainted 
>> 6.1.0-rc5-next-20221114 #3
>> [   16.737099] Hardware name: AMD Corporation DAYTONA_X/DAYTONA_X, 
>> BIOS RYM1008B 01/19/2022
>> [   16.745175] Call Trace:
>> [   16.747623]  <TASK>
>> [   16.749727]  dump_stack_lvl+0x38/0x4c
>> [   16.753393]  panic+0xfb/0x28a
>> [   16.771999]  ? _printk+0x4c/0x52
>> [   16.775224]  mount_block_root+0x143/0x1dd
>> [   16.779237]  prepare_namespace+0x13f/0x16e
>> [   16.783334]  kernel_init_freeable+0x15a/0x164
>> [   16.787687]  ? __pfx_kernel_init+0x10/0x10
>> [   16.791785]  kernel_init+0x1a/0x130
>> [   16.795268]  ret_from_fork+0x29/0x50
>> [   16.798840]  </TASK>
>>
>> To fix this issue, early initrd must be mapped as encrypted when it is
>> being relocated.
>>
>> Zelin Deng (2):
>>    mm/early_ioremap.c: Always build early_memremap_prot() in x86
>>    x86/setup: Preserve _ENC flag when initrd is being relocated
>>
>>   arch/x86/Kconfig                    |  1 +
>>   arch/x86/kernel/setup.c             | 30 ++++++++++++++++++++++++++++-
>>   include/asm-generic/early_ioremap.h |  6 ------
>>   mm/early_ioremap.c                  | 21 --------------------
>>   4 files changed, 30 insertions(+), 28 deletions(-)
>>
