Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8373832F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFUL40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjFUL4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:56:18 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09E172C;
        Wed, 21 Jun 2023 04:56:16 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L8OqRH006129;
        Wed, 21 Jun 2023 13:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=YxBtpSM5sSg0wVwpGUcq/kres7yIfCpVOY8/p11inRU=;
 b=I5v523/vgZDUjaL9k74Z0R4EUpR6/9hhODi4Iyccc+FNBJBIuyfV2j4KzcL05V7ClDvb
 7jTU7gmaiCCTvmblVQl8rCpHqJjEoBKxsRmjdvp+oYtmDhpoGaBEIVUFoZKlHI2BhvkV
 zyEDbZcFcHjxiP6f1xxwTPqt4FMegbV1LGZ8y9igfAup1zkU0nGIxitRE+yAy5/nR6ji
 UsuosGv7R4SknRftrFHSkk8sKrJJWDtWy12znp4nw+LJ+FMnEBviAqvggNsQUqPPS+BB
 NTIrmXrIX8p+kZJyNnNSQ51zy11Sbl/OFCYOkL1/dg8d9dHiblDZnaHdoEAEaN7ce9Jb Vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rbutsannu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:55:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3011F100069;
        Wed, 21 Jun 2023 13:55:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 17C25235F39;
        Wed, 21 Jun 2023 13:55:54 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 21 Jun
 2023 13:55:53 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 0/2] spi: stm32: disable spi device mode for stm32f4-f7
Date:   Wed, 21 Jun 2023 13:55:21 +0200
Message-ID: <20230621115523.923176-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series follows this thread:
https://lore.kernel.org/all/20230615075815.310261-1-valentin.caron@foss.st.com/

As STM32F4-F7 hardware can handle device mode and stm32 spi kernel
driver can't, a restriction should be put in the kernel driver and
not in the device-tree bindings. This series fixes that.

Valentin Caron (2):
  spi: stm32: disable device mode with st,stm32f4-spi compatible
  spi: dt-bindings: stm32: do not disable spi-slave property for
    stm32f4-f7

 .../devicetree/bindings/spi/st,stm32-spi.yaml     |  1 -
 drivers/spi/spi-stm32.c                           | 15 ++++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.25.1

