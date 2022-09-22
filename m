Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586815E5EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiIVJxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIVJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:53:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD9D5740;
        Thu, 22 Sep 2022 02:53:03 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M97vZ8023988;
        Thu, 22 Sep 2022 09:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Ni2sNyZD58V1LfSilR3D/uZPMiFKAxbRlGMPhlhkFrE=;
 b=m0rf5APFLuKFFyuY866Q5DubMIdOn0FPAIzdT8xs2HP5my6S0Hc21Se+kJjBnu3nUNOV
 xhWdU5VGFgF+HojKwcKT1Jo69UDSOcv1Q4xjE+pwTTs0yZ+vzQznuQSM2qPP+WkRXbPU
 GY0x3V8IW2tteb/M/rOXMtGNGKPDiTISTLLiM2rvzDdMjYlzrMhsSUKPQPylzfrzLQsU
 UDO7YZR9w4Ck+Vh/C2vPKNcri4emhOJ8B+rgbTGP7EmhCVnSNOF+RnvgyZRRkvuBXnLW
 brZjPHy6OOdtombYHVOX/bZAZ4EqXPf9JyDv0C4r/4EJlYwN3Elj5N2tRn/u0Ysw+a9/ XA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrmnv9h5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:52:45 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28M9pADl020983;
        Thu, 22 Sep 2022 09:52:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3jn5v8pfrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:52:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28M9qe9K49414434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 09:52:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95FD84C044;
        Thu, 22 Sep 2022 09:52:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21C0F4C040;
        Thu, 22 Sep 2022 09:52:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 09:52:40 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iommu/s390: Fixes related to repeat attach_dev calls 
Date:   Thu, 22 Sep 2022 11:52:36 +0200
Message-Id: <20220922095239.2115309-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WQ4ZL8LBcCEM_5tU-SS_aDoE9l4B1WEy
X-Proofpoint-GUID: WQ4ZL8LBcCEM_5tU-SS_aDoE9l4B1WEy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=685 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209220060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is a follow up to Matt's recent series[0] where he tackled a race that
turned out to be outside of the s390 IOMMU driver itself as well as duplicate
device attachments. After an internal discussion we came up with what I believe
is a cleaner fix. Instead of actively checking for duplicates we instead detach
from any previous domain on attach. From my cursory reading of the code this
seems to be what the Intel IOMMU driver is doing as well.

During development of this fix we realized that we can get rid of struct
s390_domain_device entirely if we instead thread the list through the attached
struct zpci_devs. This saves us from having to allocate during attach and gets
rid of one level of indirection during IOMMU operations. Coincidentally
I discovered that a previous list_head in struct zpci_dev is unused so this is
removed and then replaced.

The duplicate entry fix is the first patch of this series and the only one
which carries a Fixes tag. It may be applied alone or together with patches
2 and 3 which are followup clean ups.


Best regards,
Niklas

Changes since v1:
- After patch 3 we don't have to search in the devices list on detach as
  we alreadz have hold of the zpci_dev (Jason)
- Add a WARN_ON() if somehow ended up detaching a device from a domain that
  isn't the device's current domain.
- Removed the iteration and list delete from s390_domain_free() instead
  just WARN_ON() when we're freeing without having detached
- The last two points should help catching sequencing errors much more
  quickly in the future.

[0] https://lore.kernel.org/linux-iommu/20220831201236.77595-1-mjrosato@linux.ibm.com/

Niklas Schnelle (3):
  iommu/s390: Fix duplicate domain attachments
  s390/pci: remove unused bus_next field from struct zpci_dev
  iommu/s390: Get rid of s390_domain_device

 arch/s390/include/asm/pci.h |  2 +-
 drivers/iommu/s390-iommu.c  | 94 +++++++++++++++++--------------------
 2 files changed, 43 insertions(+), 53 deletions(-)

-- 
2.34.1

