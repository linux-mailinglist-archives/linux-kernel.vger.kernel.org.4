Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5C6A423F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjB0NGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjB0NGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:06:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E721EBFA;
        Mon, 27 Feb 2023 05:06:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F6E4660220D;
        Mon, 27 Feb 2023 13:06:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677503178;
        bh=gM5HmWhtaJ0gdI7nEntVsCXZUWyh+xKgAjaVCtJGEFA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B3IIkROHkoRW4wMlM/DtbXyuFDCSZntM02oRKBg2PsoV1F6QZTPMrXuObtiOlsxV/
         5NA4moHNCAA1W6YMku7sZGbs12qstmQzsZJ248A4Guej6m77r3JDLtbWFJnod26mxH
         8eGd0KVK1aLeCW01u04drir57gJYTaB18nhef9ICOpBAJAXk7MmG6jvEx6eveE+dvR
         kYfarzlT9+mS9xoVJw625HDIh1IY3Q536ewz4+4uRoPAxvtJijrQSetR0RaFbJQnc8
         Vcjb0JF/cMt2beRCnvkBWlUfE4taHfo3fHtZIhmTImr2jm8FweXQSk4VMt3cDzP1p1
         t4vuvpdL4W6hQ==
Message-ID: <8a813713-c60d-4726-0c62-de032db99ede@collabora.com>
Date:   Mon, 27 Feb 2023 14:06:14 +0100
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
 <8c105a4f-f450-8fbf-ff0b-5629a47c1463@collabora.com>
 <d2784517-0f0c-43a5-63a6-57f6aa3e5912@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d2784517-0f0c-43a5-63a6-57f6aa3e5912@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/02/23 13:01, Dmitry Baryshkov ha scritto:
> On 27/02/2023 11:13, AngeloGioacchino Del Regno wrote:
>> Il 27/02/23 03:55, Dmitry Baryshkov ha scritto:
>>> On 17/02/2023 13:08, Konrad Dybcio wrote:
>>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>>
>>>> This commit introduces a new driver, based on the one for cpr v1,
>>>> to enable support for the newer Qualcomm Core Power Reduction
>>>> hardware, known downstream as CPR3, CPR4 and CPRh, and support
>>>> for MSM8998 and SDM630 CPU power reduction.
>>>>
>>>> In these new versions of the hardware, support for various new
>>>> features was introduced, including voltage reduction for the GPU,
>>>> security hardening and a new way of controlling CPU DVFS,
>>>> consisting in internal communication between microcontrollers,
>>>> specifically the CPR-Hardened and the Operating State Manager.
>>>>
>>>> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
>>>> from the mid-range to the high end ones including, but not limited
>>>> to, MSM8953/8996/8998, SDM630/636/660/845.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@somainline.org>
>>>> [Konrad: rebase, apply review comments]
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>   drivers/soc/qcom/Kconfig      |   22 +
>>>>   drivers/soc/qcom/Makefile     |    4 +-
>>>>   drivers/soc/qcom/cpr-common.h |    2 +
>>>>   drivers/soc/qcom/cpr3.c       | 2923 +++++++++++++++++++++++++++++++++++++++++
>>>>   include/soc/qcom/cpr.h        |   17 +
>>>>   5 files changed, 2967 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/soc/qcom/cpr.h b/include/soc/qcom/cpr.h
>>>> new file mode 100644
>>>> index 000000000000..2ba4324d18f6
>>>> --- /dev/null
>>>> +++ b/include/soc/qcom/cpr.h
>>>> @@ -0,0 +1,17 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (c) 2013-2020, The Linux Foundation. All rights reserved.
>>>> + * Copyright (c) 2019 Linaro Limited
>>>> + * Copyright (c) 2021, AngeloGioacchino Del Regno
>>>> + *                     <angelogioacchino.delregno@somainline.org>
>>>> + */
>>>> +
>>>> +#ifndef __CPR_H__
>>>> +#define __CPR_H__
>>>> +
>>>> +struct cpr_ext_data {
>>>> +    int mem_acc_threshold_uV;
>>>> +    int apm_threshold_uV;
>>>> +};
>>>
>>> Who is going to use this? Is it the cpufreq driver or some other driver?
>>> We are adding an API without a clean user, can we drop it for now?
>>>
>>
>> This is mandatory: qcom-cpufreq-hw is supposed to program the OSM before
>> starting.
> 
> Thanks for the explanation!
> 
>>
>>  From SDM845 onwards, the OSM is programmed by the bootloader before booting
>> Linux;
>> In MSM8996/98, SDM630/636/660, others, the bootloader does not program the OSM
>> uC, so this has to be done in Linux - specifically, in the CPUFREQ driver
>> (qcom-cpufreq-hw), otherwise this driver is completely pointless to have.
>>
>> CPU DVFS requires three uC to be correctly programmed in order to work:
>>   - SAW (for sleep states)
> 
> I believe this is handled by the PCSI for all mentioned platforms.
> 

