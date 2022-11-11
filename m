Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33E625B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiKKNa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiKKNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:30:26 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6395460359;
        Fri, 11 Nov 2022 05:30:25 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13c2cfd1126so5395096fac.10;
        Fri, 11 Nov 2022 05:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lo2p58cHEgV1SDnl6XTUQGUtHBgdDU1qqKkHovtNXaI=;
        b=49nrLbtqNjWXh0EjGzONm/Hug+gI8EVajt5pYYFtcQ82SU4evlqU7EbAYvP/3hV5vx
         L6llixEdSWzR8IXDZa336+q9WWSviYQU+hDXGNpsy32zRbw6tVH22VpEXs071zygXXFD
         +ThcCdJBBFJ5p8mGrZpIhHlVBgkJ+v0UCNHASWNCKVGjeTFB8jBERDRUJ+EQ/DWYtl9A
         E5WhM+j+dEdK0JlWjY11/1WBLH9QGyc16MFBLuE983Vos56H1eMjVJUuj6SEiXEkaVg/
         vhx6JUUgUA8BzWjpDl7fHDZjT2CzevrAVq3xEYriunrq/LnRhgT0xLTn/zwL+sh8Vpru
         zzeg==
X-Gm-Message-State: ANoB5pmZEmTKKuLfd6pSiJydFsFEYxoe2kRL2H5mEAG2qAxiKqeAdqu8
        r/g/OIh3NOnBCT69W3d8hA==
X-Google-Smtp-Source: AA0mqf71ZDnvJcVvYaHMWcT9ADtsziN74fdU+bu2Y8OC6CWAn6wtqLDgukiurl08AE4CGWhs2VIu8g==
X-Received: by 2002:a05:6870:1708:b0:13c:59d5:3f5e with SMTP id h8-20020a056870170800b0013c59d53f5emr879353oae.129.1668173424622;
        Fri, 11 Nov 2022 05:30:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g14-20020a4adc8e000000b004768f725b7csm798456oou.23.2022.11.11.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 05:30:24 -0800 (PST)
Received: (nullmailer pid 3073770 invoked by uid 1000);
        Fri, 11 Nov 2022 13:30:24 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@qti.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20221111113547.100442-3-krzysztof.kozlowski@linaro.org>
References: <20221111113547.100442-1-krzysztof.kozlowski@linaro.org>
 <20221111113547.100442-3-krzysztof.kozlowski@linaro.org>
Message-Id: <166817308876.3060199.17933327732327950670.robh@kernel.org>
Subject: Re: [PATCH 02/10] ASoC: dt-bindings: qcom,apr: Split services to
 shared schema
Date:   Fri, 11 Nov 2022 07:30:24 -0600
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


On Fri, 11 Nov 2022 12:35:39 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR nodes are organized like:
> 
>   apr-or-gpr-device-node <- qcom,apr.yaml
>     apr-gpr-service@[0-9] <- qcom,apr.yaml
>       service-specific-components <- /schemas/sound/qcom,q6*.yaml
> 
> The schema for services (apr-gpr-service@[0-9]) already grows
> considerably and is still quite not specific.  It allows several
> incorrect combinations, like adding a clock-controller to a APM device.
> Restricting it would complicate the schema even more.  Bringing new
> support for sound on Qualcomm SM8450 and SC8280XP SoC would grow it as
> well.
> 
> Simplify the qcom,apr.yaml by splitting the services to a shared file
> which will be:
> 1. Referenced by qcom,apr.yaml with additionalProperties:true,
> 2. Referenced by specific bindings for services with
>    additionalProperties:false (not yet in this commit).
> 
> While moving the code, add also required 'reg' and
> 'qcom,protection-domain' to further constrain the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,apr-services.yaml  |  54 +++++++++
>  .../bindings/soc/qcom/qcom,apr.yaml           | 108 +-----------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 58 insertions(+), 106 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/qcom/qcom,apr.example.dtb:0:0: /example-0/apr/service@3: failed to match any schema with compatible: ['qcom,q6core']
Documentation/devicetree/bindings/soc/qcom/qcom,apr.example.dtb:0:0: /example-0/apr/service@4: failed to match any schema with compatible: ['qcom,q6afe']
Documentation/devicetree/bindings/soc/qcom/qcom,apr.example.dtb:0:0: /example-0/apr/service@7: failed to match any schema with compatible: ['qcom,q6asm']
Documentation/devicetree/bindings/soc/qcom/qcom,apr.example.dtb:0:0: /example-0/apr/service@8: failed to match any schema with compatible: ['qcom,q6adm']
Documentation/devicetree/bindings/soc/qcom/qcom,apr.example.dtb:0:0: /example-1/gpr/service@1: failed to match any schema with compatible: ['qcom,q6apm']
Documentation/devicetree/bindings/sound/qcom,q6adm-routing.example.dtb:0:0: /example-0/apr/service@8: failed to match any schema with compatible: ['qcom,q6adm']
Documentation/devicetree/bindings/sound/qcom,q6asm-dais.example.dtb:0:0: /example-0/apr/service@7: failed to match any schema with compatible: ['qcom,q6asm']
Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.example.dtb:0:0: /example-0/apr/service@4: failed to match any schema with compatible: ['qcom,q6afe']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.example.dtb: gpr: service@2: 'qcom,protection-domain' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.example.dtb:0:0: /example-1/gpr/service@2: failed to match any schema with compatible: ['qcom,q6prm']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.example.dtb: gpr: service@1: 'qcom,protection-domain' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
Documentation/devicetree/bindings/sound/qcom,q6apm-dai.example.dtb:0:0: /example-0/gpr/service@1: failed to match any schema with compatible: ['qcom,q6apm']
Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.example.dtb:0:0: /example-0/apr/service@4: failed to match any schema with compatible: ['qcom,q6afe']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.example.dtb: gpr: service@1: 'qcom,protection-domain' is a required property
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-ports.example.dtb:0:0: /example-1/gpr/service@1: failed to match any schema with compatible: ['qcom,q6apm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

