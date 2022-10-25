Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC8660CB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJYL53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiJYL5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:57:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A189931;
        Tue, 25 Oct 2022 04:57:23 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PB8Vnr018212;
        Tue, 25 Oct 2022 11:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=unYoLKyySQNeEa7w7NV2iUuiZnAZ4UtNtoWgCnGGL4s=;
 b=Tdv8iDsUtOVxKZ5lgv5u/oTkEReQD8iUV/6UpmObUgTG4mPJXrksYJNt6pWsGP5sCNUI
 ORqOEpmh2jV41VG+8lDKgt7Yns7v0v/F5jdE6XvRKzvo9YFB+L+vLyRK13oBWOJrAdX7
 lpj5KMqzq4PVa5o5Q4toxx5Jgb9HqttAhGbnPIz/DUnLM0RuSbZx5g8zVY8DJHZ+Ab3a
 d/yDwsegjpoisILQpXqTaGT0/C/5sc9x2+x+uN4ZKkbcQcY49VIkpRqI0eNP9h6ENUMH
 erp8hra3pFze1nfA0DlPuLV1lg9QWPaZ/qPve2pd+6n7wG9B26AwmCJy7peHW/IRdwCj rw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3keea7a69w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 11:57:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29PBoqLl000478;
        Tue, 25 Oct 2022 11:57:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3kdugat5r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 11:57:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29PBv0oL3932904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 11:57:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40C924203F;
        Tue, 25 Oct 2022 11:57:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD4C42047;
        Tue, 25 Oct 2022 11:56:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Oct 2022 11:56:59 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v8 4/6] iommu/s390: Fix incorrect aperture check
Date:   Tue, 25 Oct 2022 13:56:55 +0200
Message-Id: <20221025115657.1666860-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025115657.1666860-1-schnelle@linux.ibm.com>
References: <20221025115657.1666860-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9RftsI3RZCAxYB0NfIuqzR71TKrTObBQ
X-Proofpoint-GUID: 9RftsI3RZCAxYB0NfIuqzR71TKrTObBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_05,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=939
 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The domain->geometry.aperture_end specifies the last valid address treat
it as such when checking if a DMA address is valid.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v7->v8:
- Added Jason's R-b
v3->v4:
- Make check robust against overflow (Jason)

 drivers/iommu/s390-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 9b3adc61005c..3e601ca6ee0f 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -213,7 +213,7 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 	int rc = 0;
 
 	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
-	    dma_addr + size > s390_domain->domain.geometry.aperture_end)
+	    (dma_addr + size - 1) > s390_domain->domain.geometry.aperture_end)
 		return -EINVAL;
 
 	nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-- 
2.34.1

