Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8665C8F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbjACVfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjACVfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:35:17 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0951261B;
        Tue,  3 Jan 2023 13:35:16 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so19819233otk.8;
        Tue, 03 Jan 2023 13:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8P3ginyQKonop89J+7DfYw/82uc/ZrqaQ0PG8kTwCUs=;
        b=aKWf8bJ2k99asm2tdDzzSf+UesabGJMsbYuOQAyTZrAnsTCM9+2cZ575ukwyyO2Ptp
         4acoeTFmOi4aebndnbsjqyUgwEYYs3IVKDmfmnXE5LUJV2AuMAUQOtxLsc3hnojfk3Jc
         VXNXNkXPuuiqT759l3b9TYMYmVunrQ48R4Tba7zuPALTY5+cMT5MtEGw1hwh0dzasqME
         MzGZ/czI8Lm1JvcZNF+zWCWeN+R7aMpB1JECMh6dJCJ/7fCh6hOwlKoI291Vvy6qTsg8
         5+shTGz4gDQaK989SAESyHkTP92crWqmnZqAHTHic5a26q+gMvIWiRhohgFu7mx7AbE3
         +/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8P3ginyQKonop89J+7DfYw/82uc/ZrqaQ0PG8kTwCUs=;
        b=aDSmDnoWtwh7RI9SZmD178CoBLDR9ifQ/EYxthAIYUqlI/bwQPdBxgm23SOtRxow07
         858XdsleOAUArb9ieo8jshTAXbkLSvK9etUWXz/QlMSRyidIcY7/7pRePt/AwCAf92uR
         3Rf78CF1INdJnNaz+kGEiKCLy3O8ZuuV4b8f2jq65rXXFW+ga9UrQyl1YKqmzdLA78qe
         JtHKlNwMKrCConUhCWMSjlfyUHTeZIL/0z6KwzbeTKLTCH06lUbyL2mi2pXfu67wSsex
         VQdpX6o/KSvFqIrYEJjJhXfBNF7Zgno2EUYglImn+6Vsfbyk9iQtGpIEr6gkaM4DxZgK
         0U/A==
X-Gm-Message-State: AFqh2kr6mUvJFsQnvlxOsS9J91bp6caiXKHqs14whzr/QSpRLyyr34EW
        51Fy5RzHr1MkE6hg0c036/g=
X-Google-Smtp-Source: AMrXdXuFoDGPeAwH/nDZ3FkyWvhEXgHn6dPjZyJ/mzFc5kwKVIuBNaUayVo5Cwy1W/onbY3+f+hd4A==
X-Received: by 2002:a9d:4701:0:b0:671:81c2:6406 with SMTP id a1-20020a9d4701000000b0067181c26406mr22659086otf.38.1672781715760;
        Tue, 03 Jan 2023 13:35:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id db6-20020a0568306b0600b00683e4084740sm11448796otb.10.2023.01.03.13.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:35:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:35:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/5] dt-bindings: hwmon: Add hpe,gxp-fan-ctrl
Message-ID: <20230103213514.GA216224@roeck-us.net>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103203654.59322-3-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 02:36:51PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the binding to support control of the fans on
> HPE platforms.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v4:
>  *No change
> v3:
>  *No change
> v2:
>  *Changed plreg to pl
>  *Changed fn2reg to reg
>  *Edited descriptions for all registers
>  *Changed fanctrl to fan-controller
>  *Changed commit description
> ---
>  .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> new file mode 100644
> index 000000000000..4a52aac6be72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/hpe,gxp-fan-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Fan Controller
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +description: |
> +  The HPE GXP fan controller controls the fans through an external CPLD
> +  device that connects to the fans.
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-fan-ctrl
> +
> +  reg:
> +    items:
> +      - description: Fan controller PWM
> +      - description: Programmable logic
> +      - description: Function 2
> +
> +  reg-names:
> +    items:
> +      - const: base
> +      - const: pl
> +      - const: fn2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    fan-controller@1000c00 {
> +      compatible = "hpe,gxp-fan-ctrl";
> +      reg = <0x1000c00 0x200>, <0xd1000000 0xff>, <0x80200000 0x100000>;
> +      reg-names = "base", "pl", "fn2";
> +    };
