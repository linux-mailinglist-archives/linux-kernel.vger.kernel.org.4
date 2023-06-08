Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D069072815B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjFHN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFHN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:27:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DE2136;
        Thu,  8 Jun 2023 06:27:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6537d2a8c20so351297b3a.2;
        Thu, 08 Jun 2023 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686230863; x=1688822863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qTMZtxLsgZNc3cuP7Uokky79RRouOuEgPTdkBkwmwtc=;
        b=kxqpzDX+UXXviHrKawFn8GFyawmYEm1odpfT91KAzRbE0urbs58ds+pSUX1koV9UnJ
         eCipIZ8Cm30xJZzrhikbzxwmIPptF2O5QHVzMwNxt6LgXXRYxOSPd0hh6uLjfMmGPbOX
         gF9Gx6rpO/H8xS3rR0yoL0r90Jo32qIJMO2nhZs10q9VSGwZXVl1qmsYyWA7MAW/u93f
         skP+4Ujzujnh+4O1xrP2VqzglY8u4NTYuZfOJLp1TBGydVc7tvpTDtxRtKsiBDw9q2ja
         2Vqnng0lLxwFWytR6BjeCWp5dcZ4/ghPNrjZt8tESSxI7SprYx7yIO47KHaBcmbaES6J
         7Y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686230863; x=1688822863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTMZtxLsgZNc3cuP7Uokky79RRouOuEgPTdkBkwmwtc=;
        b=YxDjN1Rm5w8tSHM/QN8GN1O9eoaVYX63hpeZAMOB5XOBAxmzuhDEYFanT6/C/GtH78
         Liqv7KQDKC3D/sxqLODevLjcfkL9BV9aOwI24QOoEb+f+D0QVRjFp5c0CLYaB8wwEcLq
         JY92Mq0bcYuZ1xIT1OzY8KQa9PGMczhxyr6XkhA93VysRo0sgfTx5eyivIYfrau6kzPE
         8a+QKJlTmtHBBwMxhJK543mUjpKqIe3qTHdyeDim0ReIl4Aw5UddzUTHAnDGj52E+nTQ
         Dhjwe1SLWRxl9ZnZz2UR0nAI0y/q1qkJTmp2PUwETBua/vc8h6h72OPeyJZ9HtWOKdv5
         ePfw==
X-Gm-Message-State: AC+VfDzO2oQFLuDaJrHms0/rRIJc8lmSvcIGbkq2oTbk2gjoonIeiuTE
        cRUq7/Pgnkyc+trtxo6vwHNTkdTsDlc=
X-Google-Smtp-Source: ACHHUZ7XnHRkgrU20otn1V777Rw1TPxhaBNfOWLz68sNpQjXPu7waU9jRrBNs3zlEfTXX61ue966dQ==
X-Received: by 2002:a05:6a00:24d1:b0:662:93b5:56b9 with SMTP id d17-20020a056a0024d100b0066293b556b9mr3850834pfv.14.1686230862785;
        Thu, 08 Jun 2023 06:27:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e21-20020a62aa15000000b0065014c15a57sm1130991pff.35.2023.06.08.06.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:27:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <da56e9c8-ed4a-c11f-fe8c-a97fbbddb736@roeck-us.net>
Date:   Thu, 8 Jun 2023 06:27:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v11 1/2] dt-bindings: hwmon: add MAX31827
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Matyas <daniel.matyas@analog.com>
Cc:     Rob Herring <robh@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230608104152.14249-1-daniel.matyas@analog.com>
 <aeef2066-72f4-8e41-cec3-f5c6815820a6@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <aeef2066-72f4-8e41-cec3-f5c6815820a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 04:30, Krzysztof Kozlowski wrote:
> On 08/06/2023 12:41, Daniel Matyas wrote:
>> MAX31827 is a low-power temperature switch with I2C interface.
>>
>> The device is a ±1°C accuracy from -40°C to +125°C
>> (12 bits) local temperature switch and sensor with I2C/SM-
>> Bus interface. The combination of small 6-bump wafer-lev-
>> el package (WLP) and high accuracy makes this temper-
>> ature sensor/switch ideal for a wide range of applications.
>>
>> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> Change log:
>> v10 -> v11: No change.
> 
> Wasn't this applied? Why do you send it again?
> 

There was a problem reported in the driver implementation
(bad compatible entry). The submitter chose to send
v11 instead of a patch fixing the already applied driver.

I'll fix up the original driver patch instead. Please ignore.

Guenter

