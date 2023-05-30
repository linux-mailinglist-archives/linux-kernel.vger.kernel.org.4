Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586E47160E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjE3NAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjE3M7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:59:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A737115
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:59:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f99222e80so914066066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685451565; x=1688043565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJKVtkQkQoC4E9Aq5P1zai4vqqsMy8w6t211JaxwDCU=;
        b=EduhXg0vsAisfGwJuKPj3SLiJgITAVJmRg5G/6Ql+7WOtJ7zUJevpiepbuNgYqkDFC
         0GsX4/It5j/OFt+Mq/VhrtN9ysbiLmBkm5gVGLYghScaAzhWePvqJdk2Ix1CTAsk7dWN
         p4ij+/Fq9oCLp0Gi/upuWJa+66dJA8YtC7cAN5V5l6tRW/cqgWwR/z3tK7Y17U931z6B
         /yjiL4jEIlwoWfmBat6/90A1b/ilP3oXDAWvlJrZKF2Zcxrep2Er1OJwdNOgHVvIV5Fz
         ZuOGvfxeH7LvRcE4kkYWgtMTNRqjURacLlCk/MmnlE9kQx8ZTcZOZA/8lojCB9lLuUHN
         OsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451565; x=1688043565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJKVtkQkQoC4E9Aq5P1zai4vqqsMy8w6t211JaxwDCU=;
        b=erWBojOOkP+BDQMY9xMZ3FcbAwKjZfQgPaSeMrzVaXmzBVns87WIFNAhNVlq33idRI
         ku2mGchzJLykqVwzxPVGU0qMr8D+tyArZkvSYNjyUj+h9pszQVTDJ+VHaEIy/Jvesytp
         +45B318o0PbTHQe/haJpsIE1gHjAGcNW3lv/HMZBek5sq1BaXvlXt3JuJziBwp21DxY/
         Jd04mt7il/VHgdIdMbEhZmy2fXuUjc+ptRBdKiD6ZxIeyrVvru8xY/u74xUirmIO+l34
         gXUhBh+Asrot6yxV9ezFx/W7j2jDvO3R1xGmLq1Ieb29YBj4a1Oex997En/dwRVhz3M1
         LLsA==
X-Gm-Message-State: AC+VfDw1nKF6ABUMNbnSpvmpVjks6N9Vi//r7pzPw+Djh+XzVPPCL48s
        gPzjmaUbcIyRrEjptwIvHp6M3g==
X-Google-Smtp-Source: ACHHUZ7sG1jHvP1ouiV/MHYG37LTy7wih8YNLIQsIFYJ+2JNQM0VSKF1FQl4S03+1Ik1p8l5H1S7yg==
X-Received: by 2002:a17:907:868c:b0:967:4bc7:38c0 with SMTP id qa12-20020a170907868c00b009674bc738c0mr2120189ejc.9.1685451561717;
        Tue, 30 May 2023 05:59:21 -0700 (PDT)
Received: from krzk-bin ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id j1-20020a1709064b4100b009664cdb3fc5sm7275579ejv.138.2023.05.30.05.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:59:21 -0700 (PDT)
Date:   Tue, 30 May 2023 14:59:18 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/4] dt-bindings: nvmem: qfprom: add compatible for
 few IPQ SoCs
Message-ID: <20230530125918.4waqxc4xmnetb5wb@krzk-bin>
References: <20230526125305.19626-1-quic_kathirav@quicinc.com>
 <20230526125305.19626-2-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230526125305.19626-2-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023 18:23:02 +0530, Kathiravan T wrote:
> Add the QFPROM compatible for IPQ5332, IPQ6018 and IPQ9574
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- No changes
> 
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1786533


qfprom@1b44000: compatible:0: 'qcom,qcm2290-qfprom' is not one of ['qcom,apq8064-qfprom', 'qcom,apq8084-qfprom', 'qcom,ipq5332-qfprom', 'qcom,ipq6018-qfprom', 'qcom,ipq8064-qfprom', 'qcom,ipq8074-qfprom', 'qcom,ipq9574-qfprom', 'qcom,msm8916-qfprom', 'qcom,msm8974-qfprom', 'qcom,msm8976-qfprom', 'qcom,msm8996-qfprom', 'qcom,msm8998-qfprom', 'qcom,qcs404-qfprom', 'qcom,sc7180-qfprom', 'qcom,sc7280-qfprom', 'qcom,sdm630-qfprom', 'qcom,sdm670-qfprom', 'qcom,sdm845-qfprom', 'qcom,sm6115-qfprom', 'qcom,sm6350-qfprom', 'qcom,sm6375-qfprom', 'qcom,sm8150-qfprom', 'qcom,sm8250-qfprom']
	arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb

qfprom@1b44000: Unevaluated properties are not allowed ('compatible' was unexpected)
	arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb

qfprom@700000: Unevaluated properties are not allowed ('ranges' was unexpected)
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dtb
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dtb
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dtb
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-lagan-yuga.dtb
