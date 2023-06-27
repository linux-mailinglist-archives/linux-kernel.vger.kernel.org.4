Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0022C7405FA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjF0V4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0V4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:56:36 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897E198;
        Tue, 27 Jun 2023 14:56:35 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77797beb42dso179776939f.2;
        Tue, 27 Jun 2023 14:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687902994; x=1690494994;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=64oZsUuru0HA89uc2YjHgtD5IZLSgmyXIIjxqeMMqhk=;
        b=i0nbbJEuMjCDDxF6C/AmP4FAR/KWe90mk7KfM3iEACy7+Mzd3ZWQNGxyAshNM7CI0q
         Cp0Xtx72x+PTmKtaE2U+WfSCVFsSFQPFtS5b82whNIi9mQrzXUA/ELPg8TpzcUOYHq9j
         tRC1meUz/Fif2dIzpGwcSg+5szWQJAWVKuj5s/YhM4oBQ+ROGNwRVDKwS0JHMTBfRuhb
         UMyoJGCf2c6bLjHrBHN5bzcOPicpyNs9+FFHTXlLXwAFnYWUjWSj7GvTK5233dQZNG83
         CdcHLGhf/rQTYbkY52Z/99Yen0mDCnNykezqevjzPwDze+lIv9hlg4rQjemRDTBpNpp+
         bKyA==
X-Gm-Message-State: AC+VfDxw5o9US1tBel9YAJITReJwMQkmB9Z0Xg42gL/0/q6ilpFfAlop
        M6ngb4YnFhy+gbvewMLkTA==
X-Google-Smtp-Source: ACHHUZ7DUHS4TrojiJZ3NsBw35j/fMK1gmtN5i++5TIkcjGsL3oli58Kt42Pzl3zrM/8ZzqRDjcw8A==
X-Received: by 2002:a6b:6604:0:b0:785:d017:c16f with SMTP id a4-20020a6b6604000000b00785d017c16fmr1419772ioc.14.1687902994173;
        Tue, 27 Jun 2023 14:56:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k26-20020a02a71a000000b004182f88c368sm37736jam.67.2023.06.27.14.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:56:33 -0700 (PDT)
Received: (nullmailer pid 3087346 invoked by uid 1000);
        Tue, 27 Jun 2023 21:56:30 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Sean Paul <sean@poorly.run>,
        Loic Poulain <loic.poulain@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230627-sm6125-dpu-v2-7-03e430a2078c@somainline.org>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-7-03e430a2078c@somainline.org>
Message-Id: <168790299021.3087309.11039202845199087454.robh@kernel.org>
Subject: Re: [PATCH v2 07/15] dt-bindings: display/msm: Add SM6125 MDSS
Date:   Tue, 27 Jun 2023 15:56:30 -0600
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


On Tue, 27 Jun 2023 22:14:22 +0200, Marijn Suijten wrote:
> Document the SM6125 MDSS.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../bindings/display/msm/qcom,sm6125-mdss.yaml     | 217 +++++++++++++++++++++
>  1 file changed, 217 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.example.dtb: dsi@5e94000: compatible: 'oneOf' conditional failed, one must be fixed:
	['qcom,sm6125-dsi-ctrl', 'qcom,mdss-dsi-ctrl'] is too long
	'qcom,sm6125-dsi-ctrl' is not one of ['qcom,apq8064-dsi-ctrl', 'qcom,msm8916-dsi-ctrl', 'qcom,msm8953-dsi-ctrl', 'qcom,msm8974-dsi-ctrl', 'qcom,msm8996-dsi-ctrl', 'qcom,msm8998-dsi-ctrl', 'qcom,qcm2290-dsi-ctrl', 'qcom,sc7180-dsi-ctrl', 'qcom,sc7280-dsi-ctrl', 'qcom,sdm660-dsi-ctrl', 'qcom,sdm845-dsi-ctrl', 'qcom,sm6115-dsi-ctrl', 'qcom,sm8150-dsi-ctrl', 'qcom,sm8250-dsi-ctrl', 'qcom,sm8350-dsi-ctrl', 'qcom,sm8450-dsi-ctrl', 'qcom,sm8550-dsi-ctrl']
	'qcom,sm6125-dsi-ctrl' is not one of ['qcom,dsi-ctrl-6g-qcm2290', 'qcom,mdss-dsi-ctrl']
	from schema $id: http://devicetree.org/schemas/display/msm/dsi-controller-main.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230627-sm6125-dpu-v2-7-03e430a2078c@somainline.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

