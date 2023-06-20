Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD37368AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjFTKDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFTKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:03:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1019BD;
        Tue, 20 Jun 2023 03:02:21 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 756F06606F23;
        Tue, 20 Jun 2023 11:02:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687255340;
        bh=RLHVI/wjjEu7tgaFY7P5mxMUKibf2l0LJy6KXwWfTcA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MNBGt+PAu1mufc3pOtgjMZsDRsZVkBktZDjH9Dz7Uj7xuARm3UE1Hp+m1EuAIkv1B
         wsq6HxhL47hyFqG48h1AfLyEMdcZsEm0/sSi/U9RmHlRp92TaYQ+I/IBQ1CRI0TpL0
         UZH2wsHoxlN5X0vH2NahxbvGryTduWB+/Bu5n9jlo8uFISCOE69AArOmnuKga363U4
         ZTLQKgeyWz4WLy76ZsYBMetcLMh9wOugHPNULDaww5W4x8zAMemG0KQnL3cz74M+vs
         +LflWzhOmPJXhdCE4lDo68BVQwnIOdTiPxnHCKfh/uElBlSBNNhpyMR/xEPikge/JQ
         t4n5olsHSPtmA==
Message-ID: <491fab1f-e1fe-4388-52a7-05adb17c2c36@collabora.com>
Date:   Tue, 20 Jun 2023 12:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/6] Add support for Qualcomm's legacy IOMMU v2
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
 <254cfbb5-c8b8-0abc-e6bc-5007fe757004@collabora.com>
 <2759637.mvXUDI8C0e@z3ntu.xyz>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2759637.mvXUDI8C0e@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/06/23 23:42, Luca Weiss ha scritto:
> On Mittwoch, 22. Februar 2023 10:57:47 CEST AngeloGioacchino Del Regno wrote:
>> Il 15/11/22 11:11, AngeloGioacchino Del Regno ha scritto:
>>> This series adds support for handling "v2" firmware's IOMMU, found
>>> on at least MSM8956 and MSM8976 (some other SoCs also need the same
>>> but I honestly don't remember which ones precisely).
>>>
>>> This is strictly required to get functional IOMMUs on these SoCs.
>>>
>>> I'm sorry for not performing a much needed schema conversion on
>>> qcom,iommu.txt, but I really didn't have time to do that :-(
>>>
>>> This series was tested on Sony Xperia X and X Compact (MSM8956):
>>> ADSP, LPASS, Venus, MSS, MDP and GPU are happy :-)
>>
>> Hello,
>> this series is really old and got sent and resent many times.
>> The first time I've sent this one was .. I think in 2019, then, at the
>> end of 2022, I had some time to actually respin it and send another
>> three versions. It's been 3 long years :-)
>> The third version got the last comments addressed.
>>
>> Since this didn't get any more feedback for 3 months, I'm worried that it
>> will be forgotten again, hence:
>>
>> Is there any more feedback? Anything else to fix?
>> If not, can this be picked, please?
> 
> Hi Angelo,
> 
> there's some open review comments since March now on this series. Since some
> of these patches are also needed for msm8953 and msm8974 IOMMU it would be
> nice if you could respin :)
> 

Hello Luca,

I've just sent a v4, but I'm sorry I forgot to Cc you. Please find it at [1].

[1]: 
https://lore.kernel.org/all/20230620095127.96600-1-angelogioacchino.delregno@collabora.com/

Cheers,
Angelo

> Regards
> Luca
> 
>>
>> Thank you.
>>
>> Best regards,
>> Angelo
>>
>>> Changes in v3:
>>>    - Removed useless FSRRESTORE reset and definition as pointed
>>>    
>>>      out in Robin Murphy's review
>>>    
>>>    - Fixed qcom,iommu.txt changes: squashed MSM8976 compatible
>>>    
>>>      string addition with msm-iommu-v2 generics addition
>>>
>>> Changes in v2:
>>>    - Added back Marijn's notes (sorry man!)
>>>    - Added ARM_SMMU_CB_FSRRESTORE definition
>>>    - Changed context bank reset to properly set FSR and FSRRESTORE
>>>
>>> AngeloGioacchino Del Regno (6):
>>>     dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
>>>     iommu/qcom: Use the asid read from device-tree if specified
>>>     iommu/qcom: Properly reset the IOMMU context
>>>     iommu/qcom: Index contexts by asid number to allow asid 0
>>>     dt-bindings: iommu: qcom,iommu: Document QSMMUv2 and MSM8976
>>>     
>>>       compatibles
>>>     
>>>     iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
>>>    
>>>    .../devicetree/bindings/iommu/qcom,iommu.txt  |  9 +++
>>>    drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 78 +++++++++++++++----
>>>    2 files changed, 70 insertions(+), 17 deletions(-)
> 
> 
> 
> 
> 
