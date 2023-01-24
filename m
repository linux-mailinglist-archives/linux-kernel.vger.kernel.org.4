Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB167988C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjAXMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjAXMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:52:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAFC7699;
        Tue, 24 Jan 2023 04:51:42 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBnXuf018706;
        Tue, 24 Jan 2023 12:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a9ko8+SfBJpFm0MscknoI7eqwNEE8A4XsRRjuFD+Gwk=;
 b=oamOU0Xo/Gy7aqQ+0oXj28A5A6rLSSjw1v/grwel2ZzcAIGdQ6R9sWyhhltw9cUrI68X
 PY/P5zPC/isidyXP82J70OuIyQNs/x4iVEbndYvjm9OLkYcs1uH8at89MQXnq2oJ23lr
 V3j4BDFVes9sZuMhTIT7oWz/AfMErWGpi/lMl2ewrn/MKIs5CBNWfpU3c7UoeDi/Ouku
 MyR8ClxM4mQrPNeeHEKSHCwVPSnmXBUJcDydV23CdYqwn16QBxYhgauLentDwSFY1vx3
 uWSNUpJSmqB2dMds9AQmBt1CFJUz6lq9SmTOew16JA3WtlnEncnDDt+zVJbGLA738HsO bw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na838an4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:47 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30O2NV6i009185;
        Tue, 24 Jan 2023 12:50:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6aqpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OCocSY21758506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:50:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEB9020040;
        Tue, 24 Jan 2023 12:50:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 325B32004B;
        Tue, 24 Jan 2023 12:50:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 12:50:38 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v5 1/7] s390/ism: Set DMA coherent mask
Date:   Tue, 24 Jan 2023 13:50:31 +0100
Message-Id: <20230124125037.3201345-2-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124125037.3201345-1-schnelle@linux.ibm.com>
References: <20230124125037.3201345-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BRvKZE6t-Gnt_R5CWZuO_cn-NVnNUmGC
X-Proofpoint-ORIG-GUID: BRvKZE6t-Gnt_R5CWZuO_cn-NVnNUmGC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future change will convert the DMA API implementation from the
architecture specific arch/s390/pci/pci_dma.c to using the common code
drivers/iommu/dma-iommu.c which the utilizes the same IOMMU hardware
through the s390-iommu driver. Unlike the s390 specific DMA API this
requires devices to correctly call set the coherent mask to be allowed
to use IOVAs >2^32 in dma_alloc_coherent(). This was however not done
for ISM devices. ISM requires such addresses since currently the DMA
aperture for PCI devices starts at 2^32 and all calls to
dma_alloc_coherent() would thus fail.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index dfd401d9e362..aba03b613296 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -557,7 +557,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_disable;
 
-	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret)
 		goto err_resource;
 
-- 
2.34.1

