Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689B069D08B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjBTPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjBTPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:23:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C082121;
        Mon, 20 Feb 2023 07:22:53 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KEcd9q003286;
        Mon, 20 Feb 2023 15:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ocXE8dx4OzBmhhNyICrdDairyhT/foJnOuuA44gAOQk=;
 b=Cc9CU5ZVatNxUElKlZemOCaIuKwiNcv/EdNWjj4OtL4qUs4elDsZxMQVDkELYiOv289+
 w/KAqk3sDZUKFD/bIF21DwJceww53In+Y4ytqNRrSx/ZW2NffuR1OrCoPp2UzTluj9lF
 xHAC9bq7bWUfo7dGsqhBb8Ei5zEdxZqz9WDrTSZ9hblKjLI3XjudnGEq2B0Z0St+pvd7
 7WWYTI9IwTi3MroMniyt11HP5ww1Ce3LQKEFNY0ZLOkTgZU0wcY3FBD6acpHtWg+Euy9
 XkCmiJP9hQVl5ZZNbPDk2B7HRXs1F7s2t+w0ZNzjG6MXemMWhmWyvVuJe2Z/9zWX2K77 Zw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nva3n2f6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 15:22:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31KFJO5L019871;
        Mon, 20 Feb 2023 15:22:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ntnxf2uqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 15:22:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31KFMNTE23658942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 15:22:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D7E920063;
        Mon, 20 Feb 2023 15:22:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B25E2004B;
        Mon, 20 Feb 2023 15:22:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Feb 2023 15:22:22 +0000 (GMT)
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
Subject: [PATCH v7 0/6] iommu/dma: s390 DMA API conversion and optimized IOTLB flushing
Date:   Mon, 20 Feb 2023 16:22:16 +0100
Message-Id: <20230220152222.1818344-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0m0dHR7pXQxSfC36Mq1YIriRT3s--GIJ
X-Proofpoint-GUID: 0m0dHR7pXQxSfC36Mq1YIriRT3s--GIJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200138
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
out-of-resource indication in virtualized environments. Patches 1-2 may be
applied independently. The conversion itself only touches the s390 IOMMU driver
and s390 arch code moving over remaining functions from the s390 DMA API
implementation. No changes to common code are necessary.

After patch 4 the basic conversion is done and on our partitioning machine
hypervisor LPAR performance matches or exceeds the existing code. When running
under z/VM or KVM however, performance plummets to about half of the existing
code due to a much higher rate of IOTLB flushes for unmapped pages. Due to the
hypervisors use of IOTLB flushes to synchronize their shadow tables these are
very expensive and minimizing them is key for regaining the performance loss.

To this end patches 5-6 propose a new, single queue, IOTLB flushing scheme as
an alternative to the existing per-CPU flush queues. Introducing an alternative
scheme was also suggested by Robin Murphy[1]. In the previous RFC of this
conversion Robin suggested reusing more of the existing queuing logic which
I incorporated since v2. The single queue mode is introduced in patch
5 together with a new dma_iommu_options struct and tune_dma_iommu callback in
IOMMU ops which allows IOMMU drivers to switch to a single flush queue.

Then patch 6 enables variable queue sizes using power of 2 queue sizes and
shift/mask to keep performance as close to the existing code as possible. The
variable queue size and a variable timeout are added to the dma_iommu_options
struct and utilized by s390 in the z/VM and KVM guest cases. As it is
implemented in common code the single queue IOTLB flushing scheme can of course
be used by other platforms with expensive IOTLB flushes. Particularly
virtio-iommu may be a candidate.

In a previous version I verified that the new scheme does work on my x86_64
Ryzen workstation by locally modifying iommu_subsys_init() to default to the
single queue mode and verifying its use via "/sys/.../iommu_group/type". I did
not find problems with an AMD GPU, Intel NIC (with SR-IOV and KVM
pass-through), NVMes or any on board peripherals.

As with previous series this is available via my git.kernel.org tree[3] in the
dma_iommu_v7 branch with signed s390_dma_iommu_v7 tag. This version applies
on top of iommu-next to incorporate the ops->set_platform_dma() and GFP
changes.
 
NOTE: Due to the large drop in performance I think we should not merge the DMA
API conversion (patch 4) until we have a more suited IOVA flushing scheme
with similar improvements as the proposed changes.

Best regards,
Niklas

[0] https://lore.kernel.org/linux-iommu/20221109142903.4080275-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
[2] https://lore.kernel.org/linux-iommu/a8e778da-7b41-a6ba-83c3-c366a426c3da@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/

Changes since v6:
- Rebased on iommu-next branch (Matt)
  - No need for ops->set_platform_dma() anymore
  - Add gfp_t gfp parameters for page allocations
- In patch 4 removed a superflous s390_domain->dma_table assignment
- Added R-bs from Matt

Changes since v5:
- Instead of introducing a new IOMMU domain type utilize a new options
  mechanism that allows IOMMU drivers to tune the DMA IOMMU flushing (Jason,
  Robin)
- The above reworks patches 5 and 6
- Dropped patch 7 as its functionality is no longer needed

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

Niklas Schnelle (6):
  s390/ism: Set DMA coherent mask
  iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
  s390/pci: prepare is_passed_through() for dma-iommu
  s390/pci: Use dma-iommu layer
  iommu/dma: Allow a single FQ in addition to per-CPU FQs
  iommu/dma: Make flush queue sizes and timeout driver configurable

 .../admin-guide/kernel-parameters.txt         |   9 +-
 arch/s390/include/asm/pci.h                   |   7 -
 arch/s390/include/asm/pci_clp.h               |   3 +
 arch/s390/include/asm/pci_dma.h               | 121 +--
 arch/s390/pci/Makefile                        |   2 +-
 arch/s390/pci/pci.c                           |  22 +-
 arch/s390/pci/pci_bus.c                       |   5 -
 arch/s390/pci/pci_debug.c                     |  12 +-
 arch/s390/pci/pci_dma.c                       | 735 ------------------
 arch/s390/pci/pci_event.c                     |  17 +-
 arch/s390/pci/pci_sysfs.c                     |  19 +-
 drivers/iommu/Kconfig                         |   4 +-
 drivers/iommu/amd/iommu.c                     |   5 +-
 drivers/iommu/apple-dart.c                    |   5 +-
 drivers/iommu/dma-iommu.c                     | 189 +++--
 drivers/iommu/dma-iommu.h                     |   4 +-
 drivers/iommu/intel/iommu.c                   |   5 +-
 drivers/iommu/iommu.c                         |  24 +-
 drivers/iommu/msm_iommu.c                     |   5 +-
 drivers/iommu/mtk_iommu.c                     |   5 +-
 drivers/iommu/s390-iommu.c                    | 435 ++++++++++-
 drivers/iommu/sprd-iommu.c                    |   5 +-
 drivers/iommu/sun50i-iommu.c                  |   4 +-
 drivers/iommu/tegra-gart.c                    |   5 +-
 drivers/s390/net/ism_drv.c                    |   2 +-
 include/linux/iommu.h                         |  29 +-
 26 files changed, 671 insertions(+), 1007 deletions(-)
 delete mode 100644 arch/s390/pci/pci_dma.c

-- 
2.37.2

