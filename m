Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2603A5FD856
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJML1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJML1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:27:32 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A44C68894
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:27:31 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221013112729epoutp0294a700ba5a8a6c33dfc1232df133d00d~dnVqpsi533099430994epoutp024
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:27:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221013112729epoutp0294a700ba5a8a6c33dfc1232df133d00d~dnVqpsi533099430994epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665660449;
        bh=PX79MYiSus1tyXjbsji0h4Qz4c4jMOIY/ooDUSjWUHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACyGFO/b1gBt4evBCcaPUu7Rqdmmr9gpQH5WDwTUQoMo/TvSybLp554oH4vzzBljF
         gxlHXa6La1owoBDidN6oPRcdIerih7SMeh931D2cAZwqUno46mg5GmUF4U5AdhmnzC
         RWRfz2I4X5q01mtCR/uwZwyYKnyc2BrwYpROwAz8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221013112728epcas5p188445c59160c60b2c96e825b9b004a31~dnVpzDsPL1688716887epcas5p1L;
        Thu, 13 Oct 2022 11:27:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Mp6gd2yDQz4x9Q1; Thu, 13 Oct
        2022 11:27:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.DA.26992.D16F7436; Thu, 13 Oct 2022 20:27:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221013110721epcas5p44cc7dcc5ac2ab8eaf6c472cc87dea06f~dnEFHtvBr1540615406epcas5p4X;
        Thu, 13 Oct 2022 11:07:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221013110721epsmtrp20f904697c284021f36eb79f9b31d7f56~dnEFG9PQS0646506465epsmtrp2w;
        Thu, 13 Oct 2022 11:07:21 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-67-6347f61dede0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.FC.18644.961F7436; Thu, 13 Oct 2022 20:07:21 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221013110719epsmtip1de93c1620795105aaf518345a62fdb3a~dnEDmspBv1089910899epsmtip1M;
        Thu, 13 Oct 2022 11:07:19 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, chanho61.park@samsung.com,
        linus.walleij@linaro.org, pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 1/4] arm64: dts: fix drive strength macros as per FSD HW
 UM
Date:   Thu, 13 Oct 2022 16:10:21 +0530
Message-Id: <20221013104024.50179-2-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221013104024.50179-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmhq7sN/dkgykLhS0ezNvGZnF5v7bF
        /CPnWC36XjxktpjyZzmTxeVdc9gsZpzfx2RxdGOwxaKtX9gtWvceYXfg8ti0qpPN4861PWwe
        fVtWMXp83iQXwBKVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1
        xMrQwMDIFKgwITtj9u4PTAVHRSveHkxoYPwg2MXIySEhYCJxZe421i5GLg4hgd2MEueutrBD
        OJ8YJc7f2ccE4XxmlLjfdIIVpmXKiZNsEIldjBLrPlyBclqZJPpPTGMBqWITMJVYNacRbLCI
        wFJGif+fFjGCOMwCUxgltm67wQhSJSwQIPHjzVt2EJtFQFVi9flbTCA2r4CNxO9Vj6H2yUus
        3nCAuYuRg4NTwFbiyQV5kDkSApfYJe5sOQtV4yJxYkcrlC0s8er4FnYIW0ri87u9bBB2vsS0
        j81QdoVE28cNTBC2vcSBK3NYQOYzC2hKrN+lDxGWlZh6ah1YCbMAn0Tv7ydQ5bwSO+bB2KoS
        65dvYoSwpSX2Xd/LCDJGQsBDYkV7KCRQJjBKfPzezTiBUW4WwoYFjIyrGCVTC4pz01OLTQsM
        81LL4bGWnJ+7iRGc5LQ8dzDeffBB7xAjEwfjIUYJDmYlEV6XELdkId6UxMqq1KL8+KLSnNTi
        Q4ymwOCbyCwlmpwPTLN5JfGGJpYGJmZmZiaWxmaGSuK8i2doJQsJpCeWpGanphakFsH0MXFw
        SjUwLTcw/vioyl+Q+6R1pd67U2VvBW8vefcxdfbSgAMClhKaRU8OVWyMefOsZdWdpfPsQy3b
        ddmZ799wlA5daVSyyt37b9QJrdvcBx+2tF5i8vZivPBMSdkl79rTtZfPuae8iDV5ZW14w824
        NOnxtruCXzZ2HU99HitmZSw0Z1di6apFTmUJUWJKuXd2V0a9Tw7uPnQxYZZw8IX9wn9tH7+f
        /L+jffWtvYJTl80RnjK/g69JjJP9VenCIxIMIa5JbJbZi7W/P+Ruvfeo99OL98un1UWtyjj7
        sDlwo+TLiWZNNjMTbdcLdMrPeXZjjejeM9wCbrs6O6bekFNZ+74hVonltuPHyza7HBpF1hwP
        WFM8VYmlOCPRUIu5qDgRADtwVEn7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnG7mR/dkgy9/eC0ezNvGZnF5v7bF
        /CPnWC36XjxktpjyZzmTxeVdc9gsZpzfx2RxdGOwxaKtX9gtWvceYXfg8ti0qpPN4861PWwe
        fVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlTF79wemgqOiFW8PJjQwfhDsYuTkkBAwkZhy4iQb
        iC0ksINRYtXkcIi4tMT0/j1sELawxMp/z9m7GLmAapqZJOb+nwCWYBMwlVg1p5EVJCEisJpR
        4nN/O1iCWWAao8SuqfUgtrCAn0Rbz0lmEJtFQFVi9flbTCA2r4CNxO9Vj1khNshLrN5wAKiG
        g4NTwFbiyQV5iINsJCZ8XcI0gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M
        4BDU0trBuGfVB71DjEwcjIcYJTiYlUR4XULckoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6
        GS8kkJ5YkpqdmlqQWgSTZeLglGpgWuseayH56pP8ibCWcE5Pjwt1mrty/Eu+zsyTEvt49PZ1
        DZZ7s24X2syOToyPW6x54fr6qNbqBKeYoP2Fe5ukq5b9X1F0r0ZE/93FDjll5ev3nmxVyugR
        qYyyXpyw55M7j9LJQzxbZ39kvHe86YyUcM5GhQ9WlwrUVVm73cyD8+zvuzx87HzrljXHvJ64
        vr0vIsVMSr0TPpq5VnmvjjjPUyU5Oe/Q60obB+/Vz/ONuqLMNJO6Ll7w2X7CZbH2pX+3193+
        /sbBmaFONr8nP3eVuwVHRJrGN59kgXyR8N/a4vpxO2/diXkrtthqh0/hmTky3faJ8yYZf7Bf
        JX5TeM6cmqkCdyccDzm07ZEDU5wSS3FGoqEWc1FxIgDHdBkTsAIAAA==
X-CMS-MailID: 20221013110721epcas5p44cc7dcc5ac2ab8eaf6c472cc87dea06f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221013110721epcas5p44cc7dcc5ac2ab8eaf6c472cc87dea06f
References: <20221013104024.50179-1-p.rajanbabu@samsung.com>
        <CGME20221013110721epcas5p44cc7dcc5ac2ab8eaf6c472cc87dea06f@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drive strength macros defined for FSD platform is not reflecting actual
names and values as per HW UM. FSD SoC pinctrl has following four levels
of drive-strength and their corresponding values:
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
in FSD HW UM.

Fixes: 684dac402f21 ("arm64: dts: fsd: Add initial pinctrl support")
Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 8 ++++----
 arch/arm64/boot/dts/tesla/fsd-pinctrl.h    | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index d0abb9aa0e9e..4e151d419909 100644
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
 
@@ -239,14 +239,14 @@
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

