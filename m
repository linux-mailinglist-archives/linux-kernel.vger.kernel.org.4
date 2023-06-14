Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A72730440
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245001AbjFNPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244996AbjFNPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:54:25 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517F106;
        Wed, 14 Jun 2023 08:54:22 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDtObl014662;
        Wed, 14 Jun 2023 11:54:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r4p359c1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:54:08 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 35EFs7Ho029744
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Jun 2023 11:54:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 14 Jun
 2023 11:54:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 14 Jun 2023 11:54:06 -0400
Received: from dariana.ad.analog.com ([10.48.65.197])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 35EFrqeM020884;
        Wed, 14 Jun 2023 11:53:55 -0400
From:   Alisa Roman <alisa.roman@analog.com>
CC:     Alisa Roman <alisa.roman@analog.com>, <stable@vger.kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad7192: Fix ac excitation feature
Date:   Wed, 14 Jun 2023 18:52:43 +0300
Message-ID: <20230614155242.160296-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: cr6Efloz85FlQNTvcRMST9D6wbR_8Q67
X-Proofpoint-ORIG-GUID: cr6Efloz85FlQNTvcRMST9D6wbR_8Q67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_11,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140138
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AC excitation enable feature exposed to user on AD7192, allowing a bit
which should be 0 to be set. This feature is specific only to AD7195. AC
excitation attribute moved accordingly.

In the AD7195 documentation, the AC excitation enable bit is on position
22 in the Configuration register. ACX macro changed to match correct
register and bit.

Note that the fix tag is for the commit that moved the driver out of
staging.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Alisa Roman <alisa.roman@analog.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/adc/ad7192.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8685e0b58a83..7bc3ebfe8081 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -62,7 +62,6 @@
 #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
 #define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
-#define AD7192_MODE_ACX		BIT(14) /* AC excitation enable(AD7195 only)*/
 #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
 #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
 #define AD7192_MODE_SCYCLE	BIT(11) /* Single cycle conversion */
@@ -91,6 +90,7 @@
 /* Configuration Register Bit Designations (AD7192_REG_CONF) */
 
 #define AD7192_CONF_CHOP	BIT(23) /* CHOP enable */
+#define AD7192_CONF_ACX		BIT(22) /* AC excitation enable(AD7195 only) */
 #define AD7192_CONF_REFSEL	BIT(20) /* REFIN1/REFIN2 Reference Select */
 #define AD7192_CONF_CHAN(x)	((x) << 8) /* Channel select */
 #define AD7192_CONF_CHAN_MASK	(0x7FF << 8) /* Channel select mask */
@@ -472,7 +472,7 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
+	return sysfs_emit(buf, "%d\n", !!(st->conf & AD7192_CONF_ACX));
 }
 
 static ssize_t ad7192_show_bridge_switch(struct device *dev,
@@ -513,13 +513,13 @@ static ssize_t ad7192_set(struct device *dev,
 
 		ad_sd_write_reg(&st->sd, AD7192_REG_GPOCON, 1, st->gpocon);
 		break;
-	case AD7192_REG_MODE:
+	case AD7192_REG_CONF:
 		if (val)
-			st->mode |= AD7192_MODE_ACX;
+			st->conf |= AD7192_CONF_ACX;
 		else
-			st->mode &= ~AD7192_MODE_ACX;
+			st->conf &= ~AD7192_CONF_ACX;
 
-		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
 		break;
 	default:
 		ret = -EINVAL;
@@ -579,12 +579,11 @@ static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 
 static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       ad7192_show_ac_excitation, ad7192_set,
-		       AD7192_REG_MODE);
+		       AD7192_REG_CONF);
 
 static struct attribute *ad7192_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
-	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
 };
 
@@ -595,6 +594,7 @@ static const struct attribute_group ad7192_attribute_group = {
 static struct attribute *ad7195_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
+	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
 };
 
-- 
2.34.1

