Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E735EE00A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiI1PUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiI1PUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:20:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151B757273
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d42so20981923lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=o6z/7qFA6aTihIkRQlQVaaDZnJmWKtOGTISKDfUokng=;
        b=j25kiT8VnKGSOkq1tFxRLGMrqmV7bc5kSuNe6rED5H5ELh4c73c5GGHbrrVWjPVCh/
         zVwCUiI+eY7ke7Dp3Y2qUiSVD4qpSZepTH4XchPvfgxh+SBxTO4yZUILl4dsEphwneCW
         QCiX40qRwnixWarJMF2mfOlCAYzvOCNUthj1Iu1L6nCRNL95WL/DOnR498J5MlYHDi9X
         GDl6kzN4PGLruIhogiKUFvS4XSTJ5vaGPoY6gF2a4z4xyMH3PLCsAq6YYkPDOt/Hv7/o
         lY6nAA8RGrO+922kU2jOVka1sDDuePvKN/uHzF9Ql1/RNtGjFWs5yQN+ZqoMAr+km5hC
         PaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o6z/7qFA6aTihIkRQlQVaaDZnJmWKtOGTISKDfUokng=;
        b=PCoSoxyCVu5V3/mGI3tARwx6dT77HLH6ExX9NDzyoTpKrZpg5Os8EBIGamKOnPHUU4
         2gy19hgOoQaFcV0wB/5eaAXe5YyAbGITnXpO5S5SKCx1QbnmyVE5t7OmvZ0YvpjMwhQj
         juEMqt2swnj2EbyTWS7mIi9UN5rSeBCYIaql/tMi4a1PJiJ/2r5repET+1nkHx9KTMzy
         XHoT31L7l/WlfVx6q7yTVRtmRHuctptniUdH4cyjD6oXhsuJz61m1Esfe9s3lV2kP8dT
         Cekj7wsvH/SRjGBZVX+K20WAepRa0MiItKsrblBShZgPcnzE9Rguw3kDOTP2jRbDRug/
         iwkQ==
X-Gm-Message-State: ACrzQf1omfU7mMdUqp2/BNJHJw1UCYWPawr+pHvUD5B+w0fvnI5fYFba
        SG1ghQn05vumxEwdrKWyYltrTt3oEfIAqw==
X-Google-Smtp-Source: AMsMyM5iIpHnFvI01xKPQmtcSKnVEWQ7ni5Fcd/dJO7PhSyM7oqJ3Lg4MJHgBgjoyypLJWhp1562Ew==
X-Received: by 2002:a05:6512:1055:b0:49a:de51:5458 with SMTP id c21-20020a056512105500b0049ade515458mr13216754lfb.585.1664378432933;
        Wed, 28 Sep 2022 08:20:32 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b00497a41b3a42sm503023lfq.88.2022.09.28.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:20:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v2 01/11] arm64: dts: qcom: sdm845: drop unused slimbus properties
Date:   Wed, 28 Sep 2022 17:20:17 +0200
Message-Id: <20220928152027.489543-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
References: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
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

Drop properties from slimbus node: unneeded status and
downstream-related qcom,apps-ch-pipes/qcom,ea-pc (not documented, not
used).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d761da47220d..9db1fce6b198 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3828,9 +3828,6 @@ slim: slim@171c0000 {
 			reg = <0 0x171c0000 0 0x2c000>;
 			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 
-			qcom,apps-ch-pipes = <0x780000>;
-			qcom,ea-pc = <0x270>;
-			status = "okay";
 			dmas = <&slimbam 3>, <&slimbam 4>,
 				<&slimbam 5>, <&slimbam 6>;
 			dma-names = "rx", "tx", "tx2", "rx2";
-- 
2.34.1

