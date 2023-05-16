Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D836705639
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjEPSpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjEPSpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:45:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9861583C5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:45:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965d2749e2eso2210415066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684262699; x=1686854699;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0R6xp7YQ3gXwFCPRUuJGIiIiyVS7D7jsO2XhIMMg8S0=;
        b=fv1o/DQwvo7Zb9713rpQNsv1UWh65ypqD2BdRsfazJlgMLJUseyg5CjLKNWOCOUsIX
         c7AmgLukqWyveKH0jsFKPgQf2fiKyte1Hw+rT/2PWx8wXgDcQizMuOreWGAG1b7zw/I5
         ZkY89ewur7055uFPmJiIOZHR+3/VvlE65+K+hnI0fOGUZlUy8gPRgk+KMtGWS2R1/SbI
         T+ghWyHEtTlj2RMtxA/7CQl2odoBdwh+kHWTkfxS0VJEKvtEVnOAIwbRcXuYdxKGVL2N
         Xm+JbJ7SBMZfGtp/oKP51NhSXE3odQh9DW26SFj5hdRqa0CUZqjqvwrz3GTUFCeVDh9p
         AbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684262699; x=1686854699;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0R6xp7YQ3gXwFCPRUuJGIiIiyVS7D7jsO2XhIMMg8S0=;
        b=ABWUBGTCJRnCk6wELBk7X7xE8JCoqHKxpLfwA6dU5wUOfVKg4p/S0pp1V72zUuGlue
         6gXSjz0RvFe2j6hpfnF3fbNRUGzd/mjgmRnY+Mfr3BhhqKxcwBNXXjPCfnBZ0OGnB9Su
         vhEWDdtmMlhnSadBaoWUEmpKLcUGyqGP4W9Ao2ucPov2scRuqPahwfc8QZsywnJBwXgG
         lvzhQSpGMGExU/MJk1R0qA2uHbazAb2kv/rOr4fctHU20MGEwT/BQugLdRK+VFrHQaKl
         4QX72D6+qp612bh3BT8gtjm8JUReCofMcVBVWnP0p0MLCQ0vXvo7N3RuFA74UnOWud5B
         wo5Q==
X-Gm-Message-State: AC+VfDzrwscFrcQvQeD6UEAXTo9LRTfE7xK7k06srw4CjeMnV6TYeARW
        9s8mEg2WBmTu3j4YS9eFhK4O+g==
X-Google-Smtp-Source: ACHHUZ5ThZTFMSXSEAC3o7SH7pz0eaf28tlzDtg7rOOH0lwD2mkN0QHq7/qtTmPm1kbpX+4Hqy5Ghg==
X-Received: by 2002:a17:907:7251:b0:96a:1ab:b4a2 with SMTP id ds17-20020a170907725100b0096a01abb4a2mr28133300ejc.25.1684262698977;
        Tue, 16 May 2023 11:44:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906070d00b0093313f4fc3csm11278381ejb.70.2023.05.16.11.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 11:44:57 -0700 (PDT)
Message-ID: <367e0b47-eb36-c169-7f4f-c004c6f5ac84@linaro.org>
Date:   Tue, 16 May 2023 20:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mux: mmio: use reg property when parent device is not a
 syscon
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515191909.611241-1-afd@ti.com>
 <21429720-e27f-bf26-64e7-ace1186da31b@linaro.org>
In-Reply-To: <21429720-e27f-bf26-64e7-ace1186da31b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 20:37, Krzysztof Kozlowski wrote:
> On 15/05/2023 21:19, Andrew Davis wrote:
>> The DT binding for the reg-mux compatible states it can be used when the
>> "parent device of mux controller is not syscon device". It also allows
>> for a reg property. When the parent device is indeed not a syscon device,
>> nor is it a regmap provider, we should fallback to using that reg
>> property to identify the address space to use for this mux.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>  drivers/mux/mmio.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
>> index 44a7a0e885b8..42e00b9fd0a9 100644
>> --- a/drivers/mux/mmio.c
>> +++ b/drivers/mux/mmio.c
>> @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
>>  	int ret;
>>  	int i;
>>  
>> -	if (of_device_is_compatible(np, "mmio-mux"))
>> +	if (of_device_is_compatible(np, "mmio-mux")) {
>>  		regmap = syscon_node_to_regmap(np->parent);
>> -	else
>> -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
>> +	} else {
>> +		regmap = dev_get_regmap(dev->parent, NULL);
>> +		if (!regmap)
>> +			regmap = device_node_to_regmap(np) ?: ERR_PTR(-ENODEV);
> 
> Unless I miss something obvious, the original code is simply bogus and
> wrong. I would like to give here Rb tag... but maybe I miss something
> obvious. Why mux cannot be a device with MMIO itself? Binding allows it
> which would be perfectly proper description of hardware.

OK, I see now original binding and it did not allow 'reg' property, thus
binding was matching driver. Commit 9b358af7c818 ("dt-bindings: mux:
Convert mux controller bindings to schema") introduced reg, which is
reasonable.

The driver change is reasonable as well - we should not need syscon
parent... however, I think the code should be different. If reg is
present you should use it first. If reg is missing, use parent. This
solves the case when node with reg will be put inside something else
which has regmap, but should not be used for reg-mux.

Best regards,
Krzysztof

