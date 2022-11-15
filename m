Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A53629604
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbiKOKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiKOKfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:35:05 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75366A1B8;
        Tue, 15 Nov 2022 02:35:02 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFA1qNU007476;
        Tue, 15 Nov 2022 11:34:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=FR3Ak5brVAj0TlAyXv0t45EkwjMIibLUzSL/a8UA32Y=;
 b=4eWMyPtx3hpJFKJ43kinjBtc1124Of87Q+elsX3OObiU5Jc8YLzyetXuU1BSAimW1VD5
 SxrT0uItxMjx7SqIpZNtAVzICG3d5vnRi+oivbQRPoV3t4OMb16VdTBezbtVdR3DPEam
 UT3Bab0fG3F3WqN9/ryZhlb0psPVqCnEtoamvg3ACsaTlFOjKaZAgoJvq04ckuGjJP2v
 bWfwa33Z8hGIYHDGvC+tZq7F5APTC4SY6mC+xHgqg6h+pDTODyG7+/wBm+WhC8ynbrQ+
 d4Lz0T/c9C1NbbfBx7ZJAAaX1MPlKHLJ3vqrYq2COZtlogdYK6igzJKN8DEvnzfwXlDv 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ktq2ynedv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 11:34:36 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2768510002A;
        Tue, 15 Nov 2022 11:34:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2042321A206;
        Tue, 15 Nov 2022 11:34:31 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Tue, 15 Nov
 2022 11:34:30 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     <fabrice.gasnier@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] iio: adc: stm32: add smart calibration
Date:   Tue, 15 Nov 2022 11:31:20 +0100
Message-ID: <20221115103124.70074-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_05,2022-11-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refine offset and linear calibration strategy for STM32MP15 and
STM32MP13 SoCs:

- offset calibration
This calibration depends on factors such as temperature and voltage.
As it is not time consuming, it's worth doing it on each ADC
start, to get the best accuracy. There is no need to save these data.

- linear calibration
This calibration is basically SoC dependent, so it can be done only once.
When this calibration has been performed at boot stage, the ADC kernel
driver can retrieve the calibration data from the ADC registers.
Otherwise, the linear calibration is performed once by the ADC driver.
The backup of these data, allows to restore them on successive ADC starts.

Olivier Moysan (3):
  iio: adc: stm32-adc: smart calibration support
  iio: adc: stm32-adc: improve calibration error log
  iio: adc: stm32-adc: add debugfs to read raw calibration result

 drivers/iio/adc/stm32-adc-core.h |   1 +
 drivers/iio/adc/stm32-adc.c      | 135 ++++++++++++++++++-------------
 2 files changed, 78 insertions(+), 58 deletions(-)

-- 
2.25.1

