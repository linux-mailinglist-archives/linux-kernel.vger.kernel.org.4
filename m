Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6148A72196F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjFDTL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDTL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 15:11:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D870A4;
        Sun,  4 Jun 2023 12:11:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso645330e87.2;
        Sun, 04 Jun 2023 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685905914; x=1688497914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azAP3x1baPIF9TbZBZ/iwj9CaGYl4y3es7jb/ELOFIA=;
        b=pfxsmkbyB8/+7tGHKrqVx1tdPTcUyi0+pa7WFkwh1EiHwkuyD2wc7eD5CiOqwsGm4b
         TurgxvO4X0a6HuMdjVXV8ox/CEwfRpx98kXBdD9RgrY8reW9kFLDSdAvyv8ibz4g7JYf
         CVO2D9TnG02RfiUeAtsxYriCX/wXUFYA0Z1fm6aXJKAhnBKH0V8Y+9QRbq4vU9+/STBv
         C6GPK8TdLQDQPU2s3Mo2GeHFzYoCfneUDF4j80vgrCsMKTw3/4XOxN7tiEfAahuch+Fe
         upST+TcXK4FuIsCh2ECSIKLsiPa2UgvL8acXEmMCaYSZCuOsUpVOR7l7rB430YhAzUS+
         aUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685905914; x=1688497914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azAP3x1baPIF9TbZBZ/iwj9CaGYl4y3es7jb/ELOFIA=;
        b=eswQ/AU41+MYbM5s6Y7/NbBncQN1OmqvJsZENgQv1MIHDS3DdnOLp9G2ZkbsLS6Ih1
         jzAjF0BEjEck1u74wFUiJYLvJKm5Pgou1vyHrCblUmZ7lBrZlEiRYp9rXjk8dAzPeRf1
         6AO51dgoNnAV6FkuZk/E+1BAhrbmFHvdqOCuAH7YeaVItcZLV/DeNAFNekgmpuWvy9Q6
         oXAE5AdgCH/MhB7cbVFN/6mqvwomscd7eSvegNLEVyAiNtR0pS4X8BCfe2nMZczWuf7i
         lxTagYf5a9ZpBWvhNiZennc13qwkB4vuW0VQ+WdFVbGVmakBuWc3bCNnAP5o2C1q9CCv
         rAbA==
X-Gm-Message-State: AC+VfDziVJWq/Y5gwk8p9LkZAFEOojJMtgu+I8VaJImvsb53PYlvMffM
        XEGrT1uDVHsQFArLoRIJeAg=
X-Google-Smtp-Source: ACHHUZ4QX84YGTAap42xf8IcVLART9ckvKesrVoX2+oE65kP2pidl7JNsvozPo1y0LQJ9I7eRhD7QQ==
X-Received: by 2002:ac2:46f4:0:b0:4ee:e0c7:434d with SMTP id q20-20020ac246f4000000b004eee0c7434dmr4561954lfo.51.1685905913218;
        Sun, 04 Jun 2023 12:11:53 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id u8-20020ac25188000000b004f377f317d4sm858351lfi.285.2023.06.04.12.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 12:11:52 -0700 (PDT)
Date:   Sun, 4 Jun 2023 22:11:50 +0300
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
Subject: Re: [PATCH v2 3/6] dt-bindings: ata: ahci: dwc: enforce rockchip
 clocks
Message-ID: <20230604191150.aqx4jewtifsknijt@mobilestation>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
 <20230522173423.64691-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522173423.64691-4-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 07:34:20PM +0200, Sebastian Reichel wrote:
> Provide a specific list of clocks allowed for RK3568 and RK3588
> based DWC AHCI controllers.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/ata/snps,dwc-ahci.yaml           | 34 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> index c6a0d6c8b62c..37830185b9b5 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> @@ -13,9 +13,6 @@ description:
>    This document defines device tree bindings for the generic Synopsys DWC
>    implementation of the AHCI SATA controller.
>  
> -allOf:
> -  - $ref: snps,dwc-ahci-common.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -41,6 +38,37 @@ required:
>    - reg
>    - interrupts
>  
> +allOf:
> +  - $ref: snps,dwc-ahci-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3588-dwc-ahci
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: sata
> +            - const: pmalive
> +            - const: rxoob
> +            - const: ref
> +            - const: asic
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,rk3568-dwc-ahci
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: sata
> +            - const: pmalive
> +            - const: rxoob
> +

As I already suggested here
https://lore.kernel.org/all/20230421192822.yckihqlk2vlkueyc@mobilestation/
let's create a separate DT-schema for the Rockchip AHCI SATA
controllers. Please see the way it's done for Baikal-T1 AHCI SATA
here: Documentation/devicetree/bindings/ata/baikal,bt1-ahci.yaml
Your generic schema patch doesn't provide a full hardware constraints
(what about resets, number of ports, etc?), but makes the generic
DW AHCI SATA controller DT-schema harder to read.

* Don't forget to add the "select: ..." property to prevent your
DT-schema from being applied to all the "snps,dwc-ahci"-compatible
DT-nodes (see my comment to the previous patchset revision).
Alternatively you can just drop the generic DW AHCI compatible string
from the DT-files (but in this case you would need to add vendor-specific
compatible string to the driver).

-Serge(y)

>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.39.2
> 
