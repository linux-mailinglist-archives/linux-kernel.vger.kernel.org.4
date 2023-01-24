Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE1567988E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjAXMwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjAXMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:52:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2E740BFC;
        Tue, 24 Jan 2023 04:51:44 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBVD6J001302;
        Tue, 24 Jan 2023 12:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=kM89gj3G4MJN4xmLt0QFlA96GWTNFdJw8zxUixocrtY=;
 b=aY/60V1MNRaCdSEbpt9v4ELiMtl5iNyT3ryWUvj7Ddjg3l5RBtt8WihjlSDmBLEP5csI
 tM+FFbj4SBiyTmJOivhl6MlIkphjq2kDb+XXX3mbqdND0nbG0HC4yiPu0K3LsNkv14/N
 uifAlPpUYvj7yNv+ssaUm8Nbrzi79f2Ith/11w5DXUvC5TPLlbVCOI/TUrrFT2eI8cHB
 8Ifo3n0zuV+j1AIVIY3u84c0CiiFL8scQ5rDtqu8ci4jU81W+ZgeLdGud8rhxszcTmMV
 uaLn7MNGXg3DxtBetnGO/uN9o/2ZDzMakGWz9FNWtJZ60dvBva+yZYqtlGxjCIjsBdr8 PA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nac1ywcsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30O9dAPo026670;
        Tue, 24 Jan 2023 12:50:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6btmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:50:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OCocdr17105246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:50:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2593220040;
        Tue, 24 Jan 2023 12:50:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B52E20043;
        Tue, 24 Jan 2023 12:50:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 12:50:37 +0000 (GMT)
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
Subject: [PATCH v5 0/7] iommu/dma: s390 DMA API conversion and optimized IOTLB flushing
Date:   Tue, 24 Jan 2023 13:50:30 +0100
Message-Id: <20230124125037.3201345-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aaoWQIjir9xcrBRZwBVKCMVnfwGRXUd5
X-Proofpoint-ORIG-GUID: aaoWQIjir9xcrBRZwBVKCMVnfwGRXUd5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
dma_iommu_v5 branch with signed s390_dma_iommu_v4 tag. Thanks to previous IOMMU
changes merged with v6.2-rc1 this does apply directly on v6.2-rc2 now.
 
NOTE: Due to the large drop in performance I think we should not merge the DMA
API conversion (patch 4) until we have a more suited IOVA flushing scheme
with similar improvements as the proposed changes of patches 5-7. Patches 1 and
2 on the other hand are ready to be applied as is from my point of view.

Best regards,
Niklas

[0] https://lore.kernel.org/linux-iommu/20221109142903.4080275-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
[2] https://lore.kernel.org/linux-iommu/a8e778da-7b41-a6ba-83c3-c366a426c3da@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/

Changes since v4:
- Picked up R-b's for patch 1, 2 and 3
- In patch 5 fixed iommu_group_store_type() mistakenly initializing DMA-SQ
  instead of DMA-FQ. This was caused by iommu_dma_init_fq() being called before
  domain->type is set, instead pass the type as paramater. This also closes
  a window where domain->type is still DMA while the FQ is already used. (Gerd)
- Replaced a missed check for IOMMU_DOMAIN_DMA_FQ with the new generic
  __IOMMU_DOMAIN_DMA_LAZY in patch 5
- Made the ISM PCI Function Type a define (Matt)
- Removed stale TODO comment (Matt)

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
 arch/s390/include/asm/pci_clp.h               |   3 +
 arch/s390/include/asm/pci_dma.h               | 120 +--
 arch/s390/pci/Makefile                        |   2 +-
 arch/s390/pci/pci.c                           |  22 +-
 arch/s390/pci/pci_bus.c                       |   5 -
 arch/s390/pci/pci_debug.c                     |  12 +-
 arch/s390/pci/pci_dma.c                       | 732 ------------------
 arch/s390/pci/pci_event.c                     |  17 +-
 arch/s390/pci/pci_sysfs.c                     |  19 +-
 drivers/iommu/Kconfig                         |   4 +-
 drivers/iommu/amd/iommu.c                     |   5 +-
 drivers/iommu/apple-dart.c                    |   5 +-
 drivers/iommu/dma-iommu.c                     | 193 +++--
 drivers/iommu/dma-iommu.h                     |   4 +-
 drivers/iommu/intel/iommu.c                   |   5 +-
 drivers/iommu/iommu.c                         |  49 +-
 drivers/iommu/msm_iommu.c                     |   5 +-
 drivers/iommu/mtk_iommu.c                     |   5 +-
 drivers/iommu/s390-iommu.c                    | 430 +++++++++-
 drivers/iommu/sprd-iommu.c                    |   5 +-
 drivers/iommu/sun50i-iommu.c                  |   4 +-
 drivers/iommu/tegra-gart.c                    |   5 +-
 drivers/s390/net/ism_drv.c                    |   2 +-
 include/linux/iommu.h                         |  23 +-
 26 files changed, 687 insertions(+), 1005 deletions(-)
 delete mode 100644 arch/s390/pci/pci_dma.c

-- 
2.34.1

