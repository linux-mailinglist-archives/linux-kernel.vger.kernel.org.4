Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF1D700409
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbjELJlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbjELJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:41:10 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A556AD879;
        Fri, 12 May 2023 02:40:38 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C8bG0T025488;
        Fri, 12 May 2023 11:39:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=tr01CIe/LpDGGpoPafu39bOHteV6ORG+tu0CkFYJUD0=;
 b=vBk9mG9Q/KmMCVqg48ljoIqEpnKCRZ2+N/aFo6SjONW6Y918JMzJn4Y1o8xBHn65NdPE
 NcDP+edBHIGFWXLUF/Ud9ASFiW0lKTs62vGouVJIgZrlXxHN2SXQfvhc/yOEE0ktWN3x
 WRK1qI2GQ3/sr/T3ItTEW9pJCE/tM8KP6RqYFlbMwLk1f1PvFFMlS0nsrnAb9cqMIDpa
 xzLiiFwVlhWsxaCtTow+acZOvF1wah+QeH/2dgPANx9Y8xqhaBU2eMf9o5ce+q8a5ZS3
 Ou29m/fLLi42BbpZhFyJxp9hOXHjrT7VLofevWBNI/+dtGSR1botx84J3cgTqK8Dq75W kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qguwkrsks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:39:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE23B10002A;
        Fri, 12 May 2023 11:39:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C5E172248B0;
        Fri, 12 May 2023 11:39:32 +0200 (CEST)
Received: from localhost (10.201.21.213) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 12 May
 2023 11:39:32 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v3 4/4] ARM: dts: stm32: fix m4_rproc references to use SCMI
Date:   Fri, 12 May 2023 11:39:26 +0200
Message-ID: <20230512093926.661509-5-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
References: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_06,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes stm32mp15*-scmi DTS files introduced in [1]:
This patch fixes the node which uses the MCU reset and adds the
missing HOLD_BOOT which is also handled by the SCMI reset service.

This change cannot be applied as a fix on commit [1], the management
of the hold boot impacts also the stm32_rproc driver.

[1] 'commit 5b7e58313a77 ("ARM: dts: stm32: Add SCMI version of STM32 boards (DK1/DK2/ED1/EV1)")'

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts | 6 ++++--
 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts | 6 ++++--
 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts | 6 ++++--
 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts | 6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
index e539cc80bef8..134788e64265 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
@@ -55,8 +55,10 @@ &mdma1 {
 	resets = <&scmi_reset RST_SCMI_MDMA>;
 };
 
-&mlahb {
-	resets = <&scmi_reset RST_SCMI_MCU>;
+&m4_rproc {
+	resets = <&scmi_reset RST_SCMI_MCU>,
+		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
+	reset-names =  "mcu_rst", "hold_boot";
 };
 
 &rcc {
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
index 97e4f94b0a24..c42e658debfb 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
@@ -61,8 +61,10 @@ &mdma1 {
 	resets = <&scmi_reset RST_SCMI_MDMA>;
 };
 
-&mlahb {
-	resets = <&scmi_reset RST_SCMI_MCU>;
+&m4_rproc {
+	resets = <&scmi_reset RST_SCMI_MCU>,
+		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
+	reset-names =  "mcu_rst", "hold_boot";
 };
 
 &rcc {
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
index 9cf0a44d2f47..7a56ff2d4185 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
@@ -60,8 +60,10 @@ &mdma1 {
 	resets = <&scmi_reset RST_SCMI_MDMA>;
 };
 
-&mlahb {
-	resets = <&scmi_reset RST_SCMI_MCU>;
+&m4_rproc {
+	resets = <&scmi_reset RST_SCMI_MCU>,
+		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
+	reset-names =  "mcu_rst", "hold_boot";
 };
 
 &rcc {
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
index 3b9dd6f4ccc9..119874dd91e4 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
@@ -66,8 +66,10 @@ &mdma1 {
 	resets = <&scmi_reset RST_SCMI_MDMA>;
 };
 
-&mlahb {
-	resets = <&scmi_reset RST_SCMI_MCU>;
+&m4_rproc {
+	resets = <&scmi_reset RST_SCMI_MCU>,
+		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
+	reset-names =  "mcu_rst", "hold_boot";
 };
 
 &rcc {
-- 
2.25.1

