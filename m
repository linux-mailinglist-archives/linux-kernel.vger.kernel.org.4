Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6FD689F96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjBCQtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjBCQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:49:05 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A507198E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:49:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k16so4334170wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmHMd/kJo9fi7KUEzvqHg27Up1GHzX0whgZfEcncBQ4=;
        b=bMHs43HMrfCWH9zAIBTbOpr2xZ5KYHTtR8G0AzASLUsgdxIwj2FYAqeavXjlEWFh53
         OB6/XPeBy2n+qdMJlpxuVjtrVYCkfXKnDxpkIuANG0Q6NFGelx+bMpV1H0ZTWItQKaRv
         LRHO5X9E3SU7xOhaO1eAjzGGdiOWhieIedErESslL8vONxmz/Kqrdqif81mwk49srkGK
         URILhQtN9Tpp+zhOI7fJV30XPdRtMM0hC4seOUFfPjaF3rYnU7rGpce7Ib/+nK2zPMmY
         Yj988Pw9wnDwY7P/K7U9+lscXztIqcpfSjIt0XxNS9fOXuR3XpQVSBju4DiOgq7VSWBu
         m5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmHMd/kJo9fi7KUEzvqHg27Up1GHzX0whgZfEcncBQ4=;
        b=DNo2x5eOGjGOw1usnXKKpfKAVURjEOngnRFMpizkGM7U3x6MNDCnnbXTeIqC2acPnE
         PRXOsBHRz8CAXMRfJ3bqIle7oc2aqBSHT4Tvm0+hVrxjNp6qiL0lwTlES3ooOOUTdpI8
         Ft7eSNRteOPI4u/fFL1+K0SLlOpHwSCaCVeiHw+8hgMC4XyzgBNrf2Vsufthf+g8sq+/
         odUkaY97GvIq3xEh9VD4/+Z5+zZwJ1bORVj/eKQOO+F9LECfT8P36xMmBylz1LabPmZ+
         8t3Zi4iT4k2S6Gmi04mp4kqID8smAC1YgYKhHul6EyOgHECZ5yvux4qg9mbX2R3TRRwH
         k5Mw==
X-Gm-Message-State: AO0yUKUKAnXy156XPjU6pIE2DQN3ios/GYcm3RSqoKAEkK0Q8k6N6p0Y
        t90zfej/59Z1b/B3Mfik8PpQZA==
X-Google-Smtp-Source: AK7set8KflwscXqE6oaijqOQZef+hssDC9XdOLRTIyBO8DDAgaA8/38qma6IMdeQx0E8p8gAkOqFmg==
X-Received: by 2002:a05:600c:4fd2:b0:3df:eecc:de2b with SMTP id o18-20020a05600c4fd200b003dfeeccde2bmr852091wmq.11.1675442941004;
        Fri, 03 Feb 2023 08:49:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003dc4b4dea31sm3503247wmq.27.2023.02.03.08.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:49:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: correct GPIO name pattern
Date:   Fri,  3 Feb 2023 17:48:51 +0100
Message-Id: <20230203164854.390080-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
References: <20230203164854.390080-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8250 LPASS pin controller has GPIOs 0-13, so narrow the pattern of
possible GPIO names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
index bd45faa3f078..de9d8854c690 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
@@ -64,7 +64,7 @@ $defs:
           subnode.
         items:
           oneOf:
-            - pattern: "^gpio([0-9]|[1-9][0-9])$"
+            - pattern: "^gpio([0-9]|1[0-3])$"
         minItems: 1
         maxItems: 14
 
-- 
2.34.1

