Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8B26CD7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjC2Kbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2Kbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:31:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FB71BFD;
        Wed, 29 Mar 2023 03:31:33 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVMc3025096;
        Wed, 29 Mar 2023 05:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680085882;
        bh=PUL1cvEWkKClCucj93fnbX6yg15GZFE6TDNhJSm5E34=;
        h=From:Subject:Date:To:CC;
        b=g4uE1ZTOJ+xco+g2Z/XN0y0Ll98gAi0QNbh2ndPScSeUEDHrwycGFgVbQD5rqnlrO
         4R20VlRxhq6OQ1ZhVHM8zaAtRLr954P1Ax4Sddsm1BbkgN6NZ7CPf0PQvZMVK7m71I
         CLDW2q4216KE/WN4ZhwV5Va1M9alEI9OYTlXJZzo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TAVMF6032651
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 05:31:22 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 05:31:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 05:31:22 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVLTQ062112;
        Wed, 29 Mar 2023 05:31:21 -0500
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v9 0/6] arm64: ti: Enable audio on AM62 and AM62A
Date:   Wed, 29 Mar 2023 16:00:57 +0530
Message-ID: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGETJGQC/33NzYrDIBQF4FcJrsfBRM3VruY9hlKu5mYiND9oG
 lpK3n1MF4UsmuU58J3zZIlioMROxZNFWkIK45CD/SqY73D4Ix6anFklKilkKXnvMU2X25TmSNh
 zQaUEUUqhrWMZOUzEXcTBd5kNt+s1l1OkNtxfL7/nnLuQ5jE+XqeL3tqP+4vmgje1UQoEIBr8m
 cO3H3u27Sz1sa2zBaiNbsA7cmZn4dhCtqpFbz0YXVm7s+bYms0qYUqpyFWtfNt1Xf8BCQZgB3I
 BAAA=
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3929; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=R5pGNJ5s1W8duP+FDEN28uJxFl33guuAFu5QwFPMOt8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkJBNzv+LxjeWVeWl7xz2lh+xufWYi72JvFonbj
 cIFdLHtTYiJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCQTcwAKCRBD3pH5JJpx
 ReiZEADNNNRPmno9PW5g6feYjxntK+v01u3tlhqws6xnHO5oePNrzZ+A45yHmBVNlW2u5nYVuZS
 RbePL//EbWAXdaMVH9cepqsKCf8FuXk2mMj+fhIbKHmPUsxHDLtVTGsfrd9ruh3QT28zCNHgSTZ
 YAOScJ3lf/GMI67RXODMiX2M9eO+2bNPrmHc1vKQXaOFNyJ3NEwi0euNGZPOcQpOzHmqSrY+kbd
 WKxfn20Axxs5TH5Tt/PydEaYfKCdtPYLK44lRgvQ63CS8922wNjLuDE+imZgLELBYolp11FEN5T
 Fl93kAMbl5tbvbkD2gQObZw89CerYV68KI/V2RgWXCl23wjwCEmECuE1cGDRGZZj0uKTYkp1ScW
 fhd+KP++HJv3ed+ykrx54m0ctZQOgZeze8OqOsv4mTu6+wrkrT5ygdr8dLMqq5rtPm5MMNxsTYG
 hdZpD5yGU6ZbuH0nOS4xZCKBThmgA/JBAzH9OJZSwfFMgeIYFVqoGMzi3cBbw3kqHb/5EI0xwO/
 1SgYsur+cx0P5DBrSj6UxKjJiSxOivkHKElb+rC3P9GaWPx7kfBwf07F1iveAG8IsTfWaUrWj0M
 bUM/wbXeIbr66/0fc6iHr9sKYuDAVzmzkGwGtqDxwQnCyYmS8YqTcAmPNeH/CBeDwbihgTOrCOh
 JAyHWYRGjgBtxqQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for audio via headphone jack on SK-AM62
(E2+) and SK-AM62A boards. The jack is wired to TLV320AIC3106 (codec),
which is connected to McASP1 (serializer) on the SoC.

The TRRS 3.5mm jack can be used for simultaneous playback and recording.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v9:
- Use correct codec 1.8V supply (PMIC) for SK-AM62-LP
- Link to v8: https://lore.kernel.org/r/20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com

The range-diff between v9 and v8 is given below:

1:  7555632dc2cc = 1:  321a9a26699b arm64: defconfig: Enable audio drivers for TI K3 SoCs
2:  d79f2aebfcc3 = 2:  56253cd6ba31 arm64: dts: ti: k3-am62-main: Add McASP nodes
3:  1fc7976b17aa ! 3:  c437bbe97ff7 arm64: dts: ti: k3-am625-sk: Enable audio on AM62 SK
    @@ Commit message
         Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

      ## arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts ##
    -@@ arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts: vddshv_sdio: regulator-4 {
    -           states = <1800000 0x0>,
    -                    <3300000 0x1>;
    +@@ arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts: ldo4_reg: ldo4 {
    +           };
        };
    -+
    -+  vcc_1v8: regulator-5 {
    -+          /* output of TPS62824DMQ */
    -+          compatible = "regulator-fixed";
    -+          regulator-name = "vcc_1v8";
    -+          regulator-min-microvolt = <1800000>;
    -+          regulator-max-microvolt = <1800000>;
    -+          vin-supply = <&vcc_3v3_sys>;
    -+          regulator-always-on;
    -+          regulator-boot-on;
    -+  };
      };
    -
    - &main_pmx0 {
    ++
    ++&tlv320aic3106 {
    ++  DVDD-supply = <&buck2_reg>;
    ++};

      ## arch/arm64/boot/dts/ti/k3-am625-sk.dts ##
     @@ arch/arm64/boot/dts/ti/k3-am625-sk.dts: vdd_sd_dv: regulator-4 {
    @@ arch/arm64/boot/dts/ti/k3-am625-sk.dts: vdd_sd_dv: regulator-4 {
      };

      &main_pmx0 {
    +@@ arch/arm64/boot/dts/ti/k3-am625-sk.dts: partition@3fc0000 {
    +           };
    +   };
    + };
    ++
    ++&tlv320aic3106 {
    ++  DVDD-supply = <&vcc_1v8>;
    ++};

      ## arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi ##
     @@ arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi: led-0 {
    @@ arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi: &main_i2c1 {
     +          AVDD-supply = <&vcc_3v3_sys>;
     +          IOVDD-supply = <&vcc_3v3_sys>;
     +          DRVDD-supply = <&vcc_3v3_sys>;
    -+          DVDD-supply = <&vcc_1v8>;
     +  };
      };

4:  f08c0107849f = 4:  de37e1738c5c arm64: dts: ti: k3-am62a-main: Add nodes for McASP
5:  70087cabf258 = 5:  e2419b8646a7 arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
6:  411f0e171eec = 6:  ca8472bcecb4 arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A

---
Jai Luthra (5):
      arm64: defconfig: Enable audio drivers for TI K3 SoCs
      arm64: dts: ti: k3-am625-sk: Enable audio on AM62 SK
      arm64: dts: ti: k3-am62a-main: Add nodes for McASP
      arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
      arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A

Jayesh Choudhary (1):
      arm64: dts: ti: k3-am62-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       |  4 ++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 60 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts         | 15 +++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 60 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 92 +++++++++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 76 +++++++++++++++++++++
 arch/arm64/configs/defconfig                   |  2 +
 7 files changed, 307 insertions(+), 2 deletions(-)
---
base-commit: f3910d4b06af57669b77c0afe829deca6d5a3ed2
change-id: 20230313-mcasp_upstream-0e137013059b

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

