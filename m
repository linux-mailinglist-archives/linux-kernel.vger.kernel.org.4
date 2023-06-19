Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D65735635
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjFSLwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFSLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:52:04 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4610B;
        Mon, 19 Jun 2023 04:52:03 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JAiV8x017493;
        Mon, 19 Jun 2023 13:51:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=XMJnVSv0T7nCBxS+9vu0ogPkCSj//pIU8jGy+wxMdT8=;
 b=ZfJvzNYMtTbmpVrR74XAneE3UGXw5Gf9oAO8KxboaGR0xkIwHT44QYDAqo+lTx3YKFrA
 jsvGLydrY12uhjQFG0bkADarU0ydU7kOZ0H7WwCdCq2UTbfYZPePIHHbhy+lmQqfKa8S
 RmqSqev5ny8e8s3V/HCfiHmqGnlNcAn9cOlFkCoyBSr5V8RNu6qh3iY/gfX0sEeLFWMx
 wvMHe2o2cp+yv8B0TTgPJPWujIxdNSL/1rgvyjBNzJcMaH6UOYSxsVxsonRO5pfip0l5
 hB9y8g7JNQXh9iK14njmxcTpxvvksGliK4rBrOUzuxFZkvO8wENRbBl+o3O3rFq+bkel og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rah6bt9jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 13:51:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E14F810002A;
        Mon, 19 Jun 2023 13:51:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D34CC228A33;
        Mon, 19 Jun 2023 13:51:28 +0200 (CEST)
Received: from localhost (10.201.21.210) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 19 Jun
 2023 13:51:28 +0200
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH v2 0/6] Update MMCI driver for STM32MP25
Date:   Mon, 19 Jun 2023 13:51:14 +0200
Message-ID: <20230619115120.64474-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_08,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32MP25 is a new SoC from STMicroelectronics. The machine was
pushed by Alexandre [1] in his tree.
On this new SoC, the SDMMC peripheral, using PL18x/MMCI driver
has been updated to v3.
The driver has been updated to manage this new version, and the new
features it supports:
* FIFO size increased from 64B to 1kB
* IDMA size alignment/mask updated
* New block gap hardware flow control
* Delay block updated and dependent on SoC

This series was pushed on top of next branch in Ulf's mmc tree, as it
requires feedback clock update patch [2].

[1] https://lore.kernel.org/lkml/59f4a900-34ee-d991-c350-265d38e7c862@foss.st.com/T/
[2] https://lore.kernel.org/r/20230613150148.429828-1-yann.gautier@foss.st.com

Changes in v2:
- update dt-bindings file (remove bootloader reference and use enum)

Yann Gautier (6):
  dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2 compatible
  mmc: mmci: add stm32_idmabsize_align parameter
  mmc: mmci: Add support for sdmmc variant revision v3.0
  mmc: mmci: stm32: manage block gap hardware flow control
  mmc: mmci: stm32: prepare other delay block support
  mmc: mmci: stm32: add delay block support for STM32MP25

 .../devicetree/bindings/mmc/arm,pl18x.yaml    |   7 +-
 drivers/mmc/host/mmci.c                       |  35 ++++
 drivers/mmc/host/mmci.h                       |   8 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c           | 149 ++++++++++++++++--
 4 files changed, 179 insertions(+), 20 deletions(-)

-- 
2.25.1

