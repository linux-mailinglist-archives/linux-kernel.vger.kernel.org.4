Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5BD750073
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGLHv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:51:47 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832A21989;
        Wed, 12 Jul 2023 00:51:46 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C55VZa020933;
        Wed, 12 Jul 2023 03:51:44 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rq4q6r166-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 03:51:44 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 36C7pgVR023714
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 03:51:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Jul
 2023 03:51:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Jul 2023 03:51:41 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.149])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36C7pPt9015653;
        Wed, 12 Jul 2023 03:51:36 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH 1/1] iio: imu: adis16475.c: Add delta angle and delta velocity channels
Date:   Wed, 12 Jul 2023 10:50:54 +0300
Message-ID: <20230712075054.953421-2-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712075054.953421-1-ramona.bolboaca@analog.com>
References: <20230712075054.953421-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jerlYi41YguOpYy_gB1WukjS2_cuHVR3
X-Proofpoint-ORIG-GUID: jerlYi41YguOpYy_gB1WukjS2_cuHVR3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120068
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add delta angle and delta velocity channels to adis16475 driver.
All supported devices offer the capabilities to read this data
by performing raw register reads.

Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
 drivers/iio/imu/adis16475.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 3abffb01ba31..84bee9e155bd 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -31,6 +31,12 @@
 #define ADIS16475_REG_Y_ACCEL_L		0x14
 #define ADIS16475_REG_Z_ACCEL_L		0x18
 #define ADIS16475_REG_TEMP_OUT		0x1c
+#define ADIS16475_REG_X_DELTANG_L	0x24
+#define ADIS16475_REG_Y_DELTANG_L	0x28
+#define ADIS16475_REG_Z_DELTANG_L	0x2C
+#define ADIS16475_REG_X_DELTVEL_L	0x30
+#define ADIS16475_REG_Y_DELTVEL_L	0x34
+#define ADIS16475_REG_Z_DELTVEL_L	0x38
 #define ADIS16475_REG_X_GYRO_BIAS_L	0x40
 #define ADIS16475_REG_Y_GYRO_BIAS_L	0x44
 #define ADIS16475_REG_Z_GYRO_BIAS_L	0x48
@@ -90,6 +96,8 @@ struct adis16475_chip_info {
 	u32 accel_max_val;
 	u32 accel_max_scale;
 	u32 temp_scale;
+	u32 deltang_max_val;
+	u32 deltvel_max_val;
 	u32 int_clk;
 	u16 max_dec;
 	u8 num_sync;
@@ -453,6 +461,14 @@ static int adis16475_read_raw(struct iio_dev *indio_dev,
 		case IIO_TEMP:
 			*val = st->info->temp_scale;
 			return IIO_VAL_INT;
+		case IIO_ROT:
+			*val = st->info->deltang_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_VELOCITY:
+			*val = st->info->deltvel_max_val;
+			*val2 = 31;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
 			return -EINVAL;
 		}
@@ -553,6 +569,32 @@ static int adis16475_write_raw(struct iio_dev *indio_dev,
 		}, \
 	}
 
+#define ADIS16475_MOD_CHAN_DELTA(_type, _mod, _address, _r_bits, _s_bits) { \
+		.type = (_type), \
+		.modified = 1, \
+		.channel2 = (_mod), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+		.address = (_address), \
+		.scan_index = -1, \
+		.scan_type = { \
+			.sign = 's', \
+			.realbits = (_r_bits), \
+			.storagebits = (_s_bits), \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define ADIS16475_DELTANG_CHAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_ROT, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTANG_L, 32, 32)
+
+#define ADIS16475_DELTVEL_CHAN(_mod) \
+	ADIS16475_MOD_CHAN_DELTA(IIO_VELOCITY, IIO_MOD_ ## _mod, \
+			   ADIS16475_REG_ ## _mod ## _DELTVEL_L, 32, 32)
+
 static const struct iio_chan_spec adis16475_channels[] = {
 	ADIS16475_GYRO_CHANNEL(X),
 	ADIS16475_GYRO_CHANNEL(Y),
@@ -561,6 +603,12 @@ static const struct iio_chan_spec adis16475_channels[] = {
 	ADIS16475_ACCEL_CHANNEL(Y),
 	ADIS16475_ACCEL_CHANNEL(Z),
 	ADIS16475_TEMP_CHANNEL(),
+	ADIS16475_DELTANG_CHAN(X),
+	ADIS16475_DELTANG_CHAN(Y),
+	ADIS16475_DELTANG_CHAN(Z),
+	ADIS16475_DELTVEL_CHAN(X),
+	ADIS16475_DELTVEL_CHAN(Y),
+	ADIS16475_DELTVEL_CHAN(Z),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
@@ -664,6 +712,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -679,6 +729,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -694,6 +746,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -709,6 +763,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -724,6 +780,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -739,6 +797,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -754,6 +814,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -769,6 +831,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -784,6 +848,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -799,6 +865,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(4000 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -814,6 +882,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -829,6 +899,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -844,6 +916,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 1,
 		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -859,6 +933,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -876,6 +952,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -893,6 +971,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -910,6 +990,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 78,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 100,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -927,6 +1009,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 360,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -944,6 +1028,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 720,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
@@ -961,6 +1047,8 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.accel_max_val = 392,
 		.accel_max_scale = 32000 << 16,
 		.temp_scale = 100,
+		.deltang_max_val = 2160,
+		.deltvel_max_val = 400,
 		.int_clk = 2000,
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
-- 
2.25.1

