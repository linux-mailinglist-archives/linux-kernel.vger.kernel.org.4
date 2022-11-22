Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12AC633717
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiKVI2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiKVI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:28:33 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44827DDF;
        Tue, 22 Nov 2022 00:28:32 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AM6Kt6s026886;
        Tue, 22 Nov 2022 03:28:30 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kxvxa17pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 03:28:30 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2AM8STT7046736
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 03:28:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 22 Nov
 2022 03:28:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Nov 2022 03:28:28 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2AM8SFcX016751;
        Tue, 22 Nov 2022 03:28:21 -0500
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v6 1/9] iio: adis: add '__adis_enable_irq()' implementation
Date:   Tue, 22 Nov 2022 10:27:49 +0200
Message-ID: <20221122082757.449452-2-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122082757.449452-1-ramona.bolboaca@analog.com>
References: <20221122082757.449452-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: IvnYifdcJGceA5_eh5AF3bznawy_Ck3r
X-Proofpoint-ORIG-GUID: IvnYifdcJGceA5_eh5AF3bznawy_Ck3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211220062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add '__adis_enable_irq()' implementation which is the unlocked
version of 'adis_enable_irq()'.
Call '__adis_enable_irq()' instead of 'adis_enable_irq()' from
'__adis_intial_startup()' to keep the expected unlocked functionality.

This fix is needed to remove a deadlock for all devices which are
using 'adis_initial_startup()'. The deadlock occurs because the
same mutex is acquired twice, without releasing it.
The mutex is acquired once inside 'adis_initial_startup()', before
calling '__adis_initial_startup()', and once inside
'adis_enable_irq()', which is called by '__adis_initial_startup()'.
The deadlock is removed by calling '__adis_enable_irq()', instead of
'adis_enable_irq()' from within '__adis_initial_startup()'.

Fixes: b600bd7eb3335 ("iio: adis: do not disabe IRQs in 'adis_init()'")
Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis.c       | 28 ++++++++++------------------
 include/linux/iio/imu/adis.h | 13 ++++++++++++-
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index f7fcfd04f659..bc40240b29e2 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -270,23 +270,19 @@ EXPORT_SYMBOL_NS(adis_debugfs_reg_access, IIO_ADISLIB);
 #endif
 
 /**
- * adis_enable_irq() - Enable or disable data ready IRQ
+ * __adis_enable_irq() - Enable or disable data ready IRQ (unlocked)
  * @adis: The adis device
  * @enable: Whether to enable the IRQ
  *
  * Returns 0 on success, negative error code otherwise
  */
-int adis_enable_irq(struct adis *adis, bool enable)
+int __adis_enable_irq(struct adis *adis, bool enable)
 {
-	int ret = 0;
+	int ret;
 	u16 msc;
 
-	mutex_lock(&adis->state_lock);
-
-	if (adis->data->enable_irq) {
-		ret = adis->data->enable_irq(adis, enable);
-		goto out_unlock;
-	}
+	if (adis->data->enable_irq)
+		return adis->data->enable_irq(adis, enable);
 
 	if (adis->data->unmasked_drdy) {
 		if (enable)
@@ -294,12 +290,12 @@ int adis_enable_irq(struct adis *adis, bool enable)
 		else
 			disable_irq(adis->spi->irq);
 
-		goto out_unlock;
+		return 0;
 	}
 
 	ret = __adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	msc |= ADIS_MSC_CTRL_DATA_RDY_POL_HIGH;
 	msc &= ~ADIS_MSC_CTRL_DATA_RDY_DIO2;
@@ -308,13 +304,9 @@ int adis_enable_irq(struct adis *adis, bool enable)
 	else
 		msc &= ~ADIS_MSC_CTRL_DATA_RDY_EN;
 
-	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
-
-out_unlock:
-	mutex_unlock(&adis->state_lock);
-	return ret;
+	return __adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
 }
-EXPORT_SYMBOL_NS(adis_enable_irq, IIO_ADISLIB);
+EXPORT_SYMBOL_NS(__adis_enable_irq, IIO_ADISLIB);
 
 /**
  * __adis_check_status() - Check the device for error conditions (unlocked)
@@ -445,7 +437,7 @@ int __adis_initial_startup(struct adis *adis)
 	 * with 'IRQF_NO_AUTOEN' anyways.
 	 */
 	if (!adis->data->unmasked_drdy)
-		adis_enable_irq(adis, false);
+		__adis_enable_irq(adis, false);
 
 	if (!adis->data->prod_id_reg)
 		return 0;
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 515ca09764fe..d789ecf8d0c8 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -402,9 +402,20 @@ static inline int adis_update_bits_base(struct adis *adis, unsigned int reg,
 	__adis_update_bits_base(adis, reg, mask, val, sizeof(val));	\
 })
 
-int adis_enable_irq(struct adis *adis, bool enable);
+static inline int adis_enable_irq(struct adis *adis, bool enable)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_enable_irq(adis, enable);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
+
 int __adis_check_status(struct adis *adis);
 int __adis_initial_startup(struct adis *adis);
+int __adis_enable_irq(struct adis *adis, bool enable);
 
 static inline int adis_check_status(struct adis *adis)
 {
-- 
2.25.1

