Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E56B2F04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCIUsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCIUrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:47:31 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF4FEF37;
        Thu,  9 Mar 2023 12:46:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8713CE9850;
        Thu,  9 Mar 2023 12:46:37 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ffLjKzkQbcpa; Thu,  9 Mar 2023 12:46:36 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678394796; bh=YuMBgRVd+3H5CpXFdam6+WpwNglEKOVsXHnIMWO7pd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUWsOsdE8SQYrYZ+JWgGJekH3kl/y+WozDJNuE+fuU98zW8HvDO3zPZw8+KQBS5W4
         A32maBVFmPokdLk7Pbdgm0FqwQDE7k44hsBWjKZK2cT7Y7SpZAhkzZaZ9PA59S0fqL
         z33cZoWTxjF1iRfe8cg+rAVr0uZoMtaV0uBmOTFdO4lDBrK4+yUNmetJ8IzEbFgtl0
         sVXGCybJyx1GdStAk7/ka7dP/nnB/0IH1LirXiOlAILsPGtvqUEMBAd49X9yWJ4PVZ
         qQM/5MbyEZPySba17Dc2SYIVylxcNGO0Fo0VN6JIW0R+KwCoXNg3/2piKnOjplWjik
         BPpky4QGNLFXw==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 02/14] arm64: dts: imx8mq-librem5: describe the clock for the csi sensors
Date:   Thu,  9 Mar 2023 21:45:56 +0100
Message-Id: <20230309204608.237605-3-martin.kepplinger@puri.sm>
In-Reply-To: <20230309204608.237605-1-martin.kepplinger@puri.sm>
References: <20230309204608.237605-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CLKO2 clock is used for both camera CSI interfaces as the
driving clock for the connected sensors. In order for it to be
available, use this hog. We can't simply add it to 2 different
sensor descriptions.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index c81cf3e6582b1..fd1f6fb6d6f6f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -371,6 +371,16 @@ pmic-5v-hog {
 };
 
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			/* CLKO2 for cameras on both CSI1 and CSI2 */
+			MX8MQ_IOMUXC_GPIO1_IO15_CCMSRCGPCMIX_CLKO2      0x1f
+		>;
+	};
+
 	pinctrl_audiopwr: audiopwrgrp {
 		fsl,pins = <
 			/* AUDIO_POWER_EN_3V3 */
-- 
2.30.2

