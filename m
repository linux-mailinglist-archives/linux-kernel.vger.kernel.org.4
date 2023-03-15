Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30956BAB85
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjCOJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjCOJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:04:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240B72B3A;
        Wed, 15 Mar 2023 02:03:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F93dqb070995;
        Wed, 15 Mar 2023 04:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678871019;
        bh=l7ufB9qJB5Y08IAsw5s05aIR6nGv7Q3wwepWVvFuERo=;
        h=From:To:CC:Subject:Date;
        b=pNh+Xv0Vj2f/rWQV222ZYfq36Vnhyq6Q71cikGcpFtk33hzZQ21aMV2bnDY5psi9l
         KVFZJQ9PRgUpCpuQgS6kVD98drpOgnCRt8PpIvPJdJjJuZb+AzDjSaUtHkWjc+Smzh
         ncGBIsbEyQS1cUK0/90Yaz2ZsJeVYFuccgB/8kbQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F93d5I071115
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 04:03:39 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 04:03:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 04:03:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F93ck5104672;
        Wed, 15 Mar 2023 04:03:38 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v6 0/6] arm64: ti: Enable audio on AM62 and AM62A
Date:   Wed, 15 Mar 2023 14:33:29 +0530
Message-ID: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=6P8kCzy7Tg0KQ3+sZGfnxi2nRc+PsA2duK1jLQaovOY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkEYdVrVat9akqCFUGnFdopAUHyRED1n2jc2ANj
 5UYe7I33kSJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZBGHVQAKCRBD3pH5JJpx
 RbXiD/9dx50r2Kpc5iB8PNmg8IbQchLGAc61Q4Me9Kols775yc30VFZFlKSad8E7wjIzQIuM+kz
 GVkueYbc4+YphFtAhgKaq86Oh0jlBu5UUCcrdfz5AtZ2OM/fDXkdRen1ki4SX50j/6hJGIhoutL
 smruv/j+B37hD2AP6ZYNabSf1XkF2wLKMAuuvJ+t5imi20eI+tBFfrHkfaEPYVNkq9iJGki7o70
 J9UKNbW8wO2ui6+T+mJvcmk3dtl788nhKHjyc6oK732pR82WQRzjs3vTwaHBjzscRg48en68V3A
 rzRT3KH/9liSz/7uIsncOyvoBdWq7nS6u3qw6Ho0kKwRn/f4aSLGw97xnGTjEASV0COdfjT0W/j
 moH/6+zoJXnJuvaWJqfCVF/hohu0GrAGeYjV+/fteJkO8J9I9VIIIDryZ5AuAeThMDLeHA9qWRM
 kz1QGGv6dAVXiONVU9fEZMu64y1be3fryYXKL6CO1Ur1J2Zux5uMVePuEHm5P8kOiXpTk3YsuB7
 8amcsQZnBE3jhsA+HKWHWTEaOE0SK/YaHl/eRkTmZJUNW6OP5IZWqhLnx8/bd+yonlzzqjG2sZu
 yQ0G12IdaLaaiveVV7BdO2K4y4UdwMbuTwZuJJsXTjF964PvW+Ga177DPVul5vL+dBZoE4KYa+R
 qqK+U3x0zwKKqYg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for audio via headphone jack on SK-AM62
and SK-AM62A boards. The jack is wired to TLV320AIC3106 (codec), which
is connected to McASP1 (serializer) on the SoC.

The TRRS 3.5mm jack can be used for simultaneous playback and recording.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v6:
- Use generic node names (audio-controller@) for McASP
- Fix labels, indentation and spacing issues
- For SK-AM62A:
	- Remove redundant status property from codec
	- Add a note in commit message about missing DVDD regulator
	- Supply OCMV level manually to the codec

Link to v5: https://lore.kernel.org/r/20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com

---
Jai Luthra (5):
      arm64: defconfig: Enable audio drivers for TI K3 SoCs
      arm64: dts: ti: k3-am625-sk: Enable audio on AM62 SK
      arm64: dts: ti: k3-am62a-main: Add nodes for McASP
      arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
      arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A

Jayesh Choudhary (1):
      arm64: dts: ti: k3-am62-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 60 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts    | 88 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 60 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   | 92 ++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig              |  2 +
 5 files changed, 300 insertions(+), 2 deletions(-)
---
base-commit: 24469a0e5052ba01a35a15f104717a82b7a4798b
change-id: 20230313-mcasp_upstream-0e137013059b

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>
