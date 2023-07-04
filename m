Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6EC7469D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGDGof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDGoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:44:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17B2E42;
        Mon,  3 Jul 2023 23:44:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26339ef4212so3729104a91.1;
        Mon, 03 Jul 2023 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688453068; x=1691045068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbS7rm6AM4XH8UoO3ynpeSvV1hwaSm51g+RnnML8YOM=;
        b=sJ5ni6HRmSdFcP4rsLYzD7qefh6dZC38ZNahYQDga7z4XmmjcdWJST7FF9e/ArQHaq
         4WmGTdMNjpE5mf8+5Xgev5djoutsGJntI94SBxLUS9fFqbwtdkSoz/nEzGio+/ZWQhJk
         wmvzItKUWPK+SYdWBKiLZqLXS8UO+U/3Zc0xuukmHr3lHixUMcF3i/b9vMfXJQLVlZrX
         Z0e6ismh4Nyz4giFL13D/dOs6pj7XJv6LeVhkM43Kmecs+upVazBPXFs8SvsiIcUKWBF
         DtpDUvOXb5M2brjwop6wckH1K0nI5wrPXVsxp2qeUttLl8PAUCJje8HH+k5heK/gQVty
         ijaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453068; x=1691045068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbS7rm6AM4XH8UoO3ynpeSvV1hwaSm51g+RnnML8YOM=;
        b=RXdoyC3MvpCYep1PePMhcqmrbT4kt+jNTGi9oY/34GcHDQMQXGDjyAHKAJtCvpeC5v
         FJhy8vg41sNbJ7eFFbFhpUJRNy/tZ3NuhobaIhikDZqfBOju0TjTP0YDlindR9jE9hjX
         U8LnExxi0tSOXjXb/chB+MXdnkwsNUkODcmJDuZHAGAX4IlJ+nX7F1D3k1XSTZQ9FsJB
         kpiwyZS0YLJNagstG5/ipO59/GKKErSpivMIkR1v2Gwxou46WMliyR43VtCgsUTnceOQ
         +4qyBOLIW3e76Piuwn0e5OjGU6PlynBztIQT1On9lxFf6KnER6CmuiJYVT5/7LyzhQSf
         uIzw==
X-Gm-Message-State: ABy/qLYoa9LwC4vbF9dojhz1UWNogNvzbVHwU5Zhqx/vyxRUm5RgvvFr
        7PIF9qZfP9/Mn2+PqVo3Mqw=
X-Google-Smtp-Source: APBJJlHaFp+boEpHow3asBQL1qclJo2h+8NqCMr5bAu+/83eM9Os+Y+now5vXRCrBrSP046LHxQkvA==
X-Received: by 2002:a05:6a21:6da4:b0:121:e573:3680 with SMTP id wl36-20020a056a216da400b00121e5733680mr16069056pzb.62.1688453068088;
        Mon, 03 Jul 2023 23:44:28 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u2-20020aa78382000000b00668652b020bsm14863429pfm.105.2023.07.03.23.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:44:27 -0700 (PDT)
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
Subject: [PATCH v13 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Tue,  4 Jul 2023 14:44:06 +0800
Message-Id: <20230704064412.2145181-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704064412.2145181-1-milkfafa@gmail.com>
References: <20230704064412.2145181-1-milkfafa@gmail.com>
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
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..13a76689e14a 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
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

