Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5433862464C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiKJPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiKJPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:46:42 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9229B31231;
        Thu, 10 Nov 2022 07:46:41 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AAFNOGg006316;
        Thu, 10 Nov 2022 16:46:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Vd1nmwWR7Zh9ApMapN6X7xEklVMUKzQ/GXf4SnNG6XI=;
 b=DZG614YQo1BhfkKYPWTpC4qnVwPB3ECNZ8CVDwfA2W9d5dWC4pOaLVi26rFi1TKWwu4d
 SKw9oXKgiByTEYZGQ9pQ8vKQRXL727qmpmCFWO8SpCpjChej9bCputTFo6Ha+aeavPNS
 unBJ2QGW7vXT0DwJ4chXyardEyjQUPqNe3PAzUTnc4bqDLQNgi05xrhj+LfccCxHwJ5D
 GviXjoY1904ZG8IolCtVs3IFHfLN8n2qJibgFewSFXMnS+0nDpMXbosHW2OpeV6oTEvG
 FieYVBcEobS5Ew/wSapN1o/+ykQuMnC6ILTjmF3R+2NgkCbM/9pg0sqJqQQLrq8DeURV IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3krxfubgqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 16:46:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D921910002A;
        Thu, 10 Nov 2022 16:46:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0D3522AFED;
        Thu, 10 Nov 2022 16:46:10 +0100 (CET)
Received: from localhost (10.252.15.206) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Thu, 10 Nov
 2022 16:46:10 +0100
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Etienne CARRIERE <etienne.carriere@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Date:   Thu, 10 Nov 2022 16:45:46 +0100
Message-ID: <20221110154550.3220800-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.15.206]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_10,2022-11-09_01,2022-06-22_01
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
(using BSEC STM32MP15 compatible) and so it break the STM32MP13x DTS
compatible.

I create this serie for more efficient review, including support for
STM32MP15x.

The first patches of the V1 series is already merged:
"dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem"

This STM32MP13x DTS break is acceptable as
- the STM32MP13x SoC is not yet available outside STMicroelectronics
  (not official)
- the same patch is already integrated or modifications are in progress in
  the other users (arm-trusted-firmware/TF-A, OP-TEE and U-Boot) of
  stm32mp131 device tree.

It is the good time to correct this issue before the real availability of
the SoC and before full support of STM32MP13x SoC in Linux kernel.

Regards

Patrick

Changes in v2:
- rebase series on linux-next/master
- minor update after V1 revue

Changes in v1:
- update commit message to indicate DTS break reason.

Patrick Delaunay (3):
  ARM: dts: stm32mp13: fix compatible for BSEC
  nvmem: stm32: add OP-TEE support for STM32MP13x
  nvmem: stm32: detect bsec pta presence for STM32MP15x

 arch/arm/boot/dts/stm32mp131.dtsi |   2 +-
 drivers/nvmem/stm32-romem.c       | 474 +++++++++++++++++++++++++++++-
 2 files changed, 471 insertions(+), 5 deletions(-)

-- 
2.25.1

