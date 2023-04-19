Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABAA6E760F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjDSJPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjDSJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:15:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8283D9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:15:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b73203e0aso14674166b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681895707; x=1684487707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Z0ENOsxZA50TlybfipLilceqyR8d2UbgPRKNrb/JLs=;
        b=EZdPY0hV7UGxWev6L8eVb7Foo0yzENzcfO9RxvJuf5U4rfpd/IbeJp5f7gfcRkjmS4
         Jyn0O23qg2iabTXV4xry9aEl3dfyyT3SIAHf65VGQtAm7dxJoIFsGQSaT0T3ZjfRBiay
         v78eh0oGIgjSCZfqBhOlRnmMqtJ0eMaCmLnADywoJqNd7HVQROvS0YMX+qTRSW24e9nR
         k5P0yhJnSogVKFf6JomjVV6Un/bY3m8odbTbg4jh8LsT1ywbpnTFw1UOEhTwmBGL27dU
         pYOnuaWb0nPWDsL1wNy948nINiern7msMhfDUrwd/70WNTOmcBmVjIzKHBgk7Zg91eyE
         JP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681895707; x=1684487707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z0ENOsxZA50TlybfipLilceqyR8d2UbgPRKNrb/JLs=;
        b=e+fDRhHko2X+XzkSXqCVq2aeqUWybPqSREmf/cgr6GY8H4SHQPg4Qc7X11Onye3oBg
         oM4OiIBhWo+j/VG7Gm4ozy3cUoRvpTuf977hdS78n2QDHxjBKC4RddhdNE7b1Dx/tEVc
         xQJUeNF0+gGApPWsL2LvDCwEkeODwXw59EygfGDwvqSvyinGGfIBZpSlJ1bNQ6P9vWVk
         uAnA4idujrc6nd9tUuIAHfxZyOYQN19Yef8VOhgC05SwQpm5DCiyQqQQBV7/V7FYE2nl
         h4edh8vHDhlCbkusQBrxKNd7aYn+vQpXKVRouN+ntAJ9eOASJY8A5dD3RJ3vdkV5bF3e
         4CQA==
X-Gm-Message-State: AAQBX9fNQtZxw0OwZ7Aq6dLmSHme11CjJ1efTJtLEI7qmI4DiH+ssN5B
        oZJlp4dLhBFLdM4rIBFjAYGRWA==
X-Google-Smtp-Source: AKy350bBTuM/4nKfDh0YTWMB0cqwQHC3Yo4+8hbJvH1PvSfcgFHW27FUOZlA60cmD1IDmFQFt27HlQ==
X-Received: by 2002:a05:6a00:1506:b0:634:4f6:86df with SMTP id q6-20020a056a00150600b0063404f686dfmr2030736pfu.1.1681895707069;
        Wed, 19 Apr 2023 02:15:07 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id k4-20020aa790c4000000b0063d2dae6247sm3825041pfk.77.2023.04.19.02.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:15:06 -0700 (PDT)
Message-ID: <877a0d7f-4f68-f02f-fb12-ba9b694cf12f@9elements.com>
Date:   Wed, 19 Apr 2023 14:45:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add binding for max6639
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418113217.781524-1-Naresh.Solanki@9elements.com>
 <742f546b-3952-32f4-9f20-3a355785d162@linaro.org>
 <e63bba13-05f0-7d1b-bf11-04ef5eda3afd@9elements.com>
 <84e1428b-a50e-92c4-9c8b-74e2a8034e64@linaro.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <84e1428b-a50e-92c4-9c8b-74e2a8034e64@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 19-04-2023 02:34 pm, Krzysztof Kozlowski wrote:
> On 19/04/2023 11:00, Naresh Solanki wrote:
>> Hi Krysztof,
>>
>> On 18-04-2023 09:47 pm, Krzysztof Kozlowski wrote:
>>> On 18/04/2023 13:32, Naresh Solanki wrote:
>>>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>>>> monitor with PWM fan-speed controller.
>>>
>>> Subject: drop second/last, redundant "binding for". The "dt-bindings"
>>> prefix is already stating that these are bindings.
>> Ack
>>>
>>>>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>>    .../bindings/hwmon/maxim,max6639.yaml         | 55 +++++++++++++++++++
>>>>    1 file changed, 55 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>> new file mode 100644
>>>> index 000000000000..20b28cd36555
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>> @@ -0,0 +1,55 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +
>>>
>>> Drop blank line
>> Ack
>>>
>>> This is v9. Where is the changelog? Where is previous authorship? At
>>> least some parts of it? Why this has less properties than old one? Why
>>> this has more mistakes than the old one? Go to previous patch... or fix
>>> everything which was already fixed.
>> This patch is to add basic dt support only hence no additional properties.
> 
> How does that answer my questions?
This patch is intended to add dt support for the max6639 driver, and I 
did not take it from previous patches. As this is a basic dt binding, it 
has fewer properties compared to the old one.

I have used v8 as a reference for this patch, and I will review it again 
to make sure I have not missed anything. Will ensure to fix them in the 
next patch.

Although I cannot go back to the previous patch, I will address and fix 
any issues in this patchset.
> 
> Best regards,
> Krzysztof
> 
Regards,
Naresh
