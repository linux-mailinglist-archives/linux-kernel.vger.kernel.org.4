Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370BE73B996
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjFWONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjFWONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:13:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC42689;
        Fri, 23 Jun 2023 07:12:50 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NCnMJi001404;
        Fri, 23 Jun 2023 16:12:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=4w+XTZcklvwz2Fhwwbd75o/e+Qy9XSNVKTR2QtoHRfQ=;
 b=I1FOOH3qMs0c6+tO8nXhqgi0NqOFcX19AArVGvRgovBerWSnSUd95b2IbecB6aGO7Qxh
 VlfcXiAylMXRCowmmZXqUeQYF0D55GJnK/qVDxT/DfVkzU/bqVsZ7fpIuBrFuYj+0V9P
 sIIMNCKct8UKFeKT76VS1oK5argxk4BGb5ZHXGfioYfMpsaNAILi47lK1Iv49dDuLj+T
 9QmCO/yFBX8W0APzO6qccg7i0G/OHUrTdPfFsLLXVxSECAboubdYBBCG7NU9pqstEtwb
 I4V8j+n2h7k4JIuvir6AZj+CTdCda80Asdsb8ei8/g8fg8q+e5Np0TlRSKnXCNt5QlKc HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rd1t6vb2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:12:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 90F80100079;
        Fri, 23 Jun 2023 16:12:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88E9E22D16A;
        Fri, 23 Jun 2023 16:12:28 +0200 (CEST)
Received: from localhost (10.252.5.198) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 23 Jun
 2023 16:12:28 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/7] iio: adc: stm32-dfsdm: manage dfsdm as a channel provider
Date:   Fri, 23 Jun 2023 16:09:39 +0200
Message-ID: <20230623140944.2613002-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
References: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.5.198]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32 is currently implemented as a channels consumer
of the sigma delta modulator.
Change the topology to expose a single IIO device for DFSDM
and remove the IIO device associated to the SD modulator.
Manage the DFSDM as a channel provider to allow this change.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index a428bdb567d5..20756d496c52 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -76,7 +76,6 @@ struct stm32_dfsdm_adc {
 
 	/* ADC specific */
 	unsigned int oversamp;
-	struct iio_hw_consumer *hwc;
 	struct completion completion;
 	u32 *buffer;
 
@@ -1006,12 +1005,6 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 	/* Reset adc buffer index */
 	adc->bufi = 0;
 
-	if (adc->hwc) {
-		ret = iio_hw_consumer_enable(adc->hwc);
-		if (ret < 0)
-			return ret;
-	}
-
 	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
 	if (ret < 0)
 		goto err_stop_hwc;
@@ -1035,8 +1028,6 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
 stop_dfsdm:
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 err_stop_hwc:
-	if (adc->hwc)
-		iio_hw_consumer_disable(adc->hwc);
 
 	return ret;
 }
@@ -1051,9 +1042,6 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
 
 	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
 
-	if (adc->hwc)
-		iio_hw_consumer_disable(adc->hwc);
-
 	return 0;
 }
 
@@ -1230,7 +1218,6 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-		ret = iio_hw_consumer_enable(adc->hwc);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"%s: IIO enable failed (channel %d)\n",
@@ -1239,7 +1226,6 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 		ret = stm32_dfsdm_single_conv(indio_dev, chan, val);
-		iio_hw_consumer_disable(adc->hwc);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev,
 				"%s: Conversion failed (channel %d)\n",
@@ -1449,11 +1435,6 @@ static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
 		return num_ch < 0 ? num_ch : -EINVAL;
 	}
 
-	/* Bind to SD modulator IIO device */
-	adc->hwc = devm_iio_hw_consumer_alloc(&indio_dev->dev);
-	if (IS_ERR(adc->hwc))
-		return -EPROBE_DEFER;
-
 	ch = devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*ch),
 			  GFP_KERNEL);
 	if (!ch)
-- 
2.25.1

