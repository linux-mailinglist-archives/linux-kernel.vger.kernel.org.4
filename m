Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35B6F68A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjEDJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjEDJr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:47:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF6949C5;
        Thu,  4 May 2023 02:47:24 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3447UYeH020976;
        Thu, 4 May 2023 11:46:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=JhLdoccG9tbVqo20ekeAFmjgj7nuP6heNt1rvTRIr6k=;
 b=kQxcsxCBAF/dZ9vXLyYXy2Efs0jYl0XYx+t/1Pvpl0Hqt+nROJrILFl9ojH4QKJlWYiw
 m5ULUdhPIC2xfwDhGh3F+UeID1Ce2x/RiKfMAusChdXkizOE/oxNfNDgTmDuqH4RFgzL
 nQ7XYbO4xLZDHDW325YeXjl5HCx5xQINzdpmFlE5qJb9Vff2bYNH3z/pl9dvkfbK34s2
 FjCQkKYSJQwGxNKcE0Rj83MSBoFMxSicaqH1LyA25lQmaWa7t+TP/rfZCTr1d3Vdkt4M
 oTDF/Dz1FKcL2pRy6voGjJHE3Rk0mueEWpt4vVHhl1Y7V+ovRUepYZBYrC/cdaL4aXK0 Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qc8cp13dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 11:46:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DC1B10002A;
        Thu,  4 May 2023 11:46:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3CDF2138F9;
        Thu,  4 May 2023 11:46:51 +0200 (CEST)
Received: from localhost (10.201.21.213) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 4 May
 2023 11:46:51 +0200
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
Subject: [PATCH v2 0/4] stm32mp15: update remoteproc to support SCMI Device tree
Date:   Thu, 4 May 2023 11:46:37 +0200
Message-ID: <20230504094641.870378-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update vs V1[1]:
---------------
- Keep compatibility with legacy DT by keeping support of st,syscfg-tz property
- Add comments to explain the different configuration supported for the old boot

[1]https://lore.kernel.org/lkml/DU0PR04MB941747DDF6FD2F157A24183288939@DU0PR04MB9417.eurprd04.prod.outlook.com/t/

Description:
-----------
This series updates the stm32_rproc driver and associated DT node to
support device tree configuration with and without SCMI server. 
The impact is mainly on the MCU hold boot management.

Three configurations have to be supported:

1) Configuration without OP-TEE SCMI (legacy): Trusted context not activated
- The MCU reset is controlled through the Linux RCC reset driver.
- The MCU HOLD BOOT is controlled through The RCC sysconf.

2) Configuration with SCMI server: Trusted context activated
- The MCU reset is controlled through the SCMI reset service.
- The MCU HOLD BOOT is no more controlled through a SMC call service but
  through the SCMI reset service.

3) Configuration with OP-TEE SMC call (deprecated): Trusted context activated
- The MCU reset is controlled through the Linux RCC reset driver.
- The MCU HOLD BOOT is controlled through The SMC call.

In consequence this series:
- adds the use of the SCMI reset service to manage the MCU hold boot,
- determines the configuration to use depending on the presence of the
  "reset-names" property
  if ( "reset-names" property contains "hold_boot")
  then use reset_control services
  else use regmap access based on "st,syscfg-holdboot" property.
- set the DT st,syscfg-tz property as deprecated

Arnaud Pouliquen (4):
  dt-bindings: remoteproc: st,stm32-rproc: Rework reset declarations
  remoteproc: stm32: Allow hold boot management by the SCMI reset
    controller
  ARM: dts: stm32: Update reset declarations
  ARM: dts: stm32: fix m4_rproc references to use scmi

 .../bindings/remoteproc/st,stm32-rproc.yaml   | 42 ++++++++--
 arch/arm/boot/dts/stm32mp151.dtsi             |  2 +-
 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts    |  6 +-
 drivers/remoteproc/stm32_rproc.c              | 78 ++++++++++++++-----
 7 files changed, 111 insertions(+), 35 deletions(-)

-- 
2.25.1

