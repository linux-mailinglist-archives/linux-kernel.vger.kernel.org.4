Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A19F667049
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjALKz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjALKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:54:31 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496158D2D;
        Thu, 12 Jan 2023 02:45:52 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C7vmS9020522;
        Thu, 12 Jan 2023 11:45:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=WjBj1qZ/+9wZWePmbKSPXuaTeMxTwjgMwHfpXwQM5TE=;
 b=zRRZ6QMkf0S85FD8/1LFg9yEwcN0h43jNL91x0/Zq03GoDHgeGQfu5hxP5/Tgh80lL2L
 br+u5NOpm0j/XKpInPbqczZFiVf1Ob33MNeHwy0MNqAk+gJjzNYu4oNq/4GReKSMBzl2
 MGNOD/VjntKJyB2DJ9eXP6hLJ+9RCHJZUrdPv86mGL5RLVBFPjmCj8uG8qln9hgvxwi5
 /Aoh3RrXTXhd/K0rsteaZ+wIHXfo2F6cEU2AG8vnC6Fod2Wr9tFGeOzhts7ZxK1swDFw
 K+Cks6ZrkvvdPPfd7RJ16VtPvNDCkb2Phgx1dZiU/jREaPnkac2ycRfEjU8w96yTdmvZ YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n1k5s1y2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:45:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED65D10002A;
        Thu, 12 Jan 2023 11:45:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DE81A214B11;
        Thu, 12 Jan 2023 11:45:03 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 12 Jan
 2023 11:45:03 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marek Vasut <marex@denx.de>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
Subject: [PATCH 00/10] ARM: dts: stm32: add adc internal channels on stm32mp15
Date:   Thu, 12 Jan 2023 11:44:35 +0100
Message-ID: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_06,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 ADC2 internal channels VREFINT and VDDCORE to STM32MP15x SoCs.

Add support of vrefint channel by adding access to vrefint calibration
data in OTP.

The internal channels are defined in STM32MP15 SoC DT according to
generic channel bindings. The STM32 driver does not support a mixed use
of legacy and generic channels. When generic channels are defined,
legacy channel are ignored. This involves that the board device trees
using legacy bindings have to be changed to generic bindings.

Adopt generic iio bindings on all STM32 boards implementing the ADC.

Olivier Moysan (10):
  ARM: dts: stm32: add adc internal channels to stm32mp15
  ARM: dts: stm32: add vrefint calibration on stm32mp15
  ARM: dts: stm32: add vrefint support to adc2 on stm32mp15
  ARM: dts: stm32: enable adc on stm32mp15xx-dkx boards
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    stm32mp157c-ed1
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    avenger96
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    emstamp-argon
  ARM: dts: stm32: adopt generic iio bindings for adc channels on dhcom
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    dhcor-drc
  ARM: dts: stm32: adopt generic iio bindings for adc channels on
    dhcor-testbench

 arch/arm/boot/dts/stm32mp151.dtsi             | 17 +++++++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts         | 16 ++++++++--
 .../boot/dts/stm32mp157c-emstamp-argon.dtsi   |  6 ++--
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  | 12 +++++---
 .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi | 28 +++++++++++++++---
 .../dts/stm32mp15xx-dhcor-drc-compact.dtsi    | 28 +++++++++++++++---
 .../boot/dts/stm32mp15xx-dhcor-testbench.dtsi | 28 +++++++++++++++---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        | 29 +++++++++++++------
 8 files changed, 134 insertions(+), 30 deletions(-)

-- 
2.25.1

