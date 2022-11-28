Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1774B63A82A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiK1MXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiK1MWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:22:48 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067621A803;
        Mon, 28 Nov 2022 04:20:52 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id v82so11336552oib.4;
        Mon, 28 Nov 2022 04:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+FPo2WMjz1oPDzlV6ADoN3PSIwjDDQpgyYjmLqfyYX4=;
        b=sUK+eIySREnpIzIcPt3fuvCiRKq2EQ6CPFUlQP5UksWUEGHAAd0gOKbUj2YDdn7Kab
         IMrSUqzGRITO6gvHtrpRKxghb9PHhFkncZFcj4ET2LxVZZB+7Lw0PZXMkcyD1+e+iRoY
         pU/lhlNLmnnwygbui92UBDfKQ1JIJinQczR92KyRh23OpPwYvAy2F1X5nrGd24V6xrJp
         e1xvvowlYp+PBbB4uZN7hLOHNldvbBlsTAENy86ixsIeCdfp/1yvTuwD/vzx4ZIZowlt
         qRD5q7IE4yL8ZnjEh1dffF4RPJe8eQWB15am19DsQ9RH/NINuYUgS0PTQAg2KyahkK8k
         HSIg==
X-Gm-Message-State: ANoB5pki9vcWqWP8NqgMG1WsC0kEgPXdHYqk3E5WE3dX49OLfTxvlNDU
        HgEt2Z1twQl9qCgSc9XSpMDJp78ngQ==
X-Google-Smtp-Source: AA0mqf726uGB6ogpr3Btlm8KuLBoxYKdgRYv9DIjeQ+3++fQwmGhSRWBEq9qcHeRZ3+S2KCe9EqMhw==
X-Received: by 2002:a05:6808:159a:b0:35a:f68e:7ddf with SMTP id t26-20020a056808159a00b0035af68e7ddfmr15811418oiw.34.1669638051227;
        Mon, 28 Nov 2022 04:20:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a11-20020a544e0b000000b00359ba124b07sm4281045oiy.36.2022.11.28.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:20:50 -0800 (PST)
Received: (nullmailer pid 477524 invoked by uid 1000);
        Mon, 28 Nov 2022 12:20:47 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, bin.zhang@mediatek.com,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        devicetree@vger.kernel.org
In-Reply-To: <20221128020613.14821-9-xiangsheng.hou@mediatek.com>
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
 <20221128020613.14821-9-xiangsheng.hou@mediatek.com>
Message-Id: <166963790318.472861.17415602940881967423.robh@kernel.org>
Subject: Re: [PATCH 8/9] dt-bindings: mtd: Split ECC engine with rawnand controller
Date:   Mon, 28 Nov 2022 06:20:47 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Nov 2022 10:06:12 +0800, Xiangsheng Hou wrote:
> Split MediaTek ECC engine with rawnand controller and convert to
> YAML schema.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  .../bindings/mtd/mtk,nand-ecc-engine.yaml     |  60 ++++++
>  .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
>  .../devicetree/bindings/mtd/mtk-nand.yaml     |  92 +++++++++
>  3 files changed, 152 insertions(+), 176 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mtk,nand-ecc-engine.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtk-nand.yaml: properties:clock-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'nfi_clk'}, {'const': 'pad_clk'}] is too long
	[{'const': 'nfi_clk'}, {'const': 'pad_clk'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtk-nand.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'clock used for the controller'}, {'description': 'clock used for the pad'}] is too long
	[{'description': 'clock used for the controller'}, {'description': 'clock used for the pad'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtk,nand-ecc-engine.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'clock used for the controller'}] is too short
	False schema does not allow 1
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtk-nand.example.dtb: nfi@1100d000: $nodename:0: 'nfi@1100d000' does not match '^nand-controller(@.*)?'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/mtk-nand.yaml

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mtd/mtk-nand.txt
MAINTAINERS: Documentation/devicetree/bindings/mtd/mtk-nand.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221128020613.14821-9-xiangsheng.hou@mediatek.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

