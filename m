Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBC6B7B10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCMOvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjCMOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:50:56 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8414A74327;
        Mon, 13 Mar 2023 07:50:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DEncUW098641;
        Mon, 13 Mar 2023 09:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678718978;
        bh=jqiwvKhK0MoSO+E5WYsQRxHXD2+OHL9GrDUbrzDdUj0=;
        h=From:To:CC:Subject:Date;
        b=vKnlKExq+LCJwinjqxkQHDv8NuJ8wfGyiZY7Tv5ljrae94SsCsmvptNWW/xpYoGeO
         2N6AjZaqVe/Qr8/iP45JiFVtdj+NBmR8ADAXHFYJqG0+MEWY9GUaPcsAFYTKqeEPkl
         BjrfHbIOKdHuQ/s2T+r6MvK9rZTt53i3lRWi4e3s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DEnciB127699
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 09:49:38 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 09:49:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 09:49:37 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DEnbCs010577;
        Mon, 13 Mar 2023 09:49:37 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v5 0/6] arm64: ti: Enable audio on AM62 and AM62A
Date:   Mon, 13 Mar 2023 20:19:29 +0530
Message-ID: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=znojq+aE5np24WXhSQB59rMEsaX2v9ISP8S8MbzV++w=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkDzbRYCcpejVouy4ciHu9kUvJaaIZclrF5Ntt/
 cvn9j+gdjmJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZA820QAKCRBD3pH5JJpx
 RchFEACAI5xp4u5cMgTTPxGQALyDMPg/nKcC8L8Rvdh8qb72Q0e4ikvFcpWLFjRLkIilHZB6dh1
 4zsgfoA0bZDhVYpLBKpRakUOKARFdn81NhAbJfXjGzC1EvC3mCRItMDVRnqd6clGRlIXh4ztClU
 fynCYRC21aNt8rYVWAi3/TpQ1gu0SL9nOaMDWAsMuF8or3weTDRzQG923g6oYTOBG8AuoqskY8e
 +KayTUCr6uKwdWhXebvtcjAH/NSLC1TUPUNBPSV4LHeCIpMIldvlzbjfx4KE4q4nLPtW9StEOwd
 1DSAQY539Etk8hyjFo1Zf567RN/4d6PSjGUNV9Z9GbALRz34hGy6Tkggf9sLnJBGjdzajYg9Xj+
 ZdtkZGMnPpQXm68liEI4CNOaddT/gndt/R6625dnGhfqVe6LIZZCIQzpBcHilz5PfXdGUodYUkW
 8XEqap9dVYfgVvXCAAs0k0rB7Qb3XNEGXseRVb4zp67qoS7gH6IPA+bisjRC7h/8y8H5xLy9Q8F
 qJNpyVU0ew2EGRgnHgAnK+oL6klpNZmrmiO0OOPOGQxVXOUf95ERVHpSWLCrOfIg80MLtcxAV4C
 ySUJQNseaXDcHFEhpyBpzFbnUBxaWTcVPlOxcgXSSl/Ykrq4fAaFb37Vnugz92wytFjcGmoLT0H
 AG7jLKgU7nb0W+A==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for audio output via headphone jack on
SK-AM62 and SK-AM62A boards. The jack is wired to TLV320AIC3106 (codec),
which is connected to McASP1 (serializer) on the SoC.

The TRRS 3.5mm jack can be used for simultaneous playback and recording.

v5:
- Ported codec bindings to dtschema
- Add audio drivers in arm64 defconfig
- Keep McASP nodes disabled in SoC dtsi
- Enable audio-input for AM62
- Enable same feature-set for AM62A

v4: https://lore.kernel.org/all/20220620102750.32718-1-j-luthra@ti.com/

Signed-off-by: Jai Luthra <j-luthra@ti.com>
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
