Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42E6E3A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjDPP4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:55:59 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C485F30CF;
        Sun, 16 Apr 2023 08:55:58 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-32ac0743030so8554475ab.0;
        Sun, 16 Apr 2023 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681660558; x=1684252558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hacll8+yaet7lqpDVagmKNxxYLLu5u39JL1nBadScbw=;
        b=qJwLZCG2kjlFkuOacT62j2DLSGMVkMSvkWKuMjx/ukIb9huzFbZ7FtLBaNyJQ+n9oa
         jgkDWa10wZ2Qbg/CTi/abpQ1PNf6tErIB1b1w5u8zfrhm5eHVVF2mzPAKQUCdBETs5vg
         K0RfQoKeLk0+Csepq6e+0HGRzjoCdx/SSEYJZFWCSccVfy8+M8zXlDQaw7w7mmor90V3
         YRpnNvEbHKHJwDYLcfm6bA2zj71r7NNYJ/H5YY+Dtvk4YqdITI0I2ZkQkc4ZU7kf3kcw
         KxkWz18GDmaMMLGAn+5O82KJ7IhipQx6X58EPQML+zD41s7fJm4fvzGoE5BpSZ7CdJfI
         MSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681660558; x=1684252558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hacll8+yaet7lqpDVagmKNxxYLLu5u39JL1nBadScbw=;
        b=bP6yLOZGjC5R4I3wbzXFvygkZo6XOJbePRSPTVHcbo6ct/NpdGBa3bZ3V2pXV/bUqR
         P080z7/Zk1pMhwsRfsvcu8HS+TUEf87ZfezGU2VA4k+eMen3+Ztj25QdfgdMZTSocAS3
         9jMC+WLy+vWk9EMmSjJhHthkd1NJ1CG4cu+K3+TTik8yVIBGev3ru8BfEMo98x3x4t3x
         9cuXkTSk9CTkKcDf0B4m25t+qAKxeocvAmSXZD66yEoR9PqZN9goC6bfWwN6XCxwmCGu
         xPxD5aRuWzJ3lsspobrkbbafUmYodg0RfCGFVOlao/FOW6ijtOHcjaPWCdTvh8lYR8K1
         qNAQ==
X-Gm-Message-State: AAQBX9f9wgQ4GdMdnEPak47rCThVVNC1/kPSkYlaGCP4KHjtAM/vFOWc
        j/BU+MjmVbTMKSjF0WdAonI=
X-Google-Smtp-Source: AKy350bcBAXoqSlGftfK2IcoMq6UqJp6qXR3y53cZ8bxc4ZyTZGOTYw4lFyE5OiUj/bZ3y6GdgxQCQ==
X-Received: by 2002:a92:c088:0:b0:329:4a17:4b17 with SMTP id h8-20020a92c088000000b003294a174b17mr9506677ile.21.1681660558139;
        Sun, 16 Apr 2023 08:55:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d134-20020a02628c000000b00408b3bc8061sm2711163jac.43.2023.04.16.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 08:55:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 08:55:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add binding for MediaTek MT6735
 TOPRGU/WDT
Message-ID: <ecfbaf67-de10-4c2a-ac80-6668ba465d64@roeck-us.net>
References: <20230302124015.75546-1-y.oudjana@protonmail.com>
 <20230302124015.75546-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302124015.75546-2-y.oudjana@protonmail.com>
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

On Thu, Mar 02, 2023 at 03:40:14PM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a DT binding for the MT6735 top reset generation unit/watchdog timer.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../bindings/watchdog/mediatek,mtk-wdt.yaml     |  1 +
>  include/dt-bindings/reset/mediatek,mt6735-wdt.h | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6735-wdt.h
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 55b34461df1b..009ccdb60b84 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -22,6 +22,7 @@ properties:
>        - enum:
>            - mediatek,mt2712-wdt
>            - mediatek,mt6589-wdt
> +          - mediatek,mt6735-wdt
>            - mediatek,mt6795-wdt
>            - mediatek,mt7986-wdt
>            - mediatek,mt8183-wdt
> diff --git a/include/dt-bindings/reset/mediatek,mt6735-wdt.h b/include/dt-bindings/reset/mediatek,mt6735-wdt.h
> new file mode 100644
> index 000000000000..c6056e676d46
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6735-wdt.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT6735_WDT_H_
> +#define _DT_BINDINGS_RESET_MEDIATEK_MT6735_WDT_H_
> +
> +#define MT6735_TOPRGU_MM_RST		1
> +#define MT6735_TOPRGU_MFG_RST		2
> +#define MT6735_TOPRGU_VENC_RST		3
> +#define MT6735_TOPRGU_VDEC_RST		4
> +#define MT6735_TOPRGU_IMG_RST		5
> +#define MT6735_TOPRGU_MD_RST		7
> +#define MT6735_TOPRGU_CONN_RST		9
> +#define MT6735_TOPRGU_C2K_SW_RST	14
> +#define MT6735_TOPRGU_C2K_RST		15
> +#define MT6735_TOPRGU_RST_NUM		9
> +
> +#endif
