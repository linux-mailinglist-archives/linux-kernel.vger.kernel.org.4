Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE46C6B0A70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjCHOEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjCHOEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:04:25 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BBCDA19;
        Wed,  8 Mar 2023 06:01:47 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cw28so66145317edb.5;
        Wed, 08 Mar 2023 06:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678284106;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B1bXJOyXjPOrWGNoY1T7rRsDOWzuuEM286YNL5pDWXg=;
        b=fdp+qaegXNOzS3XIjm6hn5VGF+bbxueEXNFjOjuKS+e/gbhGC9Gx8DTcBp22wgrnsy
         HCS9msReZl9IkVwKoGyavMbRrxcISGNfI1IEcsY4Jtj/JNMzKjwpk/5m7UyUhHcUHqsq
         vu0C0NjjGnPE6GZrpJ0MCy7uAT/zgd6WRbUbbm+hDy645jKQUzqcqzhQO0dIwFZmHFpd
         IXKDJeyE9jb/VU0iTLJZPJv7Ly5GyMBMDXi4m11Ma6C77jSTCPkwqDH4m6mGdLGfU67W
         ZZrFFEZYT7hab0QnfZZKDEIBsc9JujpSejpNpjiIYJzc47OKWjnVoDMBmn3OB7NYaUQV
         hFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284106;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1bXJOyXjPOrWGNoY1T7rRsDOWzuuEM286YNL5pDWXg=;
        b=KjhI44iyeOKXqPmBUsFkOiqnoh5lWQ0FlbYXF8IbT/6/yTJHW5D5agNYCZHhty6Wi/
         Rwz1Ac5b9mhmztDpmy5gJ5oDsQeHwbYIuwD74sAWEcdaWfism/m2vvv6/yUmZI4ptnDl
         viXFbcT9FiMYv5/tSiD9X+UTfiGCTtFU3J3yP0VTTeyz1gkXL1mwyY7Ye3iPw581TpJ9
         McIgqvxff3pnyfYY8LT8CRgpeNaP/7NPqUfQEyKUslbSgp+11lBK7lwJ5E98qkY+boFV
         5AWx61nW4myjPfsf/2ILdiHFwkll2OBbIR9MPmCkLqgPh89saQTxVLp3NMqmpHJLXuNq
         qpdw==
X-Gm-Message-State: AO0yUKU0CLuGEKPv+EyFFcyDIugIFTY5KvEMJJYBRWyv5/ELCxLoEGKW
        +DjxiITx8louQLE1Sc9oIOTJrjr0EIdF+g==
X-Google-Smtp-Source: AK7set8posVtu3K86DBJkt0PWWC/HrybdhiW+IG2rlMrXHozpU/5tccCOX3TilQFS5W2y2fuI51tNg==
X-Received: by 2002:a17:907:7f13:b0:884:3174:119d with SMTP id qf19-20020a1709077f1300b008843174119dmr24705007ejc.14.1678284106452;
        Wed, 08 Mar 2023 06:01:46 -0800 (PST)
Received: from [127.0.0.1] ([46.211.69.230])
        by smtp.gmail.com with ESMTPSA id y7-20020a170906470700b008ef13127b5fsm7529758ejq.29.2023.03.08.06.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:01:46 -0800 (PST)
Date:   Wed, 08 Mar 2023 16:01:44 +0200
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
User-Agent: K-9 Mail for Android
In-Reply-To: <5cd6764c-9b04-42ea-932d-9f14aa465605@sirena.org.uk>
References: <20230308094024.14115-1-clamor95@gmail.com> <20230308094024.14115-2-clamor95@gmail.com> <31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk> <6DBD0F5A-4625-4FCD-8D64-23293D734A82@gmail.com> <5cd6764c-9b04-42ea-932d-9f14aa465605@sirena.org.uk>
Message-ID: <135993BF-B4AC-42C1-AD36-94F66EE1620D@gmail.com>
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



8 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80=2E 15:46:52 GMT+0=
2:00, Mark Brown <broonie@kernel=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Mar 08, 2023 at 02:58:20PM +0200, Svyatoslav Ryhel wrote:
>> 8 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80=2E 14:54:34 GM=
T+02:00, Mark Brown <broonie@kernel=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
>> >On Wed, Mar 08, 2023 at 11:40:23AM +0200, Svyatoslav Ryhel wrote:
>> >> Add supply property=2E
>
>> >> +  vdd-supply: true
>> >> +
>> >>  required:
>> >>    - compatible
>> >>    - reg
>
>> >Unless the device can work without power the supply should be required=
=2E
>
>> Device can work without supply defined on most devices, but in my case =
power is gated with gpio and devices will not work without fixed regulator=
=2E
>
>If there are devices that work without any source of power at all that
>would be very surprising=2E  It doesn't matter if a particular system has
>a non-controllable regulator, the binding should still make it mandatory
>to describe that=2E

Then question is WHY and WHO passed driver without power supply system imp=
lemented? Why it pops only now?
