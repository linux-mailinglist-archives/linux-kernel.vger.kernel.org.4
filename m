Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D44627AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiKNKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiKNKtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:49:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E3FAF2;
        Mon, 14 Nov 2022 02:49:02 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 718DC6601E4C;
        Mon, 14 Nov 2022 10:48:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668422940;
        bh=b59RAUdgvzBDzIoLF/FN/FbsHdKBekzyW613jZm6ADQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WxjiIOjL9B3Vy5WWMdALNveVc0c5liT/GntHkm2C/hnfmCMT8kYAgsMHB1EsaML3B
         m39QcPqz0J9JdMoQkoCSI3GUxp+fKRcsBywaDbc8HAPXlRQz2gri2sGOzAygB+JdYd
         uOdoaKAmHoOqGaoYY00zhK2T+tuMTWxNNS8iSpiixdhv9M25ksRevkiTlBs/pw3bNd
         2buCwfspt8D438Mit/6CE2oj7I8agdlcmT8v8qoYjOPtcYeLPpjRSxT+LIh8h1LweV
         9acTigFkVy78oZfrL+zZ00P7roep6OSQb/CqVbhb/5i/0/of7P+rZydPMuhd6QMpJ3
         gPlORjjzF1Dbw==
Message-ID: <f8f84113-c6f0-706c-cc87-4b57bacea059@collabora.com>
Date:   Mon, 14 Nov 2022 11:48:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 3/8] iommu/arm-smmu: Add definition for
 ARM_SMMU_CB_FSRRESTORE
To:     Robin Murphy <robin.murphy@arm.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
 <20221111145919.221159-4-angelogioacchino.delregno@collabora.com>
 <d677f7c1-8c99-4bb0-d363-7a538b38a83a@arm.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d677f7c1-8c99-4bb0-d363-7a538b38a83a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/11/22 16:18, Robin Murphy ha scritto:
> On 11/11/2022 2:59 pm, AngeloGioacchino Del Regno wrote:
>> In preparation for adding a proper context bank reset sequence in
>> qcom_iommu, add a definition for the implementation defined Fault
>> Status Restore register (FSRRESTORE).
> 
> It's not implementation defined, it's architectural. But I don't follow why we 
> should need this. If we're resetting FSR, we don't need to restore any previous 
> value to it; all we want to do is clear it, which we do already via its own mechanism.
> 

The spec says "configurations" -> implementation defined whether the system
implements stage 1 translation.... and that's how I got confused about it, sorry.

Thanks for the review, this clears up my doubts: I can reset FSR without caring
about FSRRESTORE.
I'll send a v3 ASAP.

Regards,
Angelo

> Thanks,
> Robin.
> 
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> index 703fd5817ec1..5015138799c5 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> @@ -219,6 +219,7 @@ enum arm_smmu_cbar_type {
>>                        ARM_SMMU_FSR_TF |        \
>>                        ARM_SMMU_FSR_IGN)
>> +#define ARM_SMMU_CB_FSRRESTORE        0x5c
>>   #define ARM_SMMU_CB_FAR            0x60
>>   #define ARM_SMMU_CB_FSYNR0        0x68


