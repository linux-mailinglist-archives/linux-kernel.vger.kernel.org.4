Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353DE645118
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLGBZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLGBZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:25:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89CA51C26
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:25:29 -0800 (PST)
Received: from kwepemm600010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRfhk3wPKzmWK8;
        Wed,  7 Dec 2022 09:24:38 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 09:25:27 +0800
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
To:     Palmer Dabbelt <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <liaochang1@huawei.com>, <rdunlap@infradead.org>,
        <u.kleine-koenig@pengutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <lizhengyu3@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
 <167027930833.25586.2671834159281320615.b4-ty@rivosinc.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <75925d58-ee92-e0f0-d1df-d8bd1d3fcfe3@huawei.com>
Date:   Wed, 7 Dec 2022 09:25:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <167027930833.25586.2671834159281320615.b4-ty@rivosinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/6 6:28, Palmer Dabbelt wrote:
> On Fri, 4 Nov 2022 17:56:57 +0800, Li Huafei wrote:
>> This is reported by kmemleak detector:
>>
>> unreferenced object 0xff60000082864000 (size 9588):
>>   comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
>>   hex dump (first 32 bytes):
>>     d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
>>     00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
>>   backtrace:
>>     [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
>>     [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
>>     [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
>>     [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
>>     [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
>>     [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
>>     [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
>>     [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
>>     [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
>>     [<0000000040c62c03>] ret_from_syscall+0x0/0x2
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] RISC-V: kexec: Fix memory leak of fdt buffer
>       https://git.kernel.org/palmer/c/96df59b1ae23
> [2/2] RISC-V: kexec: Fix memory leak of elf header buffer
>       https://git.kernel.org/palmer/c/cbc32023ddbd
> 
> These are on for-next.  They'd probably be fine fixes candidates had I gotten
> to them in time, but it's pretty late and a leak during kexec doesn't seem like
> a show-stopper.  They'll get backported anyway, but this way they get an extra
> week in linux-next just to see.
> 

I have no problem with it being merged into the -next branch. Thanks Palmer!

> Best regards,
> 
