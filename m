Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E5566B3B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 20:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjAOTwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 14:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjAOTwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 14:52:30 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C11A12854;
        Sun, 15 Jan 2023 11:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yZfYvCeRQR/OkCJqdsPpVkd0rVFb184AMOYWRElkTgg=; b=roXQKhd93TuC0Nkqt4sAaj0Fis
        J2PUjIL5dTVZ0+Cu0xIj1j9o1PO1Ib2yyqaVt2wUaTlv+8/EbxMoTXsS/jcZuvCh4Aoavz/t5ux68
        tF9XZrXWJNSd5hzPhou8iUePgZ6iiD10nIkjdYwJEYLhNsghSTfOBqnu10tBBDl7Pi12jJyiKF/wS
        kNa41E9mz+QIphFZdobMAkYMhcas2De7ECrgdzkiWbTDWMVAsnEGkcUSTd8UF5A6OOJAiZ6FBiBO2
        zk7DjM+fM7wxieB+hpBEKIjuaNv6VYzQk57PUf/SNfbEcP7HmmYFl1m1/0GnEJ02kEOBifY51KjDn
        2TlB0aow==;
Received: from p200300ccff407d001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff40:7d00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pH938-0001CG-NS; Sun, 15 Jan 2023 20:52:14 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pH938-00AcCe-21; Sun, 15 Jan 2023 20:52:14 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3] dt-bindings: mmc: fsl-imx-esdhc: Add some compatible fallbacks
Date:   Sun, 15 Jan 2023 20:52:12 +0100
Message-Id: <20230115195212.2530087-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently make dtbs_check shows lots of errors because imx*.dtsi does
not use single compatibles but combinations of them.

Add fallbacks for imx6sll/ull which are useful for U-Boot.

This will significantly reduce noise on make dtbs_check.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v3:
- simplify things by using enums

Changes in v2:
- allow only combinations with fallback compatible
- reduce them to the cases where they are actually useful

 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index dc6256f04b42..3423e1cd8b5d 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -29,14 +29,17 @@ properties:
           - fsl,imx53-esdhc
           - fsl,imx6q-usdhc
           - fsl,imx6sl-usdhc
-          - fsl,imx6sll-usdhc
           - fsl,imx6sx-usdhc
-          - fsl,imx6ull-usdhc
           - fsl,imx7d-usdhc
           - fsl,imx7ulp-usdhc
           - fsl,imx8mm-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
+      - items:
+          - enum:
+              - fsl,imx6sll-usdhc
+              - fsl,imx6ull-usdhc
+          - const: fsl,imx6sx-usdhc
       - items:
           - enum:
               - fsl,imx8mq-usdhc
-- 
2.30.2

