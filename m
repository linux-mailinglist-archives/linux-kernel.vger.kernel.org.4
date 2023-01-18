Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F76710C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjARCHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjARCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:06:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A6E43470
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bk15so22323259ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl/XkiU1Zo5yPQtQsNq0TJFZYt+lSpYW+rHMFbbmx2c=;
        b=gVJWAsBEx3ro0T0bUaoK50N5rPdtAA/91kHfTv4oMfIYEgKKo5KTQLXDtTRK6Fp6lD
         KvrOP4GyZgoo9ALHmAoh6jE5jlk08eQG4fAaBYRdkRJtBKWpHxB1aMGDarndtSU2U9Fs
         YXj90ZtY6EL2ILLAq0wq02cG80CoXopsaBbq2QvQckBZmFKPvf5oyETqlxLBhbbQ+vNf
         jyjiNAyUf0u9ehQwA28QkSxtNqwHABoADFwkoD6pEsDbVW0dCZBJ5Dn/QHyXepVk8PJS
         lAN9a4VgcU86knE1xVjWrWuTy4qOllkxHVdnzPD5yk0NzclaGk2OBZI0kWbNjX43HxVI
         dRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl/XkiU1Zo5yPQtQsNq0TJFZYt+lSpYW+rHMFbbmx2c=;
        b=B/jopEhxQ8e+SuxOYaXFbFeIFq9b01KihGI+Zqzf48OY0dvqqLWvYdSKnB0L4qDfo6
         cnLwXOFN34M6U76bbKZehow8rv6oTl+cwjwjtnE0uoOsuYGa6EWKq2dxYDGGM71fxvrH
         b1XO14gEKyQcMIQH1T9fFnzRK29pD2dEbPinTEdLPmjzMsBqAQvN27bJVqIm7kkrLeqp
         hpo1FLNBsGwV9lRkTZzPZ6oKhxxsmonTSTpt9yQ6yyZYYMz0bna8iW9HPKgrSViBOu10
         xDyV2edoSQEex3H900Ct4oplYLKGdCp+SK0tIoGKchWhRKskEsYfpgQRqN1sBxKyA6Su
         8LfQ==
X-Gm-Message-State: AFqh2koJ2cQBscB1rBwGPp7GB0ToXnXRV5W0jnn+dp2Ul0OA77eGzrHw
        S1S/szBQfmAS/5ISaHaqcVp8Bg==
X-Google-Smtp-Source: AMrXdXu70jLkMqpEH3OC0+L22Q20BtYClmQohFyXhQMcYw6a+N73826h2xTZraxRVcY7q4a0I5/sgQ==
X-Received: by 2002:a17:907:c99c:b0:7c0:d6ba:c934 with SMTP id uj28-20020a170907c99c00b007c0d6bac934mr1098233ejc.13.1674007596720;
        Tue, 17 Jan 2023 18:06:36 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0084d368b1628sm12702694ejc.40.2023.01.17.18.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 18:06:36 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display/msm: Add SM8150 MDSS & DPU
Date:   Wed, 18 Jan 2023 04:06:17 +0200
Message-Id: <167400670546.1683873.1758703609286578116.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221212093315.11390-1-konrad.dybcio@linaro.org>
References: <20221212093315.11390-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Dec 2022 10:33:12 +0100, Konrad Dybcio wrote:
> Add bindings for the display hardware on SM8150.
> 
> 

Applied, thanks!

[1/3] dt-bindings: display/msm: Add SM8150 MDSS & DPU
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9ffbefc1553c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
