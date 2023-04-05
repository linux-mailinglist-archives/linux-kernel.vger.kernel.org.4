Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564896D7C56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbjDEMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbjDEMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:22:44 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F2840D3;
        Wed,  5 Apr 2023 05:22:43 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso3637490ott.4;
        Wed, 05 Apr 2023 05:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680697363;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LeDwDvXYhfA2d71gl7rb1f+QkWdueZ1TNdSOE+YoWCs=;
        b=NYdptZnyHmJDDcVnZkzcrdfxt0fk5wdF7UDsOcgk69rH5uty+CAnVP1hafvmwaXi6r
         Cjai8sMSgIOHULC+uotNgXS6Li9xiNvDFWZEwwGLdZcurvr7ktBi675qfaeqa/A/RieR
         4x/wnYxTj4z1iFmURhFgffZpyXjcwEhCdAk6eqxSEfctcXsV3pV8pIUvXuuigZAEdYmz
         Z1ygHk2B4D+oCveQQyfjblBVFZ2cvvjPSWisAShNyiwkk6ERivOD8y965fzra78Z1JOY
         d1YVHvv2fbstA2ZGpu0cKMVXrHYjeUEOJN+Mg1uZujK2khbgoy97tipFR9vjMEHy2IqD
         /iQQ==
X-Gm-Message-State: AAQBX9dMGwjpA8eCgEJc6vwbQmahqAFbaebiqoc6w8Pauzl3wf2upWgQ
        LUyLBMtHePRr4ZVjzNa83ezphMMXkQ==
X-Google-Smtp-Source: AKy350advWfK1nMJuw8VfMt4TKtlETE0dqxbRHGp16j+kEQuzhMCVGrqjhHB4nYSAFOd2RPsHUhbEA==
X-Received: by 2002:a9d:744f:0:b0:69c:1ca2:90f2 with SMTP id p15-20020a9d744f000000b0069c1ca290f2mr2725647otk.13.1680697362651;
        Wed, 05 Apr 2023 05:22:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k17-20020a9d7dd1000000b0069f8ff38bcbsm6736083otn.16.2023.04.05.05.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:22:42 -0700 (PDT)
Received: (nullmailer pid 2357974 invoked by uid 1000);
        Wed, 05 Apr 2023 12:22:40 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
Message-Id: <168069726278.2356075.14351594478003012447.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass
 MSG RAM slice through phandle
Date:   Wed, 05 Apr 2023 07:22:40 -0500
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Apr 2023 12:48:34 +0200, Konrad Dybcio wrote:
> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
> use 'reg' to point to the MPM's slice of Message RAM without cutting into
> an already-defined RPM MSG RAM node used for GLINK and SMEM.
> 
> Document passing the register space as a slice of SRAM through the
> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml   | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dts:22.35-38.11: Warning (node_name_vs_property_name): /example-0/interrupt-controller: node name and property name conflict

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

