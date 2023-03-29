Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D16CF0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjC2RVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjC2RVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:21:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487C6585
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:21:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z11so10766719pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680110470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gutUdfZnZGJz80FqANIFD9947ke4IDEKtmrilCP9Asg=;
        b=uoDbG/Rpr227AQzHfgKoRhIFdGyFDgE38i3QuNOHy1nfld7wbGPfRr9WuTb7JUFFRv
         5S6IUx5xo+jHf4HvuW37VUeU6CjeSxv7fJ3Xu1nDh3LyiSPOzXMvxx0JIjwsnbFpR5AC
         h/Z91+pEymRNAWpDcf4quLxfLPS/ZppPxHBsPd6hfixrDpFQxADA7OvslGVMam2HYR1T
         0nFVVFHIHCF83Qv5QPd7b/P0qCSfQK+pmpvJ/1puEeX934QmJKrQHP2Z5Zao9n2DUn2L
         gkMFCIk+VFJN3pd6/P7u1g6lhw+g3t5dv0cnLwPs3L7zuHEKDj2kEBENZazXqqiHwvYq
         f/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680110470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gutUdfZnZGJz80FqANIFD9947ke4IDEKtmrilCP9Asg=;
        b=gjLeS+HyTG8LsI/S+XPPBhbHYU8iZN71r9wJz9gibpK7Fb9/JNJg9wNppKRqVrqb5P
         TtXqYJOSh1h/aswr+Jcc10NxRjdFn56dPUm3Fx2DBRLVdqqRZ0aOgsNqKhvpBwzGlazs
         WJBTj2d2NuCtHbtdWGsJJMc3iB0g8bKJH6dlIB3Qou9f73oERxD/5c4nGxFLukfSG/z3
         UD6W+KXO9i9SsSigX7JINJ5MTIRoETWp/TLrzLYMHorXZZyaErEa2KhJll29idifTfyA
         vH4GDQAJocYoXElqa4SYbOOlhSSNuUMxNv00YCr1LoOyepf9KeFnblqmPPClc5TbaE5a
         Y9TA==
X-Gm-Message-State: AAQBX9eqqoKMvXAhIyCQsfP1FUlvMWZ1WaKXMA53QU3FfmjofpTGd1Y2
        XjIxbdAfvi8eExHiJosJPUVrkQ==
X-Google-Smtp-Source: AKy350Y9SAYyqMx62p9jKSnHqyG110Q69ooC4fMXn9Wpn/gCEjRcEAoPcOxIkdsN6Ap4ln7XX1StRw==
X-Received: by 2002:aa7:99d2:0:b0:626:7c43:7cb8 with SMTP id v18-20020aa799d2000000b006267c437cb8mr19386468pfi.20.1680110470163;
        Wed, 29 Mar 2023 10:21:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6b79:83ab:5e33:50a5])
        by smtp.gmail.com with ESMTPSA id v3-20020a632f03000000b00502e6bfedc0sm21950243pgv.0.2023.03.29.10.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 10:21:09 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:21:06 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: remoteproc: Drop unneeded quotes
Message-ID: <20230329172106.GA3374270@p14s>
References: <20230327170114.4102315-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327170114.4102315-1-robh@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:01:13PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../remoteproc/amlogic,meson-mx-ao-arc.yaml        |  4 ++--
>  .../bindings/remoteproc/fsl,imx-rproc.yaml         |  4 ++--
>  .../bindings/remoteproc/ingenic,vpu.yaml           |  4 ++--
>  .../bindings/remoteproc/qcom,glink-edge.yaml       |  2 +-
>  .../bindings/remoteproc/qcom,smd-edge.yaml         |  2 +-
>  .../bindings/remoteproc/renesas,rcar-rproc.yaml    |  4 ++--
>  .../bindings/remoteproc/st,stm32-rproc.yaml        | 14 +++++++-------
>  7 files changed, 17 insertions(+), 17 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml b/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml
> index 11cb42a3fdd1..3100cb870170 100644
> --- a/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-arc.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/remoteproc/amlogic,meson-mx-ao-arc.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/remoteproc/amlogic,meson-mx-ao-arc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Amlogic Meson AO ARC Remote Processor
>  
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index ae2eab4452dd..0c3910f152d1 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/remoteproc/fsl,imx-rproc.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/remoteproc/fsl,imx-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: NXP i.MX Co-Processor
>  
> diff --git a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
> index 85b1e43cab08..8b55dbd909b0 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/remoteproc/ingenic,vpu.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/remoteproc/ingenic,vpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Ingenic Video Processing Unit
>  
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
> index 15e6851e1ff8..7b43ad3daa56 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
> @@ -15,7 +15,7 @@ description:
>  
>  properties:
>    $nodename:
> -    const: "glink-edge"
> +    const: glink-edge
>  
>    apr:
>      $ref: /schemas/soc/qcom/qcom,apr.yaml#
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
> index 7ec8a6b6682c..02c85b420c1a 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml
> @@ -21,7 +21,7 @@ description:
>  
>  properties:
>    $nodename:
> -    const: "smd-edge"
> +    const: smd-edge
>  
>    apr:
>      $ref: /schemas/soc/qcom/qcom,apr.yaml#
> diff --git a/Documentation/devicetree/bindings/remoteproc/renesas,rcar-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/renesas,rcar-rproc.yaml
> index 7e0275d31a3c..4bea679a0f61 100644
> --- a/Documentation/devicetree/bindings/remoteproc/renesas,rcar-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/renesas,rcar-rproc.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/remoteproc/renesas,rcar-rproc.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/remoteproc/renesas,rcar-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Renesas R-Car remote processor controller
>  
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index 66b1e3efdaa3..37c0d7b4ceef 100644
> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/remoteproc/st,stm32-rproc.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/remoteproc/st,stm32-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: STMicroelectronics STM32 remote processor controller
>  
> @@ -29,7 +29,7 @@ properties:
>  
>    st,syscfg-holdboot:
>      description: remote processor reset hold boot
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        - items:
>            - description: Phandle of syscon block
> @@ -39,7 +39,7 @@ properties:
>    st,syscfg-tz:
>      description:
>        Reference to the system configuration which holds the RCC trust zone mode
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        - items:
>            - description: Phandle of syscon block
> @@ -95,7 +95,7 @@ properties:
>        (see ../reserved-memory/reserved-memory.txt)
>  
>    st,syscfg-pdds:
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: |
>        Reference to the system configuration which holds the remote
>      items:
> @@ -105,7 +105,7 @@ properties:
>            - description: The field mask of the PDDS selection
>  
>    st,syscfg-m4-state:
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: |
>        Reference to the tamp register which exposes the Cortex-M4 state.
>      items:
> @@ -115,7 +115,7 @@ properties:
>            - description: The field mask of the Cortex-M4 state
>  
>    st,syscfg-rsc-tbl:
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: |
>        Reference to the tamp register which references the Cortex-M4
>        resource table address.
> -- 
> 2.39.2
> 
