Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54C869E448
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjBUQLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBUQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:11:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4EA298FE;
        Tue, 21 Feb 2023 08:11:17 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LFFXFC031431;
        Tue, 21 Feb 2023 16:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JymdbLQeTeDhlP2A/OsKh68JdIUnbSBDiFwxb0u8pO4=;
 b=HGTQRnc/Tu1es4Vq1INy2HGCNlBNcEGMECB6ZHMbqbcKplRji4vtRk6/19RKLpzsxZnR
 98tt4kX6MR7a1t55ObvtY0nYmB3xVzFzN7UsvmbNqope53AzW5rMkBaJt7d+1yoqVZUk
 EqNYBUipiCEBsg8emdkxoM3tOknFL+yQotpT+bSNTT1rlFIGAmNZJ2UmQ+v3/Bv+j8IS
 nWYdwJfTyamZp7+FWmIDhC4HhxDroP8JZCymZrhCYF1mAqmFj7EMeRct1BaTzjgpn2La
 WdUdX7kMF3v38nA9CQezRTfnZJKmFS+aJoWd0wsLrFOVqsZ2YaXgeo3zk3cr6QP73X54 Yg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nw0cp204j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 16:10:50 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCVcXd031864;
        Tue, 21 Feb 2023 16:10:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3ntpa6b6v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 16:10:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LGAivC43909608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 16:10:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA732004D;
        Tue, 21 Feb 2023 16:10:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB7AC20043;
        Tue, 21 Feb 2023 16:10:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 16:10:43 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        agordeev@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Update s390-iommu driver maintainer information
Date:   Tue, 21 Feb 2023 17:10:43 +0100
Message-Id: <20230221161043.37065-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: inK0pKToyXumXYAitzx08cjAJ_52Mm3g
X-Proofpoint-ORIG-GUID: inK0pKToyXumXYAitzx08cjAJ_52Mm3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=949
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s390 DMA API conversion changes currently under review will extend
the use of the s390-iommu driver to the DMA API. With s390's mandatory
use of an IOMMU this means all DMA for PCI devices will then use the
s390-iommu driver. With this in mind and considering my involvement in
these changes it makes sense to reflect this increased interdependence
in the maintainer structure. Thus add myself as first maintainer and
move Gerald to reviewer status.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 135d93368d36..ad6536817f88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18291,8 +18291,9 @@ F:	drivers/s390/block/dasd*
 F:	include/linux/dasd_mod.h
 
 S390 IOMMU (PCI)
+M:	Niklas Schnelle <schnelle@linux.ibm.com>
 M:	Matthew Rosato <mjrosato@linux.ibm.com>
-M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
+R:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 F:	drivers/iommu/s390-iommu.c
-- 
2.37.2

