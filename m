Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08D75FAE88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJKIgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJKIg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:36:28 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5290C7C1D1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:36:25 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221011083623epoutp04b6a6d6cf5a4629c05c1eac7dfc7c2ac0~c9tsaLCkY0323403234epoutp04H
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:36:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221011083623epoutp04b6a6d6cf5a4629c05c1eac7dfc7c2ac0~c9tsaLCkY0323403234epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665477383;
        bh=FxZXstTVZ5WaTjdioUsVMZPbOQeROiPSyOQt/DfZdv8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SIz/meJUFEWMM0BcMJYJEPbCbwmQ0okZdO1bnMXGCu6YP8ZVl4N1AgQfZDyLSnT7D
         nQ2Ff0aAnWn0bNjU8BAxO4btv3ulTozoBtP2wHZR7zBkCaUuBGGF2NM+V6qtUIs3Jz
         j5UoYbU49/pX9fY6AIrwDjerNpw4aHs577B4CSg4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221011083622epcas5p4e996b9f6b75ef2964e05103d05af125a~c9tsA5eQv2460424604epcas5p4u;
        Tue, 11 Oct 2022 08:36:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Mmpz62zbGz4x9QD; Tue, 11 Oct
        2022 08:36:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.EB.56352.10B25436; Tue, 11 Oct 2022 17:36:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221011083029epcas5p3cef6047d23d0682a9cb70ba6178067a8~c9ojJxzKa1037710377epcas5p3a;
        Tue, 11 Oct 2022 08:30:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221011083029epsmtrp2411e00dc67fc3e40435558623e0b20f2~c9ojIu3Vd2657426574epsmtrp2k;
        Tue, 11 Oct 2022 08:30:29 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-63-63452b015241
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.65.14392.5A925436; Tue, 11 Oct 2022 17:30:29 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221011083027epsmtip2865ea2df94a67adf242ff7248b00e225~c9ohnPhEK1555815558epsmtip2s;
        Tue, 11 Oct 2022 08:30:27 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, chanho61.park@samsung.com,
        linus.walleij@linaro.org, pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH V2] arm64: dts: fix drive strength macros as per FSD HW UM
Date:   Tue, 11 Oct 2022 13:33:59 +0530
Message-Id: <20221011080359.76220-1-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmhi6jtmuyweUnXBYP5m1js7i8X9ti
        /pFzrBZ9Lx4yW0z5s5zJ4vKuOWwWM87vY7I4ujHYYtHWL+wWrXuPsDtweWxa1cnmcefaHjaP
        vi2rGD0+b5ILYInKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
        CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5da
        YmVoYGBkClSYkJ1xePF15oJOg4p5/e/ZGxh3qncxcnJICJhIzF54ihHEFhLYzSjx5VFCFyMX
        kP2JUeLQn7nsEM43RomHpz+ywHSsnzaVFaJjL6PEyk0REEWtTBKrHi8EK2ITMJVYNaeRFSQh
        IrCUUeL/p0WMIA6zwBRGia3bbgA5HBzCAl4S5yepgjSwCKhKbNn5mw3E5hWwkfjV1s4EsU1e
        YvWGA8wgvRICu9gl7s24D3WGi8SuqS+hbGGJV8e3sEPYUhKf3+1lg7DzJaZ9bIayKyTaPm6A
        GmovceDKHBaQG5gFNCXW79KHCMtKTD21DqyEWYBPovf3E6hyXokd82BsVYn1yzcxQtjSEvuu
        7wV7RULAQ+LfxEBIoMRKbH66kX0Co+wshAULGBlXMUqmFhTnpqcWmxYY56WWw+MpOT93EyM4
        kWl572B89OCD3iFGJg7GQ4wSHMxKIryM852ShXhTEiurUovy44tKc1KLDzGaAoNsIrOUaHI+
        MJXmlcQbmlgamJiZmZlYGpsZKonzLp6hlSwkkJ5YkpqdmlqQWgTTx8TBKdXAxBT19cKcR0sy
        p6TuqE6QePVZ8t5R0Y8N8TWTlm2MrLNX32E83f3U0QOnY08cjLqs4lwcztHMlLu+Zo9RTLro
        zg7rlBkLeKeq/uC10HlyyIr3y+GLysl33x1oVT2m79u74P/HxiUz+e79Ebzj98rneGlYdpPU
        IevqLfdPGP7RYWVQNl70MSfL0E6+Z0JEq9ArxU4ev1j70C/ujw0ZX900Dua+JW33Z0qt+P+u
        UCmBaZ63vv28r2Ti4DorOV756PtOlcgXvxNkLjIbb//rwJnpOV8shTFOfOsLZ162HR+eXp61
        9b7W6xmWun2v54VtvupWI52gLfB/YSdb8ZKOmsnfd56z/Jpy0nyt4spFT+/9V2Ipzkg01GIu
        Kk4EAFXFL/DtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjluLIzCtJLcpLzFFi42LZdlhJXneppmuyQfNaOYsH87axWVzer20x
        /8g5Vou+Fw+ZLab8Wc5kcXnXHDaLGef3MVkc3RhssWjrF3aL1r1H2B24PDat6mTzuHNtD5tH
        35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVwZRxefJ25oNOgYl7/e/YGxp3qXYycHBICJhLrp01l
        BbGFBHYzSmw9XAkRl5aY3r+HDcIWllj57zl7FyMXUE0zk8S0tmnMIAk2AVOJVXMaWUESIgKr
        GSU+97eDdTALTGOU2DW1vouRg0NYwEvi/CRVkDCLgKrElp2/wUp4BWwkfrW1M0EskJdYveEA
        8wRGngWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKDSktzB+P2VR/0DjEycTAe
        YpTgYFYS4WWc75QsxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
        B6dUA9OKlSL60+Is/+92FOnrnNb7Yb++ZbFNJs/XI5wlAr/UwirWhv9zD/qzgncHv9CpFY75
        UxYoXIuP8tVaajmhu+lXRo3069OcH2vO1yxLKnWeaXsi///ev7NL5dO5fMzv6DJNva4xrf/L
        tqR/fTYbS4xWtu0/FSlzRuI742wBHiE/Pt/7f6K7DYwfBXLnakbucrFdl5ufrrBf7sJshuw6
        FsvmW2t5cwSr8rd32Bw15eLgfVBZUOMW8vLsnJn/X9z48v/JL8eVM3MT3ovfjJ8fkaBQIF3y
        SDNo0bGVhWcX7Y4sr/wr+mrih/UR1+6JLJ3//xGPf0pRftN0vYSmae/sDiRuMfzuoaattKzy
        UxfXFCWW4oxEQy3mouJEADYl5sSZAgAA
