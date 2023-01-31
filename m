Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971426832FC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjAaQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAaQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:47:21 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D912A3433C;
        Tue, 31 Jan 2023 08:47:20 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so2549357otj.4;
        Tue, 31 Jan 2023 08:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocvFu8bY6yVyMnTFTmW4VNxSdgQzFoQqdQVplWxIToI=;
        b=KPvdMbaCbzTt1996PdkhalzCn32qnfE/+x6iWKqOtAr86WLL7UGnp+xik3NEXPjST5
         2KcIVy+uq5R79zpJnBjXbVhGG3lmka9T3E04QHapx6PY8fsRWzRSHO2qX5YAAyltrwFj
         DaVaKed+xErvZiYv/F45ZvEE7q4e8APev0bb/5+JFdM2qPQrFUwrEEEQWbYYbofVz0or
         bHwLQSTHir2VcHS+c5GERmesFhf+5bFP3HyTBYQ5poP+b2XiyxnCs6ENpyw9wrqmsXZe
         DbFGmIiLRmh8JVzfgkYZ8ynf0XBhlZZeflUtDkf/dxdDMR2X5QM+Ewq4dz29Rd5WvXwa
         /48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocvFu8bY6yVyMnTFTmW4VNxSdgQzFoQqdQVplWxIToI=;
        b=Dg5KIjaNbmQAdjBDf4vFpMsH1+8cmh/ExoqyTxo1YaqJ+3hS9V3DT1jRdlKORyDsKE
         mxAJWk1xgi8GfwOhv84gteJf1JE6sPMq4r+7kCuvwPfMrnxxo8vhQI/MuLJ3BHzVlN8o
         MdJv57L34SiX26a+jgYRwlPGsKUYlifc9AfSJlxjHrXfKqwMqJ+nMwLBQr3HqFqppb8O
         PVY0Lfb1FFrCA+ihdhRGL5ratq7iWJ12OJQu3zsM4AhWVZB1+jsHYdgaGR02FwzC5cYs
         EOAHeLpDh3XcHn1eHOic+/Gm12d7Im5kh/PO+YkeT6SkWm42sypdhkqMDGNJo7f+3MSQ
         ok+g==
X-Gm-Message-State: AO0yUKUcD4bJigCb7ZHJaA3uabVAWceDMFGWB4bv8G7FfQtBlLtkqRSk
        lW8zhQnueM1+hqzwJg38uTc=
X-Google-Smtp-Source: AK7set/ZY4mTvooxBqD3WOeWuTHhOB53Df1V/jE4+7aw+J59Tn5gh1ghMARazQlh+2Jka9hjBOGf1g==
X-Received: by 2002:a9d:2e2:0:b0:68b:9e3b:3758 with SMTP id 89-20020a9d02e2000000b0068b9e3b3758mr7953734otl.9.1675183640063;
        Tue, 31 Jan 2023 08:47:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s10-20020a9d58ca000000b006865223e532sm781368oth.51.2023.01.31.08.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:47:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 08:47:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: watchdog: mtk-wdt: Add
 reset-by-toprgu support
Message-ID: <20230131164717.GA3596213@roeck-us.net>
References: <20230117014023.2993-1-allen-kh.cheng@mediatek.com>
 <20230117014023.2993-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117014023.2993-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 09:40:22AM +0800, Allen-KH Cheng wrote:
> In some applications, the mtk-wdt requires the TOPRGU (Top Reset
> Generation Unit) to reset timer after system resets. Add optional
> mediatek,reset-by-toprgu property to enable it.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index b3605608410c..55b34461df1b 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -52,6 +52,12 @@ properties:
>      description: Disable sending output reset signal
>      type: boolean
>  
> +  mediatek,reset-by-toprgu:
> +    description: The Top Reset Generation Unit (TOPRGU) generates reset signals
> +      and distributes them to each IP. If present, the watchdog timer will be
> +      reset by TOPRGU once system resets.
> +    type: boolean
> +
>    '#reset-cells':
>      const: 1
>  
