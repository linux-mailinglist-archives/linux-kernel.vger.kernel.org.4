Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A2D6F48F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjEBRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjEBRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:13:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B177DAB
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:13:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f109b1808so803568366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683047629; x=1685639629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8c7YTMrMqO6NiIk6aRyvvE9OvrnJpW6uZRx0Qb7U3uQ=;
        b=zgnIXfrpmrq8W4s5EAIhf5gir1yUUW0Rx0zxLklNwXeuXbpmB0SdDfZCVD+E7FPEd9
         6BhmsZ8/TcTnHL/BRfxgeQsmwDzUlStLP6i6H4vYmaH1ucMz1rchhg7qraphC84lkE6h
         qxYtaHUSHhRC9026P2XwfrfhVy+80eLLtV6CG2d2jkv+K0r22dU0VkYbvBgTqcbvOKLu
         3ZlHQvmP+ei9HoEBBcypNWv54MqVWa1WN56hjGrukmu+RnchIxiQV2L+crzXA0scMgm3
         g90zJp+CSjAvRhguupJW9Yt085pjePwHvk3JL7sZB6FgOnpG+CzZJ96j6TBTOsTPdYph
         ce0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047629; x=1685639629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8c7YTMrMqO6NiIk6aRyvvE9OvrnJpW6uZRx0Qb7U3uQ=;
        b=l+rUqndH4e2inFuBp7vKYi2KCjafKebcGRL6T3ouxVhJcStdi0AvzVNDJu25JjNVWN
         1pJX2DPx7eUnJOBkbn2nvN6l5EbqEPQ5kFuAcTiTHCde6x/QVPV3QzM/nTa5YgUmj/yi
         xQWuqH/+TqfyPydUKKHp2iV6p2SqChs3Y/7purTv1bSh5Z8+/yqUw17/oYXgO9actvgC
         x8xD7cTjSX7qLDTmG4JU2VfC1Q/eV/6BLKgGAX+aejELOJfNi7l6WPH71GF2D+lH4iza
         Q36wgrswPH0vo3FR5ZnSEf1xQx8uWEIAoST4Q409N7IJuEPkCw7hLs1cL2fngLgYkVL2
         40cA==
X-Gm-Message-State: AC+VfDwtGvEJSPqCc9lKMjjTz3NvmrXnCC2tLFptNJYubmePYRDQDdEj
        wjdBeY8gYADopxq+vVOSQOllxSv3qAA257iNj0ezJQ==
X-Google-Smtp-Source: ACHHUZ6e7VBIhBT7ojisZ4f6uNBoZ8irQ8thLSU1xgomR8S5YlRCSGV/kFmz1qTvVSqYSp9UjDOPng==
X-Received: by 2002:a17:907:608b:b0:88f:a236:69e6 with SMTP id ht11-20020a170907608b00b0088fa23669e6mr596274ejc.7.1683047629100;
        Tue, 02 May 2023 10:13:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:37be:eda5:e303:19e0? ([2a02:810d:15c0:828:37be:eda5:e303:19e0])
        by smtp.gmail.com with ESMTPSA id cw22-20020a170906479600b0095f06c0247asm8879918ejc.209.2023.05.02.10.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 10:13:48 -0700 (PDT)
Message-ID: <96feebd6-ce0c-576d-0747-647706692846@linaro.org>
Date:   Tue, 2 May 2023 19:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 5/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77658 Battery
To:     "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-6-Zeynep.Arslanbenzer@analog.com>
 <afeecd42-ecda-4d92-bbb5-6dcff84fca7d@linaro.org>
 <MN2PR03MB5197BC6AEE58EFE098AF08358B6E9@MN2PR03MB5197.namprd03.prod.outlook.com>
 <1f520e8a-7785-f4dc-2f9b-d6afd1e3f671@linaro.org>
 <MN2PR03MB5197EB4B34DC82C62EF5A3798B6F9@MN2PR03MB5197.namprd03.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB5197EB4B34DC82C62EF5A3798B6F9@MN2PR03MB5197.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 17:05, Arslanbenzer, Zeynep wrote:
> On Tue, 2 May 2023, Krzysztof Kozlowski wrote:
>> On 01/05/2023 22:20, Arslanbenzer, Zeynep wrote:
>>
>>>> You already said it above.
>>>>
>>>>> +      in battery.yaml, with the following properties being required:
>>>>> +      - alert-celsius
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>
>>>> Why reg and monitored-batter are not required?
>>>>
>>> If no monitored-battery information is supplied, we set default values for alert-celsius.
>>
>> So the device can operate without battery? Interesting... are you sure, you can physically remove battery and device will work?
>>
> 
> I mean if battery info is not supplied, we use default values.
> 
> ret = power_supply_get_battery_info(fg->battery, &info);
> if (ret) {
>     dev_err(fg->dev, "Unable to get battery info\n");
>     fg->temp_alert_min = info->temp_alert_min;
>     fg->temp_alert_max = info->temp_alert_max;
> } else {
>     fg->temp_alert_min = -128;
>     fg->temp_alert_max = 127;
> }

You speak about driver, but I speak about hardware. The bindings are for
the latter.

Best regards,
Krzysztof

