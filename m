Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9733369DE33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjBUKuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjBUKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:50:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094EC25E1A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:50:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f13so14812683edz.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gk2DSmgvASQ5V9ePr4xMv7HQyGXDamFtmo/+7H0H7Q=;
        b=z6QrFp/Krt2zgU4roCx/tRFt9FnkDlEc8AOluIPbFpZzT/A/IB2zZiuh8MulzCnAgi
         Sd50gCC86ozaK7xkP1UFO3Wz0vOZxDo/RDTKjmmV52tUsiuXE6BasomSPjWwmNj6NVJc
         tPJajapj7D1Y3dPhQDI9SyPSgCLYvy01oSwgr4T3RlITMT2i76EEQMRwCruEsWzFPPDi
         afhbSbVjO7IzBMnWErmwWAgvcjkhLyPx4MMjD0MbUQ/e/8zv2tTKKQwQSfUH6xyr76Oz
         h+bnoIH5do3PEjNSm6vUX/Oce8OVjcG/Un0suI8PY2sFvSHfTVJ2aV81VECSNfBYMz8+
         ze0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gk2DSmgvASQ5V9ePr4xMv7HQyGXDamFtmo/+7H0H7Q=;
        b=c1laR/0viD5G+ANoVBoEg4b4+8GJEU0azGMAEZJQzsjSRu86oSAI164yZOHJy/8auf
         Nu6Yrf1OUqnF+70QaEZEJILw7khQel/bUrmovZ4TW2LDXON4edAGHlGUX4oXbwxMstTJ
         Hf5wCM4gIiUqTUV4YsmKdBx8WAEahkeoAWt08+1UBtfk8yez0y4/kEEXCv9BTprf6bY9
         96s40MNaJrS8cVHZzD+xb+EXymEJWZihqgPD2eS2+HLHE6NZb4r6jMoIuDdR7fBkmhQR
         aGryp7edoTnCIiXynrluJYdZYsKSv3dTqZqAtC5+cyoMcjV//dHg0H/oTccsvJ1496hs
         ispw==
X-Gm-Message-State: AO0yUKV8GSotX0j6sc+55ZDeeQAhxTIbIpxKMV8TuPFuW+ry0a8Ou2nf
        L9FhDJ/TdrDNYC0jmBplAC7Iqg==
X-Google-Smtp-Source: AK7set/x+xrpGP3FABf85L02cSovpPeNu1WquJ0oYlJzMGgDuyd4gj7BOgNrzBcofGxfp1/Yzv0rHw==
X-Received: by 2002:a17:906:ad82:b0:8af:40b0:3dd1 with SMTP id la2-20020a170906ad8200b008af40b03dd1mr11760401ejb.27.1676976645348;
        Tue, 21 Feb 2023 02:50:45 -0800 (PST)
Received: from fedora.. (dh207-97-58.xnet.hr. [88.207.97.58])
        by smtp.googlemail.com with ESMTPSA id bk26-20020a170906b0da00b0089d5aaf85besm6955802ejb.219.2023.02.21.02.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 02:50:44 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/3] arm64: dts: microchip: sparx5: add missing L1/L2 cache information
Date:   Tue, 21 Feb 2023 11:50:39 +0100
Message-Id: <20230221105039.316819-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221105039.316819-1-robert.marko@sartura.hr>
References: <20230221105039.316819-1-robert.marko@sartura.hr>
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

Currently, when booting on SparX-5 you will get the following error:
[    0.050132] Early cacheinfo failed, ret = -22

This is due to L2 cache node missing cache-level property to indicate its
level, so populate it to let the kernel know its L2 cache.

However, that alone is enough to get rid of the error, but then the
following warnings appear:
[    0.050162] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.093256] cacheinfo: Unable to detect cache hierarchy for CPU 1

So, lets completely populate both the L1 and L2 cache info based off the
SoC datasheet[1] and ARM A53 technical reference manual[2].

Now "lscpu -C" provides:
NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL SETS PHY-LINE COHERENCY-SIZE
L1d       32K      64K    4 Data            1  128                      64
L1i       32K      64K    2 Instruction     1  256                      64
L2       256K     256K   16 Unified         2  256                      64

Tested on PCB134 (eMMC).

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/SparX-5_Family_L2L3_Enterprise_25G_Ethernet_Switches_Datasheet_00003823D.pdf
[2] https://developer.arm.com/documentation/ddi0500/j/Level-1-Memory-System/About-the-L1-memory-system?lang=en

Fixes: 6694aee00a4b ("arm64: dts: sparx5: Add basic cpu support")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index a4fabacf5c2f7..950ba78bf73f3 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -41,6 +41,12 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0x0>;
 			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>; // 32KiB(size)/64(line-size)=512ways/4-way set
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 32KiB(size)/64(line-size)=512ways/2-way set
 			next-level-cache = <&L2_0>;
 		};
 		cpu1: cpu@1 {
@@ -48,10 +54,21 @@ cpu1: cpu@1 {
 			device_type = "cpu";
 			reg = <0x1>;
 			enable-method = "psci";
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>; // 32KiB(size)/64(line-size)=512ways/4-way set
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>; // 32KiB(size)/64(line-size)=512ways/2-way set
 			next-level-cache = <&L2_0>;
 		};
 		L2_0: l2-cache0 {
 			compatible = "cache";
+			cache-unified;
+			cache-size = <0x40000>;
+			cache-line-size = <64>;
+			cache-sets = <256>; // 256KB(size)/64(line-size)=4096ways/16-way set
+			cache-level = <2>;
 		};
 	};
 
-- 
2.39.2

