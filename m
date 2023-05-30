Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2315715F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjE3M1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjE3M13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:27:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFF511C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:27:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso7971058a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449616; x=1688041616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stytcPLfmtfo2fgiuSzdRWfNyIk7zVG1HeYjVvCDz9w=;
        b=gfCtr7jZXqESNbxzXiO43l3qqczxibfd/8w9kd1Ym8YdWhXyG+fyLdmQMpEwRJKnLX
         9CDjSBYhIeVFltkeDw6O7TZhpN4ll73Ic+iWAWQazQlPM/ceWi/cDavmggYTsBKvUASV
         M6XloXq9jSWBv2+6ermKsbpEfF9PDrvNQ5TfLnbNOBsaXF4WOoln+deS7pYJ+eRfKA2W
         FsjnppkAX32eN6OEzpNHzIxIwiHZBKMlK7lyRfmgHUD5DcyxstEfzXndYdKrIJNjIKsA
         Ll+gsI3BBLsHgdonbzLUfx83IhNiMrctNLGvHNsMHAicOLaLYPIyyfHbosoQGidJXN57
         hMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449616; x=1688041616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stytcPLfmtfo2fgiuSzdRWfNyIk7zVG1HeYjVvCDz9w=;
        b=AQJynkawjlRFNNzXwUuuyS0tEj3ON935LxBl0RZT7a8hcywuXQwAxXKgfMOQh3Wct8
         96yG6gmrHEsxXDQzOs23fFj0L/uXxoEd0ha8tDUUnVR5Fpoq2tFGcnLA0Lmw7gxmimw/
         5FbRo0RkMYler8bZcGVXrS+b3344IaqmzDuhRG2NMYKfJGf6e7KwaEyaGxCVrwmLsLlm
         7N64pbNyxwaCUoPT4tmXiOng2bYjTXfkG2ckfA9qaCVYrhunklWAJy5+3Md3pai7gyO5
         fFzKWdzATdhSrCgwlk5q+KIW3e63Iv/NZTIgXhLF+odEg6TuJULl+SjYG4FHbgmUBYec
         Q8LQ==
X-Gm-Message-State: AC+VfDwkfpb2+UMGLrPRKt+TB+cQZ9rCvusnccrCfi/JU3Dz4L03sGW1
        xXcsXE4GTur4Mtv10F2Q0oCL8Q==
X-Google-Smtp-Source: ACHHUZ66izEDUSaQQp76hTrSWMdC6fb+uAdYBYs6F5ndxLqGKRKd2/soK1F7uCXH6BQ11yXPM73REg==
X-Received: by 2002:a05:6402:693:b0:506:83fc:2dab with SMTP id f19-20020a056402069300b0050683fc2dabmr1537814edy.22.1685449616416;
        Tue, 30 May 2023 05:26:56 -0700 (PDT)
Received: from krzk-bin ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id z4-20020aa7d404000000b0050bc9ffed66sm4302283edq.53.2023.05.30.05.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:26:55 -0700 (PDT)
Date:   Tue, 30 May 2023 14:26:52 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v8 01/18] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
Message-ID: <20230530122652.lct6tk6zseny6gxl@krzk-bin>
References: <20230223-topic-gmuwrapper-v8-0-69c68206609e@linaro.org>
 <20230223-topic-gmuwrapper-v8-1-69c68206609e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230223-topic-gmuwrapper-v8-1-69c68206609e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 15:52:20 +0200, Konrad Dybcio wrote:
> The "GMU Wrapper" is Qualcomm's name for "let's treat the GPU blocks
> we'd normally assign to the GMU as if they were a part of the GMU, even
> though they are not". It's a (good) software representation of the GMU_CX
> and GMU_GX register spaces within the GPUSS that helps us programatically
> treat these de-facto GMU-less parts in a way that's very similar to their
> GMU-equipped cousins, massively saving up on code duplication.
> 
> The "wrapper" register space was specifically designed to mimic the layout
> of a real GMU, though it rather obviously does not have the M3 core et al.
> 
> GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
> specified under the GPU node, just like their older cousins. Account
> for that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/gpu.yaml       | 61 ++++++++++++++++++----
>  1 file changed, 52 insertions(+), 9 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1787121


gpu@2c00000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/qcom/sm8150-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8150-mtp.dtb
