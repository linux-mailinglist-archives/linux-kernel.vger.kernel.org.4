Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A8700CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjELQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjELQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:25:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE334696
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:25:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so15093330a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683908723; x=1686500723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8Vpo2Jow16tTvLpB1BAyUoXf/oVQLicLfPhZQQL2iY=;
        b=EvCTIfLLl3tu6txxsj1jBkd2imFPgNwyWj7Q+QWu+DffLJ2SDP9EEmkmO49icd+Fyz
         xoqpsmr3+5Uw4EOGGAxSzZXB7Y5IWeCEt9j/0e/5/CtYYZXM1hj9QlmXT9Z3/1Wzy4JW
         lAyAfalEMmCH1IXXnIgvnL/lBpytkhTFAFP4lHwwGPSfxCPV2P6pjkhxGUDJ9gndMZFf
         3NGon03xYGtIOQza64IhOGzpeBjRx1EVF4T8MqutECoNWVo9Qm6osRj4UBOnHS7jPGLd
         Lya0+dwhmX+1cBwSJUfEXzzKiuzlL30Dsz/G79hoTzwC6oGfkBNVz1ZX9fU2SqwvPXsm
         iEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683908723; x=1686500723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8Vpo2Jow16tTvLpB1BAyUoXf/oVQLicLfPhZQQL2iY=;
        b=RcckQHHmtG2E3psyzLv9AX/EWZ+/IXKVyKcjKOIH9EQITEzqbWN3KutUWfbgzaChDg
         6OUDsT+kd3f0PA3zYT481Jb3qatnMERMrOQAhZnb17v4Pv3iqVtLVHjjnd7910p9Lc0F
         3xH2GTS5MSq2K43A5i7U/tZeVvC3qXXfXv5s2/SDM1LCLC0oXhF8R7pwLhweKwLmlWrE
         XRA/+OpS72AGfsDy5SooMmk6WSEpIOc/RE0/rj1Deb2E1rDT2xw3PYFqPRJRWI1YIWyl
         GDgOc9VDC9P2/EhUR5MBDWlcI64HPCzR9vDtEKFhz8TQcMtQ3zaViWVhjWZ0O411ESS0
         gldw==
X-Gm-Message-State: AC+VfDycsOYiqiiykEmf0gNKTHl/Unf+l5AppFckxqSHSiKjjjtfuAfb
        JcllDyO3hWmrTHag2uk/r0gPjg==
X-Google-Smtp-Source: ACHHUZ52MOF5+sFRcmlq51wY2NeIrwwBRri0aFmEMbrRTi5DNlYhpCnV5koplj8nrcA2LoSmJgHf6g==
X-Received: by 2002:a05:6402:b09:b0:50d:889e:8d35 with SMTP id bm9-20020a0564020b0900b0050d889e8d35mr16257630edb.7.1683908723143;
        Fri, 12 May 2023 09:25:23 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00506987c5c71sm4144116eds.70.2023.05.12.09.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:25:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 04/40] dt-bindings: pinctrl: qcom,ipq9574-tlmm: simplify with unevaluatedProperties
Date:   Fri, 12 May 2023 18:25:15 +0200
Message-Id: <168390871587.209400.8810729198013675037.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407184546.161168-4-krzysztof.kozlowski@linaro.org>
References: <20230407184546.161168-1-krzysztof.kozlowski@linaro.org> <20230407184546.161168-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Apr 2023 20:45:10 +0200, Krzysztof Kozlowski wrote:
> All Qualcomm SoC Top Level Mode Multiplexer pin controllers have similar
> capabilities regarding pin properties, thus we can just accept entire
> set provided by qcom,tlmm-common.yaml schema.
> 
> 

Applied, thanks!

[04/40] dt-bindings: pinctrl: qcom,ipq9574-tlmm: simplify with unevaluatedProperties
        https://git.kernel.org/krzk/linux-dt/c/8625372628afd9627a28427427037e2b13b75949

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
