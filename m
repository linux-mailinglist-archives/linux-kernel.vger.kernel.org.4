Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FE627B01
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiKNKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiKNKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:50:52 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35E918E0F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:50:50 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so27292568ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O82IdtMN4gU2HPdWYJ4k/Ae4A8assTn2dDMpMVtowGw=;
        b=txB1X4GT186dmbeGXeIIwIamZIk2UtUpnIl9NptygNxW0hHhi8FeNkijyxN7OvDPu6
         ++YXt0DR11UBd/RSStujeTgzhiB21mBdDRsdsxJl5MXBJlArSj0m8V0NqJoWyPDNkcmb
         AObqiV9lKX0bB3k7M9c3+U2T2gNgL+7qAyZDuMm1OvqBnZzFGcktGYUQMMup7p1cN+zm
         qbil9d5nOG7Ebsl9KG1foKZNfZKAAEtgiA5OZcWWXuqLsUXP3gY23BleZZuNs0pO9kNU
         lg5RnmC0wQgDObRxj5H6RunNTwEyMgocfKVEQgXQU4cROkqO8PpZaYLc4vqBaqKNd1gb
         TUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O82IdtMN4gU2HPdWYJ4k/Ae4A8assTn2dDMpMVtowGw=;
        b=PcrmFEWLvNBgeL50XPLEJOIDjeEr/ZFStZrpqXipaQgCylGwaDWui6LwGMiRmSUVm7
         cWHpX8o58MeGWoudikS7OiLTuUEheELteUG9YtUcGfZrVOkJD1yeEM95kApndF1iHz4T
         9e1bHdUit9/TtIg4iCly3gukM0JHoRKFG006FoLF0GAoKbZ0C5wP4+mDNVtXnr5N9ukD
         lIzHqzuILf+JJbnmdX+x7RHJ8XQUgFW/x3JGhKrVpTL3Qir9GLFMwdGAUvT1llCrD996
         way6HV1nZVkvE/HSPzTJ+fj+q3dmWZ0q1Dtp7dcTODGWVM76J7ujWQptcn8vX1joyET1
         vnEg==
X-Gm-Message-State: ANoB5pkh/KLZw0pyA+1IYh9HBv33N5k9pXhFwvJpbM3rcNeBW1Z42zUT
        pkCAY4r9t8m5aqxCvSGRnqTNoQ==
X-Google-Smtp-Source: AA0mqf4DhiiUYgCZoIx6i3TSrYBciP3BDWtYhM4xbTCH9ibd42LoFFJte4VhLeXdm8d6RN5wXMDzUQ==
X-Received: by 2002:a17:906:414d:b0:781:951:2fb with SMTP id l13-20020a170906414d00b00781095102fbmr9849462ejk.64.1668423049581;
        Mon, 14 Nov 2022 02:50:49 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b007402796f065sm4037053ejc.132.2022.11.14.02.50.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:50:49 -0800 (PST)
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
Subject: [PATCH v3 1/3] dt-bindings: mmc: sdhci-msm: Document the SM6375 compatible
Date:   Mon, 14 Nov 2022 11:50:41 +0100
Message-Id: <20221114105043.36698-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114105043.36698-1-konrad.dybcio@linaro.org>
References: <20221114105043.36698-1-konrad.dybcio@linaro.org>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No changes in v3.

Changes in v2:
- pick up rb

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

