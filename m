Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD872195D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjFDS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjFDS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 14:58:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6DFCE;
        Sun,  4 Jun 2023 11:58:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so4894859e87.0;
        Sun, 04 Jun 2023 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685905131; x=1688497131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0uLDA7fQ1eFEBxyVgNGzB8pTMv55u419IbeoR7nu4AQ=;
        b=MuCQKaUvVjjMXgniF8sNia9BsE7FRRYHz4Pk2pNq+aYgc4wvJ8CTRJGdo+nbfVftES
         0hxG70Lob7NRmTRU/wZ7rFKxlOHaf+bLZfEXsEHXlPGGnwIjbHOxuqPlb+PCb1k9uFZB
         L067AQi559bjdLcW3ShTD9ijZydSFUoyLMjtjHd+0mubagCLzd4hAEVcMoWANSfs0b/0
         +W0q6iQxWYUZkysfY/GD86Xy8xsPmbE8VxSSF5ZMDRLJazBN7VWS/j7DZ7q1eciJgMeD
         e38B0pNnrSxkLEjE7kMJYpSX1Eadx7Fb8cWNM3+6zrihsL6oC318QsCO7fOK365jKiHb
         9UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685905131; x=1688497131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uLDA7fQ1eFEBxyVgNGzB8pTMv55u419IbeoR7nu4AQ=;
        b=HmfM9ZcK3+bsjV0bktpahVnl5YOX4FfwSvA7pGXbdHnRWU2RY7XQtglTmWwJgOjM+e
         mQnVOqIZeeqwn4SP+9JqmJmv3v/CgLHBEqsIGseQShBHz0v5p3ikbEmuzTZn0PRNlv4H
         2HfETI3ueVcUBZ4JAoa6uH99gYaNe5b7kZKvP5yZVtav8x8dm87hOjMOMbJ2h5MXGqtB
         PTxCzL+AgmV/0w/x02bk1xtfXC+Sdi7AQweqDBbzeXk2nrLNRYJte7rAXx9RGxzBfx/C
         4MabZraEAkbmH4VrONGHX7UCUGPKjur/NViqZoOr0bTKqWnLp+vuJqj5nJaKKkSJasi2
         85Iw==
X-Gm-Message-State: AC+VfDwHHgl5MIGH2fytV8xkhQ+o5dg1EtY5gRKPk+g/Gb3o0XY/PlMM
        zP+L9ID5/r9A2nFuQD3/n0o=
X-Google-Smtp-Source: ACHHUZ5EkaqP6x5GqtWx1BZ2gJzmxHf/jE8v3IHyZU6SL7aUosESZU4nC8UiF+0Xk6nOGWSAa+UFKA==
X-Received: by 2002:ac2:5eca:0:b0:4f3:a0f5:92e5 with SMTP id d10-20020ac25eca000000b004f3a0f592e5mr3904178lfq.31.1685905130670;
        Sun, 04 Jun 2023 11:58:50 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512040900b004eb0dcc52ddsm858329lfk.41.2023.06.04.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 11:58:49 -0700 (PDT)
Date:   Sun, 4 Jun 2023 21:58:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/6] dt-bindings: ata: ahci: add RK3588 AHCI controller
Message-ID: <20230604185847.r23v53eetd53okyg@mobilestation>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
 <20230522173423.64691-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522173423.64691-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 07:34:19PM +0200, Sebastian Reichel wrote:
> Just like RK3568, the RK3588 has a DWC based AHCI controller.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml     | 8 ++++++--
>  Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml  | 6 ++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> index c1457910520b..34c5bf65b02d 100644

> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> @@ -31,11 +31,11 @@ properties:
>        PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
>        clock, etc.
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 6
>      items:
>        oneOf:
>          - description: Application APB/AHB/AXI BIU clock
> @@ -48,6 +48,10 @@ properties:
>            const: pmalive
>          - description: RxOOB detection clock
>            const: rxoob
> +        - description: PHY Transmit Clock
> +          const: asic
> +        - description: PHY Receive Clock
> +          const: rbc
>          - description: SATA Ports reference clock
>            const: ref

This part looks good but as I mentioned in my comment to the previous
patchset revision these are generic clocks. Extending the common
schema could be done in a framework of a preparation patch with
the justification described in my comment back then.

>  
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> index 5afa4b57ce20..c6a0d6c8b62c 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> @@ -23,9 +23,11 @@ properties:
>          const: snps,dwc-ahci
>        - description: SPEAr1340 AHCI SATA device
>          const: snps,spear-ahci

> -      - description: Rockhip RK3568 AHCI controller
> +      - description: Rockhip AHCI controller
>          items:
> -          - const: rockchip,rk3568-dwc-ahci
> +          - enum:
> +              - rockchip,rk3568-dwc-ahci
> +              - rockchip,rk3588-dwc-ahci

Regarding this part. I would suggest to just create a separate
DT-schema instead of extending the generic one. See my comment to the
next patch in the series and my suggestion posted in a comment to
the previous patchset revision.

-Serge(y)

>            - const: snps,dwc-ahci
>  
>  patternProperties:
> -- 
> 2.39.2
> 
