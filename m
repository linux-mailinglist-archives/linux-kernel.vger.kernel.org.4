Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032574F20A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjGKOXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjGKOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C821BC6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so9127129e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085322; x=1691677322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+V2uuNbOn3Muk9n8CeQ4nOJuVUNz0Zj/TDQmddJIhU=;
        b=S9dQ47SwbBW3oGPhUV8DPizCswnKCe5cJCWx8pO66iA0Mbo5IdI48lHD9Rph7lIy13
         jyKNclwutD4Sbme/JtyALBG9fN2Lyub51h2oUK1OlUtrxo+WlPfNb0zqp+/sRfneJf0W
         RWkWUTngS5QuTK9/9q30zmY4E4UODCZR7EZEKMNJLo4/Lmf+Z3ziTmWkxTfXe9NM6h1j
         eOV2lZKbZyce0WDnu2zdVBJOMukOjBr4gvcFjZSep72SmZ7oBZ2f5yywx73nNq1pf+PQ
         RAEjXJZmE78aFKULmdiDma95XStiGIc0BpFAdLrKKxkpIkKUQtdXk76iGLBuosEiG7ea
         hwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085322; x=1691677322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+V2uuNbOn3Muk9n8CeQ4nOJuVUNz0Zj/TDQmddJIhU=;
        b=C9O9kYFnmR6wflflBcUofeJ9mmz5IfHV7X9e8slM2qpSOLDs6iuvct30FSp+S76Uf4
         EBpMqd6OuFSCOFAzTbgm675YouwEeNCKtLETFYPN6iNkiBBDF7aj7mTzS/938gE2DpWl
         IrFcmnSuxkk7dduXChvuxwy0UR395HmbDrtT1wkc1UX/uHM5vA1Za41Y1qucENR6Wmce
         sMF+Lweg4On1DOO510Q588rrhHSRZcqTSqpcnt18EqZPSxjiJ81gq4+ZLfIo0SYYlQUk
         eeXhO2W9QaZwvDbYoqwib0ga9cvPzlzJXRr57ODlot3mTRxtV3PPsJDH3Xhe9jeUoZ56
         QE7w==
X-Gm-Message-State: ABy/qLbTL/m2HQfkvz6AF/b9K3+jBAoEAuQnv2fUd/bIhkTQV1dnnLFT
        avzDSK7trSE9+xhXInSY1lXWEw==
X-Google-Smtp-Source: APBJJlE/mNiHcKUnyFMHAWcIULKZ7SEoMxh6r0VW3F2iROzDvMcbdiDX2kWWpW+2f/2YQIxM3E4gIg==
X-Received: by 2002:a2e:7c0c:0:b0:2b6:cf5e:5da0 with SMTP id x12-20020a2e7c0c000000b002b6cf5e5da0mr13185789ljc.40.1689085322058;
        Tue, 11 Jul 2023 07:22:02 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v9-20020a2e87c9000000b002b6b4424a28sm487934ljj.13.2023.07.11.07.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:22:01 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 0/3] dt-bindings: display: msm: document the SM8[345]50 displayport MDSS subnode
Date:   Tue, 11 Jul 2023 17:21:51 +0300
Message-Id: <168908465044.1869384.13770179079731144435.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v2-0-733ed383f6b6@linaro.org>
References: <20230621-topic-sm8x50-upstream-mdss-bindings-dp-subnode-v2-0-733ed383f6b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2023 14:32:52 +0200, Neil Armstrong wrote:
> Document the displayport subnode to fix the bindings check error:
> 
> arch/arm64/boot/dts/qcom/sm8550-mtp.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('displayport-controller@ae90000' was unexpected)
>         From schema: Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
> 
> And same for SM8350 and SM8450.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: display: msm: sm8350-mdss: document displayport controller subnode
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c474443b723a
[2/3] dt-bindings: display: msm: sm8450-mdss: document displayport controller subnode
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8d3850881242
[3/3] dt-bindings: display: msm: sm8550-mdss: document displayport controller subnode
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1a1506d2fd7a

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
