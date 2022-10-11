Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50C5FBAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJKTEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJKTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:04:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A76C0D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:04:37 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j21so6917137qkk.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0m4Z+4+FCGc7HbY9Z2fgPJugNdaCKUvzg3JKXxvmUR0=;
        b=kmc11stgLJRII0cVJ7VL6lBKyUVlUsme3zecN+9lmS4tWdbHIqBEoLgAMOgIM3ThDb
         xan8zs2Mros1EcZx7aITm69GvwmJYcdGspiCoYu4egt2S6p1fp+Wd3eTDIDfGNjy0weR
         r0ytWink0vB2nlM2dS1OxuYcpFz4vQZl6tPiBw5rD4YDBYAVHb1Oi5t/dVUogQyJglpo
         +70IjBD5NjifzF3EmkoyJQqRllyWUm3T8AzaWr2j0iRDO58s+Ag/fPxJcP99uMQH0BNq
         WAkF+C9PyBJmUJWEZPIIdoexE9dPC3uBOBdfdDfpBVLoXYl1598DZxCDrLrxw7Q4MWCV
         bmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0m4Z+4+FCGc7HbY9Z2fgPJugNdaCKUvzg3JKXxvmUR0=;
        b=REUm66Qpku54UblYHyst8eT/OAt1ac+Rw/1q5xC7BOOeH3ZDisWQpCGQ2hJwxzXmdT
         hPcj7sEUG9xgRfmDZSkK9tAD0PcTnmAdZD6VyYKAaeWVZ4FTp5Da5/GEIjG5tg02I8SN
         Lj2Mb3EN2ImR9qONXT9Uqnj9+FbGYldix26eSgyRxDaHxT21h8bC8/4seZSQveXslQJa
         q2fzGsS20SZlbdcmb2LsiaMXzzg7UREGF/rrEuRTmhgt/OlHdyEQjmSS/9rkgZsXu2Fu
         3OKSJmns7zurCBj8t02rYDZyOFWe2Ikn+D0si22dTuI+/IgHCi7mwLN7YptI6QDCz9LI
         q2jw==
X-Gm-Message-State: ACrzQf1LYs9jrnPPUzOfN5ViN67zEaNHuT08UNW+4faKbSuOeP5UnMKS
        fSjnmQsOjJatTOc8bN2D6mSemg==
X-Google-Smtp-Source: AMsMyM6WEyQyDwvOtDQ67NgwureRA5KlNOsRDgSUOCP3t+fLwRsMI8SJqBA7MMDWhdsmqmT3ZYHR4w==
X-Received: by 2002:a05:620a:2b42:b0:6ed:f368:c717 with SMTP id dp2-20020a05620a2b4200b006edf368c717mr6142164qkb.154.1665515076868;
        Tue, 11 Oct 2022 12:04:36 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14527185qkn.37.2022.10.11.12.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:04:36 -0700 (PDT)
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
Subject: [PATCH v2 1/4] arm64: dts: qcom: sdm630: add UART pin functions
Date:   Tue, 11 Oct 2022 15:02:28 -0400
Message-Id: <20221011190231.76784-1-krzysztof.kozlowski@linaro.org>
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

Configure UART1 and UART2 pins to respective functions in default state,
otherwise the pins might stay as GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

---

Changes since v1:
1. Add tags.
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index e119060ac56c..bc7c341e793c 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -723,6 +723,7 @@ tlmm: pinctrl@3100000 {
 
 			blsp1_uart1_default: blsp1-uart1-default {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "blsp_uart1";
 				drive-strength = <2>;
 				bias-disable;
 			};
@@ -735,6 +736,7 @@ blsp1_uart1_sleep: blsp1-uart1-sleep {
 
 			blsp1_uart2_default: blsp1-uart2-default {
 				pins = "gpio4", "gpio5";
+				function = "blsp_uart2";
 				drive-strength = <2>;
 				bias-disable;
 			};
-- 
2.34.1

