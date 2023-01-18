Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB567213B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjARP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjARP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:27:13 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6385BA9;
        Wed, 18 Jan 2023 07:26:15 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 123-20020a4a0681000000b004faa9c6f6b9so879156ooj.11;
        Wed, 18 Jan 2023 07:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT7vo//zIHYtjuHwHvVEOuFwE5YKQ11WWGeqHMGeNf0=;
        b=uTgpWe9P4CIdT+Q+FzQWm3ly8uH9REXn3e5KdRPdBuZcrRCMd8dPnIerWh5JNi9YzN
         ABVUnOYZ4sUYXPwYD+AgED9E/7euME/lK9RrXFO6rJDaIKKK0tKnY2/TbGWXsOEajuLq
         3uvBf9Vt1ZSqR4Q7+hoDX0QEbkpFbnMvu6o0F1vYiFIoB4RUsIIiTGwzQ1UcsSHam7UA
         qYmt76lqxESlWXrEnKlxraiRir6a70i+DRn1mFy9MRQ+t/j53YWVtlKEyx5Qj0K6sTeB
         eSIte1Ng6J1x5JbkFZ5DhCi35xCxQni2zYkW6B0Phm9UzwQkEJTIdhfQdX/oGy9qgDjo
         sjAg==
X-Gm-Message-State: AFqh2krorMvEFwLt581wDa7w7zgeycLZKSFniUvGkRPrxjoRyfIrBWSM
        +IjE82fVXYOAbkT5tMKZsw==
X-Google-Smtp-Source: AMrXdXvrHsL3B9As2RFndVMMqtmIzmNvUPOHglhiIYMLBz7EpgrDtHsKHz/dRPDHU+pft+uq8bi6Dg==
X-Received: by 2002:a4a:b202:0:b0:4d1:c23:3c51 with SMTP id d2-20020a4ab202000000b004d10c233c51mr2822427ooo.9.1674055574338;
        Wed, 18 Jan 2023 07:26:14 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id o10-20020a4aabca000000b004f22e40ad6fsm10435619oon.2.2023.01.18.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:26:13 -0800 (PST)
Received: (nullmailer pid 30555 invoked by uid 1000);
        Wed, 18 Jan 2023 15:26:13 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Shawn Guo <shawnguo@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Shawn Tu <shawnx.tu@intel.com>
In-Reply-To: <20230118103239.3409674-2-michael.riesch@wolfvision.net>
References: <20230118103239.3409674-1-michael.riesch@wolfvision.net>
 <20230118103239.3409674-2-michael.riesch@wolfvision.net>
Message-Id: <167405509286.19309.13229390529677400429.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: add imx415 cmos image sensor
Date:   Wed, 18 Jan 2023 09:26:13 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 11:32:38 +0100, Michael Riesch wrote:
> Add devicetree binding for the Sony IMX415 CMOS image sensor.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../bindings/media/i2c/sony,imx415.yaml       | 120 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx415.example.dtb: camera-sensor@1a: port:endpoint: Unevaluated properties are not allowed ('clock-lanes', 'data-lanes' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx415.example.dtb: camera-sensor@1a: port:endpoint: 'link-frequencies' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230118103239.3409674-2-michael.riesch@wolfvision.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

