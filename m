Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7007247D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbjFFPdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbjFFPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE91010DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686065546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1t0pmKIt5vaJFpwmXmGq+ZDjgfyGlSjiNP3LMD+ACA=;
        b=F+SLr4iZDpNwbAMO+ksnj3W+aVQbdYoY4mAxdkH7eMAyHcNuDcPYRz/MbeDl7qqUqNcUVg
        YbmP7GPXtUF4eAjUcLp+Dy7OplkqEQfCZinH2r0VWLX/T+6lhGtXsK7fAvB/e6TolRrOKu
        +78SkrtdFGgmSvSXSa0XY0DicgUVO04=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-TArNyfP4PsSuurdzRAC84Q-1; Tue, 06 Jun 2023 11:32:01 -0400
X-MC-Unique: TArNyfP4PsSuurdzRAC84Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9745c72d99cso436323666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065501; x=1688657501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1t0pmKIt5vaJFpwmXmGq+ZDjgfyGlSjiNP3LMD+ACA=;
        b=H5u/MeWteogkBQC9jE6iDFrGi16k0pcZkNEpJL1u1FHuOSwhLEDkykpzduZcbaTxj7
         A3WU+M3QWrtsxuUC6gf3L8ydvuYOuOUqIlMqAKk6uyaN22ElVUzHvGPpHxcVj3d4fkWP
         6JFkJcr5+RU92GejsVF2LSfpsHrXDZ9WYbjFjX5fc+y5RmleamkbTry19S9Odxjv9REC
         V2lJjfw9agfpyqXO26mUwSNqy5eF33c3+FKijoadvUQaK4x9EJOR7pdzSyh0tx9dejzB
         hvU9rQiDkmeZ/WNXAeTI4scgW81tv5vjbsy+rkOEn+YXe/OtVNqlZwHtqermJH4woILU
         e6Lg==
X-Gm-Message-State: AC+VfDxgDNDONiGW1rIcgw6esZOdIjS/UzVlr1tS7m2mh3tOLS/5lcAv
        lRWB/BLOS3fm1vuXfidXCfr6cqUUbZBOrZkwOppKWFJJsqz5GfXr1T7yN0uTcrct0bfSe/Xszzm
        A4xmDqIFOqYgecdUkvE4mi/fE
X-Received: by 2002:a17:907:948c:b0:96f:f6a6:58cc with SMTP id dm12-20020a170907948c00b0096ff6a658ccmr2663397ejc.15.1686065501298;
        Tue, 06 Jun 2023 08:31:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fmsq+XYgnJ2EVJ0RhRfL6yxjqnq4cY+vHlsWelX09825PP4Sa5cKe57yjCaKRFE9J9fQwCQ==
X-Received: by 2002:a17:907:948c:b0:96f:f6a6:58cc with SMTP id dm12-20020a170907948c00b0096ff6a658ccmr2663381ejc.15.1686065501036;
        Tue, 06 Jun 2023 08:31:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709060a5600b0096f6a131b9fsm5689719ejf.23.2023.06.06.08.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:31:40 -0700 (PDT)
Message-ID: <f5f20de8-851a-fe20-4664-62b6de14ebd7@redhat.com>
Date:   Tue, 6 Jun 2023 17:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 0/4] input: touchscreen: add initial support for
 Goodix Berlin touchscreen IC
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 6/6/23 16:31, Neil Armstrong wrote:
> These touchscreen ICs support SPI, I2C and I3C interface, up to
> 10 finger touch, stylus and gestures events.
> 
> This initial driver is derived from the Goodix goodix_ts_berlin
> available at [1] and [2] and only supports the GT9916 IC
> present on the Qualcomm SM8550 MTP & QRD touch panel.
> 
> The current implementation only supports BerlinD, aka GT9916.
> 
> Support for advanced features like:
> - Firmware & config update
> - Stylus events
> - Gestures events
> - Previous revisions support (BerlinA or BerlinB)
> is not included in current version.
> 
> The current support will work with currently flashed firmware
> and config, and bail out if firmware or config aren't flashed yet.

What I'm missing here / in the commit msg of
"input: touchscreen: add core support for Goodix Berlin Touchscreen IC"

is an explanation why this is a new driver instead of adding
support to the existing goodix.c code.

I assume you have good reasons for this, but it would be good
if you can write the reasons for this down.

Regards,

Hans



> 
> [1] https://github.com/goodix/goodix_ts_berlin
> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (4):
>       dt-bindings: input: document Goodix Berlin Touchscreen IC
>       input: touchscreen: add core support for Goodix Berlin Touchscreen IC
>       input: touchscreen: add I2C support for Goodix Berlin Touchscreen IC
>       input: touchscreen: add SPI support for Goodix Berlin Touchscreen IC
> 
>  .../bindings/input/touchscreen/goodix-berlin.yaml  |  81 ++
>  drivers/input/touchscreen/Kconfig                  |  33 +
>  drivers/input/touchscreen/Makefile                 |   3 +
>  drivers/input/touchscreen/goodix_berlin.h          | 228 +++++
>  drivers/input/touchscreen/goodix_berlin_core.c     | 935 +++++++++++++++++++++
>  drivers/input/touchscreen/goodix_berlin_i2c.c      |  76 ++
>  drivers/input/touchscreen/goodix_berlin_spi.c      | 183 ++++
>  7 files changed, 1539 insertions(+)
> ---
> base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
> change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c
> 
> Best regards,

