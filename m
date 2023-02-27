Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1056A3E21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjB0JSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjB0JSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:18:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D9E233CA;
        Mon, 27 Feb 2023 01:13:11 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 727DE6602216;
        Mon, 27 Feb 2023 09:13:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677489188;
        bh=7S3Wd+Y8Q5ikBWz7AoFXFSwdvy2LarrEsJYC+b2DteQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OCdsR+fCrGJISKVjFmrUinmHbCqqJQ8dFVTCSzIVW2Z5VmjLoUqXEsSOAY2LwN+Ds
         Q3BNqVKyeCATB9TZqlWokMXlOqKCu1E3ahUhr7LtlKJ96ZqxUWk69SWadQP7Xy5g1S
         mZr1lC050XkZjoWr2Pe2pcOxI9F8GCeg3TwiN/nG4/4+6WbTRggeqcfc5L/shDs+Ql
         Nl82igvvVvZM2qdwkg8Yirq6fS3rD308ZIQx1cu/euZaYJrXWKTtVyq7BWDKXlgwOH
         OLus16dff/fZetQi6aOjBxVZjFxjp54xz/FHmJwyar8dOKyeLCZcO5WyNQhNI2RmeM
         iV4LXFkzmYwcw==
Message-ID: <8c105a4f-f450-8fbf-ff0b-5629a47c1463@collabora.com>
Date:   Mon, 27 Feb 2023 10:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 5/6] soc: qcom: Add support for Core Power Reduction
 v3, v4 and Hardened
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-5-67aed8fdfa61@linaro.org>
 <153ef3e0-9978-d201-44ad-3a5e55eeef4f@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <153ef3e0-9978-d201-44ad-3a5e55eeef4f@linaro.org>
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

Il 27/02/23 03:55, Dmitry Baryshkov ha scritto:
> On 17/02/2023 13:08, Konrad Dybcio wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> This commit introduces a new driver, based on the one for cpr v1,
>> to enable support for the newer Qualcomm Core Power Reduction
>> hardware, known downstream as CPR3, CPR4 and CPRh, and support
>> for MSM8998 and SDM630 CPU power reduction.
>>
>> In these new versions of the hardware, support for various new
>> features was introduced, including voltage reduction for the GPU,
>> security hardening and a new way of controlling CPU DVFS,
>> consisting in internal communication between microcontrollers,
>> specifically the CPR-Hardened and the Operating State Manager.
>>
>> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
>> from the mid-range to the high end ones including, but not limited
>> to, MSM8953/8996/8998, SDM630/636/660/845.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> [Konrad: rebase, apply review comments]
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/soc/qcom/Kconfig      |   22 +
>>   drivers/soc/qcom/Makefile     |    4 +-
>>   drivers/soc/qcom/cpr-common.h |    2 +
>>   drivers/soc/qcom/cpr3.c       | 2923 +++++++++++++++++++++++++++++++++++++++++
>>   include/soc/qcom/cpr.h        |   17 +
>>   5 files changed, 2967 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/soc/qcom/cpr.h b/include/soc/qcom/cpr.h
>> new file mode 100644
>> index 000000000000..2ba4324d18f6
>> --- /dev/null
>> +++ b/include/soc/qcom/cpr.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2013-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2019 Linaro Limited
>> + * Copyright (c) 2021, AngeloGioacchino Del Regno
>> + *                     <angelogioacchino.delregno@somainline.org>
>> + */
>> +
>> +#ifndef __CPR_H__
>> +#define __CPR_H__
>> +
>> +struct cpr_ext_data {
>> +    int mem_acc_threshold_uV;
>> +    int apm_threshold_uV;
>> +};
> 
> Who is going to use this? Is it the cpufreq driver or some other driver?
> We are adding an API without a clean user, can we drop it for now?
> 

This is mandatory: qcom-cpufreq-hw is supposed to program the OSM before
starting.

 From SDM845 onwards, the OSM is programmed by the bootloader before booting
Linux;
In MSM8996/98, SDM630/636/660, others, the bootloader does not program the OSM
uC, so this has to be done in Linux - specifically, in the CPUFREQ driver
(qcom-cpufreq-hw), otherwise this driver is completely pointless to have.

CPU DVFS requires three uC to be correctly programmed in order to work:
  - SAW (for sleep states)
  - CPR-Hardened (voltage control, mandatory for stability)
  - OSM (for cpufreq-hw frequency steps [1..N])

Failing to *correctly* program either of the three will render CPU DVFS unusable.


That clarified, my opinion is:
No, you can't drop this. It's an essential piece for functionality.

I agree in that this commit introduces a header that has only an internal (as in
cpr3.c) user and no external ones, but I think that Konrad didn't want to include
the qcom-cpufreq-hw.c commits in this series because it's already huge and pretty
difficult to review; adding the cpufreq-hw commits would make the situation worse.

Konrad, perhaps you can send the cpufreq-hw commits in a separate series, in
which cover letter you mention a dependency on this one?
That would *clearly* show the full picture to reviewers.

I remember that when I sent the cpufreq-hw series along with this one (~2 years
ago, I think?) that code had positive reviews from Bjorn, so it should be OK.
It wasn't picked just-only-because of the cpr3 dependency.

Regards,
Angelo

>> +
>> +#endif /* __CPR_H__ */
>>
> 



