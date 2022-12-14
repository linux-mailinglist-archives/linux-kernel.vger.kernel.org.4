Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99D364C5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiLNJ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiLNJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:27:26 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA17F21832;
        Wed, 14 Dec 2022 01:27:25 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 65so4015093pfx.9;
        Wed, 14 Dec 2022 01:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v2Hnzs0/1OJywqxGltmBJ3aGPcFLQM/mVyL2AkPibQ=;
        b=NNgZuapkeFk7n59ulBy0O32WFNBp51TE995pPuOgE5QJLoqrWkOWVFtoV5scKn5e3Z
         xaqMVhVK0LxpFgCi5MaTO43wQhauSWct2uGbH9U6GmNajOh2Ks/eLc2eJ07xU428Laz8
         m+nbaGm5wOee7OvVfeSnJ+mCSiFTuOgUk0vZ2Y1+XBsfrD2KoX/+xdTx9T5UunowER3F
         IgB2mqs/186mc7EHSnxk1TcLtJcd8Gm4wk/jURQK+ytRyfFmRzvCcx9Z6OcnID3YlyQG
         U/9A/b2GmceDvWkgwbJkK8Zj8WhiHN9UyujlRmb2tFE0aRhjQAy3b7Ql6BujngFF0xCz
         gHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v2Hnzs0/1OJywqxGltmBJ3aGPcFLQM/mVyL2AkPibQ=;
        b=nyU8ThtRStbM3CzKOnXGXMAkzSSwkf+dzpv0GHvucRQURxlcIv/ZqmkePjGdjV8NqR
         ZNbJBo7/nXoAkvMj/rfIKDhIwcOtqMP2BilouT/4KqzF7pv3qw5eG0LUi4tIxv+K6wiH
         AfeuTCLrpClaPAf5zlJh2agKvpaQoiT8pjU/fvSeTTWJ7qPB8k7vHCT+0WEwNdUM3xKO
         MTbdPxZdQ9NPcFSMkKItzrZUbb1/QUpSDRQQ6B1iYWGICkNzza93UYwxn8OfjnhCvHn5
         2s7qQN/2P8s66ide45Wp1/N8P5n4o6dBfUk0E/1iYb1DWcU5NiMDWUpmALjLN+eeNFC4
         CzVA==
X-Gm-Message-State: ANoB5plW/LNIofGJGVQYpqUd+mzJUOoNtJENxrcFDQ7/0q/US0ODJqYi
        17iI5CgG2BzuxXFQ79Bwym4=
X-Google-Smtp-Source: AA0mqf5hhWMvTBEcxBKuAav1yFJesn4l75sw28A1sQknb8ihHWqlvJvBB5lLwUGOIS0SFCHTbQvbgQ==
X-Received: by 2002:aa7:9810:0:b0:577:1553:9241 with SMTP id e16-20020aa79810000000b0057715539241mr27771275pfl.17.1671010045184;
        Wed, 14 Dec 2022 01:27:25 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t123-20020a628181000000b00576145a9bd0sm9003312pfd.127.2022.12.14.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 01:27:24 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v8 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Wed, 14 Dec 2022 17:26:30 +0800
Message-Id: <20221214092636.810883-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214092636.810883-1-milkfafa@gmail.com>
References: <20221214092636.810883-1-milkfafa@gmail.com>
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
index c7b5ef15b716..78a309a56cd5 100644
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
+		ece: ece@f0820000 {
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

