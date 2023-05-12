Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643EE700CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjELQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjELQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:25:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585647A97
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:25:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so18574957a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683908728; x=1686500728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvQk+svCP50HKElKrlCVyAJgzuwb5SdFt55hE/Eiezk=;
        b=EaWN1rYIfwhZ2E/kWq48ltb87MtkqMX9ZbP2nuz6SIw1KHQy7OsUXIvuZNzURxaIsr
         Q+hWdqd1GxScSw3+Gk8K0nzdmcpGvow9Oyb4Dh4W1TK7wSvtmSr09fo+saXcey5DXlPU
         CKWSb/6Lv0ECb5d+qACJvT2O/uV+6oH9ywFjM2hVMdATC8htjq32Wk7dneV1C6+1sJEL
         Dp+2IqhmsDciECq2WatDBTfycfz/s3xJaCSXtxLfmdC9LrGYMBbuZQHUTwI/inQkPvXm
         /IkK47r/zbGy5RWewzQj//8F9WyEVIykRRSprLe2R6rXLfBRCwKdbCvp7js413Z7ENP0
         8Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683908728; x=1686500728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvQk+svCP50HKElKrlCVyAJgzuwb5SdFt55hE/Eiezk=;
        b=HfwUZPGqkfw5lDz2W75N01FpH0WPb3E+vz7LC7F0vjZxHBEuJlETDbDkYlo24K2GIW
         HwE5Wx9VNL3WfQ7Lo5d6MH5/44QVmM0SFVtlaM8y/gIsVoHAAExgEIiEsgF7ExYVAIjY
         gvQsVL0wMWkdcvFDuHhsMnNYnuAaKZFe4aNXwfj/XdAtkRx/1k3BgFqniwMVJSriNM/T
         srDKw2zQlLy63Mrtj/lThYt1tlOEPcECGSowCqYuNhScCrzg8qXtQuPB6r0TOlgBsLE+
         ohcy9zCupRNArj1ZRyWKEWsE9+TIIcklnxr2cwIMgC3xiHi5oNu6JrVWw4CJu66xR4KL
         LVVw==
X-Gm-Message-State: AC+VfDxbEA/rvLovEV9V2XJK+uJjg4fctliPQuP5bdH17w1iO19OL0Oq
        SXxh4ZNjvlcdCqlDnfM8h6W64w==
X-Google-Smtp-Source: ACHHUZ6uXUT0lW+LFVr4KL5Jm5mw4HaigdvvK4SmfDrSMK0reRn9kNg11GffukuojXCHJ+5xydomtA==
X-Received: by 2002:a50:ed0b:0:b0:50b:d83b:9c61 with SMTP id j11-20020a50ed0b000000b0050bd83b9c61mr20007419eds.32.1683908727795;
        Fri, 12 May 2023 09:25:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00506987c5c71sm4144116eds.70.2023.05.12.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 09:25:27 -0700 (PDT)
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
Subject: Re: (subset) [PATCH 35/40] dt-bindings: pinctrl: qcom,sm7150-tlmm: simplify with unevaluatedProperties
Date:   Fri, 12 May 2023 18:25:18 +0200
Message-Id: <168390871588.209400.11438301358631937951.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407184546.161168-35-krzysztof.kozlowski@linaro.org>
References: <20230407184546.161168-1-krzysztof.kozlowski@linaro.org> <20230407184546.161168-35-krzysztof.kozlowski@linaro.org>
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


On Fri, 07 Apr 2023 20:45:41 +0200, Krzysztof Kozlowski wrote:
> All Qualcomm SoC Top Level Mode Multiplexer pin controllers have similar
> capabilities regarding pin properties, thus we can just accept entire
> set provided by qcom,tlmm-common.yaml schema.
> 
> 

Applied, thanks!

[35/40] dt-bindings: pinctrl: qcom,sm7150-tlmm: simplify with unevaluatedProperties
        https://git.kernel.org/krzk/linux-dt/c/647c16ac7b15fc8fe6ab679690ac2ffe7c53abd3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
