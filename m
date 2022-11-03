Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D00617865
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiKCIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKCIJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:09:09 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE6BE60;
        Thu,  3 Nov 2022 01:09:08 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A347R6u008154;
        Thu, 3 Nov 2022 04:09:06 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kjn9u0rqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 04:09:06 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2A3895Ga004116
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 04:09:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 3 Nov 2022
 04:09:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 3 Nov 2022 04:09:04 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2A388q0J009844;
        Thu, 3 Nov 2022 04:08:57 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v2 1/8] iio: accel: adis16201: Fix deadlock in probe
Date:   Thu, 3 Nov 2022 10:08:40 +0200
Message-ID: <20221103080847.162509-2-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103080847.162509-1-ramona.bolboaca@analog.com>
References: <20221103080847.162509-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8DKN4vEbSuZ2D7dkdlUCMHjrSIs1CuC1
X-Proofpoint-ORIG-GUID: 8DKN4vEbSuZ2D7dkdlUCMHjrSIs1CuC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030057
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '__adis_initial_startup()' instead of 'adis_initial_startup()' to
avoid deadlock.
When using 'adis_initial_startup()' 'mutex_lock()' is called twice,
without releasing it (once inside 'adis_initial_startup()' and
once inside 'adis_enable_irq()').

Fixes: b600bd7eb3335 ("iio: adis: do not disabe IRQs in 'adis_init()'")
Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
changes in v2:
 - changed commit in 'Fixes' tag to the correct commit
 - added commas and brackets for functions in commit message
 drivers/iio/accel/adis16201.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index dfb8e2e5bdf5..d054721859b3 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -281,7 +281,7 @@ static int adis16201_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = adis_initial_startup(st);
+	ret = __adis_initial_startup(st);
 	if (ret)
 		return ret;
 
-- 
2.25.1

