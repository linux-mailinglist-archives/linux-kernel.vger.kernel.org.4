Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8DA6F3F6C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjEBIo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjEBIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:44:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC8746AF;
        Tue,  2 May 2023 01:44:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaff9c93a5so10813855ad.2;
        Tue, 02 May 2023 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683017091; x=1685609091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuPzabFK+ItSAS4Njr3Xe+weyJyvM5VjKuGON2TO41E=;
        b=c/MC+l2PMjUh5/z1Lq1LWNShz3iTBiYLiDKEHLRYf9g8x5hrU08x8J/qDTkjMCziE0
         45Hq+XxnheXMwOhVFiTR+Q1YlbECt0CrVbMC8PZdDAYh9wuT+FtwLNHxm65WQpyGPwGX
         3eMYqYfAYIe26Oi92PjOhK3MOI3S17pbUl6esXjvSKuxyhGV1X3Bf65WWKRGu/9/qcR/
         1+ZvQIYN++2PFdUq/ct1atMq7pXKDZ7DkVn8q6BQAsCMlfVkdy6cORr8+kcrdOM3QI8c
         ovZLi2E5h6ZguOhkDZLmAJ6Dr4aboNiMG7IEixEn7soWxAGV2igzJWPDulwfzNPxuoir
         fjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683017091; x=1685609091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuPzabFK+ItSAS4Njr3Xe+weyJyvM5VjKuGON2TO41E=;
        b=gxL7PAsbBwf76aEMZLvhdGQYuUpKBQxdHwa0g24h5ho9fJKGLc9Dg7NimQX9AUXWOW
         fEXxmrq6tix6c2fG378gBy78u+WiBG71M7JebabrWl7XuSktVQsOOX2fRWDyuHuq4w3k
         u66sep1EuOohbuwU2SodwmRPrjYP+RjCNdcFzCZkeOz9fe6RzNuHXqoA/gWreiiHbrQH
         qLNaFGz8r/eyVFd6LiyQG5kOxl4AF11KHdoG9iB4hinEzQfYBxLGhqkI4Vz379qbR3B5
         kzT5BsfQ0f+g73/+1cUwp1jdMAD13Cksp2HGRVGZm2eMhOFtROn5V1rFWJ+mhFNbk7Rr
         U/JA==
X-Gm-Message-State: AC+VfDz1A+9CmspgnySHIm4PnWd4qZOEnPJJhx7wHI9HS7rp3bkkcAof
        YXqMXHfPv5V/Q5ZLKlIep/hwyrHEx/8Qcg==
X-Google-Smtp-Source: ACHHUZ6bUD4qgqGKN6owikfnkWn0bSk7LqcSoWh8JI23V73nSqA1zJx9mOBO3JY9NzIHkrppxqcICw==
X-Received: by 2002:a17:902:e849:b0:1a9:8ff5:af43 with SMTP id t9-20020a170902e84900b001a98ff5af43mr19514100plg.18.1683017091235;
        Tue, 02 May 2023 01:44:51 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a520a00b0023fcece8067sm7059039pjh.2.2023.05.02.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 01:44:50 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v12 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Tue,  2 May 2023 16:44:24 +0800
Message-Id: <20230502084430.234182-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502084430.234182-1-milkfafa@gmail.com>
References: <20230502084430.234182-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with
Nuvoton NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..13a76689e14a 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -179,6 +179,24 @@ fiux: spi@fb001000 {
 			status = "disabled";
 		};
 
+		vcd: vcd@f0810000 {
+			compatible = "nuvoton,npcm750-vcd";
+			reg = <0xf0810000 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>;
+			nuvoton,sysgcr = <&gcr>;
+			nuvoton,sysgfxi = <&gfxi>;
+			nuvoton,ece = <&ece>;
+			status = "disabled";
+		};
+
+		ece: video-codec@f0820000 {
+			compatible = "nuvoton,npcm750-ece";
+			reg = <0xf0820000 0x2000>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -554,6 +572,11 @@ i2c15: i2c@8f000 {
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.34.1

