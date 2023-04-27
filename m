Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636706F095F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbjD0QMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbjD0QMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:12:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188793585
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:12:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f6c285d22so1642491766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1682611948; x=1685203948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMqYIMvxQzMeNZyvXScd0d9ZjZQUVmBHnaHMVur7PZI=;
        b=47g0X7BSbMbvv9L/Q9QUepC51/0/TQau9ztKHNIjZPRAu18BfSZwcYUZVenNlbaewp
         NiPe9w4TDMscaoknOdvTZvqMxgBuUlKkNmelAbA/YIopx4I29Mfd1897kyLRP88TVqmc
         8TFGrit4A0yflaIwe9JWcFsSul9heo5Du7IOoDFp+xVjVcCrm2Re6YVcjNu3brkYiqUb
         ZitjrlWKTlpSCbK0VTC6LjRaG8a16ADuC4RtEungg1SLxdCt8myxiqRtn82yGIavrB4Y
         mPjJo85tc81DLj8iZiLNJbtICwphoW9xH3sS7FsuxGd2WSaiRd8iICINbz1zs0LioeNr
         Vhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611948; x=1685203948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMqYIMvxQzMeNZyvXScd0d9ZjZQUVmBHnaHMVur7PZI=;
        b=TtT3z8alFYk+0YqddpK7D5VJiHP8BEthw6h4f/KBxaMqHQ1E3EX3xunrZN6zZRXh13
         g8LsNpT/7Plee/GyUTuIAfByU15lcNSZMRXDbiFekM0DGk37yIeeFSakwZIq3ZYmii1b
         V7j6SIYsDRGjIC9ToDP2ckSZIfqOJJ92Rmj985yaNxu1HjvQYs5uY3VWauD2YwVDd0dT
         YD0nKvjloRSTIwed1YfKk+SaalpgalDbnfbJemhKBm9e/sGQB/dMQWyABNo3G5CmjtQE
         1a+JXOoiB9qMncPlCxPotgwTIeQOCoU6JwjGSP6Y6UVExfXfO2rCxnhqEhcZshvXpNVb
         3qXA==
X-Gm-Message-State: AC+VfDwUfTppiFMd9qpT9we+jCBqRTZ5AnfHTanV76OjU2OG4OwcUtxT
        fxlH4q5/NGBSYw21NT04ZS5fnA==
X-Google-Smtp-Source: ACHHUZ7WBBja5Lx65Estj/dqaAZRltQnKHCN4a4WPD9RhhPeRBS3LNkizwx+3dPAR0i1nU1Vxk1z0Q==
X-Received: by 2002:a17:907:3e1a:b0:957:db05:a35d with SMTP id hp26-20020a1709073e1a00b00957db05a35dmr2670020ejc.48.1682611948580;
        Thu, 27 Apr 2023 09:12:28 -0700 (PDT)
Received: from brgl-uxlite.. ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060e1200b0094f3338129asm10144096eji.141.2023.04.27.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:12:28 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sa8775p: add the watchdog node
Date:   Thu, 27 Apr 2023 18:12:18 +0200
Message-Id: <20230427161218.201828-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Now that the hypervisor issue is fixed, we can add the watchdog node
for sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index badabf79c6ef..0737ba38fefe 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1008,6 +1008,13 @@ intc: interrupt-controller@17a00000 {
 			redistributor-stride = <0x0 0x20000>;
 		};
 
+		watchdog@17c10000 {
+			compatible = "qcom,apss-wdt-sa8775p", "qcom,kpss-wdt";
+			reg = <0x0 0x17c10000 0x0 0x1000>;
+			clocks = <&sleep_clk>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		memtimer: timer@17c20000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17c20000 0x0 0x1000>;
-- 
2.39.2

