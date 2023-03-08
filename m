Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41146B066E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCHLzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCHLyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:54:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DDFBE5C1;
        Wed,  8 Mar 2023 03:54:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so64658840edy.8;
        Wed, 08 Mar 2023 03:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678276457;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=prMOVdj6+AfmjBbKNSRQcwypgnPVuhbNxoqo8gheSlg=;
        b=ajZ+1GdcL0pkCZJ2KHGDoFhjwIKEEv5QOItZVY94jmSO7egkV1w6foj4+qSvK4JPDI
         P6J6Ua0/kkfsLvCwQu9oHjEGengVUQ7uFCCTodVE1GJu+ooAsnDeSIp64JOGLsJ3j6DI
         hqgiPNr+YZaTcS6ZYe/i/wlVqEeGsHl2NBzl7OjJYlCmM+ja6A7FTwAiDMUSpSOJ+QcA
         KdPYNwofIZJ4r9ScubEMRK0sNy3rmQcO0oRcGGenqizDCZapTCfp/Lb1salqHoIafalD
         0cUnhnyJQJ3eT80u7BvCAurVIwJYnejEw+dGGHu3tQnMqpjowHXhe5oNkJ6CZuWVWdyS
         ivFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678276457;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prMOVdj6+AfmjBbKNSRQcwypgnPVuhbNxoqo8gheSlg=;
        b=tcRmfUOWhELzIC2BGtMjTay417VZqB/B7jtvbX6rjMxid69wMPeQYd+o+mUiD0xl4P
         daX0aEC00wErwNDbIRP24+ebFFyRhpcyfPZ2oqTffNxClvGYio3g3S0LjE14LUzsueuc
         hrADHrb83Ofr6+zqeqDbF0mQBzsfRkkFun32rDEtQMh51dybPueHVLUfKZEhZi6RkTLO
         DICNdDNHh6aiFObxuV2yPUjKHjcoLEIK0phXbCHDD4pcdFCxQfHM2iDS0rkaBJZgx/0s
         6Qm01ZCfw6nZAhCu4v5I0SSjnuK5iNnKpBhWfAXk4pGz5IgWcgq1oRQc3FtW8scaedzX
         1N/Q==
X-Gm-Message-State: AO0yUKVV3jyRKZwUv6LMjoZtBL2gjtS69b3aqrrzb+182Tp//MzuwFVx
        ePpLevhfTwbXqtNGMBC2JPwJm3zG3tPCwg==
X-Google-Smtp-Source: AK7set+JQsoNNK/epTCCGejFTXeTSQ6dvBDEFSBI6EPFzoscMZN3KGS5Z5MLIRsTzcV96vh5IPaNww==
X-Received: by 2002:a17:906:154:b0:881:d1ad:1640 with SMTP id 20-20020a170906015400b00881d1ad1640mr19222532ejh.57.1678276456848;
        Wed, 08 Mar 2023 03:54:16 -0800 (PST)
Received: from [127.0.0.1] ([46.211.69.230])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906b01300b008db605598b9sm7375077ejy.67.2023.03.08.03.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:54:16 -0800 (PST)
Date:   Wed, 08 Mar 2023 13:54:14 +0200
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
User-Agent: K-9 Mail for Android
In-Reply-To: <2b012916-3955-6c4a-a74b-1e86eaa19485@roeck-us.net>
References: <20230308094024.14115-1-clamor95@gmail.com> <20230308094024.14115-2-clamor95@gmail.com> <559c2588-e586-b4fb-97f8-5fe25bb79607@linaro.org> <CAPVz0n38LtyAqBP4GfC003xzaW78FaZ91zjdTNe46ormL5RY=Q@mail.gmail.com> <2b012916-3955-6c4a-a74b-1e86eaa19485@roeck-us.net>
Message-ID: <0BB6AD07-D102-4DF2-ADBD-C1A6473A1019@gmail.com>
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



8 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80=2E 13:35:46 GMT+0=
2:00, Guenter Roeck <linux@roeck-us=2Enet> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On 3/8/23 02:32, Svyatoslav Ryhel wrote:
>> =D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80=2E 2023=E2=80=AF=D1=80=2E =D0=BE 12:=
27 Krzysztof Kozlowski
>> <krzysztof=2Ekozlowski@linaro=2Eorg> =D0=BF=D0=B8=D1=88=D0=B5:
>>>=20
>>> On 08/03/2023 10:40, Svyatoslav Ryhel wrote:
>>>> Add supply property=2E
>>>=20
>>> You have entire commit msg to explain and give background, but instead
>>> there is just sentence duplicating subject=2E And since you did not
>>> explain anything, we have questions=2E=2E=2E like: INA238 does not hav=
e VDD,
>>> so this does not look correct=2E
>>>=20
>>=20
>> This is why a regulator is not mandatory=2E If ina238 does not have vdd
>> then one who needs ina238 may omit this prop=2E How about looking from
>> this perspective?
>>=20
>
>If a chip does not have VDD, the driver should not even try to get it
>for that chip=2E INS238 is supported by a different driver, so that does
>not require special code, but it needs to be spelled out in the devicetre=
e
>bindings=2E Devicetree has a means to specify if a property is valid for
>a given device=2E
>
>Having said this, as it turns out, _none_ of the chips supported by
>the ina2xx and the ina238 drivers have VDD=2E All of them have Vs, and
>all but INA219 have Vbus=2E The bindings don't even explain which one
>of those is supposed to refer to "VDD"=2E
>

So you refer to vdd as to a real name=2E Now I understand this misundersta=
nd=2E Regulator I am interested in is Vs=2E Since you confirmed that Vs is =
supported by all ina2xx there should be no contraversions further=2E

>Also, regulator_get_optional() returns -ENODEV if CONFIG_REGULATOR
>is not enabled, so it isn't entirely optional=2E We can not suddenly fail
>to load the driver on systems with CONFIG_REGULATOR=3Dn, so some conditio=
nal
>code will unfortunately be necessary=2E
>
>Guenter
>

Hm, then Lars-Peter Clausen suggestion should be applicable in this case=
=2E

>>>=20
>>> Best regards,
>>> Krzysztof
>>>=20
>>=20
>> Best regards,
>> Svyatoslav R=2E
>
