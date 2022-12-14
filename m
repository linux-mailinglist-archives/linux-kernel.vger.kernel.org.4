Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA664C943
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbiLNMux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiLNMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:50:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A686BBC9;
        Wed, 14 Dec 2022 04:49:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8EFAFEC;
        Wed, 14 Dec 2022 04:50:36 -0800 (PST)
Received: from [10.57.88.237] (unknown [10.57.88.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2339E3F73B;
        Wed, 14 Dec 2022 04:49:54 -0800 (PST)
Message-ID: <fb8c5053-6dfc-f512-24a0-d00dd3f759a8@arm.com>
Date:   Wed, 14 Dec 2022 12:49:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        amit.pundir@linaro.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-5-quic_sibis@quicinc.com>
 <741b64c2-0b09-6475-5736-d2cd3e33c34c@arm.com>
 <ba258979-0c65-4671-dd01-c1916c26e81b@quicinc.com>
 <20221213160722.GC4862@thinkpad>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221213160722.GC4862@thinkpad>
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

On 2022-12-13 16:07, Manivannan Sadhasivam wrote:
> On Tue, Dec 13, 2022 at 09:27:04PM +0530, Sibi Sankar wrote:
>> Hey Robin,
>>
>> Thanks for taking time to review the series.
>>
>> On 12/13/22 20:37, Robin Murphy wrote:
>>> On 2022-12-13 14:07, Sibi Sankar wrote:
>>>> The memory region allocated using dma_alloc_attr with no kernel mapping
>>>> attribute set would still be a part of the linear kernel map. Any access
>>>> to this region by the application processor after assigning it to the
>>>> remote Q6 will result in a XPU violation. Fix this by replacing the
>>>> dynamically allocated memory region with a no-map carveout and unmap the
>>>> modem metadata memory region before passing control to the remote Q6.
>>>>
>>>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>>>> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for
>>>> mem ownership switch")
>>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>>> ---
>>>>
>>>> The addition of the carveout and memunmap is required only on SoCs that
>>>> mandate memory protection before transferring control to Q6, hence the
>>>> driver falls back to dynamic memory allocation in the absence of the
>>>> modem metadata carveout.
>>>
>>> The DMA_ATTR_NO_KERNEL_MAPPING stuff is still broken and pointless, so
>>> I'd expect to see this solution replacing it, not being added alongside.
>>> It's just silly to say pass the "I don't need a CPU mapping" flag, then
>>> manually open-code the same CPU mapping you would have got if you
>>> hadn't, in a way that only works at all when a cacheable alias exists
>>> anyway.
>>
>> only a subset of SoCs supported by the driver are affected by
>> the bug i.e. on the others dma_alloc_attr would still work
>> without problems. I can perhaps drop the NO_KERNEL_MAPPING along
>> with the vmap/vunmap and simplify things for those SoCs.
>>
> 
> Or perhaps revert fc156629b23a?

Oh, indeed, if it's already self-contained that's even neater. Basically 
that whole commit is based on a misunderstanding, doesn't actually do 
what it thinks it does, and you'd be far better off not maintaining the 
extra code.

Thanks,
Robin.
