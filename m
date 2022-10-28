Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C46F611537
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJ1Oxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJ1Ox1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:53:27 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55D1F9A37;
        Fri, 28 Oct 2022 07:53:25 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDKRxf013088;
        Fri, 28 Oct 2022 16:53:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Fa1kfPZR0So1Ksdf6tTlPVDiOP3/9UUGcgnzcV+vz+U=;
 b=XoI7FGC8nyHYfyJUEtxKOwxm+iC0dTnfgBR7H55PvqsRNlK1nqwgfhE4485igW4sfQ9o
 GY3GY+y4tR+iHK+eK5pXi386hqzlEIrJKQxVmtqPELkTl14LHyfPEMvrZKYsZksGAfJN
 Lz9UJ1miYy9AKqj3dFf9JAez1wvEnpVoAN0htcGz+7k1i8VuNjB8jjYXCLgadzFULdfv
 d7ZtysJSh+ILWeBuTCrd0QSeGp2fA/EZqpXdA5Wa7guga7JrMJ5x0natx2AgBITPt7/q
 NMO/5AC/uXWaILA+y6sUkpVDOk0oU+ULdlY6ms/IHXpIVdGWJfwcBtFZ78Fnqn5Hb1eH JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kfahu5hyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 16:53:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E058100034;
        Fri, 28 Oct 2022 16:52:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 69120228A4E;
        Fri, 28 Oct 2022 16:52:59 +0200 (CEST)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 16:52:58 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Etienne CARRIERE <etienne.carriere@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Date:   Fri, 28 Oct 2022 16:52:48 +0200
Message-ID: <20221028145252.2115933-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This serie update the NVMEM BSEC driver to be compatible with STM32MP13x
SoC and the trusted application STM32MP BSEC in OP-TEE

This serie solve issue in initial support of STM32MP131
(using BSEC STM32MP15 compatible) and so it break the DTS compatible.

I create this serie for more efficient review.

The 2 first patches of this series are re-sent of patches already sent

1- "dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem"
    https://lore.kernel.org/all/20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid/
    https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685403

2- "ARM: dts: stm32mp13: fix compatible for BSEC"
    https://lore.kernel.org/all/20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid/
    https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685815

This DTS break is acceptable as
- the STM32MP13x SoC is not yet available outside STMicroelectronics
  (not official)
- the same patch is already integrated or modifications are in progress in
  the other users (arm-trusted-firmware/TF-A, OP-TEE and U-Boot) of
  stm32mp131 device tree.

It is the good time to correct this issue before the real availability of
the SoC and before full support of SoC in Linux kernel.

This last patch on NVMEM STM32 ROMEM driver in depend on the preliminary
patch for the driver:

  "nvmem: stm32: move STM32MP15_BSEC_NUM_LOWER in config"
  https://lore.kernel.org/all/20221017174953.v2.1.I95e71328dd654723bd4c57206bd008ff81c726bb@changeid/

present in the serie

  "nvmem: stm32: several minor improvements"
  https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685886

Regards

Patrick

Changes in v1:
- update commit message to indicate DTS break reason.

Patrick Delaunay (3):
  dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem
  ARM: dts: stm32mp13: fix compatible for BSEC
  nvmem: stm32: add OP-TEE support for STM32MP13x

 .../bindings/nvmem/st,stm32-romem.yaml        |   1 +
 arch/arm/boot/dts/stm32mp131.dtsi             |   2 +-
 drivers/nvmem/stm32-romem.c                   | 450 +++++++++++++++++-
 3 files changed, 448 insertions(+), 5 deletions(-)

-- 
2.25.1

