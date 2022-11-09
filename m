Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C30622E27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiKIOmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiKIOmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:42:07 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A345A12ACC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:42:03 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id r12so25915285lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkmGAAhASeKkyW4/+zIci7WZOjWWW0Qq/nOsqw+GfiE=;
        b=V+GLs/B72K4vuyoJBJsydkDBTzbVVgqHfQYp12G6saidzreZLhQqcWe37HezPG4ePA
         nl/L5zvGuatlOBPb1b6RNakbmnljcdXEtNVFsXkRhlMTTGMSl4MUPATc1YuQ/cS1dw3U
         5Aqfl6n2U/p7cFmzm0Cqb+pxv0uHMz04AHxIMMXx+40UmqqpwRYmLQn4IZAHGcHFTF3n
         1HyhZhNtItLmRFUK8LOTCjsbsq4cfmvi1rQw6q7muUQfRoU8RXmB14XOCZFiTkyG2FW1
         LDH45HNZO6wYQ36Dwx7/EDJaYopfw2g2oM9XGuHiom8Jxe4USVLzSadvOuJ8QP0JOBNM
         2hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkmGAAhASeKkyW4/+zIci7WZOjWWW0Qq/nOsqw+GfiE=;
        b=D0JKzv+nHa3EEBEwVHId5dpgBFQ7Rwhhx2/x6NVrP4guGxmtugq8n73bmIZANeJOre
         pX0Ttxsk6/nS7bAd5RTFYf4fsljNSF1K6LC3ypFSzFlKbzdXh/eMyZIBE4ntCzHlBj5O
         Fg76AYBy05BNTfz9/jM2NUKh6xrKnnA53TgIbDM5qszVeXTSwpvXNlNSKUZ2aRR6UJ8Y
         d6rZQLkIVDAaU8x0a4agNxUgdFAmDkYKVl5Dg2LeViS6G3/eARmxhalQJ2Nn1MI7Izjx
         RLyl0mErpYuN1r/S6heGCTQE0bVkJfnyst0CvQYyG5USr1uuI/OSBlj9OH5MgqCQEtc9
         gOig==
X-Gm-Message-State: ACrzQf02V1yXARvcz/LwkXedgJ/CxqCxIenG47wDqai+eZbAyGdsOaeL
        kQJccMBhyuXnaoB2he+zwHj8yQ==
X-Google-Smtp-Source: AMsMyM7ZklXHqmsEaE8RxsLrvb2+FVR6HqDGDie2dTIf8XuqINH1FuRAzbnj5B02HrsAx562S4SGog==
X-Received: by 2002:a05:6512:64:b0:4ae:2465:192a with SMTP id i4-20020a056512006400b004ae2465192amr19588900lfo.62.1668004922021;
        Wed, 09 Nov 2022 06:42:02 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id q10-20020a056512210a00b004a478c2f4desm2235229lfr.163.2022.11.09.06.42.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 06:42:01 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: Document the SM6375 compatible
Date:   Wed,  9 Nov 2022 15:41:51 +0100
Message-Id: <20221109144153.53630-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109144153.53630-1-konrad.dybcio@linaro.org>
References: <20221109144153.53630-1-konrad.dybcio@linaro.org>
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

Document the compatible for SDHCI on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v1:
- Pick up r-b

 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fc8a6b345d97..12def0f57e3e 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -46,6 +46,7 @@ properties:
               - qcom,sm6115-sdhci
               - qcom,sm6125-sdhci
               - qcom,sm6350-sdhci
+              - qcom,sm6375-sdhci
               - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
               - qcom,sm8450-sdhci
-- 
2.38.1

