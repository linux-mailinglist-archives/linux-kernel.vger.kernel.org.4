Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95B4622DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKIO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiKIO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:29:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED10DAE6D;
        Wed,  9 Nov 2022 06:29:23 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9EH0YO017321;
        Wed, 9 Nov 2022 14:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=5X7c70HwpdKGqwrRi8VHe8cooQgIi0KkuKnzwyodgvM=;
 b=AztfFATKJ9gBhJ2s3YPOSWJEjrUYaVqCeX2HaB7lRE4uM8NSob0wet0cuaTk7LjMMd49
 5Lundsa1bo+igHKlRN+TYxSs/e42pGop9KY5xhYv2mn95GCdTeKWrKECEyMIKiEcnP5o
 59y1dEBoPt+7FN/QOT5tkAupvuej5SrVa+4CN+yZihmTVH18eKtwPqtVGgNQtPiHWjrb
 Ufh6xbAOG9p4D393M8baLqCVYz5+cmY2O9iT6fLyJGSwPnIDIH3JP17YOoPKPT/qAuGi
 Yx5IrRiCva1k+6CR3PgdImmgp0GQkeGNwoXrnmkDvbDJUUHCMXBMNQ9W601ZiYar+1Lj Xg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krdu2raj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9ELLcj013876;
        Wed, 9 Nov 2022 14:29:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3kngqddsb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 14:29:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9ET4Pi2163334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 14:29:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 967E5A4040;
        Wed,  9 Nov 2022 14:29:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26448A404D;
        Wed,  9 Nov 2022 14:29:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 14:29:04 +0000 (GMT)
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
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] iommu/s390: Further improvements
Date:   Wed,  9 Nov 2022 15:28:58 +0100
Message-Id: <20221109142903.4080275-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7NYYePf_vI1X_VvKDgz3RyRoILvutN1J
X-Proofpoint-GUID: 7NYYePf_vI1X_VvKDgz3RyRoILvutN1J
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=652
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series of patches improves the s390 IOMMU driver. These improvements help
existing IOMMU users, mainly vfio-pci, but at the same time are also in
preparation of converting s390 to use the common DMA API implementation in
drivers/iommu/dma-iommu.c instead of its platform specific DMA API in
arch/s390/pci/pci_dma.c that sidesteps the IOMMU driver to control the same
hardware interface directly.

Among the included changes patch 1 improves the robustness of switching IOMMU
domains and patch 2 adds the I/O TLB operations necessary for the DMA API
conversion. Patches 3, 4, and 5 aim to improve performance with patch 5 being
the most intrusive by removing the I/O translation table lock and using atomic
updates instead.

This series is based on the s390 branch of Joerg's IOMMU tree[0] that includes
the latest s390 IOMMU fixes. It is available for easy testing in the
iommu_improve_v2 branch with signed tag s390_iommu_improve_v2 of my
git.kernel.org tree[1].

Best regards,
Niklas Schnelle

Changes sinve v1:
- If an IOTLB flush fails for one device don't skip the flush for other devices.
  This is also needed when RCU readers try to flush a detached device. (Jason)
- Free a domain's IOMMU translation table via call_rcu() (Jason)

[0] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=s390
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/

Niklas Schnelle (5):
  iommu/s390: Make attach succeed even if the device is in error state
  iommu/s390: Add I/O TLB ops
  iommu/s390: Use RCU to allow concurrent domain_list iteration
  iommu/s390: Optimize IOMMU table walking
  s390/pci: use lock-free I/O translation updates

 arch/s390/include/asm/pci.h |   4 +-
 arch/s390/kvm/pci.c         |   6 +-
 arch/s390/pci/pci.c         |  13 +--
 arch/s390/pci/pci_dma.c     |  77 +++++++++------
 drivers/iommu/s390-iommu.c  | 184 ++++++++++++++++++++++++------------
 5 files changed, 185 insertions(+), 99 deletions(-)

-- 
2.34.1

