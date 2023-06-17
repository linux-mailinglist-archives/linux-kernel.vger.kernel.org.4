Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3716073407E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjFQLVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 07:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjFQLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 07:21:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9081733
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 04:21:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9741caaf9d4so231537266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 04:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687000879; x=1689592879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Krcc/vXi7Y/oQrZ+20/s87VCD/03LOPSb5ljOW/mb/o=;
        b=czrZgN6YMKptxuiuK74rBJt180zMz/fmQaDQ3kzvYFYRfVKqlPa9RW3fBTrfnuzu3/
         UcfFvN3zDZqhtdqmyOMyL+LwVBqyKnWM3DQt6DrmwCCQ/aHdKns6J8kBz4TATrMd3EF/
         bqMlSuTZdIoFEMO7CpqpMSzVoUwGT8e8fHL6LJ/kGZePiaKg5ojg6TFTFhV5ouxLPjFy
         dQsNAXSNv9J6G7u+Lh3lftUOtrmeTEF+7VwXli+5UOsemmTdEKWarRobq9hLwtZavowT
         9IzavH6LFXO/iPp6HpuWu1RzkdOTxO/yZlJa3GN7yvwUpDoSgH1bqM2czMHk3SnRJA2Q
         tuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687000879; x=1689592879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Krcc/vXi7Y/oQrZ+20/s87VCD/03LOPSb5ljOW/mb/o=;
        b=VP0tyw6aCZjpRxX0sVvkcn2C/q/wWt2PFk6CoRWecKcBR+0Q9yDCsOukuvlXYi2/KG
         Yib5AUeUcosn7Xi/l6JOU99ZGNsxRO3HJuJhj9sP2MC6biJniuosZtTMetxh0VxzUfw4
         k+JlpENd8H489bNbHkrlWJbwGNbYwIvi5SEKI8+O8bzyKFeOLiICwv52RDMWplShtLvc
         DQsKazgpqT5NPhmBn01Bv6rTtD3Q6yk1Qm6rbePCiMeK/OmEjTv7HQ8Izj1ztYJajoS3
         VHAgo6LEoKARBbBUcwMTT5VBBO4gTdMPi08fcg0887ycjYdq5WTad7pCUFrGph9WktN/
         W+GA==
X-Gm-Message-State: AC+VfDz+cWFc0CeSPABAkr1p20oIWWM2rxZmgufmkaOcZL1IgRrq0NNH
        TAGJoAoLxTZVbG3VwUHI29rx7w==
X-Google-Smtp-Source: ACHHUZ4AA9V2iKNQmUuN+hakXx8+pjCADqUBGZ21ZBHwXQFRzt/8njtGU93pPL1hgl/RpgF+PRhH2Q==
X-Received: by 2002:a17:907:9281:b0:982:caf9:126 with SMTP id bw1-20020a170907928100b00982caf90126mr4785068ejc.42.1687000878925;
        Sat, 17 Jun 2023 04:21:18 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906128900b00965ffb8407asm11837838ejb.87.2023.06.17.04.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 04:21:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: apq8039-t2: remove superfluous "input-enable"
Date:   Sat, 17 Jun 2023 13:21:14 +0200
Message-Id: <20230617112115.130024-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Pin configuration property "input-enable" was used with the intention to
disable the output, but this is done by default by Linux drivers.  Since
commit c4a48b0df8bf ("dt-bindings: pinctrl: qcom: tlmm should use
output-disable, not input-enable") the property is not accepted anymore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8039-t2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index 40644c242fb7..43686bbd87f4 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -366,7 +366,6 @@ typec_irq: typec-irq-state {
 		function = "gpio";
 		pins = "gpio107";
 		bias-pull-up;
-		input-enable;
 	};
 };
 
-- 
2.34.1

