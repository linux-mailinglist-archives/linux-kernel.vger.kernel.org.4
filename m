Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C43733002
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbjFPLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFPLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:39:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0722295B;
        Fri, 16 Jun 2023 04:39:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8854C1FB;
        Fri, 16 Jun 2023 04:39:47 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EF193F5A1;
        Fri, 16 Jun 2023 04:39:00 -0700 (PDT)
Message-ID: <e9939011-cd7d-ab22-b271-f2e9d591576a@arm.com>
Date:   Fri, 16 Jun 2023 12:38:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "Revert "Revert "arm64: dma: Drop cache
 invalidation from arch_dma_prep_coherent()"""
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>
Cc:     Will Deacon <will@kernel.org>, andersson@kernel.org,
        amit.pundir@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sumit.semwal@linaro.org, Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230614165904.1.I279773c37e2c1ed8fbb622ca6d1397aea0023526@changeid>
 <36565295-ebaa-2a66-3389-ba5eb714ab34@arm.com>
 <CAD=FV=W7HXYRJ7RUeVH0hQ7KjYtEvNABCi-F4iN_wRO6uuC34w@mail.gmail.com>
 <34c7c65f-e09f-fa55-c1b9-de08d71a1ac7@arm.com>
 <CAD=FV=UEx+71U5-WWL6c8vwqUg0Asceoz1aCd3YBub9-FcL61g@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAD=FV=UEx+71U5-WWL6c8vwqUg0Asceoz1aCd3YBub9-FcL61g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-15 23:00, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 15, 2023 at 12:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>>> Presumably the fact that the firmware gets a physical address means
>>> that the firmware needs to map this address somehow itself. I can try
>>> to dig up what the firmware is doing if needed (what attributes it
>>> uses to map), but I guess the hope is that it shouldn't matter.
>>
>> It absolutely matters. Linux has been told (by DT) that this device does
>> not snoop caches, and therefore is acting on that information by using
>> the non-cacheable remap. There is nothing inherently wrong with that,
>> even when the "device" is actually firmware running on the same CPU -
>> EL3 could well run with the MMU off, or just make a point of not
>> accessing Non-Secure memory with cacheable attributes to avoid
>> side-channels. However if in this case the SCM firmware *is* using
>> cacheable attributes, as the symptoms would suggest, then either the
>> firmware or the DT is wrong, and there is nothing Linux can do to
>> completely fix that.
> 
> With help from minecrell on IRC, we've found that firmare _does_ map
> it as cachable.
> 
> 
>>> If this wild guessing is
>>> correct, maybe a more correct solution would be to simply unmap the
>>> memory from the kernel before passing the physical address to the
>>> firmware, if that's possible...
>>
>> Having now looked at the SCM driver, TBH it doesn't make an awful lot of
>> sense for it to be using dma_alloc_coherent() there anyway - it's not
>> using it as a coherent buffer, it's doing a one-off unidirectional
>> transfer of a relatively small amount of data in a manner which seems to
>> be exactly the usage model for the streaming DMA API. And I think using
>> the latter would happen to mitigate this problem too - with streaming
>> DMA you'd put the dma_map_page() call *after* all the buffer data has
>> been written, right before the SMC call, so even with a coherency
>> mismatch there would essentially be no opportunity for the caches to get
>> out of sync.
> 
> Switching to the streaming API for this function _does_ work, but for
> now I'm not going to make this switch and instead going to go with the
> fix to add "dma-coherent" [1]. That seems like the more correct fix
> instead of just a mitigation.

Sure, if you're confident that it will *always* use cacheable attributes 
for any shared-memory "DMA", that makes sense.

> If someone wants to switch the SCM
> driver to the streaming APIs, that'd be cool too. On IRC, minecrell
> pointed out that at least one function in this file,
> qcom_scm_ice_set_key(), purposely didn't use the streaming APIs.

The joke there being that memzero_explicit() on the non-cacheable alias 
means a cached copy of the key data could still be visible via the 
linear map address after the buffer is freed - especially if one can 
rely on TF-A having just pulled the whole lot into caches by reading it 
through a read-write-allocate MT_MEMORY mapping. Security is hard :)

Thanks,
Robin.

> 
> [1] https://lore.kernel.org/r/20230615145253.1.Ic62daa649b47b656b313551d646c4de9a7da4bd4@changeid
> 
> -Doug
