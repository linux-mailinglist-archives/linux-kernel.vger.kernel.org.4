Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E580A6CC70F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjC1Pti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjC1Ptg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:49:36 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC6C198;
        Tue, 28 Mar 2023 08:49:34 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SE1gFw005941;
        Tue, 28 Mar 2023 17:37:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=SzvK1cLP3OVVX9Q34SB1SXBdU4+s87izaRnygm8nHqQ=;
 b=ytVCVY5OzwIsP6XlIJ0AzjLidchlClt6yZb1wCyS/CoIm48pv2nyVbDpCCPBkz9KlWAv
 btCZMQv4SbwlGOWU52edtJUgO/YQF2rzMiKcmu+mpn/cHru6uO1pCu5aJAtrBVveDy+V
 OsCaKWnvEZzv0bwvfIcBhrLETzPKubW59lL2aZ0TelgaE6WPEBVY1L25ZAd+n/pRmLBN
 cNMqkw0tM/M+ZHdlFMWpw+vCKo9/SOuBYIyf1Tbb+BrrA4HdzcFCFZnDlvv0CB0mqV6j
 Rr0Pcu+sWCjRb7rGCZkRIbE7ojJojSUQfmus5quS1IqxkSYuMjsAdnzCbT9sB4mX6vFX GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pk5xkjtk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 17:37:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D56E2100034;
        Tue, 28 Mar 2023 17:37:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CFAFA2171C4;
        Tue, 28 Mar 2023 17:37:36 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 17:37:36 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] ARM: dts: stm32: fix slew-rate of USART2 on stm32mp15xx-dkx
Date:   Tue, 28 Mar 2023 17:37:18 +0200
Message-ID: <20230328153723.498672-2-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328153723.498672-1-valentin.caron@foss.st.com>
References: <20230328153723.498672-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On stm32mp15xx-dkx boards:
- Fix slew-rate of USART 2 to 0 like other USARTs, because frequency of
USART pins doesn't exceed 10Mhz.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index e15a3b2a9b39..e86d989dd351 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -2178,7 +2178,7 @@ pins1 {
 				 <STM32_PINMUX('D', 4, AF7)>; /* USART2_RTS */
 			bias-disable;
 			drive-push-pull;
-			slew-rate = <3>;
+			slew-rate = <0>;
 		};
 		pins2 {
 			pinmux = <STM32_PINMUX('D', 6, AF7)>, /* USART2_RX */
@@ -2196,7 +2196,7 @@ pins2 {
 			pinmux = <STM32_PINMUX('D', 4, AF7)>; /* USART2_RTS */
 			bias-disable;
 			drive-push-pull;
-			slew-rate = <3>;
+			slew-rate = <0>;
 		};
 		pins3 {
 			pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
-- 
2.25.1

