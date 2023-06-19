Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2725735CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjFSRCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjFSRCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:02:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2937A10E0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:01:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso5076896a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687194117; x=1689786117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JaUNq2uBkN/LZLH2KyX589Bxtvv+gIlmVGHptckdMA=;
        b=XmczEfH9cf2mva55kZ98ts5ntqtiOr7Qwfd15OMEXEe6VwJhJzQ+zww+d4VkuCcRWA
         XsN6XYuaruND0FTQw2/dXNuyYa+JwvIo2HcBTCgSORHu1dZYpY76chbpWIMGu7VtK2qY
         ICCFxVWVI6fPOBq60VX0HPhKbWupVT8HoQCFEQxNMs3XJI26KspK3QXOQ6k1y+K3qkJg
         f5tmq6C4NC0hDdOCH9M/nN4ll4AFEEWSr/XHoW6oFQMs42USuIWY5nthD7sOhlEVzD+D
         meGBoFUHi6oadclrwF+hrbG54rPYRvo53XtrVmvSN7qDrObBbWHjxTrZ8Xx3BPEBSRsN
         Xaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194117; x=1689786117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JaUNq2uBkN/LZLH2KyX589Bxtvv+gIlmVGHptckdMA=;
        b=NfAd06Ib/KIWrU6XCNeoFFYsGRPFCkmaMemKhv+OOh8buwF6g9nOE1LBM20WLPl3CV
         Qy1yxmsX6UlS0//I+53wAg8Uq2X3ZPpehR5rNJGHLA9C/S9aQcGSnPiB3n0E57e45JXH
         O2bvxeGXDML5j6wWlZOdW3KklnXFRdS3FCgADze+omHdDvIzd7DHifnOXktAFP4ZLXAu
         nIZOpuZDO1MQFifSbBa1/iNxEo33fyJK2ACkIrTJ49oj+hrQAwh8NOYR5cZ/naXwpjF7
         sx3j4wDt9I99A5SRJi53qUzFnGBKFilSyzllkD+uSHczxA9/Sb/RX2QtCH1oT/w09hnT
         Ctjg==
X-Gm-Message-State: AC+VfDyshqZh1SHn5mlWJm8Jg3Huxrggyed8MdU1gp3BgXjgRPujYHv7
        XMtMsOTtVxpJ9XTIaQSSXFf+5A==
X-Google-Smtp-Source: ACHHUZ4A4Xqk6DZwE+htrE1EoU891qG5cn72NFcapvZV3QrjOmbfRRw6nz4ZGbsVZwBlgY4wLXt3uA==
X-Received: by 2002:a05:6402:759:b0:51a:7bcd:a82d with SMTP id p25-20020a056402075900b0051a7bcda82dmr1472410edy.23.1687194117629;
        Mon, 19 Jun 2023 10:01:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p9-20020aa7cc89000000b005166663b8dcsm13136672edt.16.2023.06.19.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 10:01:57 -0700 (PDT)
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
Subject: [PATCH 3/4] ARM: dts: qcom: ipq8064: drop spi-max-frequency from controller
Date:   Mon, 19 Jun 2023 19:01:50 +0200
Message-Id: <20230619170151.65505-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
References: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi-max-frequency is a property of SPI device, not SPI controller.  Drop
it from the controller nodes.  No functional impact expected because
child SPI device already defines spi-max-frequency.  This fixes
dtbs_check warnings like:

  qcom-ipq8064-ap148.dtb: spi@1a280000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 1 -
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 104eb729c2d6..1796ded31d17 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -282,7 +282,6 @@ gsbi5: gsbi@1a200000 {
 
 			spi4: spi@1a280000 {
 				status = "okay";
-				spi-max-frequency = <50000000>;
 
 				pinctrl-0 = <&spi_pins>;
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
index c5abe7151f14..17f65e140e02 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
@@ -30,7 +30,6 @@ gsbi5: gsbi@1a200000 {
 
 			spi4: spi@1a280000 {
 				status = "okay";
-				spi-max-frequency = <50000000>;
 
 				pinctrl-0 = <&spi_pins>;
 				pinctrl-names = "default";
-- 
2.34.1

