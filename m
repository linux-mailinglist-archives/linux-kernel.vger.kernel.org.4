Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F56664FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjAKUqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjAKUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:46:51 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACBA2AD6;
        Wed, 11 Jan 2023 12:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u6RMNbMb6ucx4uR6ZWuRrXPvgJadEglU+45lT3/wpmY=; b=BFUeKTJ8avi6CphNjqAEIkcjej
        0X42LeAqolseHK9Vtqzi6D6lI+MdKY9zliERTHArav48PQ1P6fdYT79v1Zhz+9hbnNhD67OieiM8J
        m/GvwZLoRN+j0/USBQhTwtOldGNNL16SjLWjUfaY1VSkydxRdKOMdiBF2MQveqxW+K+nSjMM3oJ8i
        v28FHFTSZiUMpKBgkziGfGptEcg24eBCkQdxOzhcWW9Ebys15Nk8c0E1lWVD9mBceK3rm1bT1EMyf
        /z7x+hntcCeC9hqU/H2EQMkwKAtEPluTrvcWQ9W9jhRLeOq2+q/FnBVwEUUyJ5PCMkYUKib1bmCGN
        3qvu/QfA==;
Received: from p200300ccff07a8001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff07:a800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pFhzX-00009L-Hu; Wed, 11 Jan 2023 21:46:35 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pFhzW-008pXR-Vk; Wed, 11 Jan 2023 21:46:34 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] dt-bindings: mmc: fsl-imx-esdhc: Add some compatible fallbacks
Date:   Wed, 11 Jan 2023 21:46:33 +0100
Message-Id: <20230111204634.2104690-1-andreas@kemnade.info>
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
Changes in v2:
- allow only combinations with fallback compatible
- reduce them to the cases where they are actually useful

 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index dc6256f04b42..be6caa25c57d 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -29,14 +29,18 @@ properties:
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
+          - const: fsl,imx6sll-usdhc
+          - const: fsl,imx6sx-usdhc
+      - items:
+          - const: fsl,imx6ull-usdhc
+          - const: fsl,imx6sx-usdhc
       - items:
           - enum:
               - fsl,imx8mq-usdhc
-- 
2.30.2

