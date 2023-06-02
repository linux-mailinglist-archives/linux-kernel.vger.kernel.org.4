Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6872063A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjFBPct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbjFBPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:32:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD731A1;
        Fri,  2 Jun 2023 08:32:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A9DA4844;
        Fri,  2 Jun 2023 17:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685719938;
        bh=b6xIS3yXBxdBAt5l9gWHCBtkRm3wBltYbjdJdCvJoAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrqInv9aHpOLa6HZaEStvMNY0Bvf5zOAioIs9qpfXXlbQl612ntctz59xrbfGttr7
         l5exEUEnauuKnVJETohri+FKWzeC8V0Yv7YUuDuwCo4q6IXsH49NwlFSmVdBmgNovT
         c6VTX9PpU9wkVIDhR6fNO1MryotpRtpH/5JcnpbQ=
Date:   Fri, 2 Jun 2023 18:32:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: move LVDS data-mapping
 definition to separate file
Message-ID: <20230602153239.GK26944@pendragon.ideasonboard.com>
References: <20230523-simplepanel_support_nondefault_datamapping-v2-0-87196f0d0b64@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v2-1-87196f0d0b64@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523-simplepanel_support_nondefault_datamapping-v2-1-87196f0d0b64@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johannes,

Thank you for the patch.

On Tue, May 23, 2023 at 10:19:41AM +0200, Johannes Zink wrote:
> As the LVDS data-mapping property is required in multiple bindings: move
> it to separate file and include instead of duplicating it.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> 
> ---
> 
> Changes:
> 
> v1 -> v2: worked in Rob's review findings (thank you for reviewing my
>           work): extract common properties to
>           file and include it instead of duplicating it
> ---
>  .../bindings/display/lvds-data-mapping.yaml        | 84 ++++++++++++++++++++++
>  .../devicetree/bindings/display/lvds.yaml          | 75 +++----------------
>  2 files changed, 92 insertions(+), 67 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/lvds-data-mapping.yaml b/Documentation/devicetree/bindings/display/lvds-data-mapping.yaml
> new file mode 100644
> index 000000000000..17ef5c9a5a90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/lvds-data-mapping.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/lvds-data-mapping.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LVDS Data Mapping
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |+
> +  LVDS is a physical layer specification defined in ANSI/TIA/EIA-644-A. Multiple
> +  incompatible data link layers have been used over time to transmit image data
> +  to LVDS devices. This bindings supports devices compatible with the following
> +  specifications.
> +
> +  [JEIDA] "Digital Interface Standards for Monitor", JEIDA-59-1999, February
> +  1999 (Version 1.0), Japan Electronic Industry Development Association (JEIDA)
> +  [LDI] "Open LVDS Display Interface", May 1999 (Version 0.95), National
> +  Semiconductor
> +  [VESA] "VESA Notebook Panel Standard", October 2007 (Version 1.0), Video
> +  Electronics Standards Association (VESA)
> +
> +  Device compatible with those specifications have been marketed under the
> +  FPD-Link and FlatLink brands.
> +
> +properties:
> +  data-mapping:
> +    enum:
> +      - jeida-18
> +      - jeida-24
> +      - vesa-24
> +    description: |
> +      The color signals mapping order.
> +
> +      LVDS data mappings are defined as follows.
> +
> +      - "jeida-18" - 18-bit data mapping compatible with the [JEIDA], [LDI] and
> +        [VESA] specifications. Data are transferred as follows on 3 LVDS lanes.
> +
> +      Slot          0       1       2       3       4       5       6
> +                ________________                         _________________
> +      Clock                     \_______________________/
> +                  ______  ______  ______  ______  ______  ______  ______
> +      DATA0     ><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
> +      DATA1     ><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
> +      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
> +
> +      - "jeida-24" - 24-bit data mapping compatible with the [DSIM] and [LDI]
> +        specifications. Data are transferred as follows on 4 LVDS lanes.
> +
> +      Slot          0       1       2       3       4       5       6
> +                ________________                         _________________
> +      Clock                     \_______________________/
> +                  ______  ______  ______  ______  ______  ______  ______
> +      DATA0     ><__G2__><__R7__><__R6__><__R5__><__R4__><__R3__><__R2__><
> +      DATA1     ><__B3__><__B2__><__G7__><__G6__><__G5__><__G4__><__G3__><
> +      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B7__><__B6__><__B5__><__B4__><
> +      DATA3     ><_CTL3_><__B1__><__B0__><__G1__><__G0__><__R1__><__R0__><
> +
> +      - "vesa-24" - 24-bit data mapping compatible with the [VESA] specification.
> +        Data are transferred as follows on 4 LVDS lanes.
> +
> +      Slot          0       1       2       3       4       5       6
> +                ________________                         _________________
> +      Clock                     \_______________________/
> +                  ______  ______  ______  ______  ______  ______  ______
> +      DATA0     ><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
> +      DATA1     ><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
> +      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
> +      DATA3     ><_CTL3_><__B7__><__B6__><__G7__><__G6__><__R7__><__R6__><
> +
> +      Control signals are mapped as follows.
> +
> +      CTL0: HSync
> +      CTL1: VSync
> +      CTL2: Data Enable
> +      CTL3: 0
> +
> +additionalProperties: true
> +
> +...
> diff --git a/Documentation/devicetree/bindings/display/lvds.yaml b/Documentation/devicetree/bindings/display/lvds.yaml
> index 7cd2ce7e9c33..2200f986c3cf 100644
> --- a/Documentation/devicetree/bindings/display/lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/lvds.yaml
> @@ -6,83 +6,24 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: LVDS Display Common Properties
>  
> +allOf:
> +  - $ref: lvds-data-mapping.yaml#
> +
>  maintainers:
>    - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>    - Thierry Reding <thierry.reding@gmail.com>
>  
>  description: |+