This is handled by the SAW/SPM driver that we have in the kernel for all mentioned
platforms (soc/qcom/spm.c)

>>   - CPR-Hardened (voltage control, mandatory for stability)
> 
> This driver (nit: 8996 has cpr3)
> 

Yes, sorry, 8996 is not CPRh.

>>   - OSM (for cpufreq-hw frequency steps [1..N])
> 
> I think this is valid only for the CPRh targets. And for OSM programming the driver 
> populates OPP tables with voltage levels (which should then be handled by the 
> cpufreq-hw).
> 

This is valid for all targets having OSM.. and I think you're right, the only ones
that do have OSM are CPR-Hardened as the introduction of OSM is part of the actual
hardening of CPR4.

> I'd toss another coin into the list: for 8996 we also have to program APM and 
> cluster (kryo) regulators _manually_.
> 

Right! I even forgot about that :-)

>>
>> Failing to *correctly* program either of the three will render CPU DVFS unusable.
>>
>>
>> That clarified, my opinion is:
>> No, you can't drop this. It's an essential piece for functionality.
>>
>> I agree in that this commit introduces a header that has only an internal (as in
>> cpr3.c) user and no external ones, but I think that Konrad didn't want to include
>> the qcom-cpufreq-hw.c commits in this series because it's already huge and pretty
>> difficult to review; adding the cpufreq-hw commits would make the situation worse.
> 
> Perhaps we misunderstand each other here. I suggest dropping the header from _this_ 
> patchset only and submit/merge corresponding code together with the cpufreq-hw 
> changes. This might sound like a complication, but in reality it allows one to 
> assess corresponding code separately.
> 

Exactly, I thought you were suggesting to drop it - having a more careful read,
you said "for now", so, eh, that was misinterpretation on my side, sorry!

> (Moreover, please correct me if I'm wrong, I think this header will be used only 
> with the CPRh, and so this has no use for CPR3/4. Is this correct?)

Even though my memories are a bit confused (changeset too old...), should be used
only for CPR-Hardened, not for CPR3, not for CPR4.

> 
> I took a glance at the 'cpufreq: qcom-hw: Implement CPRh aware OSM programming' 
> patch, it doesn't seem to use the header (maybe I checked the older version of the 
> patch). As for me, this is another signal that cpr_ext_data should come together 
> with the LUT programming rather than with the CPRh itself.
> 
>> Konrad, perhaps you can send the cpufreq-hw commits in a separate series, in
>> which cover letter you mention a dependency on this one?
>> That would *clearly* show the full picture to reviewers.
> 
> Yes, that would be great. A small note regarding those patches. I see that you 
> patched the qcom-cpufreq-hw.c. This way first the driver programs the LUT, then it 
> reads it back to setup the OPPs. Would it be easier to split OSM-not-programmed 
> driver?
> 

When I engineered that solution, I kept the cpufreq-hw reading *again* the values
from OSM to keep the driver *fully* compatible with the bootloader-programmed OSM
flow, which makes one thing (in my opinion) perfectly clear: that programming
sequence is exactly the same as what happens "under the hood" on SDM845 (and later)
but performed here-instead-of-there (linux instead of bootloader), with the actual
scaling driver being 100% the same between the two flows in the end.

Having two drivers as you suggested would indeed achieve the same, but wouldn't be
any easier... if you do that, you'd have to *somehow* make sure that the
programming driver does its job before the cpufreq driver tries to read the OSM
status, adding one more link to an already long chain.

Besides, I remember that this question got asked a while ago on the mailing lists
and there was a short discussion about it:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2555580.html

