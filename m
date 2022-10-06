Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEAC5F69FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJFOre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJFOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:47:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB534735;
        Thu,  6 Oct 2022 07:47:21 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296EAQc8031130;
        Thu, 6 Oct 2022 14:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=+/0pG+udMeKW2EMYqbZEMBLeC9BKAzpaWAWiIKWvvJc=;
 b=WBpaIeBdhRbYs5k2kmfk9d1I1BXSIE/lk30UYRjQebNAZV1TEaetrak2ppslW/JY4jy2
 zCD441i/NoU2qOt8yatkuiS87Tfhq2RctAjI1QreeulicOBYD/h/TkByGHEj4JsLqypu
 yZLwBUfNE04sNA1JVl4ZLZvLtE0Y9kFM0iSJR1dpTK3gu95WljROlj7myFFL7l4W8Ra2
 SFW15zf+ccasrEWn0IUY0Kukw11Sg0d1VgZAuXY5D/48DgDVQLXUvpRnkWigNBQESad2
 u6DQU+WlyOzuMlZZj23FiDg/cNKaQkw8gI/xsxVPRlhBwnedC8Rrq4trOdRBaRNVqwMI Vg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k1y14met3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:47:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 296EaEHg010135;
        Thu, 6 Oct 2022 14:47:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3jxd6978dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 14:47:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 296El11D3736164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Oct 2022 14:47:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BDD9A4051;
        Thu,  6 Oct 2022 14:47:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B7FEA404D;
        Thu,  6 Oct 2022 14:47:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Oct 2022 14:47:01 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] iommu/s390: Fixes related to attach and aperture handling
Date:   Thu,  6 Oct 2022 16:46:54 +0200
Message-Id: <20221006144700.3380098-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: udQcGw2uTYCiTbt37zij0xCKy34e4Suf
X-Proofpoint-GUID: udQcGw2uTYCiTbt37zij0xCKy34e4Suf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_02,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is v5 of a follow up to Matt's recent series[0] where he tackled
a race that turned out to be outside of the s390 IOMMU driver itself as
well as duplicate device attachments. After an internal discussion we came
up with what I believe is a cleaner fix. Instead of actively checking for
duplicates we instead detach from any previous domain on attach. From my
cursory reading of the code this seems to be what the Intel IOMMU driver is
doing as well.

Moreover we drop the attempt to re-attach the device to its previous IOMMU
domain on failure. This was fragile, unlikely to help and unexpected for
calling code. Thanks Jason for the suggestion.

We can also get rid of struct s390_domain_device entirely if we instead
thread the list through the attached struct zpci_devs. This saves us from
having to allocate during attach and gets rid of one level of indirection
during IOMMU operations.

Additionally 3 more fixes have been added in v3 that weren't in v2 of this
series. One is for a potential situation where the aperture of a domain
could shrink and leave invalid translations. The next one fixes an off by
one in checking validity of an IOVA and the last one fixes a wrong value
for pgsize_bitmap.

In v4 we also add a patch changing to the map_pages()/unmap_pages()
interface in order to prevent a performance regression due to the
pgsize_bitmap change.

*Note*:
This series is against the s390 features branch[1] which already contains
the bus_next field removal that was part of v2.

It is also available as a branch with the GPG signed tag
s390_iommu_fixes_v5 on my niks/linux.git on git.kernel.org[2].

*Open Question*:
Which tree should this go via?

Best regards,
Niklas

Changes since v4:
- Add patch to change to the map_pages()/unmap_pages() API to prevent
  a performance regression from the pgsize_bitmap change (Robin)
- In patch 1 unregister IOAT on error (Matt)
- Turn the aperture check in attach into a WARN_ON() in patch 3 (Jason)

Changes since v3:
- Drop s390_domain from __s390_iommu_detach_device() (Jason)
- WARN_ON() mismatched domain in s390_iommu_detach_device() (Jason)
- Use __s390_iommu_detach_device() in s390_iommu_release_device() (Jason)
- Make aperture check resistant against overflow (Jason)

Changes since v2:
- The patch removing the unused bus_next field has been spun out and
  already made it into the s390 feature branch on git.kernel.org
- Make __s390_iommu_detach_device() return void (Jason)
- Remove the re-attach on failure dance as it is unlikely to help
  and complicates debug and recovery (Jason)
- Ignore attempts to detach from domain that is not the active one
- Add patch to fix potential shrinking of the aperture and use
  reserved ranges per device instead of the aperture to respect
  IOVA range restrictions (Jason)
- Add a fix for an off by one error on checking an IOVA against
  the aperture
- Add a fix for wrong pgsize_bitmap

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
[1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git

Niklas Schnelle (6):
  iommu/s390: Fix duplicate domain attachments
  iommu/s390: Get rid of s390_domain_device
  iommu/s390: Fix potential s390_domain aperture shrinking
  iommu/s390: Fix incorrect aperture check
  iommu/s390: Fix incorrect pgsize_bitmap
  iommu/s390: Implement map_pages()/unmap_pages() instead of
    map()/unmap()

 arch/s390/include/asm/pci.h |   1 +
 drivers/iommu/s390-iommu.c  | 221 +++++++++++++++++-------------------
 2 files changed, 107 insertions(+), 115 deletions(-)

-- 
2.34.1

