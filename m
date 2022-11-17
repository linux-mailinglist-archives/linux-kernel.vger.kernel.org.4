Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A738862D7EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiKQKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:23:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8F524D5FA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:23:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FE1913D5;
        Thu, 17 Nov 2022 02:23:27 -0800 (PST)
Received: from [10.57.69.157] (unknown [10.57.69.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 396103F73B;
        Thu, 17 Nov 2022 02:23:19 -0800 (PST)
Message-ID: <f41f4fb9-9459-1fa1-494f-c20033c315da@arm.com>
Date:   Thu, 17 Nov 2022 10:23:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH] arm64: mm: Add invalidate back in
 arch_sync_dma_for_device when FROM_DEVICE
Content-Language: en-GB
To:     Ard Biesheuvel <ardb@kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, sstabellini@kernel.org,
        jgross@suse.com, oleksandr_tyshchenko@epam.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com
References: <20221117072100.2720512-1-sunnanyong@huawei.com>
 <CAMj1kXENCa5TK9EnRa9Mtn+xGLrnV_X0sAkTC64GVOShDsTK1Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMj1kXENCa5TK9EnRa9Mtn+xGLrnV_X0sAkTC64GVOShDsTK1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-17 08:24, Ard Biesheuvel wrote:
> On Thu, 17 Nov 2022 at 07:33, Nanyong Sun <sunnanyong@huawei.com> wrote:
>>
>> The commit c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE
>> buffers at start of DMA transfer") replaces invalidate with clean
>> when DMA_FROM_DEVICE, this changes the behavior of functions like
>> dma_map_single() and dma_sync_single_for_device(*, *, *, DMA_FROM_DEVICE),
>> then it may make some drivers works unwell because the implementation
>> of these DMA APIs lose the original cache invalidation.
>>
>> Situation 1:
> ...
>> Situation 2:
>> After backporting the above commit, we find a network card driver go
>> wrong with cache inconsistency when doing DMA transfer: CPU got the
>> stale data in cache when reading DMA data received from device.
> 
> I suppose this means those drivers may lack dma_sync_single_for_cpu()
> calls after the inbound transfers complete, and are instead relying on
> the cache invalidation performed before the transfer to make the DMA'd
> data visible to the CPU.

It also commonly goes wrong the other way round when the drivers are 
correct but DT/ACPI failed to indicate a coherent device as such. If 
writes from the device actually snoop, they hit the still-present cache 
line, which then gets invalidated by unmap/sync_for_cpu and the new data 
is lost.

Robin.