You can drop the |+ here.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> -  LVDS is a physical layer specification defined in ANSI/TIA/EIA-644-A. Multiple
> -  incompatible data link layers have been used over time to transmit image data
> -  to LVDS devices. This bindings supports devices compatible with the following
> -  specifications.
> -
> -  [JEIDA] "Digital Interface Standards for Monitor", JEIDA-59-1999, February
> -  1999 (Version 1.0), Japan Electronic Industry Development Association (JEIDA)
> -  [LDI] "Open LVDS Display Interface", May 1999 (Version 0.95), National
> -  Semiconductor
> -  [VESA] "VESA Notebook Panel Standard", October 2007 (Version 1.0), Video
> -  Electronics Standards Association (VESA)
> -
> -  Device compatible with those specifications have been marketed under the
> -  FPD-Link and FlatLink brands.
> +  This binding extends the data mapping defined in lvds-data-mapping.yaml.
> +  It supports reversing the bit order on the formats defined there in order
> +  to accomodate for even more specialized data formats, since a variety of
> +  data formats and layouts is used to drive LVDS displays.
>  
>  properties:
> -  data-mapping:
> -    enum:
> -      - jeida-18
> -      - jeida-24
> -      - vesa-24
> -    description: |
> -      The color signals mapping order.
> -
> -      LVDS data mappings are defined as follows.
> -
> -      - "jeida-18" - 18-bit data mapping compatible with the [JEIDA], [LDI] and
> -        [VESA] specifications. Data are transferred as follows on 3 LVDS lanes.
> -
> -      Slot          0       1       2       3       4       5       6
> -                ________________                         _________________
> -      Clock                     \_______________________/
> -                  ______  ______  ______  ______  ______  ______  ______
> -      DATA0     ><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
> -      DATA1     ><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
> -      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
> -
> -      - "jeida-24" - 24-bit data mapping compatible with the [DSIM] and [LDI]
> -        specifications. Data are transferred as follows on 4 LVDS lanes.
> -
> -      Slot          0       1       2       3       4       5       6
> -                ________________                         _________________
> -      Clock                     \_______________________/
> -                  ______  ______  ______  ______  ______  ______  ______
> -      DATA0     ><__G2__><__R7__><__R6__><__R5__><__R4__><__R3__><__R2__><
> -      DATA1     ><__B3__><__B2__><__G7__><__G6__><__G5__><__G4__><__G3__><
> -      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B7__><__B6__><__B5__><__B4__><
> -      DATA3     ><_CTL3_><__B1__><__B0__><__G1__><__G0__><__R1__><__R0__><
> -
> -      - "vesa-24" - 24-bit data mapping compatible with the [VESA] specification.
> -        Data are transferred as follows on 4 LVDS lanes.
> -
> -      Slot          0       1       2       3       4       5       6
> -                ________________                         _________________
> -      Clock                     \_______________________/
> -                  ______  ______  ______  ______  ______  ______  ______
> -      DATA0     ><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
> -      DATA1     ><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
> -      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
> -      DATA3     ><_CTL3_><__B7__><__B6__><__G7__><__G6__><__R7__><__R6__><
> -
> -      Control signals are mapped as follows.
> -
> -      CTL0: HSync
> -      CTL1: VSync
> -      CTL2: Data Enable
> -      CTL3: 0
> -
>    data-mirror:
>      type: boolean
>      description:
> -      If set, reverse the bit order described in the data mappings below on all
> +      If set, reverse the bit order described in the data mappings on all
>        data lanes, transmitting bits for slots 6 to 0 instead of 0 to 6.
>  
>  additionalProperties: true
> 

-- 
Regards,

Laurent Pinchart
