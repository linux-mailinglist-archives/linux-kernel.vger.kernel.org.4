Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BAD7301B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244581AbjFNOYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbjFNOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:24:04 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576A01BC6;
        Wed, 14 Jun 2023 07:24:03 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33b1e83e1daso29019675ab.0;
        Wed, 14 Jun 2023 07:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752642; x=1689344642;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//LQdmeIx8VDOjysyrkzNeX5nkq2mzKxfmFr/6gfOOo=;
        b=AFd2OrXBZq/X2W43HDwvFM4WCSp+qHM8IKvsA9wYQMb3wtPkmO3LwE4ro/YrdDeOrU
         dZiCkdvOE6FFH5/7nmcVr4cBfe0E41Btck7YEwptOB6pxqNdkPHPNMKYTUu0dXn8G4QS
         LrK4gS/GlF5GWDJ4ED5oA0R0iWGkHctMJTHRs6vfXdlYNHauMn9qIgBKczXUk7jiCsoW
         l9g0ypS7aa07GUzcaFnD5ZbH6cghi/+pTIUe71EHR0BjoYyMUWbK6C6QQ60fJ1nq7UfI
         mLRhld5KmDJZdP3Ta3dYGluolFbGfzs235jJ2rnyQ/cmE8/2bRkpJEuRJacs6PxEAyxf
         a2ag==
X-Gm-Message-State: AC+VfDxPkm+uQpsmmA0Dde3hDB6A0uu8g6bdgcpz8iQk5Hf4TFrMnh5+
        CUA88MGRnnyXyMllR28kCA==
X-Google-Smtp-Source: ACHHUZ7wXmcmWVBGnccJZukbwYP+C9yoCz/N62Wnj/yTIO7plH80L5GUh4kr2WXJ6/m3J00pZBVtGQ==
X-Received: by 2002:a92:db47:0:b0:33d:a34a:2d42 with SMTP id w7-20020a92db47000000b0033da34a2d42mr12955717ilq.20.1686752642282;
        Wed, 14 Jun 2023 07:24:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c5-20020a02a405000000b0041848ea6594sm4885425jal.34.2023.06.14.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 07:24:01 -0700 (PDT)
Received: (nullmailer pid 1344045 invoked by uid 1000);
        Wed, 14 Jun 2023 14:23:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-riscv@lists.infradead.org,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        William Breathitt Gray <william.gray@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>
In-Reply-To: <20230614132644.699425-3-bigunclemax@gmail.com>
References: <20230614132644.699425-1-bigunclemax@gmail.com>
 <20230614132644.699425-3-bigunclemax@gmail.com>
Message-Id: <168675263824.1343935.18392695577959894991.robh@kernel.org>
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
Date:   Wed, 14 Jun 2023 08:23:58 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jun 2023 16:26:26 +0300, Maksim Kiselev wrote:
> Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
> This ADC is the same for all of this SoCs. The only difference is
> the number of available channels.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml: patternProperties:^channel@[0-9a-f]+$:properties:reg:items: 'oneOf' conditional failed, one must be fixed:
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml: patternProperties:^channel@[0-9a-f]+$:properties:reg:items: 'anyOf' conditional failed, one must be fixed:
		'Maksimum' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
		'type' was expected
		from schema $id: http://devicetree.org/meta-schemas/core.yaml#
	{'minimum': 0, 'Maksimum': 15} is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml: patternProperties:^channel@[0-9a-f]+$:properties:reg: 'anyOf' conditional failed, one must be fixed:
	'maxItems' is a required property
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'items' is not one of ['maxItems', 'description', 'deprecated']
	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml: patternProperties:^channel@[0-9a-f]+$:properties:reg:items: 'oneOf' conditional failed, one must be fixed:
		/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml: patternProperties:^channel@[0-9a-f]+$:properties:reg:items: 'anyOf' conditional failed, one must be fixed:
			'maxItems' is a required property
				hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
			'minimum' is not one of ['maxItems', 'description', 'deprecated']
			'Maksimum' is not one of ['maxItems', 'description', 'deprecated']
			Additional properties are not allowed ('Maksimum', 'minimum' were unexpected)
				hint: Arrays must be described with a combination of minItems/maxItems/items
			'Maksimum' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
			hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
			from schema $id: http://devicetree.org/meta-schemas/core.yaml#
		{'minimum': 0, 'Maksimum': 15} is not of type 'array'
		hint: "items" can be a list defining each entry or a schema applying to all items. A list has an implicit size. A schema requires minItems/maxItems to define the size.
		from schema $id: http://devicetree.org/meta-schemas/core.yaml#
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230614132644.699425-3-bigunclemax@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

