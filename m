Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC2574ADF2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjGGJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjGGJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:42:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A051BEE;
        Fri,  7 Jul 2023 02:42:09 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:27cd:2d0a:f02b:d955])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73D316606FE7;
        Fri,  7 Jul 2023 10:42:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688722927;
        bh=2RocGZadPxeM62Wimx6tn0ZTuqx4/+NH7SB92y3TF7g=;
        h=From:To:Cc:Subject:Date:From;
        b=OLfyRpXzX1AUrp8m+OCD2XhJlw8I7+yBWCoEPPjYJwICy+2slRJARBAAENODjOQC9
         1c8yzsHJ5sn2H/rjQRU7dcAZ+JGrspz/3f333FFukb4zu/faMHCIz9GF1MvNNROLg4
         npBR3KuCVKMwFnWYRfu0OnioniqzVduWpEvlDLWZWUrhT5dvkD7hZ7GL5TQqIQnhoB
         45I4F7P+ft0Emrf6bhNHREVyHlPLeNlF92oxgtT0iZMBA5snEE0nlPB2SVVRIw6Nh0
         KtAc7r5hBFEAlP7GJeUEXVfl8F43q7TQn073VIqRvZXgydDanvQzcBs+tLl0H5Z3cT
         CoIaGcNu45MrA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ezequiel@vanguardiasur.com.ar, aford173@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] ARM64: dts: freescale: Fix VPU G2 clock
Date:   Fri,  7 Jul 2023 11:42:00 +0200
Message-Id: <20230707094200.47119-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set VPU G2 clock to 300MHz like described in documentation.
This fix pixels error occurring with large resolution ( >= 2560x1600)
HEVC test stream when using the postprocessor to produce NV12.

Fixes: 4ac7e4a81272 ("arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 0492556a10db..345c70c6c697 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -770,7 +770,7 @@ pgc_vpu: power-domain@6 {
 									 <&clk IMX8MQ_SYS1_PLL_800M>,
 									 <&clk IMX8MQ_VPU_PLL>;
 						assigned-clock-rates = <600000000>,
-								       <600000000>,
+								       <300000000>,
 								       <800000000>,
 								       <0>;
 					};
-- 
2.39.2

