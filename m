Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1EF5B8FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiINVQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiINVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:15:48 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205845057;
        Wed, 14 Sep 2022 14:15:47 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F2E81A19DD;
        Wed, 14 Sep 2022 23:15:46 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C01C01A0447;
        Wed, 14 Sep 2022 23:15:45 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 77BE04060A;
        Wed, 14 Sep 2022 14:15:44 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Biwen Li <biwen.li@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v4 4/5] arm64: dts: ls208xa-rdb: fix errata E-00013
Date:   Wed, 14 Sep 2022 16:15:37 -0500
Message-Id: <20220914211538.29473-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220914211538.29473-1-leoyang.li@nxp.com>
References: <20220914211538.29473-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Specify a channel zero in idle state to avoid enterring tri-stated state
for PCA9547.

Some information about E-00013:
- Description: I2C1 and I2C3 buses are missing pull-up.
- Impact: When the PCA954x device is tri-stated, the I2C bus will float.
  This makes the I2C bus and its associated downstream devices
  inaccessible.
- Hardware fix: Populate resistors R189 and R190 for I2C1 and resistors
  R228 and R229 for I2C3.
- Software fix: Remove the tri-state option from the PCA954x
  driver(PCA954x always on enable status, specify a channel zero in dts to
  fix the errata E-00013).

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index f8135c5c252d..3d9647b3da14 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -49,6 +49,8 @@ pca9547@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		idle-state = <0>;
+
 		i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.37.1

