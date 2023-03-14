Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04826B9E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCNSbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCNSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3918AAD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so1058654wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vO0yyz37sCPjmTdBPnxOQssiPwo3vE8UW/JvvEZOCQ=;
        b=4Gp6JaA+LlrNYraBYA8mWAWkIYN3+2QBmR2ZoCgv8mKrhj6OaBkVzALZZ2IsHQ8rj8
         rf/HpQHGt8QAXJ7mTNyCxkSkRiP98EP5KTwCZJtwj18BmHTcbQaqIvfSkQbd4Yxbmxw+
         a+xuPPLUPgdZk81+OFWDNm2/OdZQt4CjthOly5yO52BbthRyKKqCboq/icw/GoDwPI6M
         myseMTmicelOqnfW2JSIvIDIsUMiaOofIMcK3JViQRbZtGo6E+Fpt12ZuM5X7RRSXFz+
         ne/Gv6RWef3bgCaK1QtxI3nWAIgk78WFLl9Jar5OQZxHoSTUhqFPFPHC0WxpnyRucP6a
         FJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vO0yyz37sCPjmTdBPnxOQssiPwo3vE8UW/JvvEZOCQ=;
        b=Am4rtEHDkIhMkN+UkH9mwh/9C7OB2mKakPWYlngXS+AodDhgj6/2WaFWADq7Nq6HL6
         kVfUOShxuf3uFB3Gt9FNTMj9alTqhPPYTk2VRaIYnWG0Iu1jha6ZRLOGgmIUEvLFBC9A
         YcVu+hpU6YZFWCgvcHkEDiXqWKL7IpSvgdnA8OzdlOlEy9pAiMJM8Klpbg6nAjRJ6C7u
         E9G2ZZGcwuHFVNYT0Q+lemd24hPrGeJLmq21taLix/u7tx86vImdLAz7mUCp6Ao7O8Gr
         iDDnwIRH1Qj3sDPNEvX4taujuer5tI965xFNeBmnG4FzkkPLxzkbCLC/PZMMDoI6Ip8+
         togA==
X-Gm-Message-State: AO0yUKVbTa3+TqCixyLOkGYTds3tF4sLfUgUebQlAjVGadhxafwVfyo1
        d4lp0wmB9x0lEwieHM5LonJCgQ==
X-Google-Smtp-Source: AK7set98JiTo2th2oPGQJOngAEPw6VLt3IgHn4vuukzs7XUq7gqA87KwXNTJBZ1jsCbvcr/7apwWvA==
X-Received: by 2002:a05:600c:4ecf:b0:3eb:29fe:70ec with SMTP id g15-20020a05600c4ecf00b003eb29fe70ecmr16501913wmq.27.1678818654514;
        Tue, 14 Mar 2023 11:30:54 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:30:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 01/14] dt-bindings: interrupt-controller: qcom-pdc: add compatible for sa8775p
Date:   Tue, 14 Mar 2023 19:30:30 +0100
Message-Id: <20230314183043.619997-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a compatible for the Power Domain Controller on SA8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 94791e261c42..25c4662a0280 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sa8775p-pdc
           - qcom,sc7180-pdc
           - qcom,sc7280-pdc
           - qcom,sc8280xp-pdc
-- 
2.37.2

