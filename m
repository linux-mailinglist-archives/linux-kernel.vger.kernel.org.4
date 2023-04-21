Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D306EB242
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjDUT2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDUT23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:28:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C7E55;
        Fri, 21 Apr 2023 12:28:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4eed764a10cso2133299e87.0;
        Fri, 21 Apr 2023 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682105306; x=1684697306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3fs5vArEoThWvHEwgVac02PfGMwSsmxq51Eot541Pk=;
        b=USV86Vg8oEbhQWhj3kgaVwT1WLmRzqGOuVVZ+sEIOlvEUigNJk8ma1IL5/BkcYQiwM
         gOgDdrhzZOTBsTf5GMC2xUDXnOtAUXpV01hpy27MD6MAy4xu/jbH0mPJuAHE0VNXxGkQ
         TUn7p0uiw1K3ChWOCch0ESazwc1gCpMEtw++/xWCytsWmjjyV3dImKnaaPWH1brZSb16
         qQRJENEnzjhJiYc0IlHZDS3E37MNQu0JifMVAXs6AvI3Y6H4F8QAB8WLPk3Wj+Vf9Rp6
         KJVTT63SpaDSupX2Zf2SyL1E3Jvj2pdxfTGEZk4UZVHQQdCtMffrN0IpyNoe4gPPohPH
         MLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682105306; x=1684697306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3fs5vArEoThWvHEwgVac02PfGMwSsmxq51Eot541Pk=;
        b=RsIizsZukd7W/ei+htz/cYuVAhEkm1dMh0VtbpHNTn4iscbB6bBZsZlHdusiDjKTi2
         lC+cZjyRlP0/0/j4a6IhkMflITQqtmhcQB4qhIlGGFAzkt9YJXVwiMiPGIrFx+4uP+C+
         XcfDR14/R9KS0oCAl7MRDkb3SyxgKPw89MdDANCeT4tL68MyiuMXmDmhiL/mtwDIrh6t
         22yQ7r7c49QnT0IN4Wbc/HupTPVHgPh/KeIU/uiK3Hvpo+s/ZBDTwi9LT/Ihhuxkq4HH
         ZAkQeN/iRpEXUAjM+rb5LpAVQQbV+PdQ4COZShiHkhF4mJ1p6otpQzqCLvQ8G3ALoJQv
         h6ow==
X-Gm-Message-State: AAQBX9f/JVr2m0TQuLwL3YDwHi22nvaRxPVHcBHOrZU7SE/K3ohO9ica
        tlOsmSWb0TLWgPPAooL5f1hsEa8jc9JgSA==
X-Google-Smtp-Source: AKy350b4nzhvyStKwG8CwDoH+ikPDWhGFNxeEaFNvuDpetkuK+c66QM2naloCN6WduMmD3HR23CP0g==
X-Received: by 2002:ac2:5475:0:b0:4ec:81c7:119a with SMTP id e21-20020ac25475000000b004ec81c7119amr1664912lfn.3.1682105305633;
        Fri, 21 Apr 2023 12:28:25 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25190000000b004cf6c56fdb5sm638885lfi.232.2023.04.21.12.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:28:24 -0700 (PDT)
Date:   Fri, 21 Apr 2023 22:28:22 +0300
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
Subject: Re: [PATCHv1 2/5] dt-bindings: ata: ahci: add RK3588 AHCI controller
Message-ID: <20230421192822.yckihqlk2vlkueyc@mobilestation>
References: <20230413182345.92557-1-sebastian.reichel@collabora.com>
 <20230413182345.92557-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413182345.92557-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian

On Thu, Apr 13, 2023 at 08:23:42PM +0200, Sebastian Reichel wrote:
> Just like RK3568, the RK3588 has a DWC based AHCI controller.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> FWIW IDK what exactly the ASIC clock is. The TRM does not provide any
> details unfortunately. It is required for functional SATA, though.
> ---
>  .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml       | 6 ++++--
>  Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml    | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> index c1457910520b..0df8f49431eb 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> @@ -31,11 +31,11 @@ properties:
>        PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
>        clock, etc.
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 5
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 5
>      items:
>        oneOf:
>          - description: Application APB/AHB/AXI BIU clock
> @@ -50,6 +50,8 @@ properties:
>            const: rxoob
>          - description: SATA Ports reference clock
>            const: ref

> +        - description: Rockchip ASIC clock
> +          const: asic

Actually it's a standard DW SATA AHCI PHY-interface clock (named as
clk_asicN in the DW SATA AHCI HW manual). So feel free to add it to the
clock-names array with the description (taken from the manual): "PHY
Transmit Clock". The manual also says that the clock is generated by
the PHY0 for clocking Port0 Link and Transport Layers (TX clock
domain): 37.5 MHz, 75 MHz, 150 MHz, 300 MHz, or 600 MHz.

Similarly there is another clocks source "clk_rbcN". It's "PHY Receive
Clock" which is used to receive data from the PHYn. It can be also
added to the clock-names property under the name "rbc".

Note 1. Please add the suggested names to the property constraint
above the "ref" name definition. The later clock is mainly relevant to
the attached PHY rather than to the SATA AHCI controller itself.

Note 2. "rxoob", "asic" and "rbc" clocks are defined as "clk_rxoobN",
"clk_asicN" and "clk_rbcN" which means they are supposed to be defined
(if relevant) for each available SATA port. So in general they should
have been defined in the port sub-nodes clocks/clock-names properties.

Note 3. Note natively DW SATA AHCI doesn't have any PIPE interface (or
anything being called as PIPE). Instead it provides a PMA-interface
which is directly connected to a Synopsys SATA xG PHY with no
intermediate coders (PCS). Like this:

+---------+     +--------+
|         | PMA | Snps DW| SATA
| DW SATA |<--->| SATA xG|<---->
|  AHCI   | I/F |  PHY   |
|         |     |        |
+---------+     +--------+

In that case the DW SATA AHCI IP-core is supposed to be synthesized
with the particular Synopsys PHY type specified in the parameter
PHY_INTERFACE_TYPE. If a non-standard PHY is connected (like in your
case) PHY_INTERFACE_TYPE is supposed to be set to zero thus providing
a wide set of the PMA-interface configs which otherwise would have
been pre-defined with the Synopsys PHY-specific values. So judging by
the clock names in your patches and the way the DT-nodes are designed
Rockchip SATA AHCI controller diagram must be looking like this:

+---------+      +-------+       +--------+
|         | PIPE | some  | Rx/Tx | PMA/PMD| SATA
| DW SATA |<---->|  PCS  |<----->| NANEng |<---->
|  AHCI   |former|       |       |  PHY   |
|         |DW PMA|       |       |        |
+---------+      +-------+       +--------+

In the former case (DW SATA AHCI with Synopsys SATA xG PHY attached)
all the clocks "pmalive", "rbc", "asic" and "rxoob" are generated by
the Synopsys PHYs itself so there is no need in having them explicitly
defined in the system. In your case AFAICS a non-standard PCS+PHY
setup is utilized and the clocks are generated by a system-wide unit -
CRU.

>  
>    resets:
>      description:
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
>            - const: snps,dwc-ahci

What about moving all that in a dedicated YAML-file in order to define a
more comprehensive schema with actual "clocks", "clock-names",
ports-specific properties constraints? (see the way it's done for
Baikal-T1 SATA AHCI in ata/baikal,bt1-ahci.yaml).

Please note in that case you'll either need to drop the generic
fallback compatible (it's not like it would have been much useful
anyway) from your and RK3568 SATA DT-nodes, or define the
"select: properties: compatible: ..." property in the generic
DW SATA AHCI DT-schema, in order to prevent the generic schema being
automatically applied to the your SATA DT-nodes.

-Serge(y)

>  
>  patternProperties:
> -- 
> 2.39.2
> 
