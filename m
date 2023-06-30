Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16EA743ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF3LYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjF3LX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:23:59 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C9C0;
        Fri, 30 Jun 2023 04:23:58 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-345a41cebc5so7570895ab.2;
        Fri, 30 Jun 2023 04:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688124237; x=1690716237;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qTDuY1fub/AlYVcXZL8jYlsmiEw4GE6gVtFVz9G9Nys=;
        b=O9zu7IgwB7UzYsxeosCq1x/73YqRVSx0cKp6HxfFhi0FN/q7Duwipn0XJpHXCUIqbe
         8jzXR4T5DOGPsS1iKUi4hkIjbwCCErgI4BaaNNCroNHF7J/d3CHF3lTpb/tGMUhmmsJG
         F+4ZKOoAjUWkoRPSMFIlmTS98m53j3iI5hSuUiYVwlZbkK1jTsqP4tbDUtHB+aWuCnT4
         32/G+AaA8vDikjmnynfxbz/7HfJvtYwIlEkN0OyC/eIBycyscXnbPbPIQg9z2OYQr5rT
         mg6+4BW18MkSQB6wM/E0qMMTpKqLy8lsqImyo53CDETPbfp0Vk+klOKZeMS37nuBMUJ1
         hH6A==
X-Gm-Message-State: AC+VfDznIyWFnU8YvAV6mySvnanBoUL2yT8JhYNIY+le+BgHRLuT1BF8
        qS9+p5oufGQSZCuE2FsaBzhWKbNdUw==
X-Google-Smtp-Source: ACHHUZ7DcLDIREaS/YBHqwtSxRlaLvmAB1fHHkDnsf1HSnobtWWdY9D3unVpsCudqGOJcAmi/2q4tw==
X-Received: by 2002:a05:6602:3056:b0:783:67a3:a69f with SMTP id p22-20020a056602305600b0078367a3a69fmr2672870ioy.18.1688124237219;
        Fri, 30 Jun 2023 04:23:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e15-20020a056638020f00b0042ae858d84dsm2191300jaq.88.2023.06.30.04.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:23:56 -0700 (PDT)
Received: (nullmailer pid 1082765 invoked by uid 1000);
        Fri, 30 Jun 2023 11:23:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Phi-Bang Nguyen <pnguyen@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230630100321.1951138-2-jstephan@baylibre.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-2-jstephan@baylibre.com>
Message-Id: <168812423326.1082703.10045152844736741396.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: media: add mediatek ISP3.0 sensor
 interface
Date:   Fri, 30 Jun 2023 05:23:54 -0600
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


On Fri, 30 Jun 2023 12:01:50 +0200, Julien Stephan wrote:
> From: Louis Kuo <louis.kuo@mediatek.com>
> 
> This adds the bindings, for the mediatek ISP3.0 SENINF module embedded in
> some Mediatek SoC, such as the mt8365
> 
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-Bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../media/mediatek,mt8365-seninf.yaml         | 295 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 302 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.example.dts:28:18: fatal error: dt-bindings/power/mediatek,mt8365-power.h: No such file or directory
   28 |         #include <dt-bindings/power/mediatek,mt8365-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230630100321.1951138-2-jstephan@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

