Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0536ED07A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjDXOo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjDXOoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:44:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15C59D3;
        Mon, 24 Apr 2023 07:44:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso3866780b3a.3;
        Mon, 24 Apr 2023 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682347485; x=1684939485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNQqPFF9CeXoL2gMYUZkcPtpkCwmrwMvnxVAF4C3Yyc=;
        b=XQarSlGUxIEH7S8gothB7PrPKQbgy7iiAQzwqcKaWS/sZbORcJpn8+ytZ1oHmAGQO6
         ZyIGoEUtwFWrapSuYYZJyhftoHYM9TohyOiuIvra0cO5ZRX2xJIJqcxTXW8YrmbLQ2xh
         m5iQ5r6aijqi7kJ+D0b6YL2UDO1E/kHJBxltxhYiU2Le1xFl2u2YjaPj0vYgzg38Nq3g
         brINV4FkIYqpTxiAtOKzAyeE+3IiVnGljn/CAzSOzyNto69AWlAnCVkXt3qbEstEASDu
         /I3hQ8hR9VGCju798h2x0tm//DqFG9+48LwP3fScweeK+OOBlfElIrJ1Qph6BvcmaVYB
         QwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347485; x=1684939485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNQqPFF9CeXoL2gMYUZkcPtpkCwmrwMvnxVAF4C3Yyc=;
        b=BftnKHe0dl44PaiuuD+ULPPgET6qeqEHJNN29vK/lwhAznOqJ198SVkv9fmxcXtCBR
         ZLsCrRI8vUU+OXN9fxwGStGxi69Xn9FGUM5906dfzu7NHn8BB170m0gsqQPX61AfF/We
         gX0B30BTLS1rJYqruKveHzG95P5j7g1RYYYon6OBHU01wEiaj32BigJeAamq8nXkAX9X
         /OeRSXYAjeCDstPMXftlcZe86r9/AYgj+S2kvMwf8AydrnY53JFiEd3fzBBosJ+d4pzt
         UWHLEWK31WFmi1/QilLMC7rl+cdZeDYBY0vcDDqa8q39jvu+h9YPcoW0H36MLta1cs1M
         Xvyw==
X-Gm-Message-State: AAQBX9cq1APPCezJXAR6UVKHnLHESPNuPSM9cdlH0b5NmrPiDWLgLdvi
        B/au8dwKQ2a1w8N5e78MB+M=
X-Google-Smtp-Source: AKy350aoWSD2/HMa3CslUKM2LDOFFdivjwSWmyiTwfYYjcWJtX0Jw8aolbepRrEZj5LSWUBkhC4Rbg==
X-Received: by 2002:a05:6a20:4410:b0:f3:9f6:6ee8 with SMTP id ce16-20020a056a20441000b000f309f66ee8mr10007709pzb.43.1682347485194;
        Mon, 24 Apr 2023 07:44:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u14-20020a63470e000000b0051f15beba7fsm6409537pga.67.2023.04.24.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:44:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 24 Apr 2023 07:44:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Neha Malcom Francis <n-francis@ti.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, nm@ti.com, vigneshr@ti.com,
        u-kumar1@ti.com, kristo@kernel.org
Subject: Re: [PATCH RESEND v3 1/3] dt-bindings: hwmon: esm: Add ESM support
 for TI K3 devices
Message-ID: <0ddd5777-cfd0-4b35-a724-681ef9e86d2b@roeck-us.net>
References: <20230424105011.70674-1-n-francis@ti.com>
 <20230424105011.70674-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424105011.70674-2-n-francis@ti.com>
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

On Mon, Apr 24, 2023 at 04:20:09PM +0530, Neha Malcom Francis wrote:
> Document the binding for TI K3 ESM (Error Signaling Module) block.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

I think I am missing what this has to do with hardware
monitoring. I see a driver submission into drivers/misc,
but that doesn't explain the suggested location of the
devicetree bindings, and I kind of resist the idea that hwmon
should be the dumping ground for bindings which don't have
a home.

Guenter

> ---
>  .../bindings/hwmon/ti,j721e-esm.yaml          | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml b/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
> new file mode 100644
> index 000000000000..c5eb7f46cc46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ti,j721e-esm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 ESM
> +
> +maintainers:
> +  - Neha Malcom Francis <n-francis@ti.com>
> +
> +description:
> +  The ESM (Error Signaling Module) is an IP block on TI K3 devices
> +  that allows handling of safety events somewhat similar to what interrupt
> +  controller would do. The safety signals have their separate paths within
> +  the SoC, and they are handled by the ESM, which routes them to the proper
> +  destination, which can be system reset, interrupt controller, etc. In the
> +  simplest configuration the signals are just routed to reset the SoC.
> +
> +properties:
> +  compatible:
> +    const: ti,j721e-esm
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,esm-pins:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      integer array of ESM interrupt pins to route to external event pin
> +      which can be used to reset the SoC.
> +    minItems: 1
> +    maxItems: 255
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ti,esm-pins
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        esm@700000 {
> +            compatible = "ti,j721e-esm";
> +            reg = <0x0 0x700000 0x0 0x1000>;
> +            ti,esm-pins = <344>, <345>;
> +        };
> +    };