X-CMS-MailID: 20221011083029epcas5p3cef6047d23d0682a9cb70ba6178067a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011083029epcas5p3cef6047d23d0682a9cb70ba6178067a8
References: <CGME20221011083029epcas5p3cef6047d23d0682a9cb70ba6178067a8@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drive strength macros defined for FSD platform is not reflecting actual
name and values as per HW UM. FSD SoC pinctrl has following four levels of
drive-strength and their corresponding values:
Level-1 <-> 0
Level-2 <-> 1
Level-4 <-> 2
Level-6 <-> 3

The commit 684dac402f21 ("arm64: dts: fsd: Add initial pinctrl support")
used drive strength macros defined for Exynos4 SoC family. For some IPs
the macros values of Exynos4 matched and worked well, but Exynos4 SoC
family drive-strength (names and values) is not exactly matching with
FSD SoC.

Fix the drive strength macros to reflect actual names and values given
in FSD HW UM. This also ensures that the existing peripherals in device
tree file is using correct drive strength MACROs to function as
expected.

Fixes: 684dac402f21 ("arm64: dts: fsd: Add initial pinctrl support")
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 34 +++++++++++-----------
 arch/arm64/boot/dts/tesla/fsd-pinctrl.h    |  6 ++--
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index d0abb9aa0e9e..e3852c946352 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -55,14 +55,14 @@
 		samsung,pins = "gpf5-0";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	ufs_refclk_out: ufs-refclk-out-pins {
 		samsung,pins = "gpf5-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 };
 
@@ -239,105 +239,105 @@
 		samsung,pins = "gpb6-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpb6-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c0_bus: hs-i2c0-bus-pins {
 		samsung,pins = "gpb0-0", "gpb0-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c1_bus: hs-i2c1-bus-pins {
 		samsung,pins = "gpb0-2", "gpb0-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c2_bus: hs-i2c2-bus-pins {
 		samsung,pins = "gpb0-4", "gpb0-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c3_bus: hs-i2c3-bus-pins {
 		samsung,pins = "gpb0-6", "gpb0-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c4_bus: hs-i2c4-bus-pins {
 		samsung,pins = "gpb1-0", "gpb1-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c5_bus: hs-i2c5-bus-pins {
 		samsung,pins = "gpb1-2", "gpb1-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c6_bus: hs-i2c6-bus-pins {
 		samsung,pins = "gpb1-4", "gpb1-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c7_bus: hs-i2c7-bus-pins {
 		samsung,pins = "gpb1-6", "gpb1-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	uart0_data: uart0-data-pins {
 		samsung,pins = "gpb7-0", "gpb7-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	uart1_data: uart1-data-pins {
 		samsung,pins = "gpb7-4", "gpb7-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpb4-0", "gpb4-2", "gpb4-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpb4-4", "gpb4-6", "gpb4-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpb5-0", "gpb5-2", "gpb5-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.h b/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
index 6ffbda362493..c397d02208a0 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
@@ -16,9 +16,9 @@
 #define FSD_PIN_PULL_UP			3
 
 #define FSD_PIN_DRV_LV1			0
-#define FSD_PIN_DRV_LV2			2
-#define FSD_PIN_DRV_LV3			1
-#define FSD_PIN_DRV_LV4			3
+#define FSD_PIN_DRV_LV2			1
+#define FSD_PIN_DRV_LV4			2
+#define FSD_PIN_DRV_LV6			3
 
 #define FSD_PIN_FUNC_INPUT		0
 #define FSD_PIN_FUNC_OUTPUT		1
-- 
2.17.1

