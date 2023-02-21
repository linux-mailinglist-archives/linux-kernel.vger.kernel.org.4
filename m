Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8E69DE30
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjBUKut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjBUKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:50:47 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348C21A25
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:50:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h16so15530176edz.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYjWLgQYUyf0rfB+O28fl3yoRQb/M04CEuNH5hkz1cs=;
        b=p2wzYBo3W+HrqRwhYizv8ezrYEbXHvTHEGP4HDkZqnrL1td9lLY1poI37muWJ7sd3y
         Bd24g575XQwvAkILeyYn1CiV7LmkE+VFqxzYM8GiLqM3nPNvVOE2MTvW+j6Uf+petFQV
         /fL4aVnW6Awf9JyCMGMvLK/ckLO2+5LEFuVgo1wLs5cAY3yPZ+PoRu73RTIa/sfZJYxP
         vwZv0CpqP0copFJkNX++pG1KyBQarJ1StdWJlc+fh/vsDYKyjAhOSV/ZrQAPiQbQdXLQ
         v5eA2Qr9dqfCgE2gdryWm2viN/kqaT7cnzY9+2w7KioLjpVxTe90Et9jd6dIgH/ieg83
         9hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYjWLgQYUyf0rfB+O28fl3yoRQb/M04CEuNH5hkz1cs=;
        b=rGUDbPn2J00tTtF03gnNxud8+CCVH/xmgUnzoSik6+6sx+bDzSvUFQvAPPfWdHYoPA
         JddRGm5QsfSu7YvJknTaUv9VCfKr+n9176l1Tgp6kxZrctxyy5J//JT1AlgaweNJxrLv
         IlDcp4NB/3MIp7VFDgV+4UHIpvDSF7fmOuipOyGowBMF3uEQD3KkxOBuas9jVcTGurJu
         lWqxwPSGHYIUSHlVZ3Lc1xfscsPwhXOoAsfyGImAwvd/4m6nY5nbMgmsVRQJmt10H+Lz
         MTYAL32smfmPbNF3NvB36fl6hfI6DJyfLjZBAfc4z5fQZ1BGldZl3h20ADnMxkTzNk4+
         M/DQ==
X-Gm-Message-State: AO0yUKWzvr6UZnoldca59gvCaD45ix1m/Xc9bvnRaCF2ERJA7FL7SbE7
        phgwIOPVuBDHtoFeDdHHQZx6Zg==
X-Google-Smtp-Source: AK7set+cFpf8rY+4xMoIg5FcZ+hPP4nkQ6KLR86qzt/E74X3ahuDQFPJBCZTgVf2Pbt3I5AlZXx3Cg==
X-Received: by 2002:a17:907:e8d:b0:8b1:2e8f:d524 with SMTP id ho13-20020a1709070e8d00b008b12e8fd524mr19296846ejc.27.1676976642934;
        Tue, 21 Feb 2023 02:50:42 -0800 (PST)
Received: from fedora.. (dh207-97-58.xnet.hr. [88.207.97.58])
        by smtp.googlemail.com with ESMTPSA id bk26-20020a170906b0da00b0089d5aaf85besm6955802ejb.219.2023.02.21.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 02:50:42 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
        arnd@arndb.de, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/3] arm64: dts: microchip: sparx5: do not use PSCI on reference boards
Date:   Tue, 21 Feb 2023 11:50:37 +0100
Message-Id: <20230221105039.316819-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.2
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

PSCI is not implemented on SparX-5 at all, there is no ATF and U-boot that
is shipped does not implement it as well.

I have tried flashing the latest BSP 2022.12 U-boot which did not work.
After contacting Microchip, they confirmed that there is no ATF for the
SoC nor PSCI implementation which is unfortunate in 2023.

So, disable PSCI as otherwise kernel crashes as soon as it tries probing
PSCI with, and the crash is only visible if earlycon is used.

Since PSCI is not implemented, switch core bringup to use spin-tables
which are implemented in the vendor U-boot and actually work.

Tested on PCB134 with eMMC (VSC5640EV).

Fixes: 6694aee00a4b ("arm64: dts: sparx5: Add basic cpu support")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* As suggested by Arnd, disable PSCI only on reference boards
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi            |  2 +-
 arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 0367a00a269b3..5eae6e7fd248e 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -61,7 +61,7 @@ arm-pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
 	};
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
index 9d1a082de3e29..32bb76b3202a0 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
@@ -6,6 +6,18 @@
 /dts-v1/;
 #include "sparx5.dtsi"
 
+&psci {
+	status = "disabled";
+};
+
+&cpu0 {
+	enable-method = "spin-table";
+};
+
+&cpu1 {
+	enable-method = "spin-table";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.39.2

