Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52B741DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjF2Ble (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjF2Bl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:41:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0889F2D54;
        Wed, 28 Jun 2023 18:41:23 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qs1PV5cglzqTNR;
        Thu, 29 Jun 2023 09:41:02 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 09:41:20 +0800
CC:     <v-songbaohua@oppo.com>, Christoph Hellwig <hch@lst.de>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <paulmck@kernel.org>, <bp@suse.de>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <kim.phillips@amd.com>,
        <rostedt@goodmis.org>, <thunder.leizhen@huawei.com>,
        <ardb@kernel.org>, <bhe@redhat.com>, <anshuman.khandual@arm.com>,
        <song.bao.hua@hisilicon.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
To:     Barry Song <21cnbao@gmail.com>, Yajun Deng <yajun.deng@linux.dev>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tian Tao <tiantao6@hisilicon.com>
References: <20230515094955.GB23880@lst.de>
 <20230512094210.141540-1-yajun.deng@linux.dev>
 <055f964384a2bb4ba51c64a0be6072c9@linux.dev>
 <20230515133821.769158bb@meshulam.tesarici.cz>
 <20230623174046.66ce934bcf5c1303003a5afc@linux-foundation.org>
 <a18b0cf466191b0d692e431fe33c7c80@linux.dev>
 <CAGsJ_4xZp_1jLZnsZsUzaxvkkaOv=FDOiGKNgCmPN1gvJugSTg@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <78c3ebc1-c235-0b2c-b740-76141f886bfd@huawei.com>
Date:   Thu, 29 Jun 2023 09:41:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4xZp_1jLZnsZsUzaxvkkaOv=FDOiGKNgCmPN1gvJugSTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/26 13:32, Barry Song wrote:
> On Sun, Jun 25, 2023 at 7:30 PM Yajun Deng <yajun.deng@linux.dev> wrote:
>>
>> June 24, 2023 8:40 AM, "Andrew Morton" <akpm@linux-foundation.org> wrote:
>>
>>> On Mon, 15 May 2023 13:38:21 +0200 Petr Tesařík <petr@tesarici.cz> wrote:
>>>
>>>> On Mon, 15 May 2023 11:23:27 +0000
>>>> "Yajun Deng" <yajun.deng@linux.dev> wrote:
>>>>
>>>> May 15, 2023 5:49 PM, "Christoph Hellwig" <hch@lst.de> wrote:
>>>
>>> This looks fine to me. Can you please work with Barry to make sure
>>> the slight different place of the initcall doesn't break anything
>>> for his setup? I doubt it would, but I'd rather have a Tested-by:
>>> tag.
>>>> Barry's email is no longer in use. I can't reach him.
>>>>
>>>> Which one? I would hope that his Gmail account is still valid:
>>>>
>>>> Barry Song <21cnbao@gmail.com>
>>>
>>> Maybe his kernel.org address works...
>>>
>>> I have this patch stuck in limbo for 6.4. I guess I'll carry it over
>>> into the next -rc cycle, see what happens.
>>>
>>> fwiw, it has been in -next for six weeks, no known issues.
>>
>> Hi, Barry, The slight different place of the initcall, does break anything?
> 
> i don't see a fundamental difference as anyway it is still after
> arch_numa_init()
> which is really what we depend on.
> 
> and i did a test on qemu with the command line:
> qemu-system-aarch64 -M virt,gic-version=3 -nographic \
>  -smp cpus=8 \
>  -numa node,cpus=0-1,nodeid=0 \
>  -numa node,cpus=2-3,nodeid=1 \
>  -numa node,cpus=4-5,nodeid=2 \
>  -numa node,cpus=6-7,nodeid=3 \
>  -numa dist,src=0,dst=1,val=12 \
>  -numa dist,src=0,dst=2,val=20 \
>  -numa dist,src=0,dst=3,val=22 \
>  -numa dist,src=1,dst=2,val=22 \
>  -numa dist,src=2,dst=3,val=12 \
>  -numa dist,src=1,dst=3,val=24 \
>  -m 4096M -cpu cortex-a57 -kernel arch/arm64/boot/Image \
>  -nographic -append "cma_pernuma=32M root=/dev/vda2  rw ip=dhcp
> sched_debug irqchip.gicv3_pseudo_nmi=1" \
>  -drive if=none,file=extra/ubuntu16.04-arm64.img,id=hd0 -device
> virtio-blk-device,drive=hd0 \
>  -net nic -net user,hostfwd=tcp::2222-:22
> 
> and in system, i can see all cma areas are correctly reserved:
> ~# dmesg | grep cma
> [    0.000000] cma: cma_declare_contiguous_nid(size
> 0x0000000002000000, base 0x0000000000000000, limit 0x0000000000000000
> alignment 0x0000000000000000)
> [    0.000000] cma: Reserved 32 MiB at 0x000000007ce00000
> [    0.000000] cma: dma_pernuma_cma_reserve: reserved 32 MiB on node 0
> [    0.000000] cma: cma_declare_contiguous_nid(size
> 0x0000000002000000, base 0x0000000000000000, limit 0x0000000000000000
> alignment 0x0000000000000000)
> [    0.000000] cma: Reserved 32 MiB at 0x00000000bce00000
> [    0.000000] cma: dma_pernuma_cma_reserve: reserved 32 MiB on node 1
> [    0.000000] cma: cma_declare_contiguous_nid(size
> 0x0000000002000000, base 0x0000000000000000, limit 0x0000000000000000
> alignment 0x0000000000000000)
> [    0.000000] cma: Reserved 32 MiB at 0x00000000fce00000
> [    0.000000] cma: dma_pernuma_cma_reserve: reserved 32 MiB on node 2
> [    0.000000] cma: cma_declare_contiguous_nid(size
> 0x0000000002000000, base 0x0000000000000000, limit 0x0000000000000000
> alignment 0x0000000000000000)
> [    0.000000] cma: Reserved 32 MiB at 0x0000000100000000
> [    0.000000] cma: dma_pernuma_cma_reserve: reserved 32 MiB on node 3
> [    0.000000] cma: dma_contiguous_reserve(limit 100000000)
> [    0.000000] cma: dma_contiguous_reserve: reserving 32 MiB for global area
> [    0.000000] cma: cma_declare_contiguous_nid(size
> 0x0000000002000000, base 0x0000000000000000, limit 0x0000000100000000
> alignment 0x0000000000000000)
> [    0.000000] cma: Reserved 32 MiB at 0x00000000fae00000
> [    0.000000] Kernel command line: cma_pernuma=32M root=/dev/vda2  rw
> ip=dhcp sched_debug irqchip.gicv3_pseudo_nmi=1
> [    0.000000] Memory: 3848784K/4194304K available (16128K kernel
> code, 4152K rwdata, 10244K rodata, 8512K init, 612K bss, 181680K
> reserved, 163840K cma-reserved)
> [    0.175309] cma: cma_alloc(cma (____ptrval____), count 128, align 7)
> [    0.179264] cma: cma_alloc(): returned (____ptrval____)
> [    0.179869] cma: cma_alloc(cma (____ptrval____), count 128, align 7)
> [    0.180027] cma: cma_alloc(): returned (____ptrval____)
> [    0.180187] cma: cma_alloc(cma (____ptrval____), count 128, align 7)
> [    0.180374] cma: cma_alloc(): returned (____ptrval____)
> 
> so my feeling is that this patch is fine. but I would prefer Yicong
> and Tiantao who have a real numa machine
> and we can get some real device drivers to call dma APIs to allocate
> memory from pernuma cma on arm64
> even though it is 99.9% OK.
> 

Tested on our 4 NUMA arm64 server based on mainline commit 1ef6663a587b,
this patch works well, so:

Tested-by: Yicong Yang <yangyicong@hisilicon.com>

For pernuma cma reservation:
[    0.000000] cma: cma_declare_contiguous_nid(size 0x0000000040000000, base 0x0000000000000000, limit 0x0000000000000000 alignment 0x0000000000000000)
[    0.000000] cma: Reserved 1024 MiB at 0x0000002081800000
[    0.000000] cma: dma_pernuma_cma_reserve: reserved 1024 MiB on node 0
[    0.000000] cma: cma_declare_contiguous_nid(size 0x0000000040000000, base 0x0000000000000000, limit 0x0000000000000000 alignment 0x0000000000000000)
[    0.000000] cma: Reserved 1024 MiB at 0x0000004000000000
[    0.000000] cma: dma_pernuma_cma_reserve: reserved 1024 MiB on node 1
[    0.000000] cma: cma_declare_contiguous_nid(size 0x0000000040000000, base 0x0000000000000000, limit 0x0000000000000000 alignment 0x0000000000000000)
[    0.000000] cma: Reserved 1024 MiB at 0x0000202000000000
[    0.000000] cma: dma_pernuma_cma_reserve: reserved 1024 MiB on node 2
[    0.000000] cma: cma_declare_contiguous_nid(size 0x0000000040000000, base 0x0000000000000000, limit 0x0000000000000000 alignment 0x0000000000000000)
[    0.000000] cma: Reserved 1024 MiB at 0x0000204000000000
[    0.000000] cma: dma_pernuma_cma_reserve: reserved 1024 MiB on node 3
[    0.000000] cma: dma_contiguous_reserve(limit 100000000)
[    0.000000] cma: dma_contiguous_reserve: reserving 384 MiB for global area
[    0.000000] cma: cma_declare_contiguous_nid(size 0x0000000018000000, base 0x0000000000000000, limit 0x0000000100000000 alignment 0x0000000000000000)
[    0.000000] cma: Reserved 384 MiB at 0x0000000068000000

For allocation from pernuma cma, no failure recorded:
[root@localhost cma]# pwd
/sys/kernel/mm/cma
[root@localhost cma]# ls
pernuma0  pernuma1  pernuma2  pernuma3  reserved
[root@localhost cma]# cat pernuma*/alloc_pages_fail
0
0
0
0
[root@localhost cma]# cat pernuma*/alloc_pages_success
2144
0
2132
0

Thanks.
