Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62426724F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjARRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjARRaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:30:22 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B854F36E;
        Wed, 18 Jan 2023 09:30:13 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IDK3iJ020807;
        Wed, 18 Jan 2023 18:29:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=SdOetiYgPcMw3qvd+XPDduke2B2OTvZvs1GFc3/68Eo=;
 b=nyRg+fUxWXpgd81vKVUIM0oRMBSzkK82st4SUaQG8dmtQBmNGd6DWIeczaxhzVESlyAo
 Te3r0y72DJ6kBCGsuEuJ7X7fOHGHAPqrQOllScLnBgkT8cB0XDmaR9P/dhOPNREhAjeF
 cmV0F+rG7iPJMht+9rDdgbK4R4mII2XIRlAB6/nY0jSTCwc6DuRpy76B1Mj7scmmY1Si
 zxpPwLVFCzkWXwHDdvF+7LK2a9zdsJvTZvzs8qDWf7WbdMq6MmIPZ6jrxiDi/liYyTRW
 s/50pY8sX34zCdob5eoxa0Wa5vzkqDhsE+OFU3mfxIr8BKWU96YhEqKar4IWcaBVsa2W MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n3jpr9hnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:29:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE3C5100034;
        Wed, 18 Jan 2023 18:29:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7321A228A21;
        Wed, 18 Jan 2023 18:29:48 +0100 (CET)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 18 Jan
 2023 18:29:46 +0100
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Etienne CARRIERE <etienne.carriere@linaro.org>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v6 0/3] nvmem: stm32: add OP-TEE support for STM32MP13x
Date:   Wed, 18 Jan 2023 18:29:36 +0100
Message-ID: <20230118172940.841094-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The v5 patchset is rebased on next-20221226.

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

Changes in v6:
- Add reviewed by  Etienne Carierre review
- added reviewed by Etienne Carriere

Changes in v5:
- minor changes after Etienne Carierre review (comments,
  change %x to %#x, remove goto to out_tee_session)
- update the BSEC SMC detection logic in stm32_romem_probe()
  after Etienne Carierre review to support NVMEM probe after OP-TEE probe

Changes in v4:
- fixe warning reported by kernel test robot for 64 bits support in
  drivers/nvmem/stm32-bsec-optee-ta.c:260:18:
  warning: format '%d' expects argument of type 'int',
  but argument 4 has type 'size_t'

Changes in v3:
- add a separate file stm32-bsec-optee-ta.c with STM32MP BSEC TA
  communication functions to avoid #if in romem driver.
- use of_find_compatible_node in optee_presence_check function
  instead of of_find_node_by_path("/firmware/optee")

Changes in v2:
- rebase series on linux-next/master
- minor update after V1 revue

Changes in v1:
- update commit message to indicate DTS break reason.

Patrick Delaunay (3):
  ARM: dts: stm32mp13: fix compatible for BSEC
  nvmem: stm32: add OP-TEE support for STM32MP13x
  nvmem: stm32: detect bsec pta presence for STM32MP15x

 arch/arm/boot/dts/stm32mp131.dtsi   |   2 +-
 drivers/nvmem/Kconfig               |  11 +
 drivers/nvmem/Makefile              |   1 +
 drivers/nvmem/stm32-bsec-optee-ta.c | 298 ++++++++++++++++++++++++++++
 drivers/nvmem/stm32-bsec-optee-ta.h |  80 ++++++++
 drivers/nvmem/stm32-romem.c         |  84 +++++++-
 6 files changed, 472 insertions(+), 4 deletions(-)
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.c
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.h

base-commit: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5
prerequisite-patch-id: 5aaa8fffbdd16871143808180b3932d80f4045d0
prerequisite-patch-id: ae711dc528e191e4751cbb7402041fc5f185d6b3
-- 
2.25.1

