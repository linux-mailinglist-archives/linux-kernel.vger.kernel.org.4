Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F0A70F295
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbjEXJWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbjEXJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:21:07 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952E9D;
        Wed, 24 May 2023 02:21:03 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6af6df7f93aso35501a34.0;
        Wed, 24 May 2023 02:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920063; x=1687512063;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ooM2WEkot7KuXyG8TFkP/cOGbwCsIoaqyATdhVKfqHo=;
        b=hYCMKy168dcj7eOuVFj3OkyTUan/mOGuOF/Lh0cuEer68J3eeHMGI0fVcFOL+rNmxJ
         s+KbgeNu+Vrb6GYpeWzNipse9WrPFTdnrwaHYT006j5LCnGk9xBhYiUxpdJ+2jhumW3v
         rDv29e6uAUwjg3uXCf91YYLTqqm71xqOr+QgnCf+2l5o3I22bxkhQ6oNKq1N/u5adHpR
         heTZLTtrtF+H4wogdqMfz+LbjJE+x2bD4ikyJLmDxmi8AUsM95FQp3hnRE5YX789WpVD
         KU/RwD79WsP8plhBEsRB1fChysv50yG4z4L8heh+00MPoqT96TnTMH0jBlmsXp/W3ZW5
         mveg==
X-Gm-Message-State: AC+VfDyVybXLGMWDHUI7Lz9H525B9sYAjz85J6ikBKFil6dDZx+7aT2p
        /M7nHTY+5N0FplWMswYsbw==
X-Google-Smtp-Source: ACHHUZ4tFm4ZuNjyciy5rDRzPIQPer8A2tuJgUMFQzjxCy7xPQFdCReLHYiLcV5WSajQCgi+WrZNxA==
X-Received: by 2002:a05:6830:1b67:b0:6af:8b3f:cda4 with SMTP id d7-20020a0568301b6700b006af8b3fcda4mr3059936ote.13.1684920062785;
        Wed, 24 May 2023 02:21:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d6e97000000b006af8ac6ed5dsm1992509otr.38.2023.05.24.02.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:21:02 -0700 (PDT)
Received: (nullmailer pid 3187102 invoked by uid 1000);
        Wed, 24 May 2023 09:21:00 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Haibo Chen <haibo.chen@nxp.com>, Chen-Yu Tsai <wens@csie.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        linux-riscv@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>
In-Reply-To: <20230524082744.3215427-3-bigunclemax@gmail.com>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
 <20230524082744.3215427-3-bigunclemax@gmail.com>
Message-Id: <168492006052.3187086.8767275310596142124.robh@kernel.org>
Subject: Re: [RFC PATCH v1 2/4] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329 SoCs GPADC
Date:   Wed, 24 May 2023 04:21:00 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 May 2023 11:27:31 +0300, Maxim Kiselev wrote:
> Allwinner's D1, T113s and R329 SoCs have a new general purpose ADC.
> This ADC is the same for all of this SoCs. The only difference is
> the number of available channels.
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> ---
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Error: Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dts:27.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230524082744.3215427-3-bigunclemax@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

