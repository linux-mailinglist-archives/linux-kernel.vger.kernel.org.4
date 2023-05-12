Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F503700606
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbjELKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbjELKwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:52:10 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BD1FCE;
        Fri, 12 May 2023 03:51:47 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C82PwY015048;
        Fri, 12 May 2023 11:39:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=3cg3EVB9ewH286o8slPPUl1HT2sepf8ePI6K7LlsZTk=;
 b=Bnz/gsasrj/TaS8+u/rC2ZjFtOBNRBURDfpwDLM19uzxH2yggqpkSYMZuwr/W/DoCKpI
 U4xPWZ42lRH9kQJLG7WGx9gCrR4Zm6UXcyKGnpKZMw6ZEpSceYvPNJAF1YycFB6OA8y6
 KX1AV+yrSQPi7NV9J3W/mixaUEJ6J5BZCTaUgfiZ/KTrbBCWhNUqUvnCjv5f+TAZreHY
 CAMbUxtzuvAM7hj5F/HQA/GPAVn/gbZg2d50Dq+f6lhlwieY62YdJZzPRgEEwyzWeCmg
 1zSQZW61vaFQhSdbTPHM1/wcDJt/A09PITR7D7hXxEazjLlj9kgx7C0rGvecfM+DNP1q KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qg90px1xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:39:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A276C10002A;
        Fri, 12 May 2023 11:39:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 79DE12248B0;
        Fri, 12 May 2023 11:39:29 +0200 (CEST)
Received: from localhost (10.201.21.213) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 12 May
 2023 11:39:29 +0200
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
Subject: [PATCH v3 0/4] stm32mp15: update remoteproc to support SCMI Device tree
Date:   Fri, 12 May 2023 11:39:22 +0200
Message-ID: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
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

Update vs V2[1]:
---------------
- update yaml to remove label in examples
- fix error management for  devm_reset_control_get_optional(dev, "hold_boot")
- rebased on commit ac9a78681b92 ("Linux 6.4-rc1")

[1]https://lore.kernel.org/lkml/20230504094641.870378-1-arnaud.pouliquen@foss.st.com/T/


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
  ARM: dts: stm32: fix m4_rproc references to use SCMI

 .../bindings/remoteproc/st,stm32-rproc.yaml   | 44 +++++++++--
 arch/arm/boot/dts/stm32mp151.dtsi             |  2 +-
 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts    |  6 +-
 drivers/remoteproc/stm32_rproc.c              | 76 ++++++++++++++-----
 7 files changed, 111 insertions(+), 35 deletions(-)

-- 
2.25.1

