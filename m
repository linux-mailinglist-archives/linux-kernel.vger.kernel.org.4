Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB76679890
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjAXMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjAXMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:52:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7034457F1;
        Tue, 24 Jan 2023 04:51:47 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBvVD2024695;
        Tue, 24 Jan 2023 12:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=E8MJdl92aJpDkwBwj/LvmjWdNZqIXnjaJVo4Fsd1nKs=;
 b=m8yFx1JdyjcphtklIXgNOsJvueF7Ey9VWznaVXCtf4+pXaoA2Ps/Gvtpx+uB0LR/Q2yP
 NNspb9bb0Nk30fz9v2OXoKrUsrr43ZKOLphpQ0zP27Udgy6ZK7o930U/+YosqvmKlHJ6
 x/TcdV9TZVYmHVoIY0KeuATxsAMtDsRgyMf1xRNbeNtengM/6tCHnmXpKnTYOWXHsLNb
 uHtF4300ORAHldTVmlLVLAkhiWb87Q8Biicm/njHT5Apkut6VTQl4on9F6MSEKyIOfen
 /ozBEwIu4PYmAGa2rtZc6Vh/q/zv7VXoosCrmjYPwGkvyZhoLrXonLbkTIC0X1kZLX+H /Q== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nac9550m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:47 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30OCA2hb031519;
        Tue, 24 Jan 2023 12:50:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n87p6ar5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OCoggD46268886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:50:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DBDF2005A;
        Tue, 24 Jan 2023 12:50:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D23D72004B;
        Tue, 24 Jan 2023 12:50:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 12:50:41 +0000 (GMT)
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
Subject: [PATCH v5 7/7] iommu/dma: Add IOMMU op to choose lazy domain type
Date:   Tue, 24 Jan 2023 13:50:37 +0100
Message-Id: <20230124125037.3201345-8-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124125037.3201345-1-schnelle@linux.ibm.com>
References: <20230124125037.3201345-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zO_AC4edDSfCIehPYCvYGYVEnxChdjo1
X-Proofpoint-ORIG-GUID: zO_AC4edDSfCIehPYCvYGYVEnxChdjo1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=873 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With two flush queue variants add an IOMMU operation that allows the
IOMMU driver to choose its preferred flush queue variant on a per device
basis. For s390 use this callback to choose the single queue variant
whenever the device requires explicit IOTLB flushes on map indicating
that we're running in a paged memory guest with expensive IOTLB flushes.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/iommu.c      | 13 +++++++++++++
 drivers/iommu/s390-iommu.c | 11 +++++++++++
 include/linux/iommu.h      |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b58c4313851b..d3508c357d97 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1616,6 +1616,16 @@ static int iommu_get_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static int iommu_get_lazy_domain_type(struct device *dev)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (ops->lazy_domain_type)
+		return ops->lazy_domain_type(dev);
+
+	return 0;
+}
+
 static int iommu_group_alloc_default_domain(struct bus_type *bus,
 					    struct iommu_group *group,
 					    unsigned int type)
@@ -1649,6 +1659,9 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
+	if (!!(type & __IOMMU_DOMAIN_DMA_LAZY))
+		type = iommu_get_lazy_domain_type(dev) ? : type;
+
 	return iommu_group_alloc_default_domain(dev->bus, group, type);
 }
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index ff73b75be886..b8aab37e8b15 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -459,6 +459,16 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 	}
 }
 
+static int s390_iommu_lazy_domain_type(struct device *dev)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+
+	if (zdev->tlb_refresh)
+		return IOMMU_DOMAIN_DMA_SQ;
+
+	return IOMMU_DOMAIN_DMA_FQ;
+}
+
 static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 {
 	struct zpci_dev *zdev;
@@ -798,6 +808,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.device_group = generic_device_group,
 	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,
+	.lazy_domain_type = s390_iommu_lazy_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= s390_iommu_attach_device,
 		.detach_dev	= s390_iommu_detach_device,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 74cee59516aa..aec895087f63 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -250,6 +250,10 @@ struct iommu_iotlb_gather {
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
  *		- 0: use the default setting
+ * @lazy_domain_type: Domain type for lazy TLB invalidation, return value:
+ *		- IOMMU_DOMAIN_DMA_FQ: Use per-CPU flush queue
+ *		- IOMMU_DOMAIN_DMA_SQ: Use single flush queue
+ *		- 0: use the default setting
  * @default_domain_ops: the default ops for domains
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
@@ -283,6 +287,7 @@ struct iommu_ops {
 			     struct iommu_page_response *msg);
 
 	int (*def_domain_type)(struct device *dev);
+	int (*lazy_domain_type)(struct device *dev);
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
 	const struct iommu_domain_ops *default_domain_ops;
-- 
2.34.1

