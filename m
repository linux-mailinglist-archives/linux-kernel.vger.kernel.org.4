Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930297061C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEQHxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEQHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:53:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B300B3AA3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:53:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so806472a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684309993; x=1686901993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxZmzXZkXDBaGgGWBd0FKqOvFO0QoVnqw9tUxsTvOAs=;
        b=ooHuR6MkMk7X91Ce8AshfMTwcLvBEooZNPRz3QYxhe86Lp+rfo7jPEybaYeF/l7T4N
         5ErDRsYbYm5CjMPC/m0Y/2bg2dJNQbbqhZXowFei6t0G3t9K+2xV9n6pXUfRgkyxtLLq
         jRpSstSiT8ri3BHemZBHSL1/h+eKYYB+CeWORnv7n/CgBZR30X1e9vrZ1J3oIV2cSMTt
         b+xetZhXjhV31DMdQs/e+IIgITXchKJbNgD6UcT/xMKaiH8100mbf6dAa+tFeUg4heSt
         Zi94RLTwwdUtzjTcTyNYiTE+ZnZVFkaTjl/mRN6tlEtdyPiFmRl6X9B2tLAWUEJI4OI4
         jA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309993; x=1686901993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxZmzXZkXDBaGgGWBd0FKqOvFO0QoVnqw9tUxsTvOAs=;
        b=f7o//hDvJjDoyrcmZ5My+HRjkh+fB9uUBR4hOPQGTpG27TPdnXjgjGoMTE+mEeREO9
         +Q8bhaoe8336EppK+HEgjXbt8JnYqHXMHPOauo7MWsRcU0msCzLeKul+41vroHZYbNLc
         qHq5PNIVcGarNUE9c4uo5C7KY6T8HCsYiwkRYHbaNLAimflwmeFEWxTedCWDNRo+Gvot
         P6rXQFtTpTY6XXfbjPLhAJo80Z92xa7YhEprKruV4opUUc8yYp/A0I8K+wsgmRVFYdyd
         JxDdCJHnYe1uY2J05pBFK4fHKlhx87Mm+x/22HClfRHesFy5KIPaYJTB4pUuXDrtqlA8
         Ze+g==
X-Gm-Message-State: AC+VfDwSsuR/kTKspOpVQBa7/cQNsKjhKu4D+tfkiOspyOJMIKM0MBi1
        zHJxcHTE6gPoJPho/zv23U0dxQ==
X-Google-Smtp-Source: ACHHUZ4d4FF1MqDNE/QWLvtFqwDL3H45IrtZ4O8CBJ3/OL1X7qUrMJSaS5NCwnE95sV4+LxlBVpd0Q==
X-Received: by 2002:a17:906:7947:b0:94e:dd68:aba1 with SMTP id l7-20020a170906794700b0094edd68aba1mr36835117ejo.67.1684309993120;
        Wed, 17 May 2023 00:53:13 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709067ccf00b0094f23480619sm12056895ejp.172.2023.05.17.00.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:53:12 -0700 (PDT)
Date:   Wed, 17 May 2023 09:53:10 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: ehrpwm: Remove unneeded syscon
 compatible
Message-ID: <20230517075310.iduc2eisw7a5bm45@krzk-bin>
References: <20230516184626.154892-1-afd@ti.com>
 <20230516184626.154892-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230516184626.154892-2-afd@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 13:46:26 -0500, Andrew Davis wrote:
> This node's register space is not accessed by any other node, which
> is the traditional use for the "syscon" hint. It looks to have been
> added here to make use of a Linux kernel helper syscon_node_to_regmap().
> The Linux driver now uses a more appropriate helper that does not
> require the hint, so let's remove it from the binding.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml     | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.example.dtb: scm-conf@100000: clock-controller@4140:compatible: ['ti,am654-ehrpwm-tbclk', 'syscon'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.example.dtb: clock-controller@4140: compatible: ['ti,am654-ehrpwm-tbclk', 'syscon'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml

See https://patchwork.ozlabs.org/patch/1782200

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
