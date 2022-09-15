Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D485B9E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIOPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiIOPTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:19:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F208A6C2;
        Thu, 15 Sep 2022 08:14:21 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FEj96e002132;
        Thu, 15 Sep 2022 15:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=iBlK6fyWcdkdv2FYQJ8VkvugQqpCAa9nQWW5xvOgCf8=;
 b=CKCoRVjroykVNMExUni7lBMrkI8p81I0BKLKf381xb4ErcQZRTd36pI5x5eYJla8HrrD
 990SbvZnsEmP6aaTl/JbQGLEFD8+9EfC85HL+OxuXDOxeO/7m6oHsTluYnrXqK0Afoh7
 2O53lV5FU9VM7lwaFgoH8y3vsf9RchDAQwS7t6jDSJISjGv22H8MmQJW++pSkHHosEtS
 DK5X4hd/diKcAsknsJKLIMdjoP0cQ7RGSry7pvO6C+4wngMm/efleUMaNHB/sXGOnxK3
 SpvY4ey/CE7EKogFw2uVHQuiqaFiaImVtunwdMB33ut+yZVVoqmhR9EanteaqW64Npo8 mQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm6331878-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 15:14:08 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FF84TT028185;
        Thu, 15 Sep 2022 15:14:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3jjy25sydg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 15:14:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FFE2SZ41157080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 15:14:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB5BD5204F;
        Thu, 15 Sep 2022 15:14:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 48CFC52050;
        Thu, 15 Sep 2022 15:14:02 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iommu/s390: Fixes related to repeat attach_dev calls
Date:   Thu, 15 Sep 2022 17:13:59 +0200
Message-Id: <20220915151402.121032-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mnO0t2SfbGSFof-WqI4BQQ9qpwbxWkIt
X-Proofpoint-GUID: mnO0t2SfbGSFof-WqI4BQQ9qpwbxWkIt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=579 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150085
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

[0] https://lore.kernel.org/linux-iommu/20220831201236.77595-1-mjrosato@linux.ibm.com/

Niklas Schnelle (3):
  iommu/s390: Fix duplicate domain attachments
  s390/pci: remove unused bus_next field from struct zpci_dev
  iommu/s390: Get rid of s390_domain_device

 arch/s390/include/asm/pci.h |   2 +-
 drivers/iommu/s390-iommu.c  | 110 +++++++++++++++++++-----------------
 2 files changed, 59 insertions(+), 53 deletions(-)

-- 
2.34.1

