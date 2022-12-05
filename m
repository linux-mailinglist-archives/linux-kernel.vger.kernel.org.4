Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EDE642B09
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiLEPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiLEPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:08:04 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F81D0EC;
        Mon,  5 Dec 2022 07:07:52 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1442977d77dso12628994fac.6;
        Mon, 05 Dec 2022 07:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=un2tfy4ahNo9zjbkY7O4xE/RSkvkF3i02AWzGP/4rig=;
        b=c32sEX4J51LjwbpWvqQmgfrylQBJbDFBd7LEAK6d4r6Ogq5C91Q09bCAO+qBw/zp5b
         y5xBq4WWyA7H1AOPEIwLnvHarse0nW7C3fmZnHBP9jbc27qmn6eL3dgj5xNC3pnG8aG5
         Z4bdCM+Nfd7I5fq8Z7kdWTUzd36h5ZmXAenzzvFZxLpUjt3QkSo6nf9AdxDSeVy+rTj5
         ib+1k6408KivxnckKxsZwQYA26+MHQpOOPq/c43XyNDtCYseybnKJatK8pL1qWvMKyp+
         wNifi1TyVFeAx5sGTpCzUclTpycxeIl6xnzwUBfkBV/yHMd2QRZ6s4pTPsUADUQ3usTi
         o6Pg==
X-Gm-Message-State: ANoB5pmFCmjrsQIAQG9yA2F4tfRwnWSTXwY5IuHr/vxX0VA2hnpPC+VF
        oJUbG45rml0MBbVdfdb/gw==
X-Google-Smtp-Source: AA0mqf4u4kzZ1ZBWoQtzp872W52LKIVRXUvm43N91ZDjaWGZJYwEgFGMaehPuBK+w9wgO1cB9V4ooA==
X-Received: by 2002:a05:6870:ee16:b0:144:a24c:e1cb with SMTP id ga22-20020a056870ee1600b00144a24ce1cbmr2227077oab.164.1670252870872;
        Mon, 05 Dec 2022 07:07:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y30-20020a9d22a1000000b0066ea9650da8sm3195971ota.20.2022.12.05.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 07:07:50 -0800 (PST)
Received: (nullmailer pid 1794161 invoked by uid 1000);
        Mon, 05 Dec 2022 15:07:49 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-amlogic@lists.infradead.org, Joe Tessler <jrt@google.com>,
        Jeff Chase <jnchase@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20221204182908.138910-5-krzysztof.kozlowski@linaro.org>
References: <20221204182908.138910-1-krzysztof.kozlowski@linaro.org>
 <20221204182908.138910-5-krzysztof.kozlowski@linaro.org>
Message-Id: <167025248440.1785019.8058849269946787324.robh@kernel.org>
Subject: Re: [PATCH 5/9] media: dt-bindings: chrontel,ch7322: reference common
 CEC properties
Date:   Mon, 05 Dec 2022 09:07:49 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 04 Dec 2022 19:29:04 +0100, Krzysztof Kozlowski wrote:
> Reference common HDMI CEC adapter properties to simplify the binding and
> have only one place of definition for common properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/i2c/chrontel,ch7322.yaml   | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.example.dtb: ch7322@75: $nodename:0: 'ch7322@75' does not match '^cec(@[0-9a-f]+|-[0-9]+)?$'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.example.dtb: ch7322@75: Unevaluated properties are not allowed ('hdmi-phandle' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221204182908.138910-5-krzysztof.kozlowski@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

