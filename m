Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26A6164E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiKBOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiKBOTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:19:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BE9286D9;
        Wed,  2 Nov 2022 07:19:46 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2DJb88007938;
        Wed, 2 Nov 2022 10:19:44 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kjn9tusn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:19:44 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2A2EJhZn017351
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Nov 2022 10:19:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 2 Nov 2022
 10:19:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 2 Nov 2022 10:19:42 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2A2EJWOm005631;
        Wed, 2 Nov 2022 10:19:35 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH 0/8] Remove adis_initial_startup usage
Date:   Wed, 2 Nov 2022 16:18:35 +0200
Message-ID: <20221102141843.122182-1-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Iw3BbsWuu5OXtXl4tT9LCxAi97tIwlGM
X-Proofpoint-ORIG-GUID: Iw3BbsWuu5OXtXl4tT9LCxAi97tIwlGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_10,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020091
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove adis_initial_startup usage due to the fact that it leads to a deadlock.
The same mutex is acquired twice, without releasing it, once inside
adis_initial_startup and once inside adis_enable_irq.
Instead of adis_initial_startup, use __adis_initial_startup.

Ramona Bolboaca (8):
  iio: accel: adis16201: Fix deadlock in probe
  iio: accel: adis16209: Fix deadlock in probe
  iio: gyro: adis16136: Fix deadlock in probe
  iio: gyro: adis16260: Fix deadlock in probe
  iio: imu: adis16400: Fix deadlock in probe
  staging: iio: accel: adis16203: Fix deadlock in probe
  staging: iio: accel: adis16240: Fix deadlock in probe
  iio: imu: adis: Remove adis_initial_startup function

 drivers/iio/accel/adis16201.c         |  2 +-
 drivers/iio/accel/adis16209.c         |  2 +-
 drivers/iio/gyro/adis16136.c          |  2 +-
 drivers/iio/gyro/adis16260.c          |  2 +-
 drivers/iio/imu/adis16400.c           |  2 +-
 drivers/staging/iio/accel/adis16203.c |  2 +-
 drivers/staging/iio/accel/adis16240.c |  2 +-
 include/linux/iio/imu/adis.h          | 12 ------------
 8 files changed, 7 insertions(+), 19 deletions(-)

-- 
2.25.1

