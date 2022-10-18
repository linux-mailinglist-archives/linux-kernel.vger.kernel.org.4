Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEC6602ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJROwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJROv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:51:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40071DE83;
        Tue, 18 Oct 2022 07:51:56 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IEkpSN021027;
        Tue, 18 Oct 2022 14:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=8HZIWFsyMYRnuxJWz3yxtN85ktBDufyzEaa6Pm6pmFU=;
 b=e8rmeAN6nWKVINjRfkZPzVYggT3M0EY8/rsEXogEihXWu8bwGfLO3GLjlxXfGC0phdIl
 YrQxeJ9Mpg7oaobLXZrEvVaUgWOGfpWqcpGLKTOU35U+wDl2EQjIdkq//GuTuQTO0on0
 pkblxUA6/AMV4onaeqESkje0VNL3jjncZyQwZtbdfpAZQJ6pEG9WCPw4VrCeZP2OKiJH
 9PXKByYvu/bbrAARdVNcwm9ByZs9fPt12DYE/nVcyMxDWcY/qLeKkWPktH3yQGJhe2vW
 qXkORnwmd5BA6ve/DyL2/DtVVW7ZKT2BF4z3kit4Vx3vUkQ4+dCV5elOebgmpuKul0+N lA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9vt03n7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:51:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IEpaWp002081;
        Tue, 18 Oct 2022 14:51:36 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3k7mg8v48y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:51:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IEpWdh10223900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:51:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E8052050;
        Tue, 18 Oct 2022 14:51:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4962B5204E;
        Tue, 18 Oct 2022 14:51:32 +0000 (GMT)
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
Subject: [PATCH 0/5] iommu/s390: Further improvements
Date:   Tue, 18 Oct 2022 16:51:27 +0200
Message-Id: <20221018145132.998866-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AhKd-wIQ79dJdqEtxY4FiafhjEIzM05N
X-Proofpoint-ORIG-GUID: AhKd-wIQ79dJdqEtxY4FiafhjEIzM05N
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=299 lowpriorityscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180083
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

This series goes on top of v7 of my previous series of IOMMU fixes[0] and
similarly is available for easy testing in the iommu_improve_v1 branch with
signed tag s390_iommu_improve_v1 of my git.kernel.org tree[1].

Best regards,
Niklas Schnelle

[0] https://lore.kernel.org/linux-iommu/20221017124558.1386337-1-schnelle@linux.ibm.com/
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
 drivers/iommu/s390-iommu.c  | 180 ++++++++++++++++++++++++------------
 5 files changed, 183 insertions(+), 97 deletions(-)

-- 
2.34.1

