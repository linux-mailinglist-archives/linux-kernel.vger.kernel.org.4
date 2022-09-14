Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF65B8C62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiINQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiINQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:02:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA86C76A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:02:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so26465469wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=0a1rSxvAJG0YnYk7+iIiw+NeG9+9V8j9zpStoZYAMfg=;
        b=u7sQ9YzDa9AJttRF+k1/nMcRPdRO+kG+nfqYPxJ3nVXs9DRbmmGr7tuqKKhGqFWK4z
         kTXcHAfcLUGjEFEyZ0/r4eO8uWM23Fsq0qt+UY0ZHrpmm/WCs8GBsLK9Qnawv0/xn0tN
         3SMXx/1Dd4d77k/Yj6dxjyZ1c2V+ndnhDXQwdKY82wCixqLbhHm0PnCu0EWVFnIClXyw
         xUIrmpBknDUwOWb15hb82/S8XCUYzUnORQm1GcGvqo4Y3zLpf044H5WzbhXRif+JxQ8P
         EXeDQNwV0Mj7XtH3F17ztuSMhj0aNcoHyLdWi6pF66KjdJL17Anltq1bpS3U7DshrFmc
         ucXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=0a1rSxvAJG0YnYk7+iIiw+NeG9+9V8j9zpStoZYAMfg=;
        b=yLhN6G/216ycdyhAPZcDy1qYYEFvYpkRxIIyqojAf6aF/S56uXLPhOQ5VbhQQC+UKt
         F5KAAXS5ovanTRJVj+08XyDC06ZYaMbBAQ4rZvLzhHAnJswL8Fxij/hn2IC/Yp1OnZcF
         cv5/gg199x8toqHqig7wH+HMF7Etoze0Qi7tfYeTJP0D6JT66buvn8KJqOO4M/NZaqC/
         HAUZZfzdFV4KXdSoH6SmF2F42py4GfvPWdQAbaA3rfJsxBKtCffTmv4xrlpP4mqXxm6Y
         kmsdiT1Ev89X/WwCcrbNPvqbLrZJtyK4ZZqpgznf7uj7H6PPjrcht7zei5Fgr/cZud7K
         ebeA==
X-Gm-Message-State: ACgBeo3oUxLf3y25ikBhW7u/5CPrOLIrJVQmpV958I5gJbvhw5YC2Md9
        nFyR/1PyvxcE4C9e+eWKQVAvYA==
X-Google-Smtp-Source: AA6agR7zCloyLg9dA6SkmO6teoejjwRwhuaiZfmAYiHwsaIJNXiwj59Jq8E/lGyPllk5k9+m78yl/Q==
X-Received: by 2002:a5d:47a8:0:b0:226:f124:ad74 with SMTP id 8-20020a5d47a8000000b00226f124ad74mr23034923wrb.18.1663171361878;
        Wed, 14 Sep 2022 09:02:41 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c2cb100b003a5ca627333sm19229570wmc.8.2022.09.14.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:02:41 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: Convert mtk-pmic-keys to DT
 schema
In-Reply-To: <20220914103021.43593-2-angelogioacchino.delregno@collabora.com>
References: <20220914103021.43593-1-angelogioacchino.delregno@collabora.com>
 <20220914103021.43593-2-angelogioacchino.delregno@collabora.com>
Date:   Wed, 14 Sep 2022 17:02:40 +0100
Message-ID: <87leqmt04f.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Wed, Sep 14, 2022 at 12:30, AngeloGioacchino Del Regno         <angelogioacchino.delregno@collabora.com> wrote:

> Convert the mtk-pmic-keys to DT schema format.
>
> The old binding was missing documentation for key press/release
> interrupts, even though it was supported in hardware and driver,
> so support for the same was added during the conversion.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/input/mediatek,pmic-keys.yaml    | 113 ++++++++++++++++++
>  .../bindings/input/mtk-pmic-keys.txt          |  46 -------
>  2 files changed, 113 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

