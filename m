Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E165D20D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjADMGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbjADMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:06:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01374186CC;
        Wed,  4 Jan 2023 04:06:06 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304BmHXx025279;
        Wed, 4 Jan 2023 12:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ne44uFFwZ78RtMyKYxa0P75/jxED8VijZnG654c+DAs=;
 b=A7cwx0shlXB85guVBNJ01mM/lHyLo2KzQJvJRjLtyqN5CAUZsMg9H0TPRMCn/3HpZpyI
 OX7Q0wpcy3i8/HAlJadQc+bpIM1kulCFfDWafj8b3+o8QqlwYPw2A/QkyNZQ6/lYdye7
 cqTPt/D3KKwMK1UHhlJCB7OMiwUIyP6gaaa+NMJPBA0khFeV489PAJbpthmypMvlNtCP
 E/HS/iM327WUJEUjcOauTO5nbc1hHFOY7am15AOoyXNcBbhtYPnSiC+KzdebPUweRAKh
 mqCyRfjUZF51DrU/hVXiv7jQPDhjWG12dg6yhR5qcbBOumkreu/kjn57T2h2DKd/7gs8 ug== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjvfnu1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 12:05:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303LtdLC003060;
        Wed, 4 Jan 2023 12:05:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6d8kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 12:05:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 304C5iii51970466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Jan 2023 12:05:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FB3420043;
        Wed,  4 Jan 2023 12:05:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADDC620040;
        Wed,  4 Jan 2023 12:05:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Jan 2023 12:05:43 +0000 (GMT)
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
Subject: [PATCH v4 0/7] iommu/dma: s390 DMA API conversion and optimized IOTLB flushing
Date:   Wed,  4 Jan 2023 13:05:36 +0100
Message-Id: <20230104120543.308933-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lz4tspXASdkXX-lPhbVXGs5aiaRH55w4
X-Proofpoint-GUID: Lz4tspXASdkXX-lPhbVXGs5aiaRH55w4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_06,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=824
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040097
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
The conversion itself is done in patches 3-4 with patch 2 providing the final
necessary IOMMU driver improvement to handle s390's special IOTLB flush
out-of-resource indication in virtualized environments. Patches 1-2 can be
applied independently. The conversion itself only touches the s390 IOMMU driver
and arch code moving over remaining functions from the s390 DMA API
implementation. No changes to common code are necessary.

After patch 4 the basic conversion is done and on our partitioning machine
hypervisor LPAR performance matches or exceeds the existing code. When running
under z/VM or KVM however, performance plummets to about half of the existing
code due to a much higher rate of IOTLB flushes for unmapped pages. Due to the
hypervisors use of IOTLB flushes to synchronize their shadow tables these are
very expensive and minimizing them is key for regaining the performance loss.

To this end patches 5-7 propose a new, single queue, IOTLB flushing scheme as
an alternative to the existing per-CPU flush queues. Introducing an alternative
scheme was also suggested by Robin Murphy[1]. In the previous RFC of this
conversion Robin suggested reusing more of the existing queuing logic which
I incorporated since v2. The single queue mode is introduced in patch
5. It allows batching a much larger number of lazily freed IOVAs and was also
chosen as hypervisors tend to serialize IOTLB flushes removing some of the
gains of multiple queues. Except for going from one per-CPU to a global queue
the queue logic remains untouched.

Then patch 6 enables variable queue sizes using power of 2 queue sizes and
shift/mask to keep performance as close to the existing code as possible.
After this patch 7 introdues an IOMMU operation to automatically pick between
the existing per-CPU and new single queue flushing schemes on a per device
basis and utilizes this to enable single queue mode for PCI devices on s390
that require IOTLB flushes on map indicating expensive shadowing.

As it is implemented in common code the single queue IOTLB flushing scheme can
of course be used by other platforms with expensive IOTLB flushes. Particularly
virtio-iommu may be a candidate.

I did verify that the new scheme does work on my x86_64 Ryzen workstation by
locally modifying drivers/iommu/iommu.c:iommu_subsys_init() to default to the
single queue mode and verifying its use via "/sys/.../iommu_group/type". I did
not find problems with an AMD GPU, Intel NIC (with SR-IOV and KVM
pass-through), NVMes or any on board peripherals.

As with previous series this is available via my git.kernel.org tree[3] in the
dma_iommu_v4 branch with signed s390_dma_iommu_v4 tag. Thanks to previous IOMMU
changes merged with v6.2-rc1 this does apply directly on v6.2-rc2 now.
 
NOTE: Due to the large drop in performance I think we should not merge the DMA
API conversion (patches 3-4) until we have a more suited IOVA flushing scheme
with similar improvements as the proposed changes of patches 5-7.

Best regards,
Niklas

[0] https://lore.kernel.org/linux-iommu/20221109142903.4080275-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
[2] https://lore.kernel.org/linux-iommu/a8e778da-7b41-a6ba-83c3-c366a426c3da@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/

Changes since v3:
- Reword commit message of patch 2 for more clarity
- Correct typo in comment added by patch 2 (Alexandra)
- Adapted signature of .iommu_tlb_sync mapo for sun50i IOMMU driver added in
  v6.2-rc1 (kernel test robot)
- Add R-b from Alexandra for patch 1

Changes since v2:
- Move the IOTLB out-of-resource handling into the IOMMU enabling it also for
  the IOMMU API (patch 2). This also makes this independent from the DMA API
  conversion (Robin, Jason).
- Rename __IOMMU_DOMAIN_DMA_FQ to __IOMMU_DOMAIN_DMA_LAZY when introducing
  single queue flushing mode.
- Make selecting between single and per-CPU flush queues an explicit IOMMU op
  (patch 7)

Changes since RFC v1:
- Patch 1 uses dma_set_mask_and_coherent() (Christoph)
- Patch 3 now documents and allows the use of iommu.strict=0|1 on s390 and
  deprecates s390_iommu=strict while making it an alias.
- Patches 5-7 completely reworked to reuse existing queue logic (Robin)
- Added patch 4 to allow using iommu.strict=0|1 to override
  ops->def_domain_type.

 
Niklas Schnelle (7):
  s390/ism: Set DMA coherent mask
  iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
  s390/pci: prepare is_passed_through() for dma-iommu
  s390/pci: Use dma-iommu layer
  iommu/dma: Allow a single FQ in addition to per-CPU FQs
  iommu/dma: Enable variable queue size and use larger single queue
  iommu/dma: Add IOMMU op to choose lazy domain type

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
 drivers/iommu/Kconfig                         |   4 +-
 drivers/iommu/amd/iommu.c                     |   5 +-
 drivers/iommu/apple-dart.c                    |   5 +-
 drivers/iommu/dma-iommu.c                     | 184 ++++-
 drivers/iommu/intel/iommu.c                   |   5 +-
 drivers/iommu/iommu.c                         |  48 +-
 drivers/iommu/msm_iommu.c                     |   5 +-
 drivers/iommu/mtk_iommu.c                     |   5 +-
 drivers/iommu/s390-iommu.c                    | 430 +++++++++-
 drivers/iommu/sprd-iommu.c                    |   5 +-
 drivers/iommu/sun50i-iommu.c                  |   4 +-
 drivers/iommu/tegra-gart.c                    |   5 +-
 drivers/s390/net/ism_drv.c                    |   2 +-
 include/linux/iommu.h                         |  23 +-
 24 files changed, 678 insertions(+), 998 deletions(-)
 delete mode 100644 arch/s390/pci/pci_dma.c

-- 
2.34.1

