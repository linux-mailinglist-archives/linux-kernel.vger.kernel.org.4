Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967A6E39F9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDPPwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:52:45 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D52D73;
        Sun, 16 Apr 2023 08:52:44 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760ec550833so30328039f.3;
        Sun, 16 Apr 2023 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681660364; x=1684252364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4x2UJbvA5jImCs/m0TE0mCVt0AeoRniWoSCs1UrDqo=;
        b=ScGUjRJTU56vQ6XAjspmGfU+EZ2wfDnMHBldx/bQuYz1s7xiP1bp1v93edwVkoa60U
         cg+zNaSACeqDSzKBiQNMOTsBhYR7ZCHWZEIdY93KbDg5wo2iihTXLErzrhP/T+Lk+eH7
         AmUjc4a/tj/Ljju0pNP+QklD32B2XC+2U1rn8AB4WH7bMGRDIBZpzcBr4U3c6YY3d/jE
         S0s6rJPf563CL7O417OkJXkrgLgtmSkC5KCfB+uYbtxZz7OO1+CYjd5D8DZqWOSbLfpD
         /VqPF/FNyTTMU5SXRVYvL42ZRy5leAXJsNUedhihIEmbcdH0sXJ/jIpQ8maDNPAVyTEg
         UdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681660364; x=1684252364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4x2UJbvA5jImCs/m0TE0mCVt0AeoRniWoSCs1UrDqo=;
        b=gZSfR5ABy2qXXJKrX0RjDu5Yw6gOxKoXAghY6elltHgmB1rTBAoX4A5xB2lnb3aodp
         9+JdIV0g82XMKcIvYi+UUFQxqH7ncl42kbxZXl3rmjDfQo4s5IBEtQuyUXGGfru545b+
         U1diS4tlswydaW2brAmxXaRDd38W5Z41UL/oYUSJxPWjtP5xglFEGrh6zrjiS/+rKl86
         VsvHt6uuLZ6vbY25n7fSqMSfo2otmvgnZW/KT88cG+KqtGNKgJYP5/U4qiyLMgg2CtoK
         T16Y30MSDV+75UFichOav+NoO4T8lTOTXEQSkJDGO4JouhVOJ5riCSoSWSL7ivlqc155
         PXOw==
X-Gm-Message-State: AAQBX9dx/HU1+LurPHnKv1cbg3s07EVtxaxo8ztFbSQrQXO0c4fy9muE
        qiMtz0sVWsnK7SUtQXVz/cg=
X-Google-Smtp-Source: AKy350a2fmmqdnZl4mg3g2vqLIdSX8pwTBimS6MtogYV0JnSjs8ic62o+L+RAxzAJTi2ddB3s/jTyw==
X-Received: by 2002:a92:d48f:0:b0:318:d56e:9efa with SMTP id p15-20020a92d48f000000b00318d56e9efamr7990945ilg.24.1681660363979;
        Sun, 16 Apr 2023 08:52:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l13-20020a02664d000000b0040bbcee6b57sm2543288jaf.133.2023.04.16.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:52:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 08:52:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 01/17] dt-bindings: watchdog: mediatek,mtk-wdt: add
 mt8365
Message-ID: <50a598a4-016b-4f2a-9d7e-19707d612238@roeck-us.net>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-1-0003e80e0095@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203-evk-board-support-v3-1-0003e80e0095@baylibre.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:54:22AM +0200, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-wdt
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 55b34461df1b..66cacea8e47f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -38,6 +38,7 @@ properties:
>                - mediatek,mt7623-wdt
>                - mediatek,mt7629-wdt
>                - mediatek,mt8173-wdt
> +              - mediatek,mt8365-wdt
>                - mediatek,mt8516-wdt
>            - const: mediatek,mt6589-wdt
>  
