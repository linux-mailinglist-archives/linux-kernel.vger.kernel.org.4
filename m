Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12286552AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiLWQTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiLWQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:18:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F71C415
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:18:45 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m29so7591520lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdfFWcY+yQYlh0eS7hJEt/L6xzUJsk3MolFNlo9O/TE=;
        b=RSAiBTBKcepcbgnlkhqoFng1MUZlwTUzS6PLXgohGapWJ4tLZZZAC1xOaYDBspIOCs
         enJLBRP1A+Pr1zGpIgC48D3JU+FbaNh+P8k9gH29JtWfiOnisbIJmy5yOuNwzDDHDp7h
         Ln1oIhyBw4T4tmoWIZkgbI+Av5Zu4zWjZu2tBf0avbyQocFXS+L8EQCBJOMGJUxuecq0
         zbboOWyvU8MvInUo5wDbJDCxbApucVCyrQb0hqiZ2ofPCDdNerBRoOI8TU9OYV+FRS56
         p0RJy+UQro/pScUvlaOQBAXHj3r2EmuFKrIVS0mm7B3JBpRdnYikEolAVdYD1QPnVbLl
         s6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdfFWcY+yQYlh0eS7hJEt/L6xzUJsk3MolFNlo9O/TE=;
        b=f8ee/rF6DHZA260jAhsilIsRJ99lmwQVbLh8LwqxSrU5YwtWd1unBFhNMTjvxtpJ+Y
         tMfj0LBPzcHt0+VbTEulKCFT3byQvt+5zYGjztDFcwJvJ9kG+VUFhTjpRAkHotwP7dak
         xzlfJxL930i8+xuJorJpziaD+n/jrrkKugIvoCcGCK+p1cViBFNHBhmOnbyoCJLMBDSz
         wCwUyrOYob85LtIbg7+7MQlwvRc7YDdLHIuGwLtIjgRuYCs8D1gedl9SAQnrKR+nei9r
         gjb4zThRhfACB4uQPCnxt+jHRb+/QWBUOofAygYEEbzSqnLwSiyfDERCjwt0dlVeQYSu
         plEA==
X-Gm-Message-State: AFqh2kql6MEeu6BmIDvoCizctIxeSkurMPAvGB9rzM7yzfi+f7dRVF4O
        dZdyLu6LbH5dygHu7afrQStijg==
X-Google-Smtp-Source: AMrXdXtBfXtxh246hKlPoh31B/GUNxN1je2pQ+6h33637hdWUCDLRTiWPmRwsILupKeWsZqoQzYA5w==
X-Received: by 2002:ac2:5e2f:0:b0:4b5:5a15:8050 with SMTP id o15-20020ac25e2f000000b004b55a158050mr2441393lfg.32.1671812323443;
        Fri, 23 Dec 2022 08:18:43 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n18-20020a05651203f200b004b4f2a30e6csm581360lfq.0.2022.12.23.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 08:18:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ARM: dts: qcom: sdx65: add specific compatible for USB HS PHY
Date:   Fri, 23 Dec 2022 17:18:34 +0100
Message-Id: <20221223161835.112079-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
References: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
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

Add SoC-specific compatible to the USB HS PHY to match other devices and
bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index b073e0c63df4..d3c661d7650d 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -219,7 +219,8 @@ blsp1_uart3: serial@831000 {
 		};
 
 		usb_hsphy: phy@ff4000 {
-			compatible = "qcom,usb-snps-hs-7nm-phy";
+			compatible = "qcom,sdx65-usb-hs-phy",
+				     "qcom,usb-snps-hs-7nm-phy";
 			reg = <0xff4000 0x120>;
 			#phy-cells = <0>;
 			status = "disabled";
-- 
2.34.1

