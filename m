Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406376B05B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCHLUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjCHLTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:19:55 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6018F70D;
        Wed,  8 Mar 2023 03:19:54 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o12so64229379edb.9;
        Wed, 08 Mar 2023 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678274392;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rMOE4fBtmW9fxcbhT3oZcCKs1+lTss3ZikJx1taQjKU=;
        b=T4/GVkXywp+4cICmFamoeqgn7jvt4fF5m2WVkgiICwK8ht4foeX8WxKlFXztplgXRM
         dX2fn8nqp9THVMlkxjDFP9nYjdivlYkqgsKPEQx3Kj/We++6cIf5IvW5ccVeRITHaVvt
         wm3AO/cJBiywnvk4mMdQ62OhLnYdmxJkYeCUevEw7Puii5efZZy9lPcfDP9bhH63dvUX
         2YO+IHaTjAznTdfJMlJ7LvucEmUfLdZ6wZRzw8yP92CFL14hVp8o/laLoCgDhQyr8aQ4
         3W4xoAqkmsOKRY4Exnz3N5bVSw5j6i0XzcfEGGC8mw+WKLYIwcCKiSJVOqmVkFKY2Bjt
         Y+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678274392;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMOE4fBtmW9fxcbhT3oZcCKs1+lTss3ZikJx1taQjKU=;
        b=VnOlgThdyBpRnjOW7pEwSd9mImi+tjyDN5O0ac/BrHlmh33UTtWanxXLTB5y6fM6An
         DovhWu5tukiVcwZ5TX6CLhucqUpIj5227dQBZEAiN28SLNkQmg289mHFIl4AhoAJzaOe
         kD5uQcP7N923X2rYl3SJIAgOCGQKYsXf60qeFWDhqngsJnQ6ivJWlaQXZYpnXK3Oxsg6
         sDYuLPPmkm6AAbYZYQaA3J4y0+YyXGhAwks9PIUnofaKX+rVUw0l7CRaTiiKmlmpjxop
         4hxu7VaEy3M7MKQz4YcmTmUV5IG6/3ydnvvD1K21Xe2DNbm0adRcYySBIa6lFi4RgVT9
         u6XQ==
X-Gm-Message-State: AO0yUKXUpzNTjtv89jRiDBj0D7YbzejengvGPea+i447+QtxKLkFmMt1
        myNgmG6EoRkeB6c1Gq5KbF0=
X-Google-Smtp-Source: AK7set+9r3i7LbfHeh1tBgU6dJjoqHBsw/K789VGlq2goukzgVBj3+t1mlxo80W+KWGDeRUflq30cQ==
X-Received: by 2002:a17:907:9485:b0:8a9:f870:d259 with SMTP id dm5-20020a170907948500b008a9f870d259mr20081841ejc.48.1678274392526;
        Wed, 08 Mar 2023 03:19:52 -0800 (PST)
Received: from [127.0.0.1] ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id v8-20020a50c408000000b004c09f0ba24dsm8042358edf.48.2023.03.08.03.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:19:52 -0800 (PST)
Date:   Wed, 08 Mar 2023 13:19:51 +0200
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] hwmon: ina2xx: add optional regulator support
User-Agent: K-9 Mail for Android
In-Reply-To: <a1187c2e-122e-36d1-dddd-c7beba282800@roeck-us.net>
References: <20230308094024.14115-1-clamor95@gmail.com> <20230308094024.14115-3-clamor95@gmail.com> <378db0d7-4d5a-a445-3e1a-ee6d8da5a9e2@linaro.org> <CAPVz0n2KgUKi-m+kjvbxq8fA_G0+KNHtkNe4T0UGpmasMjWK2A@mail.gmail.com> <a1187c2e-122e-36d1-dddd-c7beba282800@roeck-us.net>
Message-ID: <70325083-25B9-434F-9F48-9EE7AE28B550@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



8 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80=2E 13:13:18 GMT+0=
2:00, Guenter Roeck <linux@roeck-us=2Enet> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On 3/8/23 02:35, Svyatoslav Ryhel wrote:
>> =D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80=2E 2023=E2=80=AF=D1=80=2E =D0=BE 12:=
25 Krzysztof Kozlowski
>> <krzysztof=2Ekozlowski@linaro=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>>>=20
>>> On 08/03/2023 10:40, Svyatoslav Ryhel wrote:
>>>> Some devices may need a specific supply provided
>>>> for this sensor to work properly, like p895 does=2E
>>>>=20
>>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>>>> ---
>>>>   drivers/hwmon/ina2xx=2Ec | 12 ++++++++++++
>>>>   1 file changed, 12 insertions(+)
>>>>=20
>>>> diff --git a/drivers/hwmon/ina2xx=2Ec b/drivers/hwmon/ina2xx=2Ec
>>>> index 00fc70305a89=2E=2E4a3e2b1bbe8b 100644
>>>> --- a/drivers/hwmon/ina2xx=2Ec
>>>> +++ b/drivers/hwmon/ina2xx=2Ec
>>>> @@ -119,6 +119,7 @@ struct ina2xx_data {
>>>>        long power_lsb_uW;
>>>>        struct mutex config_lock;
>>>>        struct regmap *regmap;
>>>> +     struct regulator *vdd_supply;
>>>>=20
>>>>        const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROU=
PS];
>>>>   };
>>>> @@ -656,6 +657,17 @@ static int ina2xx_probe(struct i2c_client *clien=
t)
>>>>                return PTR_ERR(data->regmap);
>>>>        }
>>>>=20
>>>> +     data->vdd_supply =3D devm_regulator_get_optional(dev, "vdd");
>>>> +     if (IS_ERR(data->vdd_supply))
>>>> +             return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
>>>> +                                  "failed to get vdd regulator\n");
>>>> +
>>>> +     ret =3D regulator_enable(data->vdd_supply);
>>>> +     if (ret < 0) {
>>>> +             dev_err(dev, "failed to enable vdd power supply\n");
>>>> +             return ret;
>>>=20
>>> And where is disable? On each error path, removal etc=2E
>>>=20
>>=20
>> error path ok, should I create a remove function just to disable the re=
gulator?
>>=20
>Use devm_add_action_or_reset()=2E
>
>Guenter
>

That is good suggestion=2E Thanks!

Best regards,
Svyatoslav R=2E

>>> Best regards,
>>> Krzysztof
>>>=20
>
