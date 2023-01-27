Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5427D67E8DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjA0PCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjA0PB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:01:58 -0500
X-Greylist: delayed 967 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Jan 2023 07:01:57 PST
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com [67.231.157.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E8757B7;
        Fri, 27 Jan 2023 07:01:57 -0800 (PST)
Received: from pps.filterd (m0048299.ppops.net [127.0.0.1])
        by m0048299.ppops.net-00176a03. (8.17.1.19/8.17.1.19) with ESMTP id 30R6j4FF008620;
        Fri, 27 Jan 2023 07:57:19 -0500
From:   Ian Ray <ian.ray@ge.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        ian.ray@ge.com
Subject: [PATCH] drivers: iio: adc: ltc2497: fix LSB shift
Date:   Fri, 27 Jan 2023 14:57:14 +0200
Message-Id: <20230127125714.44608-1-ian.ray@ge.com>
X-Mailer: git-send-email 2.10.1
X-Proofpoint-ORIG-GUID: ZhqMomqWbtzWC2O6rSYnrsrZc8VQYowq
X-Proofpoint-GUID: ZhqMomqWbtzWC2O6rSYnrsrZc8VQYowq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_08,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270122
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the "sub_lsb" shift for both ltc2497 and ltc2499.

An earlier version of the code shifted by 14 but this was a consequence
of reading three bytes into a __be32 buffer and using be32_to_cpu(), so
eight extra bits needed to be skipped.  Now we use get_unaligned_be24()
and thus the additional skip is wrong.

Fixes 2187cfe ("drivers: iio: adc: ltc2497: LTC2499 support")
Signed-off-by: Ian Ray <ian.ray@ge.com>
---
 drivers/iio/adc/ltc2497.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 17370c5..ec198c6 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -28,7 +28,6 @@ struct ltc2497_driverdata {
 	struct ltc2497core_driverdata common_ddata;
 	struct i2c_client *client;
 	u32 recv_size;
-	u32 sub_lsb;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -65,10 +64,10 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 		 * equivalent to a sign extension.
 		 */
 		if (st->recv_size == 3) {
-			*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
+			*val = (get_unaligned_be24(st->data.d8) >> 6)
 				- BIT(ddata->chip_info->resolution + 1);
 		} else {
-			*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
+			*val = (be32_to_cpu(st->data.d32) >> 6)
 				- BIT(ddata->chip_info->resolution + 1);
 		}
 
@@ -122,7 +121,6 @@ static int ltc2497_probe(struct i2c_client *client)
 	st->common_ddata.chip_info = chip_info;
 
 	resolution = chip_info->resolution;
-	st->sub_lsb = 31 - (resolution + 1);
 	st->recv_size = BITS_TO_BYTES(resolution) + 1;
 
 	return ltc2497core_probe(dev, indio_dev);
-- 
2.10.1

