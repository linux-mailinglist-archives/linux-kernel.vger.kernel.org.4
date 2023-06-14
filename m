Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31072FAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjFNKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244338AbjFNKaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:30:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0AD26B1;
        Wed, 14 Jun 2023 03:28:52 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E7mxG2028747;
        Wed, 14 Jun 2023 12:27:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=4gWqcoGyM2pSJuyKg08yidHZb3D4H9iwdKx4TeQfzHk=;
 b=1dR/uNmJkE1jHTgmz5EajSuR/pAgmN9eSgk05w0zUdzOX4HmvK1XsGGfaBew0ln9yn+e
 kWUetInawfbGafQ720J6hfhIOYBjTPf0bBHcRPRl7brZv9Il486FI1nw5ZnaKdqebeDk
 0ovPZXqzNN96G/30o5qNg4ONxDhCA8hgVouXmfb5+lrOzCmLie/jB2taaX7cvfGFqxjs
 /Cc5JAww56sdiw+2YbaVKrYNjp0aS3FuEPsjAKqzF2mQGOLophsEroYi83DJSs03bEFO
 m+bVfd/o91NRfRlaC8RO1cpTYEfGBipV9UOilA25zfp/mUT+FmKmejPHu8+sLV0X7tzT 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r79g5975a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 12:27:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BAF7110002A;
        Wed, 14 Jun 2023 12:27:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 917622278AE;
        Wed, 14 Jun 2023 12:27:45 +0200 (CEST)
Received: from localhost (10.252.29.239) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 14 Jun
 2023 12:27:45 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 0/4] spi: stm32: add spi slave mode
Date:   Wed, 14 Jun 2023 12:26:23 +0200
Message-ID: <20230614102628.202936-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.29.239]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_06,2023-06-14_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 SPI can operate in slave mode.
This series add this functionnality in spi-stm32 driver.

Since v1:
 - Do not add #address-cells and #size-cells in st,stm32-spi.yaml
 - Do not add cs-gpio description in st,stm32-spi.yaml
 - Do not add st,spi-slave-underrun property to handle spi slave underrun

Alain Volmat (3):
  spi: stm32: renaming of spi_master into spi_controller
  spi: stm32: use dmaengine_terminate_{a}sync instead of _all
  dt-bindings: spi: stm32: disable spi-slave property for stm32f4-f7

Valentin Caron (1):
  spi: stm32: introduction of stm32h7 SPI slave support

 .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 +
 drivers/spi/Kconfig                           |   1 +
 drivers/spi/spi-stm32.c                       | 274 ++++++++++--------
 3 files changed, 161 insertions(+), 115 deletions(-)

-- 
2.25.1

