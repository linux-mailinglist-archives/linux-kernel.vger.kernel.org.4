Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5707728526
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjFHQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjFHQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:36:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B130C4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:35:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f7a8089709so8173905e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686242133; x=1688834133;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRPhFFSQuvm0hM7+hxNh39CKSjT+bV2/IKmhED0OOXA=;
        b=s3er2lwklZNt0qbGLX4hw9VG+G4raFB1jsFaxcZRQ31eZWezIbfrj7skV87KVv72eN
         GIIPIHRNOg8Dt7eepTWRotrddiMqIkWAPUQ6f/+HSCyPcubrkAKR/9QrqdLOm0wvt943
         bCNLtMMc3YeCJsIn9jkPiP8f5lwB+T9XSPebT5xoO4KJ0hnrNwVn3eZjRKqHHN2pk//j
         IYMZOGoPTgsBHaRcTbx3DQdI8Qc0cCzIWvs3Q8sK4eoaz/xH+1IbXm0WYFte1w4m262r
         SLCuVOPlUfyko0TBNY5W5OtMfeU7kcuCLykmt0p20/mkc83Iz0sKoNpvs8AlabFLAg7d
         WVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242133; x=1688834133;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRPhFFSQuvm0hM7+hxNh39CKSjT+bV2/IKmhED0OOXA=;
        b=J87huh/SQ3V/3+mrDJWYjSG8xxHF2hl6Bgt7fzQYqtOBU5WEwUwGGlf1zUGP4DGT1s
         AdcZpgfE50iC01e46H5vpXGpIU/0YIIXUCz5xXvB1RAsH9ccAWLBoGcmvBW+lUJn5Gbo
         gOfDrV2yec125xfAWeGXaxTYvljny4c6QA3EfIRYPdCCm8dLf8OEL1bbUI8uBL+aiHmA
         oTAe7qcdO5+cCOcPSpLq4kLHTIzEd0aH70lJO+PrVKLwmw/Vj2NLTCuC6c/dPdRY4HU8
         zy9wt/14WmODwLoSnAmDo6GJN/vKL7Lm3fzTNBRIOc1w9N5dPymWtcYGS1Y6yrpUya5q
         0W4w==
X-Gm-Message-State: AC+VfDwENzBAbyo9ATb2NKGRCyVSxwXvdvEx30osKAhH7pvE8umnpc75
        gBldmDjzJdub5lFNc5lnF2T9wvcuOvlirzmgfTsEew==
X-Google-Smtp-Source: ACHHUZ7SchFjU7VSbelGnfMmdSv2UKgPadMZaI+e0faGbW35bB/dpmxbMWCtfucYZymdawQfVJc85g==
X-Received: by 2002:a1c:f30d:0:b0:3f7:30c3:efa1 with SMTP id q13-20020a1cf30d000000b003f730c3efa1mr1973899wmq.30.1686242132943;
        Thu, 08 Jun 2023 09:35:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1b90:b83e:29ce:beb6? ([2a01:e0a:982:cbb0:1b90:b83e:29ce:beb6])
        by smtp.gmail.com with ESMTPSA id f16-20020a1c6a10000000b003f60fb2addbsm58541wmc.44.2023.06.08.09.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 09:35:32 -0700 (PDT)
Message-ID: <64a23128-12cf-9f35-c938-14b6b03af475@linaro.org>
Date:   Thu, 8 Jun 2023 18:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v2-1-3bbdf37575c3@linaro.org>
 <20230608154751.GA2750742-robh@kernel.org>
Organization: Linaro Developer Services
Subject: Re: [PATCH v2 1/8] dt-bindings: connector: usb-connector: add a gpio
 used to determine the Type-C port plug orientation
In-Reply-To: <20230608154751.GA2750742-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 08/06/2023 17:47, Rob Herring wrote:
> On Wed, Jun 07, 2023 at 10:05:00AM +0200, Neil Armstrong wrote:
>> On some platforms, the Type-C plug orientation is given on a GPIO line.
>>
>> Document this optional Type-C connector property, and take the
>> assumption an active level represents an inverted/flipped orientation.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/connector/usb-connector.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index ae515651fc6b..c3884eed6ba4 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -114,6 +114,11 @@ properties:
>>       description: Set this property if the Type-C connector has no power delivery support.
>>       type: boolean
>>   
>> +  orientation-gpios:
>> +    description: An input gpio for Type-C connector orientation, used to detect orientation
>> +      of the Type-C connector. GPIO active level means "CC2" or Reversed/Flipped orientation.
>> +    maxItems: 1
> 
> There's no such GPIO on a USB-C connector. Please explain this h/w
> better (in the commit message and/or description). Perhaps it is simple
> enough logic to leave the GPIO here. Perhaps there's more to the h/w you
> are not (yet) describing.

The h/w has an I/O line representing the usb-c orientation at any time
which is driven by the PMIC in charge of the USB-C connector(s).

On this platform, the usb-c connector orientation is only unconditionally
given by this I/O connected to a GPIO line, howerver we get an altmode
event with the orientation, but only when an altmode state has been
negociated. AFAIK there's no other way or events returning this
orientation change unconditionally unlike previous HW generations.

This is why representing it as a gpio is simple but useful since there's
a lot of passive usb-c controllers also reflecting this orientation info
in a same way to be consumed by superspeed switches for example.

As an alternative I didn't find a way that fits the current bindings
to get this simple binary information.

Neil

> 
> Rob

