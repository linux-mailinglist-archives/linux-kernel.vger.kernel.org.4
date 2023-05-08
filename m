Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D26FB1A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjEHNen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjEHNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:34:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84BB2FA01
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:34:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f4b911570so701473666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683552874; x=1686144874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNv2I8D8lHC3anjLGdCgDfw3zwn1qSi0/Ip3IkTMaV0=;
        b=tOIFXK+lcH2ykBPyI8q9+jKClkFjlnFfoO3N14ovB/CYtesjCHJJmlb8dkToJGhO+6
         QAoykSOtKQLG/ZLkx2qFyD5crlXQayazRidED74shOgBwO7S7mLTWot8pXyn/Z4WrIT3
         Zjh+dqDt91gUt+MmbO4U+9WmhPnWBlmapabIIbvZ3OS8t4dERqAJULeiNk6F1GyqhaXT
         TRoZNTgnQ+J20M9zAtT94kpiYNITnDeqMKbGrBsiUnswaIMCrIssL4/NJ8dqIcmx7Tlw
         GHl4VPGWiAxP0IBV11SvPpOhb+y0pghAA3EIfXMk4hLXPJsvM5Tzn+qLLT2gNtE+I4tp
         9bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683552874; x=1686144874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNv2I8D8lHC3anjLGdCgDfw3zwn1qSi0/Ip3IkTMaV0=;
        b=MX7m1C0HjGEN5XmfKPC6VfdiQNxCsRusIBeEKZVfDlqQkEHcrlS9pu3QyAM/RP0eFw
         x2HCSJmzuAjdOUGFUbiQO4769nRJyj1CebfdTQBTM55vfyYasSI979ntgTcfFcy2T3/m
         3+BV6TFTjZEOgksFcOCjQQvIKSYrlJ6EwHllc9iBub9vOL3/czzCDbEiv1mynVe5El6i
         FJqZ6L8iSkEAFnshNmoHcuQv8pzy9dBF1fu4B5tyLidRGK9ANHMQbYbZrxB1qUPLL/Sp
         tFUoYdeiaAEgUR4xizugRORTRJn13GIoot5Qn8GFj+WRx8bBef0SEjNSU3g3ax6NZdG3
         UA/g==
X-Gm-Message-State: AC+VfDzlP1KGWnUpxp9Is2eSkWaGDAXeYQ/tJ0z1ngKC6SbV2iajAWnz
        qbEOT/qqwHZ0Vt5Yf1LqYWCqzg==
X-Google-Smtp-Source: ACHHUZ4ccIzX5gazJRfi3DwQwRaXaprMkRCzcmHzIhwgt0MLpsVSjOBy5X0r6zj7lZcpfTtUfJAYQA==
X-Received: by 2002:a17:907:5ca:b0:965:6cb9:b768 with SMTP id wg10-20020a17090705ca00b009656cb9b768mr7216816ejb.31.1683552874325;
        Mon, 08 May 2023 06:34:34 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id ib11-20020a1709072c6b00b00965ac1510f8sm5007185ejc.185.2023.05.08.06.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:34:33 -0700 (PDT)
Date:   Mon, 8 May 2023 15:34:31 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] dt-bindings: MFD: Convert STMPE to YAML schema
Message-ID: <20230508133431.tqi7jmgcmfs5c3cf@krzk-bin>
References: <20230426-stmpe-dt-bindings-v4-0-36fdd53d9919@linaro.org>
 <20230426-stmpe-dt-bindings-v4-2-36fdd53d9919@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230426-stmpe-dt-bindings-v4-2-36fdd53d9919@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 May 2023 14:35:10 +0200, Linus Walleij wrote:
> This converts the STMPE MFD device tree bindings to the YAML
> schema.
> 
> Reference the existing schema for the ADC, just define the
> other subnode schemas directly in the MFD schema.
> 
> Add two examples so we have examples covering both the simple
> GPIO expander and the more complex with ADC and touchscreen.
> 
> Some in-tree users do not follow the naming conventions for nodes
> so these DTS files need to be augmented to use proper node names
> like "adc", "pwm", "gpio", "keyboard-controller" etc before the
> bindings take effect on them.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Drop the required pwm properties already required by the
>   template pwm schema.
> - Add the number of PWM cells as const.
> ChangeLog v1->v2:
> - Split off the GPIO bindings to their own schema, as the old
>   bindings didn't even have any GPIO bindings. Put the GPIO
>   schema before this schema so we can use GPIO in the examples.
> - Drop nodename and pattern as STMPE is not a generic name.
> - Add maxItems to the resets.
> - Make wakeup-source just :true, as it is a generic property.
> - Move unevaluatedProperties for subnodes right before properties
>   as requested.
> - Name devices "port-expander" in the examples.
> - Use lowercase hex in line init.
> ---
>  .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
>  .../bindings/input/touchscreen/stmpe.txt           | 108 --------
>  .../devicetree/bindings/mfd/st,stmpe.yaml          | 297 +++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/stmpe.txt    |  42 ---
>  4 files changed, 297 insertions(+), 191 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/st,stmpe.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/gpio/st,stmpe-gpio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: port-expander@43: gpio: False schema does not allow {'compatible': ['st,stmpe-gpio'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]], 'st,norequest-mask': [[15790082]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: /example-0/i2c/port-expander@43/gpio: failed to match any schema with compatible: ['st,stmpe-gpio']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: port-expander@41: gpio: False schema does not allow {'compatible': ['st,stmpe-gpio'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]]}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/st,stmpe.yaml
Documentation/devicetree/bindings/mfd/st,stmpe.example.dtb: /example-0/i2c/port-expander@41/gpio: failed to match any schema with compatible: ['st,stmpe-gpio']

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/patch/1778351

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
