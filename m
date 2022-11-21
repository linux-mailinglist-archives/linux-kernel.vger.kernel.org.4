Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710B16321EA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiKUM1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKUM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:27:35 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7C6411;
        Mon, 21 Nov 2022 04:27:30 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALC1QgA026852;
        Mon, 21 Nov 2022 07:27:28 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kxvx9u01a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 07:27:28 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2ALCRQll004984
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 07:27:27 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 21 Nov
 2022 07:27:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 21 Nov 2022 07:27:26 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2ALCR74u020739;
        Mon, 21 Nov 2022 07:27:21 -0500
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v4 6/9] iio: imu: adis16400: Call '__adis_initial_startup()' in probe
Date:   Mon, 21 Nov 2022 14:26:52 +0200
Message-ID: <20221121122655.48268-7-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121122655.48268-1-ramona.bolboaca@analog.com>
References: <20221121122655.48268-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: LZZNoYFK6t07i3WPZDrE2kcWjPtSdrCQ
X-Proofpoint-ORIG-GUID: LZZNoYFK6t07i3WPZDrE2kcWjPtSdrCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_12,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210097
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call '__adis_initial_startup()' instead of its locked variant in
'adis16400_probe()'.
The locks are not needed at this point.

Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 17bb0c40a149..c02fc35dceb4 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -445,7 +445,7 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 	st->adis.spi->mode = SPI_MODE_3;
 	spi_setup(st->adis.spi);
 
-	ret = adis_initial_startup(&st->adis);
+	ret = __adis_initial_startup(&st->adis);
 	if (ret)
 		return ret;
 
-- 
2.25.1

