Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165C65FEB90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJNJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJNJ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:27:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A2EEA685;
        Fri, 14 Oct 2022 02:27:45 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E77Hew023247;
        Fri, 14 Oct 2022 11:27:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=fPnbtOy06TMn1DTm+aL02K49WdHSqDZcH3ig0RdQW+w=;
 b=WMQDODOWFUwRPKDth4MgqUQnNFJct0VDftAPfUxNfM5JAldcGFn70ju5Hb473jk2R5F1
 CFS8nuhXGC6Mm471vM+da+9SMBVhYcTuBY/aq/bK+1MVrCirvZtAKO3Nd4iwd+Av7poV
 MwrONzOCtr+pOAbZYJ0rK3lmTj/+5DWlidECNgS+ahyUwb1seP/ZMgsxCbEgO+ClL2Q/
 5BOaKJgojjn+tdahFX+K4UPi6RphfZTwlZyPu5YYH4qNu2gPLth1yNVeiNXIVSqhPgNT
 akcvLknMljBtEj68XCuQj9JufMefL2po7sSayNVLjQh2ry0vp5l6a3kI42kcjy9dtyzk tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k64m7v4fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 11:27:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD10110002A;
        Fri, 14 Oct 2022 11:27:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D28F721A904;
        Fri, 14 Oct 2022 11:27:30 +0200 (CEST)
Received: from localhost (10.75.127.117) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 11:27:29 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 00/10] Add support for USB on STM32MP13
Date:   Fri, 14 Oct 2022 11:26:41 +0200
Message-ID: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for USBPHYC, USB Host and USB OTG on STM32MP13.
Enable all these interfaces on STM32MP135F-DK board.
Enable the STM32G0 UCSI driver as module.
Dependency on PWR and PMIC regulator is tempoarily managed by using
fixed regulators (resp in the SoC dtsi and the board dts files).
The USB support is functional when these regulators gets enabled at
boot time before entering the kernel.

Amelie Delaunay (5):
  ARM: dts: stm32: add USBPHYC and dual USB HS PHY support on stm32mp131
  ARM: dts: stm32: add UBSH EHCI and OHCI support on stm32mp131
  ARM: dts: stm32: add USB OTG HS support on stm32mp131
  ARM: dts: stm32: enable USB HS phys on stm32mp135f-dk
  ARM: dts: stm32: enable USB Host EHCI on stm32mp135f-dk

Fabrice Gasnier (5):
  ARM: dts: stm32: add PWR fixed regulators on stm32mp131
  ARM: dts: stm32: add fixed regulators to support usb on stm32mp135f-dk
  ARM: dts: stm32: add pins for stm32g0 typec controller on stm32mp13
  ARM: dts: stm32: enable USB OTG in dual role mode on stm32mp135f-dk
  ARM: multi_v7_defconfig: enable Type-C UCSI and STM32G0 as modules

 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi |  7 ++
 arch/arm/boot/dts/stm32mp131.dtsi        | 81 ++++++++++++++++++++
 arch/arm/boot/dts/stm32mp135f-dk.dts     | 95 ++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig      |  2 +
 4 files changed, 185 insertions(+)

-- 
2.25.1

