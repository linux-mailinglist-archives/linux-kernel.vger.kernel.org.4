Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3306A1D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBXNen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:34:41 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BAB10439;
        Fri, 24 Feb 2023 05:34:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i34so29533439eda.7;
        Fri, 24 Feb 2023 05:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kw5cJI1rHZIRKHFIWnHekwrBsn4zRcD69gaW1hs0C/U=;
        b=n+51ixapN6Td6Ox2ZaphZfZswNZWcv8r7IjlzBxg+njtkIGWD22XaYh47X6eJ7Zt0x
         9a9L7A+KqjlhbWJNpiMlv84lP1rG5+cgzWm8UXkQ6CoKtvYmb72RYFLCn9Q9qI+1aig0
         9JobeAGumu/w9YvfOLDK2P8httH35IboGFZWJuPVeQhVXQH/puaB9CZCC0S3ORQF5mJH
         ErolpBaeaLvO/GUm5cAarpvzWyoR/H4B88h4arceFwAv25JAJxVNgXAMWSu3EYbMpYfp
         zbDSrfsjnjTM/78t0jkXzqOVh57OLz5VMWMkPvwdZrDgcsAuEdCyhiR6cZGJAf8J6083
         zEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kw5cJI1rHZIRKHFIWnHekwrBsn4zRcD69gaW1hs0C/U=;
        b=VTHBK7dHBippYt1ThjnS+SPuT7Ur5FyWfQHQCvc5d1N0/8MJwAZM4mZtPrii7KOcgF
         YyZLW+PqGKrRd7Pghkg9r+tBTxQ/Ev5JQGrIvyl4ujmn8x63WdwoBDIXI2tczRvze7sh
         //4OA2sJHI8aWBZE5NuIiCWFZO1r/HNlRLJq/kJmxU9cEPrAw3i512Gc9BRflwdLTufH
         jAzLTBZE0eo3jtSjpKH2cdIf87/rEUgdoHAe9ZEWJdeD/SP8iry+tJoTJHFoPy/2bqpl
         JqizCO2+P4LJ8R1YWpeeoQ3ojZNzqRQW0Q5bHRgvAHcGssDbcMil3L9XEx0xGWtdBQPq
         1oUA==
X-Gm-Message-State: AO0yUKWQ55zjFArGMvO11/Gd1ule7mNIaCWJ85Hqjh8rpaJXsogFZVcs
        jeGgUnTVKOTWdYZSc7pVv4Q=
X-Google-Smtp-Source: AK7set9of3J1wJ2it/J7AXZmN2hY3XpHL2jexB0WeT4xbfAQaN5TEpvXvIXdR6Agc8bfL18mB0vQgA==
X-Received: by 2002:a17:906:ad82:b0:8b1:7eb4:6bea with SMTP id la2-20020a170906ad8200b008b17eb46beamr25019154ejb.38.1677245679028;
        Fri, 24 Feb 2023 05:34:39 -0800 (PST)
Received: from [127.0.0.1] ([91.204.84.193])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906491800b008dd2db45c0bsm4924674ejq.105.2023.02.24.05.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 05:34:38 -0800 (PST)
Date:   Fri, 24 Feb 2023 15:34:39 +0200
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] ARM: tegra: Add labels to tegra30.dtsi
User-Agent: K-9 Mail for Android
In-Reply-To: <50e64bd0-00cc-fd2f-b45e-e7268cd371b8@kapsi.fi>
References: <20230221175348.15681-1-clamor95@gmail.com> <20230221175348.15681-2-clamor95@gmail.com> <50e64bd0-00cc-fd2f-b45e-e7268cd371b8@kapsi.fi>
Message-ID: <99DD9F81-682B-4EFF-B665-D6C2CDC5EC75@gmail.com>
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

22 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2023 =D1=80=2E 10:56:23 GMT+02:00, =
Mikko Perttunen <cyndis@kapsi=2Efi> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
>On 2/21/23 19:53, Svyatoslav Ryhel wrote:
>> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere=2Eqmqm=2Epl>
>>=20
>> Add phandle names for memory/I2C/SPI/USB/SDMMC controller nodes to allo=
w
>> for cleaner device descriptions=2E
>>=20
>> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere=2Eqmqm=2Epl>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail=2Ecom>
>> ---
>
>Hi!
>
>Patches 1 and 2 are missing your Signed-off-by=2E But also, I'd only add =
labels as they are needed instead of adding them all in one go=2E
>
>Mikko
>

Thanks for suggestions=2E I may agree about labels, but it eventually will=
 get to stage when all labels from patches will be added=2E So why not add =
them in one commit instead of making a dozen more with adding one label a t=
ime=2E

Best regards,
Svyatoslav R=2E
