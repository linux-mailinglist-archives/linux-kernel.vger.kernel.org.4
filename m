Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635376D0006
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjC3JpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjC3Joz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:44:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDA16A63;
        Thu, 30 Mar 2023 02:44:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U9iguP012189;
        Thu, 30 Mar 2023 04:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680169482;
        bh=0K4x1bCFdhf8W82Qrb4HXn8QYl5KpnNj4WYqJkB6hSY=;
        h=From:Subject:Date:To:CC;
        b=V76ry2SwVYgWPIL+yT8g0GfsVrvxtupvKsb2Ytbs17zmDO+zqmiqJ65aey2/eCqvg
         wxqwgCyLtMAm6UZB0bxMGl5jaKXFk3GFWoK1t2fWdwKghIEKnpk56hAhVmywKXAbTp
         bU+Dxc0SAPp1XiLDQBzjVcfMoIFCCPwJVpT2e754=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U9ig1d003569
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 04:44:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 04:44:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 04:44:41 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U9ieLu097020;
        Thu, 30 Mar 2023 04:44:41 -0500
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v10 0/3] arm64: ti: Enable audio on AM62
Date:   Thu, 30 Mar 2023 15:14:04 +0530
Message-ID: <20230313-mcasp_upstream-v10-0-94332149657a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAORZJWQC/33NS2rEMBAE0KsMWkdBsj4tzSr3CCG05HYsGH+QP
 CZh8N0jzyLgRbysglf1YIVyosKulwfLtKaSprEGKV4uLPY4fhFPbS1YIxollFR8iFjmz/tclkw
 4cEFSgZBKGB9YRQEL8ZBxjH1l4/12q+WcqUvfz5v3j5r7VJYp/zxfV7O3/+6vhgveWqc1CEB0+
 Lak1zgNbN9Z7bm11QJYZ1qIgYI7WDi3UK3uMPoIzjTeH6w7t263WjipNIWmUwfrz62v1rZeAXW
 kKeo/u23bL/y82jivAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2762; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=4DpajotMw82Ms5v2M5m/Qba2uoXxvQM91kBGJpmmjbI=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBkJVoEcgcGIKPVq9D6iTDTrLqiYBTgvUwSC4tvY
 poCcAs8fK6JAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCVaBAAKCRBD3pH5JJpx
 RZ/YD/0XtVvOe4h4JPgthUeCuRLHan76wAK/trEeecGAZ8HTEhFhLNYC+9oLCbywQA88b92eix/
 7QKus3xmK+7Q1/o3seao2nlGMZXPX6a45cwnvG0Oah2b0XVAYiwJNrI42bgJbpmEXsoAtRkTaGn
 0RfJJuK0GbTWi2cDQRJzFDOv9KyLbJs/Idlbv/lx8SegyFo5xej6vLxdWO+Uqt+7o124RhwIY2F
 tgNPTStKQe0rh3fjo8SH59s1gWiPxShEWxYFw4cdYtgzfmeKFQ8fN75WV2ckl8a90YmjJdHqI/5
 MNE49HXuKvxPaqR9wVbcMXOuhSKATTggditjF8KXPc4QiVaYsXZ9Bf3ohA0iDFQwTmQx3T2dDLd
 2KjkN5uzhHKs0H7aXOOBd2SykLEL/gFJFjvXNONNzzwPhVe5HM0SxTvrZvs/gFav6Ge0doCVUw5
 L7QkVY9k6J6TYTB3+rvQlZ+v+KEDpoNx6VgiM9pt503PPYhoSYTYagLx9urJiBFgC8DRx6FoSch
 BW72sBHvHc/OD2lyxCEhgg1h90hKMqDjdxKxzfYigg6JwplT0bUdH+EAh++5nl36Rd9Lcd6R2YY
 gEqR3U7NZttey5XDXaSVh9vK7pJGnf2b2bZgaVnQPRfI+2qnZpVWqiA00hySKBhLjcMCuUCFrze
 FEdC+E215ZlHdfQ==
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
(E2+) and SK-AM62-LP boards. The jack is wired to TLV320AIC3106 (codec),
which is connected to McASP1 (serializer) on the SoC.

The TRRS 3.5mm jack can be used for simultaneous playback and recording.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---

Changes in v10:
- Drop AM62A patches [4-6/6]
- Fix defconfig to match output of savedefconfig, and move it to the end
  of the series
- Reword commit messages
- Link to v9: https://lore.kernel.org/r/20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com

Below is the range-diff from v9:

1:  05c92990b854 < -:  ------------ arm64: defconfig: Enable audio drivers for TI K3 SoCs
2:  962c58a419d5 = 1:  0bbee413da91 arm64: dts: ti: k3-am62-main: Add McASP nodes
3:  b0e710c14878 ! 2:  f624443bacf1 arm64: dts: ti: k3-am625-sk: Enable audio on AM62 SK
    @@ Metadata
     Author: Jai Luthra <j-luthra@ti.com>

      ## Commit message ##
    -    arm64: dts: ti: k3-am625-sk: Enable audio on AM62 SK
    +    arm64: dts: ti: Enable audio on SK-AM62(-LP)

         Add nodes for audio codec and sound card, enable the audio serializer
         (McASP1) under use from SK-AM62 E2 [1] onwards and update pinmux.

         Keep all audio related nodes in the common dtsi as they are exactly the
    -    same between SK-AM62 and SK-AM62-LP.
    +    same between SK-AM62 and SK-AM62-LP [2].

         Link: https://www.ti.com/lit/zip/sprr448 [1]
    +    Link: https://www.ti.com/lit/zip/sprr471 [2]
         Signed-off-by: Jai Luthra <j-luthra@ti.com>
         Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

4:  42ebd41e357f < -:  ------------ arm64: dts: ti: k3-am62a-main: Add nodes for McASP
5:  3ad21f2419fc < -:  ------------ arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
6:  edd909d78e67 < -:  ------------ arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A
-:  ------------ > 3:  4d3ec922758a arm64: defconfig: Enable audio drivers for SK-AM62

---
Jai Luthra (2):
      arm64: dts: ti: Enable audio on SK-AM62(-LP)
      arm64: defconfig: Enable audio drivers for SK-AM62

Jayesh Choudhary (1):
      arm64: dts: ti: k3-am62-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       |  4 ++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 60 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts         | 15 +++++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 76 ++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                   |  2 +
 5 files changed, 157 insertions(+)
---
base-commit: f3910d4b06af57669b77c0afe829deca6d5a3ed2
change-id: 20230313-mcasp_upstream-0e137013059b

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

