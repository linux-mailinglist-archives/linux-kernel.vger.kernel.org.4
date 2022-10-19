Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4006049E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiJSOxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJSOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:53:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D884E61;
        Wed, 19 Oct 2022 07:44:53 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JEf7gU022089;
        Wed, 19 Oct 2022 14:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=4UnVk9+oKOMa0v1NozWo3rfviAvWbivIxO/7hAKu83A=;
 b=ogtp8b4qakI001ZcIYzlSqYIQ0jTur3kHQffiqFOeWuNj1k7S3v2IBRGto9erIIZLvlP
 xGRHbCZdiq4Mjyrk0mqCwFlREkOTFYhKOGY0m4deQpSHOf7XEOa6/sB0+qWira1wYd2f
 Wnhaicd7wLSPnffhvTg2mYOwC8SO5R9L52gUFWpA/1zEzpi5o/ytdZQ9etu+xI+OmSfZ
 zXP0ysTdw0uQ6TB802DqfA1xu+Ma2FFnk3rIm/ilsn07NbXGyAXaMkuQdWLgBOq8BAeK
 nYvmY0w1HpzR+ehzx8haDu0eQkP4K0LGzW27ZC67SK6ygWPBfBDYDjshIUua0M4XkgQO cw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kaj58bmkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:44:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JEZDtZ025247;
        Wed, 19 Oct 2022 14:44:39 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg978ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:44:39 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JEia1H64684466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:44:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C94C4C040;
        Wed, 19 Oct 2022 14:44:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0770E4C044;
        Wed, 19 Oct 2022 14:44:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 14:44:35 +0000 (GMT)
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
Subject: [RFC 0/6] iommu/dma: s390 DMA API conversion and optimized IOTLB flushing
Date:   Wed, 19 Oct 2022 16:44:29 +0200
Message-Id: <20221019144435.369902-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7uL0ZU459O_8U_xzzCcASSXtKkFeIITW
X-Proofpoint-ORIG-GUID: 7uL0ZU459O_8U_xzzCcASSXtKkFeIITW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series converts s390's PCI support from its platform specific DMA
API implementation in arch/s390/pci/pci_dma.c to the common DMA IOMMU layer.
The conversion itself is done in patch 3 and after applying my previous s390
IOMMU series [0, 1] only touches the s390 IOMMU driver and arch code moving
over remaining functions from the s390 DMA code. No changes to common code are
necessary.

After patch 3 the conversion is complete in principle and on our partitioning
machine hypervisor LPAR performance matches or exceeds the existing code. When
running under z/VM or KVM however, performance plummets to about half of the
existing code due to a much higher rate of IOTLB flushes for unmapped pages.
Due to the hypervisors use of IOTLB flushes to synchronize their shadow tables
these are very expensive and minimizing flushes is very important.

To counter this performance drop patches 4-5 propose a new, single queue, IOTLB
flushing scheme as an alternative to the existing per-CPU flush queues.
Introducing an alternative scheme was also suggested by Robin Murphy[2]. The
single queue allows batching a much larger number of lazily freed IOVAs and was
also chosen as hypervisors tend to serialize IOTLB flushes removing some of the
gains of multiple queues. To give some bound on when IOVAs are flushed
a timeout of 1 second is used and postponed when a flush happens. In my tests
this scheme brought performance under z/VM and KVM on par with the existing
code.

As it is implemented in common code this IOTLB flushing scheme can of course be
used by other platforms with expensive IOTLB flushes. Particularly virtio-iommu
might be a candidate. With this series however only s390 systems that require
IOTLB flushes on map default to it while LPAR uses the per-CPU queues.

I did verify that the new scheme does work on my x86 Ryzen workstation by
locally modifying drivers/iommu/iommu.c:iommu_subsys_init() to default to it
and verifying its use via "cat /sys/bus/pci/devices/*/iommu_group/type". I did
not find problems with an AMD GPU, Intel NIC (with SR-IOV), NVMes or any on
board peripherals though I did not perform any meaningful performance tests.

Another complication is that on z/VM and KVM our IOTLB flushes can return an
error indicating that the hypervisor has run out of IOVAs and needs us to flush
the queue before new mappings can be created. In strict mode this of course
doesn't happen but with queuing we need to handle it. This is done in patch 6.

As with previous series this is available via my git.kernel.org tree[3] in the
dma_iommu_v1 branch with s390_dma_iommu_v1 tag.

Best regards,
Niklas

[0] https://lore.kernel.org/linux-iommu/20221017124558.1386337-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-iommu/20221018145132.998866-1-schnelle@linux.ibm.com/
[2] https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/

Niklas Schnelle (6):
  s390/ism: Set DMA coherent mask
  s390/pci: prepare is_passed_through() for dma-iommu
  s390/pci: Use dma-iommu layer
  iommu/dma: Prepare for multiple flush queue implementations
  iommu/dma: Add simple batching flush queue implementation
  iommu/s390: flush queued IOVAs on RPCIT out of resource indication

 .../admin-guide/kernel-parameters.txt         |   9 +-
 arch/s390/include/asm/pci.h                   |   7 -
 arch/s390/include/asm/pci_dma.h               | 120 +--
 arch/s390/pci/Makefile                        |   2 +-
 arch/s390/pci/pci.c                           |  22 +-
 arch/s390/pci/pci_bus.c                       |   5 -
 arch/s390/pci/pci_debug.c                     |  13 +-
 arch/s390/pci/pci_dma.c                       | 732 ------------------
 arch/s390/pci/pci_event.c                     |  17 +-
 arch/s390/pci/pci_sysfs.c                     |  19 +-
 drivers/iommu/Kconfig                         |   3 +-
 drivers/iommu/dma-iommu.c                     | 307 ++++++--
 drivers/iommu/dma-iommu.h                     |   1 +
 drivers/iommu/iommu.c                         |  19 +-
 drivers/iommu/s390-iommu.c                    | 415 +++++++++-
 drivers/s390/net/ism_drv.c                    |   4 +
 include/linux/iommu.h                         |   6 +
 17 files changed, 707 insertions(+), 994 deletions(-)
 delete mode 100644 arch/s390/pci/pci_dma.c

-- 
2.34.1

