Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F260624ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKKATJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiKKAS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:18:59 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366B12A8A;
        Thu, 10 Nov 2022 16:18:58 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id h206so2579482iof.10;
        Thu, 10 Nov 2022 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQdXfHXD2jNc0ULYmRYiq2ER1KgTrvIMpk00EXTgBbk=;
        b=Vnj9M23/r3Xk9etno/U5LlsvbE9GrotARk5IVwFWCnpJ02xgi12L5Q0eLifnGIkFK2
         N1K6Gnsn4w0COGvksYfFKKb4OFnmzLX2CMWabKtS8snn3ZcAmwj+60zX5PY8W9x3iIJl
         bthQCB0ZxRlwmPtxDzKJjnm8fM/tIBCnbf4An7mW1p9z9TDDfWZbIv2HzWyDAXX2oH1N
         QJo9tClDEF4Eh90JurelUW+KNSLpS1JhdP4+TEExTG0U+llBsro02M2WdXC59GDQRCcr
         4D5DSqNNOWdZRx7E5Ti23RwoPo4ER1zfohcQbAkJ/kPNRKbX7pGHQRWKD/gN8KvzIXrN
         sxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQdXfHXD2jNc0ULYmRYiq2ER1KgTrvIMpk00EXTgBbk=;
        b=UPhbO0ZzHb0zXfqLt7346+z434t/yPuC+H+Bn6iL48rE+l4RzsvPDyChdiVs8v7QRy
         /0xz2ZvAqDr0N84g1lul7cHBYs9j7rQJY9IX5DK89sVL26l73JdJz2Z5rD/uS/8IYaVT
         4YLFEtr2jLsRHq2KiwsExXj/PZGw55ZDFr+iJQyHYJ2Z1m+jtuoGtG7/YiuQvdYXpbJG
         RacxlyqURSBePpsAIO6J6mG9aMLDpSQZj+sdIb5InZFT6O7C+gNRJriEwitqafB9LfKG
         czbmAh33cHmS6oWfw3X69zK6SlryOT0bul6394/+VUC+zjRS5vGFs3NdDeOWfGg/s3SZ
         9KLA==
X-Gm-Message-State: ACrzQf0cgONHE5+AC9HTxy55UWTPgrInX0ZSxYZehehRXQa64QcTq5zW
        xhfmaapPCqgsAwbtI7cDSMM=
X-Google-Smtp-Source: AMsMyM5rvIdQ21fThx7/qq6k5kqY3cxa3PGfZZFRLqhgG+eW+/B7xxurtfiJ0nbXAEOTYeffOfEemA==
X-Received: by 2002:a6b:6018:0:b0:6a1:2c0c:6084 with SMTP id r24-20020a6b6018000000b006a12c0c6084mr3492310iog.128.1668125937660;
        Thu, 10 Nov 2022 16:18:57 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id x6-20020a026f06000000b00363ac6a0b89sm298727jab.172.2022.11.10.16.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:18:57 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Richard Acayan <mailingradian@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
Date:   Thu, 10 Nov 2022 19:18:17 -0500
Message-Id: <20221111001818.124901-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111001818.124901-1-mailingradian@gmail.com>
References: <20221111001818.124901-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Snapdragon 670 and Pixel 3a initial device trees are about to be
added. Add the compatible strings for the board.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..f9eddc22d4a4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -51,6 +51,7 @@ description: |
         sdm632
         sdm636
         sdm660
+        sdm670
         sdm845
         sdx55
         sdx65
@@ -654,6 +655,11 @@ properties:
               - xiaomi,lavender
           - const: qcom,sdm660
 
+      - items:
+          - enum:
+              - google,sargo
+          - const: qcom,sdm670
+
       - items:
           - enum:
               - qcom,sdx55-mtp
-- 
2.38.1

