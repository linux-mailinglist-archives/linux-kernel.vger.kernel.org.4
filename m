Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4056A6A5767
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjB1LCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjB1LCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:02:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1032CC4D;
        Tue, 28 Feb 2023 03:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677582124; x=1709118124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0BMjJ51501wpDWDJL+qs/Hg4DZbcQHuATRCbLu3HlY=;
  b=aKUiKLZSRZSnuQsYdNv3Dk2ICWIobD+FpybOBX3zxl/M8wTSyB8nvXnb
   DZoh3LfYjMImmA0lhuCaU03wTNLCkB8Mv0jFk2wn5jLKtr3UVe5iC2wcc
   CsN3BId8jbvqajiG/RJScPoM9DwD+8iQYMuDZQZGH44YeEwUbbKhJNOnv
   krCdKSCq4iwJqLfWIUnHSsZAEq7xe69SkYRxeFAA6c5ot3cQOP/SFM4mY
   WfY2fFDlMK9HcxlAUP3ispcaPIPWl75xzuWILUOz08yBpCCd/7KpKYi9Z
   aZX4IQDKPlR75K9rV3MVz9hK8VxsiEKEsrGV56n5UrqFN+Wi8ELtsuJAu
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,221,1673938800"; 
   d="scan'208";a="213967752"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2023 04:02:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 04:02:02 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 04:01:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] ASoC: dt-bindings: sama7g5-pdmc: add microchip,startup-delay-us binding
Date:   Tue, 28 Feb 2023 13:01:44 +0200
Message-ID: <20230228110145.3770525-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228110145.3770525-1-claudiu.beznea@microchip.com>
References: <20230228110145.3770525-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PDMC can work with different types of microphones, thus different boards
could have different microphones. Depending on microphone type the PDMC
would need to wait longer or shorter period (at startup) than the default
chosen one to filter unwanted noise. Thus add microchip,startup-delay-us
binding to let PDMC users to specify startup delay.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
index c4cf1e5ab84b..9b40268537cb 100644
--- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
@@ -67,6 +67,12 @@ properties:
     maxItems: 4
     uniqueItems: true
 
+  microchip,startup-delay-us:
+    description: |
+      Specifies the delay in microseconds that needs to be applied after
+      enabling the PDMC microphones to avoid unwanted noise due to microphones
+      not being ready.
+
 required:
   - compatible
   - reg
-- 
2.34.1

