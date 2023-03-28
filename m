Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA886CC0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjC1N36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjC1N3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:45 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0A9BDFE;
        Tue, 28 Mar 2023 06:29:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTVHB088142;
        Tue, 28 Mar 2023 08:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680010171;
        bh=wPFEHvMoRk1iQxWnoSLx5fYVpt8cuqTHjmfDRQ67MEg=;
        h=From:Subject:Date:To:CC;
        b=tLIeOr7AJ5UzO8CzHRhtC1X2UabUBYRc5t494+ocr9WxewHTyUnHVobwjKbCgOvdf
         tZG+DtUT+G5cIy1OQMelXhAC/hKTTL/QDf7EtjNYvRg1DHxKNacdQRaRSjMCR8dqsM
         f5bPSoSIy2OsUCyzxA1tXA7UGTvll2PqfZWaUEas=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDTVoS113888
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:29:31 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:29:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:29:30 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTUti031386;
        Tue, 28 Mar 2023 08:29:30 -0500
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v8 0/6] arm64: ti: Enable audio on AM62 and AM62A
Date:   Tue, 28 Mar 2023 18:59:18 +0530
Message-ID: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK7rImQC/33NzQ6CMBAE4FchPVtTKGWLJ9/DGLMtizThLy0Sj
 eHdLRxMPMhxJvlm3iyQdxTYKXkzT7MLbuhj0IeE2Qb7O3FXxcwykUkhU8k7i2G8PcYwecKOC0o
 liFQKVRoWkcFA3HjsbRNZ/2jbWI6eavfcXi7XmBsXpsG/ttNZre3f/VlxwatC5zkIQNR4ntzRD
 h1bd+Zi3xbRAhRaVWANGf1jYd9CtHmNtrSgVVaWX7ssywfnzvr6NgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=hqhtZaABsuLkdxGbaQQZwQfzGeZ9OECjFCO8UHvrkmM=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkIuu04zva18HDAXC8qJfPerPxrNmyUmD4rssrB
 LfoZNvhh6OJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCLrtAAKCRBD3pH5JJpx
 RWBqD/0aqLwP4RqhSP+7/RBkK+3HxQANG7OMP7fN380XoU0vZWs9o1sil1m+lJhC8/ssQSyNpvR
 VyD1aeQKOieZ7qKQmZ+jt4LLZXY6Cfi1R/eVAcQhjrLF9SzSs0T6CpwjaTjwQAIt/dw9D85E+oh
 F41noSKGbeYNFMUzvtdYC0JWo2sTE0I9E44aI72yhrbfU4t3s1tGKU8qhzp5oNrcbaHXbFBT4sE
 9d0MgJklzi7c8GGdAjTGewyu6SWtcdpmTGY2HZbrSZtDLZycEZj4CMSYxgBeOgmBTaFUpe6yriu
 jqTqv3U1f6BumgLj6r/vOZPxA5bKJDafpkuzZ811wQ4vWzVwRRGIVu4K0ZlGQf6WloQSNanT48I
 wj3Id6KPENH82hIWXUrxVA2yNeFXg8xv/6XHIvmY9AoDA7T9N4L3xtVgK9FQGbUavrmLaId78Ow
 2hDiNUDNgiyhGGpooTlRf7QGjT9FeWzrev3eY8rO/A7f3/orvhgMR92w19pjg3gCr06wU4G91Vg
 jHt+ef8/TxLDSlA8ayXt/Hw7twjliRDrY410Jp5oekSlWSy5REAGqnYbO8TUgtyfnM2o2VZmOtz
 o5fHU4uXe947Y9H+ZG7xPw8eWaujPEZyHBjTO7NrtgvfDZm8ze1Lp/BI2mDHH5bxskpY57kTAEt
 Cl87PoaTOwP6K4A==
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
Changes in v8:
- Rebase on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/log/?h=ti-k3-dts-next
  keeping audio nodes in the common dtsi
- Link to v7: https://lore.kernel.org/r/20230313-mcasp_upstream-v7-1-88168d0df9b8@ti.com

Changes in v7:
- Add links to schematics in commit messages
- Link to v6: https://lore.kernel.org/r/20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com

Changes in v6:
- Use generic node names (audio-controller@) for McASP
- Fix labels, indentation and spacing issues
- For SK-AM62A:
	- Remove redundant status property from codec
	- Add a note in commit message about missing DVDD regulator
	- Supply OCMV level manually to the codec
- Link to v5: https://lore.kernel.org/r/20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com

---
Jai Luthra (5):
      arm64: defconfig: Enable audio drivers for TI K3 SoCs
      arm64: dts: ti: k3-am625-sk: Enable audio on AM62 SK
      arm64: dts: ti: k3-am62a-main: Add nodes for McASP
      arm64: dts: ti: k3-am62a7-sk: Split vcc_3v3 regulators
      arm64: dts: ti: k3-am62a7-sk: Enable audio on AM62A

Jayesh Choudhary (1):
      arm64: dts: ti: k3-am62-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       | 11 +++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 60 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts         | 11 +++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 60 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 92 +++++++++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 77 +++++++++++++++++++++
 arch/arm64/configs/defconfig                   |  2 +
 7 files changed, 311 insertions(+), 2 deletions(-)
---
base-commit: e1ecd17c0d1e2219c58e5152243e4702bae4f0a4
change-id: 20230313-mcasp_upstream-0e137013059b

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

