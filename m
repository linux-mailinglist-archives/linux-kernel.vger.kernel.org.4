Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6896063F43E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiLAPjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiLAPij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:38:39 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330E29D81E;
        Thu,  1 Dec 2022 07:37:58 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so1171595otl.10;
        Thu, 01 Dec 2022 07:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gEPlKgqOAwT4dYPi/LP8L4p5vA3UQVno3LcyW5TU5do=;
        b=oTiDqVYVe8XB8vfEgM1fH7KI5SMCARIwHb5TNr4ECuffe/KlIbF3ICbwbjmg+ZgxEu
         ILAjcFWTQqVJW8NDwxUCvP0hLl8kXsqlzf3e7sf0zSuOWsqGYRTScXBXgoHQSQd3qUdg
         QT042AxSVUE/r0mkNmoqs/sPfZ8oB/vPAwxWMpafEDd8fPtuXTAqtCDXIiKIg79QDG/z
         4OJo+rF7gk7Lh7vXbcY/+ky/Q2cJxP0l3s/5KRCfeeR4caQxgCIAZmvNlEeL3zIE8jze
         i3fDoqyiurMaMxab35SksofxZnqnMY1jcaL2dfVLeD5qNTrnAg1RZXCjDY4By8WdraQ6
         yvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEPlKgqOAwT4dYPi/LP8L4p5vA3UQVno3LcyW5TU5do=;
        b=T/z7BlsnHDiv4zvyezo0SpQLctgBN9C3qn4nB1VMdVguO+MbZP/S31ykdGtt8UQS8F
         XvywyTS2BYL/Z/YH6vK/zwgTjsCYCFG1O2rb1G+Y62GUeWHo7twZBjbbnr1WiiGdClmt
         B9SZJ3oMnlORRW/pTETcHpIG+JzTAHiOs2ObPq2uKDHT1ITAa66lw3enRDduDl8gdS+q
         TrTyjfuELEfn03fFzjnVE/pt3jRZ0JjBI/VxCb1ZWzaz+hnYXV5H7V+RYZ44I9Ra1GiM
         bAl8VYGmQVvRFVuiApmGUo9swfEEThMOxaxt5knSyGPx01M6aqvdWBJrsHM28ALn2vKh
         eJTA==
X-Gm-Message-State: ANoB5pmCkidWzjnHZW0pZUsbwPHPVVv/dbXi3Ijfv13UOTqxsDl/FjWI
        0MERKvyhXvEHaK/3b6dInFY=
X-Google-Smtp-Source: AA0mqf4RoyxUmaMmV/OQumiM/v0A/BK5z6bCEClp390ndUSxS3og9fFl/A1ZLIE5QkFevyFizE4SJA==
X-Received: by 2002:a05:6830:1215:b0:66d:78b8:7b1a with SMTP id r21-20020a056830121500b0066d78b87b1amr24948947otp.206.1669909077169;
        Thu, 01 Dec 2022 07:37:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e5-20020a544f05000000b0035a5ed5d935sm1918539oiy.16.2022.12.01.07.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:37:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e0d97b79-2133-8869-eaea-eb286fdb3a11@roeck-us.net>
Date:   Thu, 1 Dec 2022 07:37:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon/pmbus: Add mps,mpq7932
 power-management IC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Saravanan Sekar <saravanan@linumiz.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marten.lindahl@axis.com,
        jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-3-saravanan@linumiz.com>
 <bc86121f-3cc2-1e55-4c6a-02cb1644a8bd@linaro.org>
 <e7b20055-4f44-aa91-e18d-9fb0f835fbf1@linumiz.com>
 <29de4d2b-3e32-809e-6ccd-5e7a4fe548fc@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <29de4d2b-3e32-809e-6ccd-5e7a4fe548fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 03:38, Krzysztof Kozlowski wrote:
> On 01/12/2022 12:29, Saravanan Sekar wrote:
>> On 01/12/22 11:26, Krzysztof Kozlowski wrote:
>>> On 01/12/2022 05:46, Saravanan Sekar wrote:
>>>> Document mpq7932 power-management IC
>>>>
>>>> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
>>>> ---
>>>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my previous comments were not fully addressed. Maybe my
>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>> Please go back to the previous discussion and either implement all
>>> requested changes or keep discussing them.
>>>
>> Hi Krzysztof,
>>
>> Thanks for your time to review and feedback.
>>
>> Here are the summary of comments on V1, I have fixed all according to my
>> understanding.
>>
>>
>> 1. Use subject prefixes matching the subsystem (git log --oneline -- ...).
>>
>> git log --oneline -- Documentation/devicetree/bindings/hwmon/pmbus/
>> 1ccca53618c4 dt-bindings: hwmon/pmbus: Add mps,mpq7932 power-management IC
>> 373c0a77934c dt-bindings: hwmon/pmbus: Add ti,lm25066 power-management IC
>> 7f464532b05d dt-bindings: Add missing 'additionalProperties: false'
>> 8a36e38d8b0f dt-bindings: hwmon/pmbus: Add ti,ucd90320 power sequencer
>>
>> I have used the same format of 373c0a77934c.
>>
>> 2. Does not look like you tested the bindings. Please run `make
>> dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>>
>> I did run dt_binding_check on V1 but failed to notice warnings. Fixed
>> warning on V2 and didn't observed any warnings.
>>
>> 3. Why requiring nodename? Device schemas usually don't do that.
>> dropped "pattern: "pmic@[0-9a-f]{1,2}""
>>
>> 4. regulators node is a regulator with one more regulator? Drop.
>> dropped "$ref: regulator.yaml# "
> 
> The comment was - drop entire regulators node.
> 
> Plus additional comment for the driver (and related to bindings) was
> that this is not hwmon but a regulator driver. Why putting regulator
> driver in hwmon?
> 

Turns out this is primarily a hardware monitoring driver, like the drivers
for all other PMBus chips. Regulator support is actually optional; the driver
works perfectly well with CONFIG_REGULATOR=n (except that it needs some
#ifdefs to address that situation).

Guenter

