Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852416C7A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjCXIus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjCXIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:50:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D32B25B87;
        Fri, 24 Mar 2023 01:50:43 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32O8oTnG076428;
        Fri, 24 Mar 2023 03:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679647829;
        bh=AtY/i68M/ZkFZCG7uuusAeSPH+cbkYa2AxPmxsZOPyk=;
        h=From:Subject:Date:To:CC;
        b=j10QDwXL6SBlmVBq1QCYcjEm16isUZgYQ7bDTfuDAHtQ/x1eraVcE0g6fyisXhwI5
         HOotMpXswqCboHB8TTQOJ8N3wbipP0WYHs+NvL19MrtLo+3Q3fgfHbrUR7PD2PEvjt
         GFiXAz1PdDy1FZm47zom+np5/Wa6+qyPEpoxHqvY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32O8oTRx006514
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 03:50:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 03:50:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 03:50:28 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32O8oSua008737;
        Fri, 24 Mar 2023 03:50:28 -0500
From:   Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v7 0/6] arm64: ti: Enable audio on AM62 and AM62A
Date:   Fri, 24 Mar 2023 14:19:53 +0530
Message-ID: <20230313-mcasp_upstream-v7-0-4fac9c785299@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFkHWQC/32Nyw6CMBQFf4V0bU2h9KEr/8MYc1uu0gQKaaHRE
 P7dwsKdLuckM2chEYPDSM7FQgImF93gM6hDQWwL/onUNZlJxSrOeMlpbyGO93mMU0DoKcOSK1Z
 yJk6GZMlARGoCeNtmzc9dl8cx4MO99pfrLXPr4jSE936axLb+7CdBGW2krmvFFICGy+SOdujJ1
 knyvyuzq5TUolHWoNFfd13XD6Fx5qf6AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=n+urLEhgDR9vQ906haf3mOsMOuNjegSNHpyDVF/fQy8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkHWRNpnRi5dyeTey4QGJBbzW9QvMxzIGX7A3oX
 +sBMo9VwM6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZB1kTQAKCRBD3pH5JJpx
 RZtqD/9N9kbliImuNRXNGhdktnnor41rbxkmkToMXlYIw92ImkPeRUPvM/KUI8fQ22oSS5lkVED
 KZ//xyl7oCKr6okHvWgGDhIBbMl2Twgi1DveIXABcQz6jyc2nF8DH1X5MlWBjnrxlbiYqiDGds5
 eGnoUqGYrn1adWcihM9Kew12L95NA/fjDoUTMeSeyo6etglbWO+MhqFdxbpQ2IWTn6V3KuQXRmN
 ij5E9fAgk+6DaQKGP+iekjuk+GEMeK4J2zX0CmgbjGIYwAlT6xXASZM0mAHikwBhzmA6sT8EjKM
 0LQeqF+xD5wTtM3tYu/W9mzPMd9hZ9sHPkvevZHlC+V/YIG1wIya+55D5FNeWKco3qj3i7FBXkc
 Da34hCeLBc1CBM4R+Ia3FdZT+6SZqQ5UqyOd+6qNEPloZXfD3rQ0tR9go9efkpi2WkHesNqtL0f
 hRjePSBgLn64v10WJW5StVPxernbNNGeZg0hS9qXlO0ngaZ4LunTVZDJy+N9pXhCQPZ6zEnc9ti
 xAGxT5bJrsautfAJTjULibJyyo3bOgyVQe5CN8hIN9U5ETEoAzkAJn1AwA4M+xcxYk5j7oiofUF
 94WcHt6yg1OQZRO0k26hKav2VoTI5oHQCcqc+f43tk7MBx1OfUF0SGidsowA15bWhEKZtItym+W
 9ugFotIrHSnNi2g==
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

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 60 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts    | 88 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 60 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   | 92 ++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig              |  2 +
 5 files changed, 300 insertions(+), 2 deletions(-)
---
base-commit: e5dbf24e8b9e6aa0a185d86ce46a7a9c79ebb40f
change-id: 20230313-mcasp_upstream-0e137013059b

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