Thank you for doing this. I started this but it seemed you were faster
than me :)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> new file mode 100644
> index 000000000000..9d8a0c3aebca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/mediatek,pmic-keys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek PMIC Keys
> +
> +maintainers:
> +  - Chen Zhong <chen.zhong@mediatek.com>
> +
> +allOf:
> +  - $ref: input.yaml#
> +
> +description: |
> +  There are two key functions provided by MT6397, MT6323 and other MediaTek
> +  PMICs: pwrkey and homekey.
> +  The key functions are defined as the subnode of the function node provided
> +  by the PMIC that is defined as a Multi-Function Device (MFD).
> +
> +  For MediaTek MT6323/MT6397 PMIC bindings see
> +  Documentation/devicetree/bindings/mfd/mt6397.txt
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6323-keys
> +      - mediatek,mt6358-keys
> +      - mediatek,mt6397-keys
> +
> +  power-off-time-sec: true
> +
> +  mediatek,long-press-mode:
> +    description: |
> +      Key long-press force shutdown setting
> +      0 - disabled
> +      1 - pwrkey
> +      2 - pwrkey+homekey
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    maximum: 2
> +
> +patternProperties:
> +  "^((power|home)|(key-[a-z0-9-]+|[a-z0-9-]+-key))$":
> +    $ref: input.yaml#
> +
> +    properties:
> +      interrupts:
> +        minItems: 1
> +        items:
> +          - description: Key press interrupt
> +          - description: Key release interrupt
> +
> +      interrupt-names: true
> +
> +      linux-keycodes:
> +        maxItems: 1
> +
> +      wakeup-source: true
> +
> +    required:
> +      - linux,keycodes
> +
> +    if:
> +      properties:
> +        interrupt-names:
> +          contains:
> +            const: powerkey
> +    then:
> +      properties:
> +        interrupt-names:
> +          minItems: 1
> +          items:
> +            - const: powerkey
> +            - const: powerkey_r
> +    else:
> +      properties:
> +        interrupt-names:
> +          minItems: 1
> +          items:
> +            - const: homekey
> +            - const: homekey_r
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pmic {
> +        compatible = "mediatek,mt6397";
> +
> +        keys {
> +          compatible = "mediatek,mt6397-keys";
> +          mediatek,long-press-mode = <1>;
> +          power-off-time-sec = <0>;
> +
> +          key-power {
> +            linux,keycodes = <KEY_POWER>;
> +            wakeup-source;
> +          };
> +
> +          key-home {
> +            linux,keycodes = <KEY_VOLUMEDOWN>;
> +          };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> deleted file mode 100644
> index 9d00f2a8e13a..000000000000
> --- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -MediaTek MT6397/MT6323 PMIC Keys Device Driver
> -
> -There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
> -and homekey. The key functions are defined as the subnode of the function
> -node provided by MT6397/MT6323 PMIC that is being defined as one kind
> -of Muti-Function Device (MFD)
> -
> -For MT6397/MT6323 MFD bindings see:
> -Documentation/devicetree/bindings/mfd/mt6397.txt
> -
> -Required properties:
> -- compatible: Should be one of:
> -	- "mediatek,mt6397-keys"
> -	- "mediatek,mt6323-keys"
> -	- "mediatek,mt6358-keys"
> -- linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
> -
> -Optional Properties:
> -- wakeup-source: See Documentation/devicetree/bindings/power/wakeup-source.txt
> -- mediatek,long-press-mode: Long press key shutdown setting, 1 for
> -	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
> -- power-off-time-sec: See Documentation/devicetree/bindings/input/input.yaml
> -
> -Example:
> -
> -	pmic: mt6397 {
> -		compatible = "mediatek,mt6397";
> -
> -		...
> -
> -		mt6397keys: mt6397keys {
> -			compatible = "mediatek,mt6397-keys";
> -			mediatek,long-press-mode = <1>;
> -			power-off-time-sec = <0>;
> -
> -			power {
> -				linux,keycodes = <116>;
> -				wakeup-source;
> -			};
> -
> -			home {
> -				linux,keycodes = <114>;
> -			};
> -		};
> -
> -	};
> -- 
> 2.37.2
