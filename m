Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB9619935
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiKDOSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiKDOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:18:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6C327CC0;
        Fri,  4 Nov 2022 07:18:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 34A3F6602987;
        Fri,  4 Nov 2022 14:18:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667571482;
        bh=86qaHxIG8Cvcil1Rrk7cDBPZwLxA2xYMfKOOsIa0Ypo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OkzByyiIxQ/LQOyvVT2VjdyUbVVxApMuu+6dcbLeQPciJF4ShyHzuGIeNIWJjI2iS
         AjOayrd+JQcKttXCAR1EJlAb4NtcREMmXIRl+PZUIfrjuEv/HSHt7PelSaN7BdWet9
         D5Qdx5ZM31mN/lFtImWSneE4dH7wW+V2A4zSw1ELNwsmdFE60I3NTjd3C+WXMdGVWV
         D0SHvLXHDyWzXV4Gzvo3aM9XL+d7FFUIDQDpRgEXAmT+5S9X7bbPZZ0A3qyatVkzAA
         UnIISWSEk4oVq140GJedxmHB0xLA+pTLk2Md1jBJQYJKkncd0CAoUcjQkzqg8EHGu4
         6PMSYYq6wDJ4w==
Message-ID: <3af810a7-0490-da36-f263-e74cd3553c84@collabora.com>
Date:   Fri, 4 Nov 2022 15:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] soc: qcom: Add Qualcomm Ramp Controller driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com>
 <20221104133506.131316-3-angelogioacchino.delregno@collabora.com>
 <cf1a15c5-a16b-2d23-8f6c-b3892c141c34@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <cf1a15c5-a16b-2d23-8f6c-b3892c141c34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/11/22 15:04, Krzysztof Kozlowski ha scritto:
> On 04/11/2022 09:35, AngeloGioacchino Del Regno wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> The Ramp Controller is used to program the sequence ID for pulse
>> swallowing, enable sequence and linking sequence IDs for the CPU
>> cores on some Qualcomm SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   drivers/soc/qcom/Kconfig           |   9 +
>>   drivers/soc/qcom/Makefile          |   1 +
>>   drivers/soc/qcom/ramp_controller.c | 330 +++++++++++++++++++++++++++++
>>   3 files changed, 340 insertions(+)
>>   create mode 100644 drivers/soc/qcom/ramp_controller.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 024e420f1bb7..1e681f98bad4 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -95,6 +95,15 @@ config QCOM_QMI_HELPERS
>>   	tristate
>>   	depends on NET
>>   
>> +config QCOM_RAMP_CTRL
>> +	tristate "Qualcomm Ramp Controller driver"
>> +	depends on ARCH_QCOM
> 
> I propose:
> depends on ARCH_QCOM && ARM || COMPILE_TEST
> 
> I don't think it is used on ARM64 SoCs, so let's make life of distros
> easier.

Forgot to reply to this one: MSM8956 and MSM8976 are ARM64 SoCs :-)

Cheers,
Angelo
