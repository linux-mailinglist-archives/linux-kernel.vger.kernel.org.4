Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC323725D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbjFGLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjFGLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:37:24 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7719BB;
        Wed,  7 Jun 2023 04:37:23 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-777a4c8e8f4so203632839f.3;
        Wed, 07 Jun 2023 04:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137842; x=1688729842;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8tVLF3oo3uKUn6FMXIR+EBqzz0+rlaJwE4+IHvkQcKQ=;
        b=GE4HQzr+WQ/Ou354srDXnqm8Tl1rbNktwoI9TDdvu51tFcB4CoF8VsGg/IuSLpWeds
         CqJL3bKWHQBS44DehCMy1xMyuvI1Yd6+MGFPih9Fl0ygzlBezx9CKFoRzuCCKPJKQlDN
         JZvWWAnuaRH4N9p7yW+dgeh9A0Gkto7pMH/t5xZEzR4vyi9b7VyYHNZAeQ7OjVkc9qYw
         5Zz+n0n7muaFvrPOUrooZzowPb5Et8O5W/S8E8NzwO1QjSAL+BemlIW+nD8rkHnM2aFz
         Yzivno0Zfxdmbsu3Y08KZtsYzHNEBENXMNbb9bNo8Fzi9jrquOTKs13l6hvXpneuLvAr
         /VuQ==
X-Gm-Message-State: AC+VfDwtlDZRot3r1zqW3fHX+sAcjTdVYqDD89eCuXJ5oVNbtf9Y55FR
        Svf5cXVMdV+m9nc6I/yYlA==
X-Google-Smtp-Source: ACHHUZ6P8ByJI192iIT0XJCH5ARhEmICRsd0dY/7p8qVdOEm4v8Q0JbvfTPPwjTUdaXSq+rmyhDQMg==
X-Received: by 2002:a6b:5917:0:b0:77a:c00c:1166 with SMTP id n23-20020a6b5917000000b0077ac00c1166mr2267103iob.15.1686137842688;
        Wed, 07 Jun 2023 04:37:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j14-20020a02cb0e000000b0041a84d0c828sm3461406jap.87.2023.06.07.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 04:37:21 -0700 (PDT)
Received: (nullmailer pid 2576907 invoked by uid 1000);
        Wed, 07 Jun 2023 11:37:18 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, rafal@milecki.pl,
        sboyd@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        mturquette@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, will@kernel.org, nfraprado@collabora.com,
        linux-clk@vger.kernel.org, andersson@kernel.org,
        linux-usb@vger.kernel.org, konrad.dybcio@linaro.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com,
        conor+dt@kernel.org, broonie@kernel.org, geert+renesas@glider.be,
        quic_wcheng@quicinc.com, kishon@kernel.org,
        quic_varada@quicinc.org, catalin.marinas@arm.com, vkoul@kernel.org
In-Reply-To: <14f60578e2935c0844537eab162af3afa52ffe39.1686126439.git.quic_varada@quicinc.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <14f60578e2935c0844537eab162af3afa52ffe39.1686126439.git.quic_varada@quicinc.com>
Message-Id: <168613783895.2576884.16624801522897027540.robh@kernel.org>
Subject: Re: [PATCH 2/9] dt-bindings: phy: qcom,m31: Document qcom,m31 USB
 phy
Date:   Wed, 07 Jun 2023 05:37:18 -0600
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


On Wed, 07 Jun 2023 16:26:06 +0530, Varadarajan Narayanan wrote:
> Document the M31 USB2 phy present in IPQ5332
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,m31.yaml          | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,m31.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,m31.example.dtb: hs_m31phy@5b00: status:0: 'ok' is not one of ['okay', 'disabled', 'reserved']
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/14f60578e2935c0844537eab162af3afa52ffe39.1686126439.git.quic_varada@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

