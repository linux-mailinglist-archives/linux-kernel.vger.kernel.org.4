Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39459629605
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiKOKfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238370AbiKOKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:35:07 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4920BB7F1;
        Tue, 15 Nov 2022 02:35:05 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFA0DEu007359;
        Tue, 15 Nov 2022 11:34:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=lQpIOKYpc+Dxu48ZbINg3+W2yJFLZFkRBfz6KvFtNwI=;
 b=qvRVe31l4CfjXLhjlkpq+l3BvCqA34USuAPIOWq72lYzeAWe22rTP3hfXc85tyXJ1D0J
 P/FGRLdlhI89oZgrBNsDcb0Q+hOzGHB7CUZGqBnx8LOZJJ2jGBCIVtFUOzlierx+LTWB
 tW9aCBEzNBDBqQiaGAR7B5xQn9kkzpR3hqPmj7We6wqtS/9nOYFWPo98Ms+u4LJGDhFP
 NHbygsov/JinEsdl1PReCTHn3gvELxkGbgr1mmhF5MhExzaXJVcg0vNo8r2UAL63g/LQ
 zJ3HjAjRmDSa7MFjPedeGWQwiQyWmMSO7e/FYXGRQlTmcDqkFyCc98V0+FlG/S3GrEA6 Xw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ktq2ynee1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 11:34:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0AA7F100038;
        Tue, 15 Nov 2022 11:34:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0326621A206;
        Tue, 15 Nov 2022 11:34:33 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Tue, 15 Nov
 2022 11:34:32 +0100
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
Subject: [PATCH 2/3] iio: adc: stm32-adc: improve calibration error log
Date:   Tue, 15 Nov 2022 11:31:22 +0100
Message-ID: <20221115103124.70074-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115103124.70074-1-olivier.moysan@foss.st.com>
References: <20221115103124.70074-1-olivier.moysan@foss.st.com>
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

Add more information in calibration error log to differentiate
single-ended and differential calibration.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 2b2b55eb130e..65dd45537505 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1109,7 +1109,7 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev, int do_lincal)
 					   !(val & STM32H7_ADCAL), 100,
 					   STM32H7_ADC_CALIB_TIMEOUT_US);
 	if (ret) {
-		dev_err(&indio_dev->dev, "calibration failed\n");
+		dev_err(&indio_dev->dev, "calibration (single-ended) error %d\n", ret);
 		goto out;
 	}
 
@@ -1125,7 +1125,8 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev, int do_lincal)
 					   !(val & STM32H7_ADCAL), 100,
 					   STM32H7_ADC_CALIB_TIMEOUT_US);
 	if (ret) {
-		dev_err(&indio_dev->dev, "calibration failed\n");
+		dev_err(&indio_dev->dev, "calibration (diff%s) error %d\n",
+			(msk & STM32H7_ADCALLIN) ? "+linear" : "", ret);
 		goto out;
 	}
 
-- 
2.25.1

