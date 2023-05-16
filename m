Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A706870461C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjEPHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjEPHRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:17:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA46173D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:17:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so25026993a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684221427; x=1686813427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yirYTDxj7pduNeaDQeO+tWn+V6MyxXiA3DTVWIK3F40=;
        b=KTm1TzjIjO8Hdxa5e/QaF0dS1/NXi4ucf7+Qy+EKJlpdpo3qiSJCzNoPoBqGSyDeHd
         e49PQv0tGFELrA/1GsuKmjoarUpcD177+EIUUNeXhXLgmvuEhKkj1MLkXoA8FMU5Kpb7
         H4eYO6Y86+KoZAr7AU+SCnSdMiHOGmvVdaChaZWwQdZhcJdHwwExhvw9lXGR+mQ1h2Zr
         lcxJnWtqXbPU91IfvcosXovZgvoILPBr16i1XHfltKs5vCT8Kq4DJ1z5mA4ryV5D8Ok4
         mPPw/cSL3UA6PMZlBKmdyjIJXkfmneLXMPlrFO6LWEX4qELc6jSTYSqP5SD6BGNb0iV4
         WfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221427; x=1686813427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yirYTDxj7pduNeaDQeO+tWn+V6MyxXiA3DTVWIK3F40=;
        b=BpxOxwHHb4iiWIMVp9PLzI1ZdTv0KSr+e6gsK/hBKIVlr5QyxQSBb9+3jMJjkDSI7E
         5d0ZmKHXCYoGYtW0L1jW/nrx4tGJpfRqGaFzaPC6m6FJqPBGhIe1RVSKgCHYJOcRAUF3
         4CkoFC+zyUmrSe+xh3g4MU6GqYjqFXFH7PbQEenjUPOGDya6QQq1ji1ep7M8N4xSYmi/
         DQj4XI0S5qIe92v++8ZSXh7VCBjz780G3t0CpM2xojseqiWHUPNbcdGo+bYNDXUz2Jmo
         BMXnvp5qxbaBnoFMYJh8XPIwXyO10ONiZr41tKqaeFDF91VGCnwaK2Epdafi8morl/oC
         6Shw==
X-Gm-Message-State: AC+VfDx9j4+l7LC4K12WMgrMCPwXtZy1hqViRjkvK5S00STm7rvkAwCG
        QuMrUpyZubrq6E1OZJMeCVaU3dyAK+FhEqqt9RQ=
X-Google-Smtp-Source: ACHHUZ76+vLbbpfzfL4GFJj/oifuoMKAqhcnfUEb2ky8VAlxUr6+v/sifoafnILiqT6GBYWJx0vhzg==
X-Received: by 2002:a17:907:928e:b0:94e:8cdb:bcee with SMTP id bw14-20020a170907928e00b0094e8cdbbceemr31175165ejc.70.1684221427166;
        Tue, 16 May 2023 00:17:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id jl21-20020a17090775d500b00965b5540ad7sm10817697ejc.17.2023.05.16.00.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:17:06 -0700 (PDT)
Message-ID: <cc3e80ab-9794-fd37-45e9-3b3d9cc761ae@linaro.org>
Date:   Tue, 16 May 2023 09:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 6/8] arm64: dts: Add AMD Pensando Elba SoC support
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
References: <20230515181606.65953-1-blarson@amd.com>
 <20230515181606.65953-7-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515181606.65953-7-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 20:16, Brad Larson wrote:
> Add AMD Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

