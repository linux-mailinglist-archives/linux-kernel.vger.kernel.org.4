Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4124E62FFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKRWHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiKRWHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:07:45 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAAAA7C2A;
        Fri, 18 Nov 2022 14:07:45 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso3896416otl.13;
        Fri, 18 Nov 2022 14:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgcPyzOf6Q15rxxM6fTsspp0P6UUf5LqBU3xDxpeGO0=;
        b=e6umILm9EFnYjS3rxK0bYDa6NoWKCEOk3ARc2VDU2V1mXMNxmMxLuApUYRlL5Y2CxT
         Byx85PFQ8acEpLADgVl90kZh7zxKGUTcc9sbWuqhz42I8k1YMiOuU/G9/IjkL1OInd/k
         Crx4J/xSMAjW0SxUR8/rGG/EjDgWWrIEApsAb31E10RymedSrC9ZgnGnebQf1+jR4Wzf
         Yn8xOFZMs0kDNdPKEDjHid6wTe2e167HU9KYD4feACuz7RYuHIlnVKR0Ih3V0VMe0jG0
         fYxw++MvSVgQdeGU9SkTRaPZt7BiitFUqCLE+LdOQgYPYvf/FMj0oitSGrOWKXIwpHyX
         K2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgcPyzOf6Q15rxxM6fTsspp0P6UUf5LqBU3xDxpeGO0=;
        b=PNUFU+R/OiBIn2chUim21IiCR+OhWapimz3DS7yv+ZsOy3ozmUvUmDLaYAKmE7HwjJ
         ZDGPnLRGtbLyxT6xudvc3V1ctpi09UVyZgPAvlgYNtophlJtAcaL86P4VSRzQFkDtBIe
         xNqryGKJrJlV5jg/BMyCsULTQocXi41lxxhwtO4EaoQmAUN8FNU5B+nG1w6uHU2hwzSV
         LOH/vOt6a0yYtQQTILZYLD5O2uszw+U/3XBNQ6c6P6izfnLUeCAoMIvT4fxaw9XoXx2V
         +MsokHkbAnNxZ7FtTyrbq440KylgUAJkCySGF1ZLoZQHV7uzvVlPtrIsvvHWfPnr1Fe+
         1BwA==
X-Gm-Message-State: ANoB5pn5pxj/hghKb9Jj0qT7C+8C0kWJQQEO3NhzurZxWNhcSCpwMF64
        /TZihkgIBtGAmwRuwlc5uCo=
X-Google-Smtp-Source: AA0mqf6B2ThA3WTewjIwAtEwYhsfuCflD8wp2jc4sesZ4vw8LYj8YHCgTydiNbyy8LPDcvzEzXzIDw==
X-Received: by 2002:a9d:2288:0:b0:66d:dff:1d9f with SMTP id y8-20020a9d2288000000b0066d0dff1d9fmr4797132ota.376.1668809264547;
        Fri, 18 Nov 2022 14:07:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a9-20020a05687073c900b00142169cb977sm2700151oan.7.2022.11.18.14.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:07:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 18 Nov 2022 14:07:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: watchdog: renesas,wdt: Document RZ/Five SoC
Message-ID: <20221118220743.GB685644@roeck-us.net>
References: <20221118133829.12855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118133829.12855-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:38:29PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The WDT block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-wdt" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
> 
> No driver changes are required as generic compatible string
> "renesas,rzg2l-wdt" will be used as a fallback on RZ/Five SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> index 26b1815a6753..e2c9bf1aec38 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -26,7 +26,7 @@ properties:
>  
>        - items:
>            - enum:
> -              - renesas,r9a07g043-wdt    # RZ/G2UL
> +              - renesas,r9a07g043-wdt    # RZ/G2UL and RZ/Five
>                - renesas,r9a07g044-wdt    # RZ/G2{L,LC}
>                - renesas,r9a07g054-wdt    # RZ/V2L
>            - const: renesas,rzg2l-wdt
> -- 
> 2.25.1
> 
