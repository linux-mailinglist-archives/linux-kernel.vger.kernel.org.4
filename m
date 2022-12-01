Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7717C63EC75
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLAJ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiLAJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:29:46 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A143AEC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:29:43 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p0fsy-0007qA-9q; Thu, 01 Dec 2022 10:29:40 +0100
Message-ID: <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
Date:   Thu, 1 Dec 2022 10:29:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Content-Language: en-US, de-DE
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, amit.pundir@linaro.org,
        andersson@kernel.org, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com> <Y3J8+O7Y3f3onH0P@arm.com>
 <20221118105402.GA184726@thinkpad> <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com> <Y39blgEueyegkz6C@arm.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y39blgEueyegkz6C@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669886983;ddb83090;
X-HE-SMSGID: 1p0fsy-0007qA-9q
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

Has any progress been made to fix this regression? It afaics is not a
release critical issue, but well, it still would be nice to get this
fixed before 6.1 is released.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

On 24.11.22 12:55, Catalin Marinas wrote:
> On Mon, Nov 21, 2022 at 03:42:27PM +0530, Sibi Sankar wrote:
>> On 11/21/22 12:12, Manivannan Sadhasivam wrote:
>>> On Fri, Nov 18, 2022 at 12:33:49PM +0000, Will Deacon wrote:
>>>> On Fri, Nov 18, 2022 at 04:24:02PM +0530, Manivannan Sadhasivam wrote:
>>>>> On Mon, Nov 14, 2022 at 05:38:00PM +0000, Catalin Marinas wrote:
>>>>>> On Mon, Nov 14, 2022 at 03:14:21PM +0000, Robin Murphy wrote:
>>>>>>> Clearly that driver is completely broken though. If the DMA allocation came
>>>>>>> from a no-map carveout vma_dma_alloc_from_dev_coherent() then the vmap()
>>>>>>> shenanigans wouldn't work, so if it backed by struct pages then the whole
>>>>>>> dance is still pointless because *a cacheable linear mapping exists*, and
>>>>>>> it's just relying on the reduced chance that anything's going to re-fetch
>>>>>>> the linear map address after those pages have been allocated, exactly as I
>>>>>>> called out previously[1].
>>>>>>
>>>>>> So I guess a DMA pool that's not mapped in the linear map, together with
>>>>>> memremap() instead of vmap(), would work around the issue. But the
>>>>>> driver needs fixing, not the arch code.
>>>>>
>>>>> Okay, thanks for the hint. Can you share how to allocate the dma-pool that's
>>>>> not part of the kernel's linear map? I looked into it but couldn't find a way.
>>>>
>>>> The no-map property should take care of this iirc
>>>
>>> Yeah, we have been using it in other places of the same driver. But as per
>>> Sibi, we used dynamic allocation for metadata validation since there was no
>>> memory reserved statically for that.
>>
>> Unlike the other portions in the driver that required statically defined
>> no-map carveouts, metadata just needed a contiguous memory for
>> authentication. Re-using existing carveouts for this metadata region
>> may not work due to modem FW limitations and declaring a new carveout for
>> metadata will break the device tree bindings. That's the reason for
>> using DMA_ATTR_NO_KERNEL_MAPPING for dma_alloc_attr and vmpa/vunmap with
>> VM_FLUSH_RESET_PERMS before passing the memory onto modem. Are there other
>> suggestions for achieving the same without breaking bindings?
> 
> Your DMA_ATTR_NO_KERNEL_MAPPING workaround doesn't work, it only makes
> the failure rate smaller. All this attribute does is avoiding creating a
> non-cacheable mapping but you still have the kernel linear mapping in
> place that may be speculatively accessed by the CPU. You were just lucky
> so far not to have hit the issue. So I'd rather see this fixed properly
> with a no-map carveout. Maybe you can reuse an existing carveout if the
> driver already needs some and avoid changing the DT. More complicated
> options include allocating memory and unmapping it from the linear map
> with set_memory_valid(), though that's not exported to modules and it
> also requires the linear map to be pages only, not block mappings.
> 
> Yet another option is to have the swiotlb buffer unmapped from the
> kernel linear map and use the bounce buffer for this. That's more
> involved (Robin has some patches, though for a different reason and they
> may not make it upstream).
> 
