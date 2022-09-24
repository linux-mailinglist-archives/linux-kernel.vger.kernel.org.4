Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D765E89F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiIXIQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiIXIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:16:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A913D7E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:13:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a8so3491467lff.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=cOoZUqAJI4AlRDTahZ2o1qAygyRmtBchZGRCt/QsCAU=;
        b=YamCRGX4bG92dl7ViPcvdQS5ROvHmBfdhVGjTmJ4DrUfclKjY7lqI7tzdSOtG5D5b2
         5/WIdKofYfcBLAaKl8IJcave6a0V067hRSBv4zB0SjP7IWKqtgDUKIYx9YCFI+qIJJfV
         Wc6pzpvfgadlRLl3HluOBkHiOur3Z9Fp53X8WSJHXCuPkkgTyUTS2fEhD9k0Lregzv7i
         OYasVqo+b7AjpUZ5T4c0ybTOYRgSClavzFmdFwWVOWtAwSMm0dUo6tJhVCWca8XQ0HZD
         Rey7q9uYEhHhChvk/KaB+RUk/prqFkmSi1x7CJGwO0U12lZ/rwQc+0R5Gih/FFlxn1H/
         R8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=cOoZUqAJI4AlRDTahZ2o1qAygyRmtBchZGRCt/QsCAU=;
        b=b7DQcuOK6kOFJ9VAIRAZisiQtQGAhldVMKrwC62idhHMioRYxOtncJDo+n+wOKJp+B
         mGQmeHPc6XMvQjFeZ75DPHRwGRBqxqPoVNxTfh1yFRcsLRXMHmTN+BnW0HXVg/GsiTAT
         Pw04rb0XXrhHGQV8apuG3lBNoo1joGe7T6+Kbe6WPWoZ39j9gKefVzIjSNCoKnGDE+Qt
         jZ9gqaYcxRYkDCgtlQswwyDDwQ+UaGUo7LsPZgPaJDoBVQRmRovWW4eid+iGRBR4o57A
         y4bYufe4jay0uTJFuYszp+76SY8opPbEEOCgiRz1RGpJPoU5FrwXt0n34p1l88Ts7sXG
         TKDw==
X-Gm-Message-State: ACrzQf0feLZEOVzbjdekeM7nI4vytC3I7y1ANFLpIUqQcQgHc6MborcI
        f4HTBoPVPCFH6lS2vmJQX2REzczI0da5Wg==
X-Google-Smtp-Source: AMsMyM62h20/xVci4etIPdvRJjjIusn8RHzqneZchuge3UEzVWdqqPCNKbDMyTop7s67UV0GBmbUaA==
X-Received: by 2002:a05:6512:3983:b0:49e:2ef9:8375 with SMTP id j3-20020a056512398300b0049e2ef98375mr4991353lfu.678.1664007201919;
        Sat, 24 Sep 2022 01:13:21 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u6-20020a05651220c600b0049771081b10sm1824979lfr.31.2022.09.24.01.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:13:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pinctrl: qcom,ipq6018: replace maintainer
Date:   Sat, 24 Sep 2022 10:13:12 +0200
Message-Id: <20220924081312.15068-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to codeaurora.org bounce ("Recipient address rejected:
undeliverable address: No such user here.").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 075d014b2ec5..77a00128eda5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. IPQ6018 TLMM block
 
 maintainers:
-  - Sricharan R <sricharan@codeaurora.org>
+  - Bjorn Andersson <andersson@kernel.org>
 
 description: |
   This binding describes the Top Level Mode Multiplexer block found in the
-- 
2.34.1

