Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992B36BBC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCOSjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjCOSjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:39:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5FB1F5EE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:38:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f16so20422906ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678905504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVubaIqvmyZcVmODQ4m0c66Rfjv3Ax4FAubBWjKvyUI=;
        b=NbsCYa1ped90PCQfFoECGkBtGykaKc5PmrnpfStkvX1VprhPanvIWZBTfNi629EIxy
         YDtrJwiS6hNH4l5Axz3ZUCkTGvqAx2kIntIExbPwW4IJaYuULXML/7y8gQCEd5o7UFqs
         nWRYcFfZ/Xoa7XfcYucXBbTRgN+/Uf/cQ16OiO+7Y/ztTOTewBf8szDUH4VXWML9ncce
         n/+YV9CFW0h+4g3Om1s5/BvB4yTE0E6JpNNLRtoY7ylYb4x6I8G2I2ZyR3C6asdUSsac
         JcDHfGzS7tv02fCXxuDY2CHGFX/OQ0DtahpZfF+p/f2V62+qSaTGqq+4QR0hoVZG5p4D
         l0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678905505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVubaIqvmyZcVmODQ4m0c66Rfjv3Ax4FAubBWjKvyUI=;
        b=fciDblofq451RD3sDon94J0E6O3x/WU3v8ByaRYeKIhC3Vn9wrqxFIBi3i68f3+52E
         ooEmQBDhLGTG6leaNOpde9moh8HL+QYOYATK3bT1ZzoSpXL+trBQ1YGk57LJnLcxWGtZ
         qIyWtbkIqa3Q3Id8JW8gmaXrQsw8PysT5vTkzF2p5ucLYDoDgQZuVEMMmxlim4x2vpkL
         aIhWK2+aGcxGn1XdAeOq95J7MT1gLPBbjn8jRGtQgaU3D+oR3hDikZck+Uus16D5/pfY
         EOaKvll0OWvDUgGNQ9MAD7fyEbjedN5J4hKPeuWJ3Up9NpQjCI6uaKqfdCtdRC2dZKxo
         JCDQ==
X-Gm-Message-State: AO0yUKUx6UDf/qRAJvEvQqEZmtSabbH46K7dHqlnHIXACTqaK3Z9Bsmw
        OAstHN5nE1fVp/WWuEOPQbc6Lw==
X-Google-Smtp-Source: AK7set84NzHICTZHh+Hel5/BN/OKTrtw1DK3YnyugJrhQvB1cG5i0IemvtS8crWDlETL4lCsusCg3A==
X-Received: by 2002:a2e:a58e:0:b0:295:a280:45e4 with SMTP id m14-20020a2ea58e000000b00295a28045e4mr1760515ljp.36.1678905504709;
        Wed, 15 Mar 2023 11:38:24 -0700 (PDT)
Received: from localhost.localdomain (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id k7-20020a2e2407000000b00298699aad60sm951261ljk.52.2023.03.15.11.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:38:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: Add PM2250
Date:   Wed, 15 Mar 2023 19:38:19 +0100
Message-Id: <20230315183819.3563704-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for PM2250, commonly found with QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 8f076bb622b1..975c30aad23c 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -33,6 +33,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,pm2250
           - qcom,pm6125
           - qcom,pm6150
           - qcom,pm6150l
-- 
2.39.2

