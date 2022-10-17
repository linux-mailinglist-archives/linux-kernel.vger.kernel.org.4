Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B954600CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJQKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJQKl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:41:58 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2761BEB7;
        Mon, 17 Oct 2022 03:41:57 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id 88834604D6;
        Mon, 17 Oct 2022 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666003315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/rv2/xAUdG1oY3mqfLC41QXomMeexmYUY9AH2+9l9o=;
        b=i5Qo7klc8WKbTAkYWsV5t4LXXq3aY0simORcZJ/8SQgI3bLnDPvunKuaUzPWLu34Ylhcde
        fy39FCmGuChGBrwK57bJO3tDSxAEDJ41aausmiIsYPAEl/OCew99zad0jKMAEQbvdD1531
        6H7+aKqHvGWCLlJBe2kqZDAZ6SvqJpI=
Received: from frank-G5.. (fttx-pool-217.61.154.127.bambit.de [217.61.154.127])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id E5B934053E;
        Mon, 17 Oct 2022 10:41:54 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v1 02/12] dt-bindings: PCI: mediatek-gen3: add support for mt7986
Date:   Mon, 17 Oct 2022 12:41:31 +0200
Message-Id: <20221017104141.7338-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017104141.7338-1-linux@fw-web.de>
References: <20221017104141.7338-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 83c5a80d-4315-46aa-b94f-9c0f82fc4136
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible string for mt7986.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
mt7986a.dtsi misses clock-names which are now required since support of
MT8192/MT8188/MT8195. This change also introduces a 6th clock which is
now needed for all pcie-gen3 dts.

i do not know how to map the clocks to the names...

mediatek-pcie-gen3.yaml:

  clock-names:
    items:
      - const: pl_250m
      - const: tl_26m
      - const: tl_96m
      - const: tl_32k
      - const: peri_26m
      - enum:
          - top_133m        # for MT8192
          - peri_mem        # for MT8188/MT8195

mt7986a.dtsi:

	clocks = <&infracfg CLK_INFRA_PCIE_SEL>,
		 <&infracfg CLK_INFRA_IPCIE_CK>,
		 <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
		 <&infracfg CLK_INFRA_IPCIER_CK>,
		 <&infracfg CLK_INFRA_IPCIEB_CK>;
---
 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index c00be39af64e..b372c8351d9a 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -51,6 +51,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - mediatek,mt7986-pcie
               - mediatek,mt8188-pcie
               - mediatek,mt8195-pcie
           - const: mediatek,mt8192-pcie
-- 
2.34.1

