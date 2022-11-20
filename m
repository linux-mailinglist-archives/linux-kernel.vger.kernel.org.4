Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA863124F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 03:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiKTC6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 21:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 21:58:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE3A7C1F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 18:58:44 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NFFVd6lf3zqSPH;
        Sun, 20 Nov 2022 10:54:49 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 10:58:41 +0800
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 10:58:40 +0800
Subject: Re: [RFC PATCH] arm64: mm: Add invalidate back in
 arch_sync_dma_for_device when FROM_DEVICE
To:     Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <sstabellini@kernel.org>, <jgross@suse.com>,
        <oleksandr_tyshchenko@epam.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linux@armlinux.org.uk>
References: <20221117072100.2720512-1-sunnanyong@huawei.com>
 <CAMj1kXENCa5TK9EnRa9Mtn+xGLrnV_X0sAkTC64GVOShDsTK1Q@mail.gmail.com>
 <f41f4fb9-9459-1fa1-494f-c20033c315da@arm.com>
From:   Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <e6bd415a-201a-b3e3-48f0-beeff91f3b7a@huawei.com>
Date:   Sun, 20 Nov 2022 10:58:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f41f4fb9-9459-1fa1-494f-c20033c315da@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.79]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/17 18:23, Robin Murphy wrote:

> On 2022-11-17 08:24, Ard Biesheuvel wrote:
>> On Thu, 17 Nov 2022 at 07:33, Nanyong Sun <sunnanyong@huawei.com> wrote:
>>>
>>> The commit c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE
>>> buffers at start of DMA transfer") replaces invalidate with clean
>>> when DMA_FROM_DEVICE, this changes the behavior of functions like
>>> dma_map_single() and dma_sync_single_for_device(*, *, *, 
>>> DMA_FROM_DEVICE),
>>> then it may make some drivers works unwell because the implementation
>>> of these DMA APIs lose the original cache invalidation.
>>>
>>> Situation 1:
>> ...
>>> Situation 2:
>>> After backporting the above commit, we find a network card driver go
>>> wrong with cache inconsistency when doing DMA transfer: CPU got the
>>> stale data in cache when reading DMA data received from device.
>>
>> I suppose this means those drivers may lack dma_sync_single_for_cpu()
>> calls after the inbound transfers complete, and are instead relying on
>> the cache invalidation performed before the transfer to make the DMA'd
>> data visible to the CPU.
>
> It also commonly goes wrong the other way round when the drivers are 
> correct but DT/ACPI failed to indicate a coherent device as such. If 
> writes from the device actually snoop, they hit the still-present 
> cache line, which then gets invalidated by unmap/sync_for_cpu and the 
> new data is lost.
>
> Robin.
>
> .
Is it acceptable?  Does the coherent device MUST run with coherent 
identifier? At least they can run with no wrong before.
