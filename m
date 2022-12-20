Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB5651DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiLTJmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiLTJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:41:45 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9912EE3C;
        Tue, 20 Dec 2022 01:41:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c7so8094181pfc.12;
        Tue, 20 Dec 2022 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuPzabFK+ItSAS4Njr3Xe+weyJyvM5VjKuGON2TO41E=;
        b=QlQ461LSl6/nNSszRRAa8o2iBTd+KVoKQMlAbv1zirCUs18dDrBF0bVkg5GuGojPa8
         Wl+lQl1FRWh4B5wZvC6lCySbxJvQHUz7c2ETo7IEKfMtd80ei7mboyB7iA9T2+gY1iAj
         yA+/dqGMj0UaO0Tow+JjIqxULklWOc4fE7fWJOzdYkoKogOYBoH8Fxm3JeTgUzbgbaiP
         FXYVPPEcwsIwYMyColcLOVjM2sHHNeTnTbiyv7fVkME2BOCbq26hK9L7G8uRbp5J0OJL
         /Z6vdizVosObwxDnfkuCwxGJ8RsoiDzI3S1Q5CcqG8uha3ovmZC5UBmFG9atvdSYTjgr
         IVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuPzabFK+ItSAS4Njr3Xe+weyJyvM5VjKuGON2TO41E=;
        b=FrjJ088YCglsycqHq4W992uDYcICU1UumEG5lwAgsaqyuUE/n9aBExPt5XOeftf8aG
         ySGX2nubKzZ8HHObcWWl0mcVCExNhD5UL877t1/KUFrg+wWU/vfgF92JYP8cZa79b4dC
         T/02E3FXi6iNrrvjBPk0wSDMz8ycK7qveM9jfIUFdCLE6sSJxl+3/qHrjQPm9HQkz3Te
         Swq/L6Dz3GjN/Rr8Q888lqNT+YM17BsOYoPHSKNbLDFXJfryEclYhZSByHtn/spBVUAb
         IExzT6S2FkyCwcXPjPF00SybWOZeWalmmTLOoZZRPKWz+HnOKZV5XF96aqYxb0Bi1G4d
         48OA==
X-Gm-Message-State: ANoB5pkTZLgPZOquXhLRuD+fBew/1q8f+l041MyNpFo86UnXe/t5BfVr
        t5lLtVvsYDsp0sgcqNWR47c=
X-Google-Smtp-Source: AA0mqf46h3a5VLwRn21N3VCnPWLOMpM4q9QAXLLV+3nNtDy7Mn4Rt9QT6rkkqHPVseUwWIHK0c97LQ==
X-Received: by 2002:a05:6a00:791:b0:577:f836:6bcb with SMTP id g17-20020a056a00079100b00577f8366bcbmr46682140pfu.29.1671529302340;
        Tue, 20 Dec 2022 01:41:42 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b17-20020a621b11000000b00576a89978e5sm8210230pfb.63.2022.12.20.01.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:41:42 -0800 (PST)
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
Subject: [PATCH v9 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Tue, 20 Dec 2022 17:40:49 +0800
Message-Id: <20221220094055.3011916-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220094055.3011916-1-milkfafa@gmail.com>
References: <20221220094055.3011916-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

