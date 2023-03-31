Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1B6D2453
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjCaPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCaPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:47:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5585D4691;
        Fri, 31 Mar 2023 08:47:29 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VDqKvU010304;
        Fri, 31 Mar 2023 17:47:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=WnaqWGLbrGE8l1DdJGiLovg7YI1781JuH5yhngJ70so=;
 b=zSTrSxBc/sfgQsuwnBvTWeNOuQFrnJHVRUPWvkEQ/kW2SRJTv/x42zeLeGjdBCZ4KfEr
 019lQyD+QK13vhXbRwVnbyWQAFTucsHNhWCfHh98pi0idgU7/UEPCo3puCcgZDOd59oD
 59xOCUSHyPVmZwgkYpXyCX50eGCURmR4ptJEr6Fh5ISLewVtR/eBGawkN4v+JkWktQOM
 p3evJSacFd/B6Ae2qSJJn+lQqSb2eyjKKlNF56Av0/50wvc/l5J15uL7OQ6IszBPfp8J
 2NXkTdZ1/D7PPnfByg71URq7ypg6JlHxEi5VxXlsJMuo0cvRH8xLw83YokDlAGkSk/Yl rQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pnw9c24rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 17:47:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C96010002A;
        Fri, 31 Mar 2023 17:47:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A6384222CAD;
        Fri, 31 Mar 2023 17:47:15 +0200 (CEST)
Received: from localhost (10.201.21.178) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 31 Mar
 2023 17:47:14 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH 0/5] stm32mp15: update remoteproc to support SCMI Device tree
Date:   Fri, 31 Mar 2023 17:46:46 +0200
Message-ID: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.178]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the stm32_rproc driver and associated DT node to
support device tree configuration with and without SCMI server. 
The impact is mainly on the MCU hold boot management.

1) Configuration without SCMI server (legacy): Trusted context not activated
- The MCU reset is controlled through the Linux RCC reset driver.
- The MCU HOLD BOOT is controlled through The RCC sysconf.

2) Configuration with SCMI server: Trusted context activated
- The MCU reset is controlled through the SCMI reset service.
- The MCU HOLD BOOT is no more controlled through a SMC call service but
  through the SCMI reset service.

In consequence this series:
- Use the SCMI server to manage the MCU hold boot instead of the a SMC
  call service,
- determine the configuration to use depending on the presence of the
  "reset-names" property
  if ( "reset-names" property contains "hold_boot")
  then use reset_control services
  else use regmap access based on "st,syscfg-holdboot" property.
- Update the bindings and DTs in consequence.

Arnaud Pouliquen (5):
  dt-bindings: remoteproc: st,stm32-rproc: Rework reset declarations
  ARM: dts: stm32: Remove the st,syscfg-tz property
  remoteproc: stm32: Clean-up the management of the hold boot by smc
    call
  remoteproc: stm32: Allow hold boot management by the SCMI reset
    controller
  ARM: dts: stm32: fix m4_rproc references to use scmi

 .../bindings/remoteproc/st,stm32-rproc.yaml   | 52 ++++++++++-----
 arch/arm/boot/dts/stm32mp151.dtsi             |  2 +-
 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts    |  6 +-
 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts    |  6 +-
 drivers/remoteproc/stm32_rproc.c              | 64 ++++++++-----------
 7 files changed, 82 insertions(+), 60 deletions(-)

-- 
2.25.1

