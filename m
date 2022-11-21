Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BBF632821
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKUP3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiKUP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:27:46 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E64DFD8;
        Mon, 21 Nov 2022 07:27:32 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALDOxAB026886;
        Mon, 21 Nov 2022 10:27:30 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kxvx9uy8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 10:27:30 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2ALFRTrm029877
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 10:27:29 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 21 Nov
 2022 10:27:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 21 Nov 2022 10:27:28 -0500
Received: from rbolboac.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2ALFRHal003861;
        Mon, 21 Nov 2022 10:27:22 -0500
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v5 0/9] Add '__adis_enable_irq()'
Date:   Mon, 21 Nov 2022 17:27:08 +0200
Message-ID: <20221121152717.403667-1-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _E3XDOAGhnlX0mJnnmeckWFuRvGs59lT
X-Proofpoint-ORIG-GUID: _E3XDOAGhnlX0mJnnmeckWFuRvGs59lT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=751 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210119
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added implementation for '__adis_enable_irq()' and called it instead of
'adis_enable_irq()' inside '__adis_initial_startup()'.
Replaced 'adis_initial_startup()' calls in probe, with its unlocked
variant.

changes in v3:
 new patches: 1,2
 changed commit message for patches 2-9

changes in v4:
 squashed patches 1 & 2 from v3

changes in v5:
 fix compilation error

Ramona Bolboaca (9):
  iio: adis: add '__adis_enable_irq()' implementation
  iio: accel: adis16201: Call '__adis_initial_startup()' in probe
  iio: accel: adis16209: Call '__adis_initial_startup()' in probe
  iio: gyro: adis16136: Call '__adis_initial_startup()' in probe
  iio: gyro: adis16260: Call '__adis_initial_startup()' in probe
  iio: imu: adis16400: Call '__adis_initial_startup()' in probe
  staging: iio: accel: adis16203: Call '__adis_initial_startup()'
  staging: iio: accel: adis16240: Call '__adis_initial_startup()'
  iio: imu: adis: Remove adis_initial_startup function

 drivers/iio/accel/adis16201.c         |  2 +-
 drivers/iio/accel/adis16209.c         |  2 +-
 drivers/iio/gyro/adis16136.c          |  2 +-
 drivers/iio/gyro/adis16260.c          |  2 +-
 drivers/iio/imu/adis.c                | 28 ++++++++++-----------------
 drivers/iio/imu/adis16400.c           |  2 +-
 drivers/staging/iio/accel/adis16203.c |  2 +-
 drivers/staging/iio/accel/adis16240.c |  2 +-
 include/linux/iio/imu/adis.h          | 17 ++++++++--------
 9 files changed, 25 insertions(+), 34 deletions(-)

-- 
2.25.1

