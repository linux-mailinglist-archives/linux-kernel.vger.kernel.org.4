Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A8695240
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBMUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBMUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:50:06 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E76F1F5D9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:50:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jg8so35001542ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2EKmFD/uLCmdYgJ9rbVqoH0K8+zTnB6m2O8sRKrnrk=;
        b=G9wokKLe0gYPoQN+jQX38Ml1Pv83XDj7zNvFBv2UJdls8nCd6Vrtg/xTlEp9RB3eCc
         tQ/ma5pNSvc9H2KdZASNooO4+eVR2oP02VyntFu6S//vePCn5SCHNA/iGoR2mXtJi2vJ
         LC3PKh6zsDfnWDN4Dr6E0QM+a+b5rpjcwytAf89oRnjRTuQcYd0AvhcXmQaKdzOcePRU
         g8qOCM2I2n5vBnB3bOzJhDfYyzniaAI5Eg7wGZj0akOFeiSbw8Wkhgri7pxB2rEPlW8S
         BsPjbf5TrgP/v0rd9OKnO0wei0LHX5850BM3evsSYSnheWFifW0iPZf542lYSYzrh43c
         OBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2EKmFD/uLCmdYgJ9rbVqoH0K8+zTnB6m2O8sRKrnrk=;
        b=hSRhXpcX/v7wT4qkBCY77WgLaYshnBScXKtzihXHVetGr/iS5hXUrJu/lQrRQtdIE2
         Zac0ZQFs8KW3cQ9M3zbKiJ+lRKXBB8BsYnKTMfG8m3R3rcS7it8bkG1qdASzgatMnYzh
         CbsHzyZkk5sxNsI5TjmgXaZD49dfn5BcFNSqN7g7KCopkOXBT1ymI0GQKQJXtZxVbG8D
         4pdFSMMYq5Ua5rgGFs5C5NutQWQawsoIURgC9Vfz3A70rhuKxOEaM5m5CdAY8fhrMzZZ
         HzGh2ppUdYF38GqCR4AmKhVIcJL1pwdcXsjWGI6r7ls8qa14X3R9ACotqLQVQyUGJj9O
         OYOw==
X-Gm-Message-State: AO0yUKVd7iy2KO4kf2AxJqrLN9fqNN/87akPChmTKpxzMIbB3uy4OLhw
        7lpHMQ1A/baAsKbZnJUrVJraoO6xevwd+KBu
X-Google-Smtp-Source: AK7set/f+xxG2O4MMtQXGC+ZfzFTdI8pROMejW7fdrRD9XbtsKprHvnkE8GXtoC2Vfl8GRO0C1Nneg==
X-Received: by 2002:a17:906:110a:b0:886:9b85:ac5d with SMTP id h10-20020a170906110a00b008869b85ac5dmr275231eja.44.1676321402705;
        Mon, 13 Feb 2023 12:50:02 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906739500b008a94f69a1e7sm7303123ejl.163.2023.02.13.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:50:02 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add a specific compatible for coincell chg
Date:   Mon, 13 Feb 2023 21:49:50 +0100
Message-Id: <20230213204950.2100538-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
References: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
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

Add a PM8998-specific compatibel to the coincell charger and keep the
PM8941 one as fallback.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index adbba9f4089a..340033ac3186 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -72,7 +72,7 @@ pm8998_temp: temp-alarm@2400 {
 		};
 
 		pm8998_coincell: charger@2800 {
-			compatible = "qcom,pm8941-coincell";
+			compatible = "qcom,pm8998-coincell", "qcom,pm8941-coincell";
 			reg = <0x2800>;
 
 			status = "disabled";
-- 
2.39.1

