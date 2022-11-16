Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0800D62C61B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiKPRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiKPRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:17:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72CE4731C;
        Wed, 16 Nov 2022 09:17:19 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGGoEwZ025234;
        Wed, 16 Nov 2022 17:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=7kggJbK6dh+VbgGxGhXLVWM4SxZazD7YTlWI9e6Kt6A=;
 b=JF9VfDiMKnGw1snlWF2LUeaiU5u2PuTpbwvPQVl5kjrYn5EO1XP9Rrd2/l+c/nA7ALWe
 2SNaK/+csfeithtfwhmlR/jWiSXqK0S2XAxHvfmBpPn8rO0tvvd7mIu+S84tVwuezZ2u
 3GfmUwoB/vxrrWXGX0R1qqv41dGDmj1Gnu9ItlnhyqHUl4gSmfR6tAI4WlbJmYutEGaT
 YfaUzULj1Rl+1VyV5/xSN1JaqqGezqlEZdIltHEmrNl77ohtwmqa4wGyL1sFfseydXtn
 tkFQn7JTEEZpgy1X33QqbCl2lL0t67RrR/T/xysoVPX5Wx6FfvTwnlrEuqzbIBaF7K/r xA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw3qt0qce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 17:17:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGH6U3U032483;
        Wed, 16 Nov 2022 17:17:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3kt2rjead2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 17:17:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGHHao739518620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 17:17:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 077A35204E;
        Wed, 16 Nov 2022 17:16:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 78F7052051;
        Wed, 16 Nov 2022 17:16:56 +0000 (GMT)
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
Subject: [PATCH v2 0/7] iommu/dma: s390 DMA API conversion and optimized IOTLB flushing
Date:   Wed, 16 Nov 2022 18:16:49 +0100
Message-Id: <20221116171656.4128212-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xMxqVXAIffo6scUi5z85KmgP1Wl3R0A2
X-Proofpoint-GUID: xMxqVXAIffo6scUi5z85KmgP1Wl3R0A2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160119
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
The conversion itself is done in patch 3 and after applying my the s390 IOMMU
improvements series[0]. It only touches the s390 IOMMU driver and arch code
moving over remaining functions from the s390 DMA API implementation. No
changes to common code are necessary. Though patch 4 does propose an additional
common code change to let the iommu.strict kernel parameter override
ops->def_domain_type.

After patch 3 the basic conversion is done and on our partitioning machine
hypervisor LPAR performance matches or exceeds the existing code. When running
under z/VM or KVM however, performance plummets to about half of the existing
code due to a much higher rate of IOTLB flushes for unmapped pages and we still
need to handle out-of-resource indications (patch 7). Due to the hypervisors
use of IOTLB flushes to synchronize their shadow tables these are very
expensive and minimizing them is key for regaining the performance loss.

To this end patches 5-7 propose a new, single queue, IOTLB flushing scheme as
an alternative to the existing per-CPU flush queues. Introducing an alternative
scheme was also suggested by Robin Murphy[1]. In the previous RFC of this
conversion Robin suggested reusing more of the existing queuing logic which
I incorporated into this version. The single queue mode is introduced in patch
5. It allows batching a much larger number of lazily freed IOVAs and was also
chosen as hypervisors tend to serialize IOTLB flushes removing some of the
gains of multiple queues. Except for going from one per-CPU to a global queue
the queue logic remains untouched.

Then patch 6 enables variable queue sizes using power of 2 queue sizes and
shift/mask to keep performance as close to the existing code as possible.
Finally patch 7 allows triggering a queue flush from the IOMMU driver in order
to handle s390's use of an IOTLB flush out-of-resource indication.

As it is implemented in common code the single queue IOTLB flushing scheme can
of course be used by other platforms with expensive IOTLB flushes. Particularly
virtio-iommu might be a candidate. With this series however only s390 systems
that require IOTLB flushes on map default to it while LPAR uses the per-CPU
queues.

I did verify that the new scheme does work on my x86_64 Ryzen workstation by
locally modifying drivers/iommu/iommu.c:iommu_subsys_init() to default to the
single queue mode and verifying its use via "/sys/.../iommu_group/type". I did
not find problems with an AMD GPU, Intel NIC (with SR-IOV), NVMes or any on
board peripherals though the only performance test was a round of CS:Go :-)

As with previous series this is available via my git.kernel.org tree[3] in the
dma_iommu_v2 branch with s390_dma_iommu_v2 tag.

NOTE: Due to the large drop in performance and the issue of out-of-resource
handling we can't merge the DMA API conversion (patches 1-3) until we have
a more suited IOVA flushing scheme with similar improvements as the proposed
changes of patches 5-7.

Best regards,
Niklas

[0] https://lore.kernel.org/linux-iommu/20221109142903.4080275-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
[2] https://lore.kernel.org/linux-iommu/a8e778da-7b41-a6ba-83c3-c366a426c3da@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/

Changes since RFC v1:
- Patch 1 uses dma_set_mask_and_coherent() (Christoph)
- Patch 3 now documents and allows the use of iommu.strict=0|1 on s390 and
  deprecates s390_iommu=strict while making it an alias.
- Patches 5-7 completely reworked to reuse existing queue logic (Robin)
- Added patch 4 to allow using iommu.strict=0|1 to override
  ops->def_domain_type.

Niklas Schnelle (7):
  s390/ism: Set DMA coherent mask
  s390/pci: prepare is_passed_through() for dma-iommu
  s390/pci: Use dma-iommu layer
  iommu: Let iommu.strict override ops->def_domain_type
  iommu/dma: Allow a single FQ in addition to per-CPU FQs
  iommu/dma: Enable variable queue size and use larger single queue
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
 drivers/iommu/dma-iommu.c                     | 188 ++++-
 drivers/iommu/dma-iommu.h                     |   1 +
 drivers/iommu/iommu.c                         |  18 +-
 drivers/iommu/s390-iommu.c                    | 409 +++++++++-
 drivers/s390/net/ism_drv.c                    |   2 +-
 include/linux/iommu.h                         |   7 +
 17 files changed, 603 insertions(+), 971 deletions(-)
 delete mode 100644 arch/s390/pci/pci_dma.c

-- 
2.34.1

