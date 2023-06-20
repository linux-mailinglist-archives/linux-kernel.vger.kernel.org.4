Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B04736821
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjFTJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjFTJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:43:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D33E68;
        Tue, 20 Jun 2023 02:43:41 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB9966602242;
        Tue, 20 Jun 2023 10:43:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687254220;
        bh=tZEQ2BgJPG46bXO/eTD7ZVZWC8BzMZH3DZDhyoOxcXI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lyPiK9hpXVlj0uVpnW/lNz3ZGOWW37jFTe8j03qHuWtTse7as8pDD5Rpf2vd+URoW
         MVdMC/AkwmISd0h7KivioDsw5Vg9ExZgHGY6iNCzcAqDLVrQEbLONeRR08RdaoFcea
         yfOjo7ZAt/RQ1bBQbQNalpDKazrFVqBXxQAwXKoUHwbonlvKd6ahdl0ETeEKD+e9ad
         k49A9PpF3imsmNHMQ5CdyDZXAGB3EBJCFrX5XyPHCnrw1P0A9KRMcsCyQVvOWTpCeQ
         Uj7RCP/1zMYFStq/e5jmva1C3AomIe2O0RJJrS8tk3FY2ib/N2tf7iFXa14HywkJoM
         KzlTh2V4Ios8g==
Message-ID: <6e3f4ff6-2556-a696-58dc-40e1e4d84189@collabora.com>
Date:   Tue, 20 Jun 2023 11:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/6] iommu/qcom: Use the asid read from device-tree if
 specified
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
 <20221115101122.155440-3-angelogioacchino.delregno@collabora.com>
 <12f0800c-beb3-6fdc-b743-8624f0d5d6ac@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <12f0800c-beb3-6fdc-b743-8624f0d5d6ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 17:44, Dmitry Baryshkov ha scritto:
> On 15/11/2022 12:11, AngeloGioacchino Del Regno wrote:
>> As specified in this driver, the context banks are 0x1000 apart but
>> on some SoCs the context number does not necessarily match this
>> logic, hence we end up using the wrong ASID: keeping in mind that
>> this IOMMU implementation relies heavily on SCM (TZ) calls, it is
>> mandatory that we communicate the right context number.
>>
>> Since this is all about how context banks are mapped in firmware,
>> which may be board dependent (as a different firmware version may
>> eventually change the expected context bank numbers), introduce a
>> new property "qcom,ctx-num": when found, the ASID will be forced
>> as read from the devicetree.
>>
>> When "qcom,ctx-num" is not found, this driver retains the previous
>> behavior as to avoid breaking older devicetrees or systems that do
>> not require forcing ASID numbers.
>>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> [Marijn: Rebased over next-20221111]
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c 
>> b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> index bfd7b51eb5db..491a8093f3d6 100644
>> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
>> @@ -551,7 +551,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct 
>> of_phandle_args *args)
>>        * index into qcom_iommu->ctxs:
>>        */
>>       if (WARN_ON(asid < 1) ||
>> -        WARN_ON(asid > qcom_iommu->num_ctxs)) {
>> +        WARN_ON(asid > qcom_iommu->num_ctxs) ||
>> +        WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
> 
> Separate change in my opinion. Please split it to a separate patch with proper 
> Fixes: tag.
> 

This is of_xlate: the array entry at [asid - 1] is always initialized before
the introduction of `qcom,ctx-num`, so this is not a separate change and it
does not require a Fixes tag, as it is not fixing a previous behavior, but
accounting for a new one.

>>           put_device(&iommu_pdev->dev);
>>           return -EINVAL;
>>       }
>> @@ -638,7 +639,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
>>   static int get_asid(const struct device_node *np)
>>   {
>> -    u32 reg;
>> +    u32 reg, val;
>> +    int asid;
>>       /* read the "reg" property directly to get the relative address
>>        * of the context bank, and calculate the asid from that:
>> @@ -646,7 +648,17 @@ static int get_asid(const struct device_node *np)
>>       if (of_property_read_u32_index(np, "reg", 0, &reg))
>>           return -ENODEV;
>> -    return reg / 0x1000;      /* context banks are 0x1000 apart */
>> +    /*
>> +     * Context banks are 0x1000 apart but, in some cases, the ASID
>> +     * number doesn't match to this logic and needs to be passed
>> +     * from the DT configuration explicitly.
>> +     */
>> +    if (of_property_read_u32(np, "qcom,ctx-num", &val))
>> +        asid = reg / 0x1000;
>> +    else
>> +        asid = val;
> 
> As a matter of preference (and logic) I'd have written that as:
> 
> if (!of_property_read(np, "qcom,ctx-num", &val))
>      asid = val;
> else
>      asid = reg / 0x1000;
> 
> LGTM otherwise
> 

Will do!

Thanks,
Angelo

P.S.: Sorry for the very late reply.

>> +
>> +    return asid;
>>   }
>>   static int qcom_iommu_ctx_probe(struct platform_device *pdev)
> 



