Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CCF6B8FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCNK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjCNKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:08 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD5D51A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:39 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4v24kpzMqQVx;
        Tue, 14 Mar 2023 11:24:31 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4t5pvqz2MRS;
        Tue, 14 Mar 2023 11:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789471;
        bh=yjauXskh+CkHXfC8KZ7Eeurcqsbo5x0x4cTYoo6F1jE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vXP4QWHLa9idoqMDT5/Ep/tX56a1L2TqWewujneSIf8HeWd17eArxMxYTX80qdI+Q
         MgFR5aDovTBT8VVEq+5Uc/zN3rR55RrDeRfZ2m0kLqzVhdEszFDRWTuJFGI5NZalXs
         EaVjiMDDy6aenl54y04XJaVeW/E5asuoAePa4dbg=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/23] arm64: dts: colibri-imx8x: Set thermal thresholds
Date:   Tue, 14 Mar 2023 11:24:03 +0100
Message-Id: <20230314102410.424773-18-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Set critical/alert thermal thresholds for all relevant SOC
temperature trips to the IT value (max T_junction 105 degree
Celsius) in accordance with the IT grade of the SOM.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 2e228c5b8109..1e41965e2d01 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -16,6 +16,18 @@ reg_module_3v3: regulator-module-3v3 {
 	};
 };
 
+&cpu_alert0 {
+	hysteresis = <2000>;
+	temperature = <90000>;
+	type = "passive";
+};
+
+&cpu_crit0 {
+	hysteresis = <2000>;
+	temperature = <105000>;
+	type = "critical";
+};
+
 /* On-module I2C */
 &i2c0 {
 	#address-cells = <1>;
-- 
2.39.2

