Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A756B07A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCHM7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCHM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:59:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D2980912
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so65296824edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhF/mzh0k+zMYd6+HxisiMZ606cMBeE43QJPsA4dPIc=;
        b=TeV+54l8IBRjQMNRFlMWlz+T+fo3KjiaUbMPWV0T8DMN1EzwmIbz6IMRdwpNFf7jx3
         AagBLRw7+I2SItoNOJzsdjMsgdEmRGT0S4fOU1OuOhnTPrVonB7UmSfx3MPhGLsNw7PJ
         JX5vG+L2/5tUK5qG2P+cJaO1WshIktxO/b9BQcV+FDEgqDX0djufAZZO4R+IjP7u7DVG
         En2ioaUfA1imTrUPlR20wACRgTxMeTRc8WPmzoFKngPP6+XaNT/uOmGr99e5CwDYnWK2
         afNYH77W1pO8NK0t3gSmqV9Y8vZIUr8L5hqDXPiHcV7Bra2FhkDqd6mIobxbK+S3iJQq
         to1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhF/mzh0k+zMYd6+HxisiMZ606cMBeE43QJPsA4dPIc=;
        b=YxU0eNsazylyr/Op7RyimxWafubeoMu8rba6twfCQN8jTlRqALfXR+Sl7VLbQw4X5b
         31eQ4IXPX58/vrlsqxl14vfy8+Zl+BUeeCTg4dYkeooXpgbtc8/uKGfbwyUswOu/WV0a
         Pa2u8sZm1YN6JS4ICSDAtpqT+z754OYX8avG1JkVOJVhtqfCZXU5olbWQg1YrpjPC01G
         W7qVqFOwfMfrQ/lHcnkwUYZU1AgucKMY2jBxjhBE9ZW5Z0w0xazgocT1VQGL/7UMdPS5
         dNwBX9TduY9qumwiwsHnjNdi/yVu78/1KgediCJcgy9R1vbH3fgxxDuIUXyK+b/Li5SN
         tVxA==
X-Gm-Message-State: AO0yUKXUVYFET2eoWCliEUrezYtQPgU0bW6TgJftHIi0npAWs9Qahllm
        zOGfIrui/nirEc14v2LJJxHeOjFfzHbSObD0q58=
X-Google-Smtp-Source: AK7set+/j7fN61xZoo7aKL2n0aPWp7upuGeyOT9jjgvwGyMNHh4IT5j1q6fnfGfJc4NZvIWYdkg99w==
X-Received: by 2002:aa7:d6d5:0:b0:4c3:8bde:c250 with SMTP id x21-20020aa7d6d5000000b004c38bdec250mr17751253edr.33.1678280354601;
        Wed, 08 Mar 2023 04:59:14 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm7464141ejf.212.2023.03.08.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:59:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 06/11] arm64: dts: qcom: ipq6018-cp01-c1: drop SPI cs-select
Date:   Wed,  8 Mar 2023 13:59:01 +0100
Message-Id: <20230308125906.236885-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
References: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI controller nodes do not use/allow cs-select property:

  ipq6018-cp01-c1.dtb: spi@78b5000: Unevaluated properties are not allowed ('cs-select' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. None
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 2aee8594b280..f5f4827c0e17 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -35,7 +35,6 @@ &blsp1_i2c3 {
 };
 
 &blsp1_spi1 {
-	cs-select = <0>;
 	pinctrl-0 = <&spi_0_pins>;
 	pinctrl-names = "default";
 	status = "okay";
-- 
2.34.1

