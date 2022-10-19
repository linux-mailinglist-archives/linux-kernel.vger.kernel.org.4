Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6226049EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJSOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiJSOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:53:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30EFEC51A;
        Wed, 19 Oct 2022 07:44:58 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JEgDc0012825;
        Wed, 19 Oct 2022 14:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=T9ipHhLWjB4FtbXLtXXC5uRsveoymZZqeV5ExTNBY10=;
 b=UljNcdwFHsHrpZoyCXMsdW36XZ0sSp3RvCX7g68FwFoxS1aandACxdR41FIRu4Y9BWlf
 hAfRuPJ+54zLjqnYIyl9aU8TqEa0JKv1jAn/oINPbQqZgE5xJf7O/tZfdskvPjj5HSbu
 Nw1meFtJ6c8LMDEirLEBAIxRjm9qoR65oILmgw6qVJNSQ4JSrxBFWswlfrAkbArYc8UM
 l03CEMr9BePefBYsapbC9j+1lpvPJyQFfejoLIan9BNwzD+JH5ERM6GTQ6vBYcFDJIIH
 R/3lu0cbnHRZB1jREJowIHn2+3yAVh+5C3DAG19++DwzfkQjQxY556QsHNyemFTYNRBX vg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kak7w82em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:44:45 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JEZQjO016360;
        Wed, 19 Oct 2022 14:44:43 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3k7mg95fuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:44:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JEidiX63308238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:44:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCEB44C046;
        Wed, 19 Oct 2022 14:44:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 591824C044;
        Wed, 19 Oct 2022 14:44:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 14:44:39 +0000 (GMT)
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
Subject: [RFC 6/6] iommu/s390: flush queued IOVAs on RPCIT out of resource indication
Date:   Wed, 19 Oct 2022 16:44:35 +0200
Message-Id: <20221019144435.369902-7-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019144435.369902-1-schnelle@linux.ibm.com>
References: <20221019144435.369902-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zvaae_gU5yUneCMK3W5k3ZpMFxHyxn3x
X-Proofpoint-ORIG-GUID: Zvaae_gU5yUneCMK3W5k3ZpMFxHyxn3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RPCIT indicates that the underlying hypervisor has run out of
resources it often means that its IOVA space is exhausted and IOVAs need
to be freed before new ones can be created. By triggering a flush of the
IOVA queue we can get the queued IOVAs freed and also get the new
mapping established during the global flush.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c  |  2 +-
 drivers/iommu/dma-iommu.h  |  1 +
 drivers/iommu/s390-iommu.c | 12 ++++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 427fb84f50c3..4853f98f3305 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -287,7 +287,7 @@ static void flush_percpu(struct iommu_dma_cookie *cookie)
 	}
 }
 
-static void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie)
+void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie)
 {
 	if (!cookie->fq_domain)
 		return;
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 942790009292..cac06030aa26 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -13,6 +13,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 int iommu_dma_init_fq(struct iommu_domain *domain);
+void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie);
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 506f8b92931f..270662584f96 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -502,6 +502,10 @@ static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
 		atomic64_inc(&s390_domain->ctrs.global_rpcits);
 		rc = zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
 					zdev->end_dma - zdev->start_dma + 1);
+		if (rc == -ENOMEM) {
+			iommu_dma_flush_fq(domain->iova_cookie);
+			rc = 0;
+		}
 		if (rc)
 			break;
 	}
@@ -525,6 +529,10 @@ static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
 		atomic64_inc(&s390_domain->ctrs.sync_rpcits);
 		rc = zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
 					size);
+		if (rc == -ENOMEM) {
+			iommu_dma_flush_fq(domain->iova_cookie);
+			rc = 0;
+		}
 		if (rc)
 			break;
 	}
@@ -545,6 +553,10 @@ static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
 		atomic64_inc(&s390_domain->ctrs.sync_map_rpcits);
 		rc = zpci_refresh_trans((u64)zdev->fh << 32,
 					iova, size);
+		if (rc == -ENOMEM) {
+			iommu_dma_flush_fq(domain->iova_cookie);
+			rc = 0;
+		}
 		if (rc)
 			break;
 	}
-- 
2.34.1

