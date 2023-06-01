Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8371F6AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjFAXbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFAXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:31:43 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE51A2;
        Thu,  1 Jun 2023 16:31:15 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-774924b7c4dso19088339f.1;
        Thu, 01 Jun 2023 16:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662274; x=1688254274;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cb1CfXzrs6lfSi6zBUOFLpr0Hb+1fAVic93bHB6hbRY=;
        b=c9w2p5UTbkkrsjfXYQB3uYYVhYZIEJyDZRA60DBLj4NQM6o5sV6Mqcwi96FBvyyzPK
         UL9hjm4rkSZr2N/uGTTt7Te2XIVFAwDhqVysPnPd1uF91R3MfZz4FhpkzlJYZCDaKWdC
         4ywp4dhwRz4DVqRcdCBA2Cxoj3Q+7dqVNrPfisKEFF2/RzZpIi+3PT/hD29av1aL6xB5
         /498lWjeNs3yGyL5YqF8NZhS/uGbi6/16P+fSm5IyYK+PV4qu5dylNimPAG8P26WBbVQ
         3KWSnQYlEhg7ii3DPNW3QR0hQd1N7bwfDS3xyfa7f5nuI+avrT0zsk2yTL/uB7okIb2Q
         Rb0Q==
X-Gm-Message-State: AC+VfDzE+hhmFWeYwe95670ap3wm6qTyJoLJr/TxjYoMTTOGJ11G781B
        9p5HL73/zYuPlw8KWKukyg==
X-Google-Smtp-Source: ACHHUZ7KuUx3HpNpCs9tLCFhl7zyHSWtos++Yn9HCL/4MuIL0XWFVJLJNNAME44mwEOW+VqD1lLqrg==
X-Received: by 2002:a6b:a04:0:b0:76c:c701:2f77 with SMTP id z4-20020a6b0a04000000b0076cc7012f77mr857930ioi.3.1685662274343;
        Thu, 01 Jun 2023 16:31:14 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k13-20020a056638370d00b0041ac54cbc60sm2507403jav.56.2023.06.01.16.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:31:13 -0700 (PDT)
Received: (nullmailer pid 680122 invoked by uid 1000);
        Thu, 01 Jun 2023 23:31:10 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-iio@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>
In-Reply-To: <20230601223104.1243871-3-bigunclemax@gmail.com>
References: <20230601223104.1243871-1-bigunclemax@gmail.com>
 <20230601223104.1243871-3-bigunclemax@gmail.com>
Message-Id: <168566227051.680105.5733105640586356762.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
Date:   Thu, 01 Jun 2023 17:31:10 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 02 Jun 2023 01:30:40 +0300, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
> 
> Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
> This ADC is the same for all of this SoCs. The only difference is
> the number of available channels.
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> ---
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dts:33.15-25: Warning (reg_format): /example-0/adc@2009000/channel@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dts:37.15-25: Warning (reg_format): /example-0/adc@2009000/channel@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dts:32.23-34.15: Warning (avoid_default_addr_size): /example-0/adc@2009000/channel@0: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dts:32.23-34.15: Warning (avoid_default_addr_size): /example-0/adc@2009000/channel@0: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dts:36.23-38.15: Warning (avoid_default_addr_size): /example-0/adc@2009000/channel@1: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dts:36.23-38.15: Warning (avoid_default_addr_size): /example-0/adc@2009000/channel@1: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230601223104.1243871-3-bigunclemax@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

