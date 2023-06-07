Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE967262A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbjFGOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjFGOUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:20:50 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75D137;
        Wed,  7 Jun 2023 07:20:48 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7747df5b674so314526139f.3;
        Wed, 07 Jun 2023 07:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147648; x=1688739648;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qwtf9R9VSv+Y8I0XvnZ+/3g2Cp2SZQu2rYgqlynwAcI=;
        b=OfCTvRpgmm4+vLkaf/NQpTveRc3FCOvpofRwetlXTa8hb7U56rdlBwPGgVpIbe9vyf
         53zQtHOhJNQ7SNtli7yz9tv3D5BzU1OcJMthTuEnzjP6rnChDu3MRnegYOK0JdIm8Mnb
         vkSeXDjLTGLRJLigV1kCNX2HpjMsQPo/39bO0K1+jiQ8J7M2zlUHHzZ6wGH9MTgoG8CV
         ZlN8p9F2ezAZ9wuk5Sk/cL/4/+y7gZsQnUPD09Su9gEr7SpMcBgLqaGqAwvN72rWDx87
         yog16Hzaqm7jwBo5SG4+4c5bDCF4kR9wUzEcHI/NqNWP7Oq9WxSem01Y4I7kKCDtfXUy
         QNEw==
X-Gm-Message-State: AC+VfDzr9h13OuZQ1twPQYyI9xpRbCc2Ts6Pk/IVk+4uPQNQ1D5hMLsb
        jjCjNpZH1rAg9EgDAPX/nL0GCwj5fA==
X-Google-Smtp-Source: ACHHUZ5xYGAA8MJty/IEsZp0yPmtoVPUUviakCuG4nBM9YuwbDWA56sxdqrmdni+Sf4I48rT/OXrqg==
X-Received: by 2002:a5e:a909:0:b0:74c:c6ed:6de with SMTP id c9-20020a5ea909000000b0074cc6ed06demr8800515iod.12.1686147648114;
        Wed, 07 Jun 2023 07:20:48 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f9-20020a056638118900b00418ad0ca629sm1427219jas.49.2023.06.07.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:20:47 -0700 (PDT)
Received: (nullmailer pid 3072441 invoked by uid 1000);
        Wed, 07 Jun 2023 14:20:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Mark Brown <broonie@kernel.org>, michael.roeder@avnet.eu,
        martin.hecht@avnet.eu, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linuxfancy@googlegroups.com,
        jacopo.mondi@ideasonboard.com, Conor Dooley <conor+dt@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        laurent.pinchart@ideasonboard.com,
        Mikhail Rudenko <mike.rudenko@gmail.com>
In-Reply-To: <20230607131936.382406-3-tomm.merciai@gmail.com>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
Message-Id: <168614764466.3072404.16058504735971429157.robh@kernel.org>
Subject: Re: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML
 binding
Date:   Wed, 07 Jun 2023 08:20:44 -0600
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


On Wed, 07 Jun 2023 15:19:24 +0200, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the ALVIUM
> Camera from Allied Vision Inc.
> 
> References:
>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v1:
>  - Fixed build error as suggested by RHerring bot
> 
> Changes since v2:
>  - Fixed License as suggested by KKozlowski/CDooley
>  - Removed rotation property as suggested by CDooley/LPinchart
>  - Fixed example node name as suggested by CDooley
>  - Fixed title as suggested by LPinchart
>  - Fixed compatible name as suggested by LPinchart
>  - Removed clock as suggested by LPinchart
>  - Removed gpios not as suggested by LPinchart
>  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
>  - Fixed vendor prefix, unit append as suggested by KKozlowski
>  - Fixed data-lanes
>  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
>  - Dropped status into example  as suggested by KKozlowski
>  - Added vcc-ext-in supply as suggested by LPinchart
>  - Dropped pinctrl into example as suggested by LPinchart
> 
> Changes since v3:
>  - Fixed vcc-ext-in-supply description as suggested by LPinchart
>  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
>  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
>  - Collected Reviewed-by tag from LPinchart
> 
>  .../media/i2c/alliedvision,alvium-csi2.yaml   | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230607131936.382406-3-tomm.merciai@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

