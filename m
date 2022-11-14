Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2EF62839D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiKNPOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiKNPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:14:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A9601F2F7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:14:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1382623A;
        Mon, 14 Nov 2022 07:14:35 -0800 (PST)
Received: from [10.57.70.90] (unknown [10.57.70.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 665E73F534;
        Mon, 14 Nov 2022 07:14:27 -0800 (PST)
Message-ID: <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
Date:   Mon, 14 Nov 2022 15:14:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     catalin.marinas@arm.com, amit.pundir@linaro.org,
        andersson@kernel.org, quic_sibis@quicinc.com,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221114141109.GG30263@willie-the-truck>
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

On 2022-11-14 14:11, Will Deacon wrote:
> On Mon, Nov 14, 2022 at 04:33:29PM +0530, Manivannan Sadhasivam wrote:
>> This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
>>
>> As reported by Amit [1], dropping cache invalidation from
>> arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
>> (most probably on other Qcom platforms too). The reason is, Qcom
>> qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
>> for validation. The modem has a secure block (XPU) that will trigger a
>> whole system crash if the shared memory is accessed by the CPU while modem
>> is poking at it.
>>
>> To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
>> with no kernel mapping, vmap's it, copies the firmware metadata and
>> unvmap's it. Finally the address is then shared with modem for metadata
>> validation [2].
>>
>> Now because of the removal of cache invalidation from
>> arch_dma_prep_coherent(), there will be cache lines associated with this
>> memory even after sharing with modem. So when the CPU accesses it, the XPU
>> violation gets triggered.
> 
> This last past is a non-sequitur: the buffer is no longer mapped on the CPU
> side, so how would the CPU access it?

Right, for the previous change to have made a difference the offending 
part of this buffer must be present in some cache somewhere *before* the 
DMA buffer allocation completes.

Clearly that driver is completely broken though. If the DMA allocation 
came from a no-map carveout vma_dma_alloc_from_dev_coherent() then the 
vmap() shenanigans wouldn't work, so if it backed by struct pages then 
the whole dance is still pointless because *a cacheable linear mapping 
exists*, and it's just relying on the reduced chance that anything's 
going to re-fetch the linear map address after those pages have been 
allocated, exactly as I called out previously[1].

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/97fface8-e40e-072c-4335-c94094884e93@arm.com/

> As I just replied to Amit, we need more information about what this
> "access" is and how it is being detected.
> 
> Will
