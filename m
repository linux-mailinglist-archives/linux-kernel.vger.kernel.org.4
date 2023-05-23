Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB170D7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjEWIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjEWIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:36:58 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA141FED;
        Tue, 23 May 2023 01:34:55 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6af6df7f93aso2232498a34.0;
        Tue, 23 May 2023 01:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830895; x=1687422895;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fbuuelze6oX5JYOQ10a+DjnQCHnZU9fuAvZCu9bIt5c=;
        b=ZaRdzWERWur1bBUgPfNoY188xkhwUY3rPwaO0s32lUeTMs1LDsTmgn6uZoZ2k7W8Rg
         ZW3azk+sJ/SBStFpqKcIsLbRA844wx+rxdNoL8RjIw0WFbVuI3I6jaVMJRBas8IfuODI
         O8ThxJ8lXU4+26nsKZsA9K/PmfZIzw1fes7aT+r0gqmoWa9J5gZd/2zv3Oqd2JlAtKWC
         phP7tge7IP9fDjdH8MLbTMyAoV3uxxxG3o/eGpGgBShUVAS3CgeJjK7FcI4tRx1VfrBq
         I7aBtFzU1L/WUD/iKOuFIm1/BP/NAPk1uaFtXIkIKoNfuD7SmSS+hbpdO7/X6itxQE1f
         iYkA==
X-Gm-Message-State: AC+VfDz5O5S4yRWb9LB8AkJhWo85ke3T7xhfhdyugfASC/7eyFygKg+2
        jq+2485YubwDUB3ErxNhNw==
X-Google-Smtp-Source: ACHHUZ7/tT2ff11MVD89mp0Uq6HgcF9rMmy1Is5kbzuJKiVecR9PIqUjz5MCk5++W0yN001aVxjPUQ==
X-Received: by 2002:a9d:6b11:0:b0:6af:85fd:ffff with SMTP id g17-20020a9d6b11000000b006af85fdffffmr2136294otp.25.1684830894792;
        Tue, 23 May 2023 01:34:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q25-20020a9d7c99000000b006aaf82bd5a2sm3258395otn.43.2023.05.23.01.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 01:34:54 -0700 (PDT)
Received: (nullmailer pid 140433 invoked by uid 1000);
        Tue, 23 May 2023 08:34:52 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        David Airlie <airlied@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        freedreno@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        Marijn Suijten <marijn.suijten@somainline.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org>
Message-Id: <168483089214.140382.17835176497108911988.robh@kernel.org>
Subject: Re: [PATCH v5 04/12] dt-bindings: display/msm: Add SM6350 MDSS
Date:   Tue, 23 May 2023 03:34:52 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 May 2023 09:46:15 +0200, Konrad Dybcio wrote:
> Document the SM6350 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 214 +++++++++++++++++++++
>  1 file changed, 214 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,sm6350-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
	'qcom,sm6350-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm6115-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	'qcom,sm6350-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.example.dtb: dsi@ae94000: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v5-4-998b4d2f7dd1@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

