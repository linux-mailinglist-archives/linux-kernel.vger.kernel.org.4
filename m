Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19ED672E08
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjASBWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjASBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:20:05 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E276CCF6;
        Wed, 18 Jan 2023 17:16:56 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id d188so540544oia.3;
        Wed, 18 Jan 2023 17:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z3r1JR3MPSsFBpDWpSJ61vE3nIfb3dVZfnc0GIpbrWQ=;
        b=evVddWvaVN+SXAZEYcX2rKEpj7sx7HJf3Srqy6k5Oop1NwQMXqSqUEMpq91R/d/vV2
         vzwwFm1oFrAjLhkhl8InXqMDwzqYFjYxFd9mO7QYuNIfYa6oazV9IdCEZxIn8ce9bj/p
         BlLfYWTHMsQom5BGBupckDKoSamZ+3xIK7eFLvsEanQiXQ4i3F6OQr1OKAlygoXAgVJ9
         1E4zbaywsW5vyRhOGpWl7DukCV0o7O4fpizukAsCdlpK92/tOczJ0jHF9JtmQRPFDew8
         cKQW7sQ9Y4IqQusXve5ubRoxoDd+eaIfLOe+RpXnBJ7FYRoF1dZpXceXafpXVcS1K8A9
         A1qQ==
X-Gm-Message-State: AFqh2kqkcbZtWNewWkZw1w9OMzwHQoaCF51ZuEgAjlumelRo2q4oc1sg
        U8/DjOUJ9lvn9Rl2E9wseBDT1HPqbA==
X-Google-Smtp-Source: AMrXdXtzdGuzM2xjuyJk74WyjD1MxXFw6y69PVYfiCmiJk6lZ/KGyd6qJxoZ1ER0uDYmhmc0ENYnXg==
X-Received: by 2002:a05:6808:1a2a:b0:35e:66a4:1b19 with SMTP id bk42-20020a0568081a2a00b0035e66a41b19mr5883257oib.8.1674091015714;
        Wed, 18 Jan 2023 17:16:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0602000000b0036508145326sm5878098oig.9.2023.01.18.17.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 17:16:55 -0800 (PST)
Received: (nullmailer pid 12835 invoked by uid 1000);
        Thu, 19 Jan 2023 01:16:53 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     javierm@redhat.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_sbillaka@quicinc.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_abhinavk@quicinc.com, lucas.demarchi@intel.com,
        konrad.dybcio@somainline.org, manasi.d.navare@intel.com,
        robdclark@gmail.com, marex@denx.de, maxime@cerno.tech,
        ankit.k.nautiyal@intel.com, arun.r.murthy@intel.com,
        quic_khsieh@quicinc.com, ashutosh.dixit@intel.com,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        tvrtko.ursulin@linux.intel.com, bhanuprakash.modem@intel.com,
        jose.souza@intel.com, rodrigo.vivi@intel.com,
        linux-arm-msm@vger.kernel.org, quic_jesszhan@quicinc.com,
        tzimmermann@suse.de, joonas.lahtinen@linux.intel.com,
        stanislav.lisovskiy@intel.com, swati2.sharma@intel.com,
        ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, sean@poorly.run,
        Mark Yacoub <markyacoub@chromiu.org>,
        bjorn.andersson@linaro.org, agross@kernel.org,
        dmitry.baryshkov@linaro.org, matthew.d.roper@intel.com,
        abhinavk@codeaurora.org, intel-gfx@lists.freedesktop.org,
        daniel@ffwll.ch, lyude@redhat.com, hbh25y@gmail.com,
        robh+dt@kernel.org, airlied@gmail.com, imre.deak@intel.com,
        christophe.jaillet@wanadoo.fr, johan+linaro@kernel.org,
        andersson@kernel.org, jani.nikula@linux.intel.com
In-Reply-To: <20230118193015.911074-9-markyacoub@google.com>
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-9-markyacoub@google.com>
Message-Id: <167409094385.4360.15863185798758300987.robh@kernel.org>
Subject: Re: [PATCH v6 08/10] dt-bindings: msm/dp: Add bindings for HDCP registers
Date:   Wed, 18 Jan 2023 19:16:53 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 19:30:13 +0000, Mark Yacoub wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch adds the bindings for the MSM DisplayPort HDCP registers
> which are required to write the HDCP key into the display controller as
> well as the registers to enable HDCP authentication/key
> exchange/encryption.
> 
> We'll use a new compatible string for this since the fields are optional.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromiu.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-13-sean@poorly.run #v1
> Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-13-sean@poorly.run #v2
> Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-13-sean@poorly.run #v3
> Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-13-sean@poorly.run #v4
> Link: https://patchwork.freedesktop.org/patch/msgid/20211115202153.117244-1-sean@poorly.run #v4.5
> Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-9-sean@poorly.run #v5
> 
> Changes in v2:
> -Drop register range names (Stephen)
> -Fix yaml errors (Rob)
> Changes in v3:
> -Add new compatible string for dp-hdcp
> -Add descriptions to reg
> -Add minItems/maxItems to reg
> -Make reg depend on the new hdcp compatible string
> Changes in v4:
> -Rebase on Bjorn's multi-dp patchset
> Changes in v4.5:
> -Remove maxItems from reg (Rob)
> -Remove leading zeros in example (Rob)
> Changes in v5:
> -None
> Changes in v6:
> -Rebased: modify minItems instead of adding it as new line.
> 
> ---
>  .../devicetree/bindings/display/msm/dp-controller.yaml    | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.example.dtb: displayport-controller@ae90000: reg: [[183042048, 512], [183042560, 512], [183043072, 3072], [183046144, 1024], [183047168, 1024], [183308288, 372], [183373824, 44]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.example.dtb: edp@aea0000: reg: [[183107584, 512], [183108096, 512], [183108608, 3072], [183111680, 1024]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/dp-controller.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230118193015.911074-9-markyacoub@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

