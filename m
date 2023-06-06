Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74272492C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjFFQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjFFQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:31:15 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C76E5E;
        Tue,  6 Jun 2023 09:31:13 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-777a2ef8d45so87067739f.2;
        Tue, 06 Jun 2023 09:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069073; x=1688661073;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uIlYPrPU4dkUuCJZtH84I2P2nXchZ3N7ZljUgdNofXc=;
        b=lmhq48mfr7az0T1bvVNzg8NSZrzuyaeELkcbZOnSoKMxwI/5qKse6YOsrdibLDXa0O
         SYJYxUi+/QhQ/dQaRA+1hlgBNTlOTi1IrbEQ9um1ZRyNlreyxX3ubvfC8+PwKctZwDgk
         eGoIdjD+rBRNZXj0q7Ba4yKLdHgOhJTKbf/nRSjSzmSS9h5miChPwFHy5eTBNCMOH97D
         u1RtYds26qzIfRyCobHokLg+tpK/DyUxt0sF6DHKew6AcrWly+HxmeWniB3OasjBG8QM
         ZVSkO8cQDaq9t6tOB+WUemw5k0RDmmnDRPq3Vbj1NTKdwkUtC2sdE5H9PbheP4R2OU5B
         Bjzg==
X-Gm-Message-State: AC+VfDw0g0NHRbZgOl9xzGvRBc1ZEMxr6N0PWIGy9qtda/bQSfo820HK
        6jAypNSxVuiB4jEnw3tj7A==
X-Google-Smtp-Source: ACHHUZ5YaKV6ltGNBSIVEA6pKe8GG7o5qDqUgS3BzZlJLxxPPCjy1Uj3X1HIRjZYojaUX2vpQd2N+g==
X-Received: by 2002:a5e:cb42:0:b0:774:9a92:f1c9 with SMTP id h2-20020a5ecb42000000b007749a92f1c9mr3114301iok.19.1686069072805;
        Tue, 06 Jun 2023 09:31:12 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dl2-20020a056638278200b00420b863fd5dsm296856jab.97.2023.06.06.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 09:31:12 -0700 (PDT)
Received: (nullmailer pid 978235 invoked by uid 1000);
        Tue, 06 Jun 2023 16:31:09 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     martin.hecht@avnet.eu, linux-media@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linuxfancy@googlegroups.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        jacopo.mondi@ideasonboard.com, michael.roeder@avnet.eu,
        =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Nicholas Roth <nicholas@rothemail.net>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        laurent.pinchart@ideasonboard.com,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230606155416.260941-3-tomm.merciai@gmail.com>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-3-tomm.merciai@gmail.com>
Message-Id: <168606906960.978218.13949721603779503286.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] media: dt-bindings: alvium: add document YAML
 binding
Date:   Tue, 06 Jun 2023 10:31:09 -0600
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


On Tue, 06 Jun 2023 17:54:03 +0200, Tommaso Merciai wrote:
> Add documentation of device tree in YAML schema for the ALVIUM
> Camera from Allied Vision Inc.
> 
> References:
>  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
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
>  .../media/i2c/alliedvision,alvium-csi2.yaml   | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230606155416.260941-3-tomm.merciai@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

