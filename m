Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BCF681734
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjA3RFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3REp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:04:45 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0ACC1D;
        Mon, 30 Jan 2023 09:04:44 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso2838112otl.11;
        Mon, 30 Jan 2023 09:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ejf7vqAQxFeMcRz+b+ludPXWyayqJapmdG5pn46nsk=;
        b=ium8EhYJ+khpX7bVHU+zYLKdMrWOhKMVJLJlI66d7ZGK6qddheFiHhuetKi7KVdvSV
         3RPSEkhm5ubVTSA1m1qNK5uTWTH0WEhvx/h072ceqrF4VnfenbdRmQncCfG9CUaID128
         kJOjn97s/8R8HoFhyLFtg3xDwUrkbTEgsL434jryLinFRpO29L2B8tRVuQfOoPNWg/3T
         N20xUV2vTr4M5f+f8PFeZAaDg/mBhXlM8E1OqdcLiUfn2DW7K/FQgc8KrN5gYNAZN0Cb
         0LNqZ2j5Dp0IBnM1KzRAL01dHFF8bPtrVVn04UjKNQ6sS8F1tz3FDrbp2QxQ4xaHtaCK
         cemg==
X-Gm-Message-State: AO0yUKXHicHL1IaK2xkP2JIeEh/cwqKMkqwW9S7XH8EGC35lSikgbDBH
        v7w1NqwoDQAWvNj6RH32yg==
X-Google-Smtp-Source: AK7set8w8/Wu9DKjsKGEnq+lsfo72FtdhgNl/pG9CyvPUTTpOD8gzinQeTtCr6QRjCiwKv9eYztbDQ==
X-Received: by 2002:a9d:6847:0:b0:68b:bca5:8dfa with SMTP id c7-20020a9d6847000000b0068bbca58dfamr4730987oto.28.1675098283123;
        Mon, 30 Jan 2023 09:04:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id df17-20020a056830479100b006884c42a38asm4066933otb.41.2023.01.30.09.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:04:42 -0800 (PST)
Received: (nullmailer pid 2814224 invoked by uid 1000);
        Mon, 30 Jan 2023 17:04:41 -0000
Date:   Mon, 30 Jan 2023 11:04:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux RISC-V List <linux-riscv@lists.infradead.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek List <linux-mediatek@lists.infradead.org>,
        Linux C-SKY Arch List <linux-csky@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: panel: Introduce dual-link LVDS panel
Message-ID: <20230130170441.GA2796575-robh@kernel.org>
References: <20230124101238.4542-1-a-bhatia1@ti.com>
 <20230124101238.4542-4-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124101238.4542-4-a-bhatia1@ti.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:42:37PM +0530, Aradhya Bhatia wrote:
> Dual-link LVDS interfaces have 2 links, with even pixels traveling on
> one link, and odd pixels on the other. These panels are also generic in
> nature, with no documented constraints, much like their single-link
> counterparts, "panel-lvds".
> 
> Add a new compatible, "panel-dual-lvds", and a dt-binding document for
> these panels.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  .../display/panel/panel-dual-lvds.yaml        | 149 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
> new file mode 100644
> index 000000000000..e2ce1768e9a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-dual-lvds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic Dual-Link LVDS Display Panel
> +
> +maintainers:
> +  - Aradhya Bhatia <a-bhatia1@ti.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |
> +  A dual-LVDS interface is a dual-link connection with the even pixels
> +  traveling on one link, and the odd pixels traveling on the other.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: /schemas/display/lvds.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - lincolntech,lcd185-101ct
> +          - microtips,mf-101hiebcaf0
> +      - const: panel-dual-lvds

Why do we need a new compatible? You have ports and properties to see if 
the panel is dual link.

We already have dual link LVDS supported in advantech,idk-2121wr.yaml 
which says is compatible with 'panel-lvds', so that decision has already 
been made. The hint was you added the compatible match to the driver 
with 0 other changes needed.

That schema is missing type definitions and constraints for 
dual-lvds-odd-pixels/dual-lvds-even-pixels so there does need to be some 
changes to add those.

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: The sink for first set of LVDS pixels.
> +
> +        properties:
> +          dual-lvds-odd-pixels:
> +            type: boolean
> +
> +          dual-lvds-even-pixels:
> +            type: boolean
> +
> +        oneOf:
> +          - required: [dual-lvds-odd-pixels]
> +          - required: [dual-lvds-even-pixels]
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: The sink for second set of LVDS pixels.
> +
> +        properties:
> +          dual-lvds-even-pixels:
> +            type: boolean
> +
> +          dual-lvds-odd-pixels:
> +            type: boolean
> +
> +        oneOf:
> +          - required: [dual-lvds-even-pixels]
> +          - required: [dual-lvds-odd-pixels]
> +
> +    allOf:
> +      - if:
> +          properties:
> +            port@0:
> +              required:
> +                - dual-lvds-odd-pixels
> +        then:
> +          properties:
> +            port@1:
> +              properties:
> +                dual-lvds-odd-pixels: false
> +
> +      - if:
> +          properties:
> +            port@0:
> +              required:
> +                - dual-lvds-even-pixels
> +        then:
> +          properties:
> +            port@1:
> +              properties:
> +                dual-lvds-even-pixels: false
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +  port: false
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - width-mm
> +  - height-mm
> +  - data-mapping
> +  - panel-timing
> +  - ports
> +
> +examples:
> +  - |
> +    panel {
> +      compatible = "microtips,mf-101hiebcaf0", "panel-dual-lvds";
> +
> +      width-mm = <217>;
> +      height-mm = <136>;
> +
> +      data-mapping = "vesa-24";
> +
> +      panel-timing {
> +        clock-frequency = <150275000>;
> +        hactive = <1920>;
> +        vactive = <1200>;
> +        hfront-porch = <32>;
> +        hsync-len = <52>;
> +        hback-porch = <24>;
> +        vfront-porch = <24>;
> +        vsync-len = <8>;
> +        vback-porch = <3>;
> +        de-active = <1>;
> +      };
> +
> +      ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +          dual-lvds-odd-pixels;
> +          lcd_in0: endpoint {
> +            remote-endpoint = <&oldi_out0>;
> +          };
> +        };
> +
> +        port@1 {
> +          reg = <1>;
> +          dual-lvds-even-pixels;
> +          lcd_in1: endpoint {
> +            remote-endpoint = <&oldi_out1>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e18388b4579..6025bb024586 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6461,6 +6461,7 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  S:	Maintained
>  F:	drivers/gpu/drm/panel/panel-lvds.c
>  F:	Documentation/devicetree/bindings/display/lvds.yaml
> +F:	Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
>  F:	Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
>  
>  DRM DRIVER FOR MANTIX MLAF057WE51 PANELS
> -- 
> 2.39.0
> 
