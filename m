Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26B62C61F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiKPRRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiKPRRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:17:24 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD7A5987F;
        Wed, 16 Nov 2022 09:17:23 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGGm8qX004040;
        Wed, 16 Nov 2022 17:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hP0kCovPbWmZTSy7tSN9XNIJQRipnc5HWdbuDbVN2YU=;
 b=I5ppI5Sa34t7XL8lJrgphc2wQQ6qaz0Cir62hE3QYn411ISMlvR7ik0pGZ7rtQPHqKCt
 sLcdBzZ+Vufl+ryjEWYVGvnT8oiDTfCah0H+maQwAl7HCU/Q0rt6Eh+zsC01IGhyPUcP
 T9lh2d2Ej2MKn4IxLfWKA1s7nv2HzwVtoCChlP+orRwTMgh+mZAqZDptRrG2p54yOdjE
 +bISHKhB2Jki+7AJnl5K3aPRoB3aiOKc1D4VXkxmK13zfNv3laDQMyPwzcIlKugxNVKb
 cS3ls0tlHLmjN0+gmCR8FX36Gdm20HSK2Wr4tVF4M5FPDoFYHcr21LTPVP/U8qCRwvhf vQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw3q1rtkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 17:17:03 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGH5PtH021164;
        Wed, 16 Nov 2022 17:17:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3kt349cqmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 17:17:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGHAwoM44892494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 17:10:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 206885204E;
        Wed, 16 Nov 2022 17:16:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 94D205204F;
        Wed, 16 Nov 2022 17:16:57 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v2 2/7] s390/pci: prepare is_passed_through() for dma-iommu
Date:   Wed, 16 Nov 2022 18:16:51 +0100
Message-Id: <20221116171656.4128212-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116171656.4128212-1-schnelle@linux.ibm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1tce3CspqI2aIwvCdZzZ0lQnt6ul_v4B
X-Proofpoint-GUID: 1tce3CspqI2aIwvCdZzZ0lQnt6ul_v4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=965
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the IOMMU always controlled through the IOMMU driver testing for
zdev->s390_domain is not a valid indication of the device being
passed-through. Instead test if zdev->kzdev is set.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index b9324ca2eb94..4ef5a6a1d618 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -59,9 +59,16 @@ static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
 	}
 }
 
-static bool is_passed_through(struct zpci_dev *zdev)
+static bool is_passed_through(struct pci_dev *pdev)
 {
-	return zdev->s390_domain;
+	struct zpci_dev *zdev = to_zpci(pdev);
+	bool ret;
+
+	mutex_lock(&zdev->kzdev_lock);
+	ret = !!zdev->kzdev;
+	mutex_unlock(&zdev->kzdev_lock);
+
+	return ret;
 }
 
 static bool is_driver_supported(struct pci_driver *driver)
@@ -176,7 +183,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	}
 	pdev->error_state = pci_channel_io_frozen;
 
-	if (is_passed_through(to_zpci(pdev))) {
+	if (is_passed_through(pdev)) {
 		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
 			pci_name(pdev));
 		goto out_unlock;
@@ -239,7 +246,7 @@ static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
 	 * we will inject the error event and let the guest recover the device
 	 * itself.
 	 */
-	if (is_passed_through(to_zpci(pdev)))
+	if (is_passed_through(pdev))
 		goto out;
 	driver = to_pci_driver(pdev->dev.driver);
 	if (driver && driver->err_handler && driver->err_handler->error_detected)
-- 
2.34.1

