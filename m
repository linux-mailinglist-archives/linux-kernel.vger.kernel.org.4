Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE576337AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiKVI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiKVI5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:57:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88B13E23;
        Tue, 22 Nov 2022 00:57:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so5641437pjs.5;
        Tue, 22 Nov 2022 00:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/LrnywkrjZ6Qfs+hNXfBn9CmvlX0OVs2pAPszfej7k=;
        b=eMKfnKwMv28riF4/1YDHxxK8upeNNMiNDjQpW6o9YVS+Jr8+795bfHT9iV16JsLvVT
         4R+DuRyRxtrXCFUOBSu0J0PQ7ZpTWro+WvQLwMhOA79LC7qatKMKILooHW7d2VUIRj4Q
         GFaDzHR3rQSNzlxn+SMa8IYGvvUA9KBlwR4VITz1PmSXik6FSxoKLpMddVwACxNbBnki
         aGmXJdVDkULulIV32etotTLKAzx+PpuDJT7+2fcvalTs1ExuB0b1MZN57NbvCz17ubmM
         PJ8ll8jP0cAamxd/I1a7jj7HwGHzn5E8lDfXrlUbmUXTW2iLZ+IHdg6JH+1G/8qxMYU+
         rDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/LrnywkrjZ6Qfs+hNXfBn9CmvlX0OVs2pAPszfej7k=;
        b=PnqnJuhMRgkvaYcJ15YsXaMDP8Fcuqa8OLU0MqmLTWHaD6lEhP9OWC/ea7uULLOKoO
         iZ7KVnBD8cQnyFJDcGDdeYVgb9yIuZ20oF24CA9lPEdzd1GRRIBaTqpO6lV5GcLYIGpK
         sBzwbdv8pMxdVTTROu3xbSoBKRsgCwLMRfeRu7XiyHuzVB94NSW5RASnrLbPs3KRzIPY
         111pEi7Yc7gHILG8omvjrrR31po2DGLyxJMpdtlGNpsAGAgWXJA+UdHe2GQODCeRDtOa
         MeHD4abQK68OEogSCIRQyS5q98xFRiCFvXartXPYlUAeTYwxLQylvfaoO4qi2k9XHrOj
         3e5Q==
X-Gm-Message-State: ANoB5pnzo2gEkqJU5jCA5XxPrqo84kYnaL5JJtmPBusPF465fB3tiiaA
        rDs/MAZHYR45kwL6geCKr2g=
X-Google-Smtp-Source: AA0mqf7R/9SWqm4vCdZgR/GaCtej2my5MbCo53bMaMnGAVFZ9TXhFDlZEVPGNFE3Ek/im26vNJqXEw==
X-Received: by 2002:a17:90b:3d7:b0:200:2538:1ca8 with SMTP id go23-20020a17090b03d700b0020025381ca8mr30950096pjb.79.1669107468489;
        Tue, 22 Nov 2022 00:57:48 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017a0668befasm11400246ple.124.2022.11.22.00.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 00:57:48 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v7 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Tue, 22 Nov 2022 16:57:18 +0800
Message-Id: <20221122085724.3245078-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122085724.3245078-1-milkfafa@gmail.com>
References: <20221122085724.3245078-1-milkfafa@gmail.com>
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
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..293a550955bb 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -179,6 +179,19 @@ fiux: spi@fb001000 {
 			status = "disabled";
 		};
 
+		video: video@f0810000 {
+			compatible = "nuvoton,npcm750-video";
+			reg = <0xf0810000 0x10000>, <0xf0820000 0x2000>;
+			reg-names = "vcd", "ece";
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
+				 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			reset-names = "vcd", "ece";
+			nuvoton,syscon-gcr = <&gcr>;
+			nuvoton,syscon-gfxi = <&gfxi>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -554,6 +567,12 @@ i2c15: i2c@8f000 {
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon",
+					     "simple-mfd";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.34.1

