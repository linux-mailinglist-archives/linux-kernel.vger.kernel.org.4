Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD8A6A9115
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCCGhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCCGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:36:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D954B2202D;
        Thu,  2 Mar 2023 22:36:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so1309302pjg.4;
        Thu, 02 Mar 2023 22:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677825415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUjTuzTTp/FXXoYY/BQnloUngbziX8MGZzy2Wy1/eYQ=;
        b=JC0qTlMTJWmsRiVb1Y+BFH8rXX42ktQzahOVJkBIoDodPtfUJrsYcNFQCwj3l+JXMo
         tRXx2a7UAMiZBe6V4I0bR4UktIV+H0hU7AT9aQomE0ibQx+VGDswpnFYGjPucS1Q3C0p
         hZ7Aj7ybRxjq3scaDaBq/17tvOG7WEG/AES8XOu+PN4CnJ29d2cmnN68iPbWCY1UmDkz
         7r0PxTYEhvv7xwSve25GPBOqcZanmYet/PquzEypPzZRBjUXFjihQR79bCfvbt5PMHsd
         qUOLOmZW3TErqNzmzfgrSogIb5uT6TMDMfbUey0KlDMyAgnA8EOWhXx+F6RFABUohOBh
         UMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677825415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUjTuzTTp/FXXoYY/BQnloUngbziX8MGZzy2Wy1/eYQ=;
        b=sSX7k4oH9vRKFzzG3d4Wj3h4xy8RvHT0pkcVtkosnJve+5+Ag/YSYXj9uvbfPpgSII
         f/9tJBPVTDqn3EzYHvAJH/q9ibVyLaIscHZr31WHCA5YWaMjkHiv22gypGOUuXZDJ13H
         8mUFdDLJhk5a+F2T3ZSpX5KKYV/JdgWRxqwJOwVIRJVjrvEHaJARKdHKgzOQG2mLIMK3
         oAUGgjByiPqzc1m8M7MEofPu2RcWZrwxeIVsQ1K3ipeTNoFjZVj+jbvHkZqyQGBK2yeh
         +pI7kjixx9zh16u20fPyOFxMpROU67lS70MxMXuum5SeAgvufi/udd0uFNYYx6cQFtk+
         u6/Q==
X-Gm-Message-State: AO0yUKW5iiNUopQ7pQgeI2xm3e732Tv+SCxbhOE6AzFA/DUexEa4W4Ld
        JoMGCamsmr5j7k1W3DF/42U=
X-Google-Smtp-Source: AK7set98WDaa+JVAEEXTa16vJKHXteaKqiwrMQSwBheW7GzCdujgBd/N7Jn1lwBGaRTF/gnffERXJw==
X-Received: by 2002:a17:90a:4e:b0:237:b5d4:c0e5 with SMTP id 14-20020a17090a004e00b00237b5d4c0e5mr582481pjb.27.1677825415298;
        Thu, 02 Mar 2023 22:36:55 -0800 (PST)
Received: from davidwang.dhcpserver.bu9bmc.local (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id l30-20020a635b5e000000b004ff6b744248sm736348pgm.48.2023.03.02.22.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 22:36:55 -0800 (PST)
From:   David Wang <tomato1220@gmail.com>
X-Google-Original-From: David Wang <davidwang@quantatw.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        fran.hsu@quantatw.com, David Wang <davidwang@quantatw.com>
Subject: [PATCH 3/7] ARM: dts: nuvoton: gbs: Split SPI flash partition
Date:   Fri,  3 Mar 2023 14:34:31 +0800
Message-Id: <20230303063435.803097-3-davidwang@quantatw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303063435.803097-1-davidwang@quantatw.com>
References: <20230303063435.803097-1-davidwang@quantatw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the primary and secondary BIOS SPI EEPROMs in 2 partitions

Signed-off-by: David Wang <davidwang@quantatw.com>
---
 arch/arm/boot/dts/nuvoton-npcm730-gbs.dts | 29 ++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
index 9e9eba8bad5e..a33766e430d7 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
@@ -414,7 +414,20 @@ flash@0 {
 		spi-max-frequency = <50000000>;
 		spi-rx-bus-width = <2>;
 		m25p,fast-read;
-		label = "pnor";
+		label = "bios";
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bios-primary@0 {
+				label = "bios-primary";
+				reg = <0x0000000 0x2000000>;
+			};
+			bios-secondary@2000000 {
+				label = "bios-secondary";
+				reg = <0x2000000 0x2000000>;
+			};
+		};
 	};
 	flash@1 {
 		compatible = "jedec,spi-nor";
@@ -424,6 +437,20 @@ flash@1 {
 		spi-max-frequency = <50000000>;
 		spi-rx-bus-width = <2>;
 		m25p,fast-read;
+		label = "bios-2";
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bios-2-primary@0 {
+				label = "bios-2-primary";
+				reg = <0x0000000 0x2000000>;
+			};
+			bios-2-secondary@2000000 {
+				label = "bios-2-secondary";
+				reg = <0x2000000 0x2000000>;
+			};
+		};
 	};
 };
 
-- 
2.25.1

