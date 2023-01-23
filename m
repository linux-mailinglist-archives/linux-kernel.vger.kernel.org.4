Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD03677B34
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjAWMkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjAWMjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:39:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43C7E07C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:39:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10504101wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AgOtt5P2IspPFUI7c8w5WSERc0jA8UFoB9NQWi3fF4=;
        b=xg4AaHDodgHXlDanNcVXmHs23yalek+9gtXH35V9UMjCX1ufTHF9rsP4hs+IhoOUhx
         x6bhJJdIEGdwOfEzBc+RW6Ny+hpuEylGdYyw6R3IrwM23XWJf0Xurkq5oeS0/wT1RD5D
         yruHYnpdXThTTBpOs2bSryup3+3qFQTr2/YYG+Vd/XF2C7KayEbzeQ8xjqHDxDwlP1r7
         ehK42D9+f2iYUOtLXuf6nDUAC80Ckzp628MAeLqy2l+Zru73xst9pQM5Obui80b063mR
         p6DnUkjQnZJmqpznD+Ry8r/uPW8EtQpyZ2mO0Itvq4VP1LUyfb6sQ7QxGR7YQWEmKqME
         5sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AgOtt5P2IspPFUI7c8w5WSERc0jA8UFoB9NQWi3fF4=;
        b=YSzPcghajsvS7zOslCXE7BnsMKQavVNOIG2is3V147h9J1mP9sV5FxQE8+W+mYJaQ+
         yvgZeeOxxJ3wDLwvyI15HGB09OXRQoSnumJD0Ce3HUpIxv9K6bKV85Q5RJ0YzM9s9ert
         LANmunsnXJJobErjoUfJwWjPEOOhAgFw25BuMGHQEv8JVubXqWo5RM3d5DCCEOAq71Ad
         AOSHH2gkgStPwkwsKDAGlxVe/9Qzaqm7FDBtYvyU6byFHFQfonUM1s6Q24Gxmi0Vmm68
         rVsZrJ8umiNPC/+bczea338DVfCHD9VryBybPBfUSucFJGxsJ9AMd8aKDHTl2eGiXAFA
         Nj/A==
X-Gm-Message-State: AFqh2kqlncdBm4SIz6YtUlQGotYh9OxXmEU1XGq6AIF49vznJtFTFGEw
        7sIDssuCJPPFBGtTJYZV1YmqEA==
X-Google-Smtp-Source: AMrXdXvMsNrGrLZqmJtcl20OcHffJIcgX7rfzgimiE3e64uUyjpLDfh92PeMjkRJUcdRR49vVmA7SA==
X-Received: by 2002:a05:600c:684:b0:3cf:5d41:b748 with SMTP id a4-20020a05600c068400b003cf5d41b748mr31873893wmn.36.1674477585138;
        Mon, 23 Jan 2023 04:39:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b003daf681d05dsm11347568wms.26.2023.01.23.04.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:39:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sm8450: drop incorrect cells from serial
Date:   Mon, 23 Jan 2023 13:39:39 +0100
Message-Id: <20230123123939.139327-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123123939.139327-1-krzysztof.kozlowski@linaro.org>
References: <20230123123939.139327-1-krzysztof.kozlowski@linaro.org>
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

The serial/UART device node does not have children with unit addresses,
so adderss/size cells are not correct.

Fixes: f5837418479a ("arm64: dts: qcom: sm8450: add uart20 node")
Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d66dcd8fe61f..395a3a156e24 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1017,8 +1017,6 @@ uart20: serial@894000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart20_default>;
 				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				status = "disabled";
 			};
 
@@ -1411,8 +1409,6 @@ uart7: serial@99c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 				status = "disabled";
 			};
 		};
-- 
2.34.1

