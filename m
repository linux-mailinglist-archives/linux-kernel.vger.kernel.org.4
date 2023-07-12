Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462C8750AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjGLOZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjGLOZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:25:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2F198A;
        Wed, 12 Jul 2023 07:25:18 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CB447T022860;
        Wed, 12 Jul 2023 16:24:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=vAQsihlA/fq+FWoOWW07sv8pi7Piaa0PlsJD/YDGoGk=;
 b=IoKk4jjj06vQ3gX5xP1jfqaU6AcWeqB1zE3EuKDnft9NUYUX08pCGqr1A47Dw9+j6jpE
 2HTjud6efJvwQ8ov5wE0Pv7jcaISI/A33cwGmcmamV36TV9SAb4v0KRi96c2u8o4Y0YA
 N7D+OizKgg/zy6qUFK8mHjo2G00DU1iF+bHmdspVGFWlXm+A5OP+6ym/UkGpUH3vOV5g
 D42mbBmMVqxLJmdKimLPpk2J58k4+PxHR43AwaY9fNl9wpMWKBEnX9HHNIIgrQuKqKZ3
 tSoFop/N2iaYx0D89yQPl+yFmWzyzFI0fL6M5ftjHLEFnp4TKVkCpLEH+NqMAHUaarfe WQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rsr19b141-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 16:24:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78C9A100058;
        Wed, 12 Jul 2023 16:24:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6942B21BF65;
        Wed, 12 Jul 2023 16:24:36 +0200 (CEST)
Received: from localhost (10.252.136.3) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Jul
 2023 16:24:36 +0200
From:   <p.paillet@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.paillet@foss.st.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 0/4] STM32MP13x expose SCMI regulators
Date:   Wed, 12 Jul 2023 16:24:28 +0200
Message-ID: <20230712142432.1885162-1-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.136.3]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_09,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pascal Paillet <p.paillet@foss.st.com>

Updates STM32MP13 DTS files to define the voltage regulators
exposed by OP-TEE SCMI service and remove the fixed regulator
abstraction previously used.

Etienne Carriere (3):
  dt-bindings: rcc: stm32: add STM32MP13 SCMI regulators IDs
  ARM: dts: stm32: STM32MP13x SoC exposes SCMI regulators
  ARM: dts: stm32: add SCMI PMIC regulators on stm32mp135f-dk board

Pascal Paillet (1):
  ARM: multi_v7_defconfig: Add SCMI regulator support

 arch/arm/boot/dts/st/stm32mp131.dtsi          | 50 +++++++-------
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       | 68 ++++++++-----------
 arch/arm/configs/multi_v7_defconfig           |  1 +
 .../regulator/st,stm32mp13-regulator.h        | 42 ++++++++++++
 4 files changed, 98 insertions(+), 63 deletions(-)
 create mode 100644 include/dt-bindings/regulator/st,stm32mp13-regulator.h

-- 
2.25.1

