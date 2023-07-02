Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E195744FEB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjGBSuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGBSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:50:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC3DCD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 11:50:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9922d6f003cso466040366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688323817; x=1690915817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShIRLb/T0SXli9dNVjoX+o4ud2DtOJUYP1DJPs9akRU=;
        b=miJXM3uy9SdqYUHKnop2enZymc1tHyMzOXfK5u1NqdJhXBKNH/xIQqAQBloVN9XYiI
         A+XFmRuIX4iFgM5k/748UdTa7wRZyptJJrD1Qfzuzkq0W8bKqF+9qC8CtNIFSnl5S6h9
         dwmbYDYU6jxVWSKlZ2XLmg/8Kz7x4jrjZde1ioCFJEsQAQnMS4vWUZ7Ptl3/4BEE3aVQ
         TZW0J3LBczEHiblLMedMIPcaTHJXTE668Faxi8jYYlFbdmuoRsRsWYUHmBwNsacqLNao
         2oj0AH9AT4d/8gP0Mt6Z0plLeY/f++PsWTsZyVyxyXkJaszdPnk3BPoGhoQFRLlI9GoL
         vp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688323817; x=1690915817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShIRLb/T0SXli9dNVjoX+o4ud2DtOJUYP1DJPs9akRU=;
        b=T7+pygu09YYaw5cpdkLOkfNjuOnRULiBunz/IbCV/CsYwV18KFedTCdiOu7vQAH7R8
         wx1J75skfUuoQ/DzY4JHW8HOHJGxdT5bGHFBv7sXFJAfm7PIxxQY3yvH2Pyuv81VVo2c
         cPeGVHDkJ7ivz/HWIfxxiX9p9LLMbWrOGA+pAM2oj8/0GwtUCR8KYYRUcHGwoTBXc90i
         WbmZ46PlVDk/KECiQQrhyFz+X6w8Rb37DJnnU6ahj6U4jUwKg3Rw4uXf8RtFZD5p7oIf
         3L3L6SA+FtSY8NbAUx0zfSqMVJolvMuSef0g59J9FNoTt7RIV/s6qQ4pxcd590OTf+fj
         m68Q==
X-Gm-Message-State: ABy/qLYAlarrKH9rKsIbLLQSR2EBHrKVe5HyIH4XftFPoukXnUUnjdLz
        XDbBqhroJVZqr5p6yDfvvftpew==
X-Google-Smtp-Source: APBJJlHuTVbiKp679O6/n+td8laZUO8bL6gUeQP3/U5Kz1R+Gcqo7LZWcgkChpXE57Ps1ruf94WAWw==
X-Received: by 2002:a17:907:76e7:b0:97b:956f:e6b5 with SMTP id kg7-20020a17090776e700b0097b956fe6b5mr6129887ejc.23.1688323816679;
        Sun, 02 Jul 2023 11:50:16 -0700 (PDT)
Received: from krzk-bin.. ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090666d900b00982842ea98bsm10861789ejp.195.2023.07.02.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 11:50:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] arm64: dts: fsd: minor whitespace cleanup around '='
Date:   Sun,  2 Jul 2023 20:50:10 +0200
Message-Id: <20230702185012.43699-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
References: <20230702185012.43699-1-krzysztof.kozlowski@linaro.org>
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

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 1c53c68efd53..bb50a9f7db4a 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -353,8 +353,8 @@ gic: interrupt-controller@10400000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
 			interrupt-controller;
-			reg =	<0x0 0x10400000 0x0 0x10000>, /* GICD */
-				<0x0 0x10600000 0x0 0x200000>; /* GICR_RD+GICR_SGI */
+			reg = <0x0 0x10400000 0x0 0x10000>, /* GICD */
+			      <0x0 0x10600000 0x0 0x200000>; /* GICR_RD+GICR_SGI */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.34.1

