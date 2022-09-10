Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9075B4584
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIJJPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIJJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:14:55 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB62427DF0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y18so4739429ljh.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rD7nUjrvSdRKK26SnCtib57c+ip99Bt4hzrz7aSHTO4=;
        b=Rsz6LsFfnqmR36Oevfef1XQ4ctRQDNyk6AVpk3sJ0VocJmtKtRxrJ5Y6wTntgo/KoA
         JdF62sz51+zHvEHuwrevm/Q9/VUqgIZOiOYctiNfsRk86D6O8izzILqyWkzAwgQQaiWC
         Ppgy+mqSeepSFohcshjktqK2HmC+8yR2PWcZSyrqkwPfcWLYwlOg6wLlVrO6EG+mQo7D
         SOS1zvT12yvBziHAFvjhK41reSJoLAWYChP8P6SsqmiB+RIDcj4Me4RhWil8dLoSLMKR
         aFFfOLF9JLW3ff/XLuAuChQWQ1aoLIHnn6thK5Xg8LbORdKEJLEbZrSjb7BKZNPMFR6+
         5kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rD7nUjrvSdRKK26SnCtib57c+ip99Bt4hzrz7aSHTO4=;
        b=LaDNy780xjeuj/jpqGGH2rEc4ExszWC/Xn+gPPdywKtFNgK/0L3qHXEVUa0P/cEt+V
         EzWWhVuoH74Iw1Vvx2sSKLa5KW/dTGLSlPcYL9wSK7BsPEISTFKyCDgbre+eGo+vg11n
         u1+Ve8N+jajmd0n7YeuSGAz9UVqKgEiZ9qKLp0H0o837Smq1WGhX6zJh9XTHE/N+sTgR
         WwGWNlZEYfDLoQNGHVuQiDKF1GHJUh7QBW+FDaWvxqC/NAPaFmt2xUJKv8GubbzSdO4d
         oRQT0HNmE8oUgKWqS7PLxbPCEJpkvTt77/EdqHseCWmTfjRRes0UFIvow2vauPBMACXL
         JJtg==
X-Gm-Message-State: ACgBeo2EoepCkPjbiKtunuZyoO0808Y0LxzaFN8tynuhzmvcwzWTfENH
        sDIONBCmIAz47tORxCNPSj/tRQ==
X-Google-Smtp-Source: AA6agR7YXCEXY5JmG+5bvoz+TD75A3dMfqQpRqVBeqMKsXkzpNvGzIY3qGRw67lU6pqY35ES7xYGng==
X-Received: by 2002:a2e:bcc7:0:b0:261:8fb3:d4ec with SMTP id z7-20020a2ebcc7000000b002618fb3d4ecmr4836085ljp.96.1662801286633;
        Sat, 10 Sep 2022 02:14:46 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 08/15] arm64: dts: qcom: sm8250: use generic name for LPASS clock controller
Date:   Sat, 10 Sep 2022 11:14:21 +0200
Message-Id: <20220910091428.50418-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
References: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic according to Devicetree specification,
so use "clock-controller" instead of "cc".  The bindings so far did not
define this name (as child of APR service).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 84b4b8e40e7f..6ee8b3b4082c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4799,7 +4799,7 @@ q6afedai: dais {
 							#sound-dai-cells = <1>;
 						};
 
-						q6afecc: cc {
+						q6afecc: clock-controller {
 							compatible = "qcom,q6afe-clocks";
 							#clock-cells = <2>;
 						};
-- 
2.34.1

