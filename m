Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60096D4557
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjDCNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjDCNKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:10:34 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697F10D7;
        Mon,  3 Apr 2023 06:10:33 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17aceccdcf6so30662084fac.9;
        Mon, 03 Apr 2023 06:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527432;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ZTdwXMG2el/ea1BKsWEd08tIXIZ8zFxXn8tPBkGQ5A=;
        b=hFNFr3zrv+30u3lqI/8aQAOvupX4RQ9rUCCak803vyLvtEv6Ce+k6aoiKoYtRp1rIk
         bAINr9sCe2uWiN3BhovIPZhhI5dWV5myWRjb8mhwHT12c56/4WA/z3QppCckq4CHbav5
         VzaGyzlsz22hdViZtX0A+dRpXsJDvR4u0S9oc9aEcoIv81knMOj4vSSqijxPOvuh5RiK
         VEtQZwEhrBT8ISg/RjEnojvzb5wGK8C3wwViRlJDGhIK5cOkmsDk8Pel4GWRRJWzTSGQ
         Mx4INjePS1/zuHbXKi8fgGjQqCidLMtDfT63N7RclO/vi/k86yRLcT0UX4ng58v+zXZT
         dCHQ==
X-Gm-Message-State: AAQBX9e3o/d1AaJMBPeluHFbkUhS3gwJwxlqjvilGNgUqT+GlpEklx5y
        TKGhm4gYfBBwUdC15zwOxA==
X-Google-Smtp-Source: AKy350bpXhr4xTknMKxWepZjrNZtrRCKwVKbMunz/PN41Xn3HTuhhAtDnaic+81eg7Onom6tpE9f9w==
X-Received: by 2002:a05:6870:4587:b0:176:3731:69 with SMTP id y7-20020a056870458700b0017637310069mr7607069oao.24.1680527432711;
        Mon, 03 Apr 2023 06:10:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id kw17-20020a056870ac1100b001802d3e181fsm3506534oab.14.2023.04.03.06.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:10:32 -0700 (PDT)
Received: (nullmailer pid 522008 invoked by uid 1000);
        Mon, 03 Apr 2023 13:10:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230403071929.360911-2-jstephan@baylibre.com>
References: <20230403071929.360911-1-jstephan@baylibre.com>
 <20230403071929.360911-2-jstephan@baylibre.com>
Message-Id: <168052512219.461959.16950455567862466256.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: add mtk-mipi-csi driver
Date:   Mon, 03 Apr 2023 08:10:30 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 09:19:28 +0200, Julien Stephan wrote:
> From: Florian Sylvestre <fsylvestre@baylibre.com>
> 
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../bindings/phy/mediatek,csi-phy.yaml        | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/mediatek,csi-phy.example.dtb: phy@10011800: reg: [[0, 268507136], [0, 96]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403071929.360911-2-jstephan@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

