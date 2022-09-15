Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349B5B9E99
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiIOPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiIOPTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:19:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CE789806;
        Thu, 15 Sep 2022 08:14:20 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FEjBu1002201;
        Thu, 15 Sep 2022 15:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QfMAECJGk1+vZHFu4ayTDGu/XjSKf/ezgEIrW9CCQiI=;
 b=iCgZstqYby6DtZ/GNWWf6IlNGUF2+WR8f3fi3vCflzwj0Iq5q+nISxvrk1b4kmkgTB3h
 KENqocTSlFyf4xDut11giSIKPLhs3NBgoaaefEPi1DO3a3PU0qDTx//dLSHqZo13UghO
 Fw2Ukw++97t4L4ZzpPNRKnYbI00k++4XFW1wks0q4taPo/OKkRFtBa4vTFk94Ozm22AX
 3BSLFynebgYkQdOsh+PgYQlChb53zZ0UV+J1UvixMi+FwozEWKg36A8y+LT+JwkM2IqD
 lTL31qB38UwxQE7MdZ/gZIlP0CTLxhgQiJChG6HrNIHvMrBWDmpUOMpEnu7zqwlpEZmT 1A== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm633187k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 15:14:09 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FF8SDG022443;
        Thu, 15 Sep 2022 15:14:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3jjyk6sx81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 15:14:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FFE3hM25362932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 15:14:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5B1D52051;
        Thu, 15 Sep 2022 15:14:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3BDCE52052;
        Thu, 15 Sep 2022 15:14:03 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] s390/pci: remove unused bus_next field from struct zpci_dev
Date:   Thu, 15 Sep 2022 17:14:01 +0200
Message-Id: <20220915151402.121032-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220915151402.121032-1-schnelle@linux.ibm.com>
References: <20220915151402.121032-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K8kq3hYgb2njsNK_YDBtCalWzTCaC5X6
X-Proofpoint-GUID: K8kq3hYgb2njsNK_YDBtCalWzTCaC5X6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=944 spamscore=0
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

This field was added in commit 44510d6fa0c0 ("s390/pci: Handling
multifunctions") but is an unused remnant of an earlier version where
the the devices on the virtual bus were connected in a linked list
instead of a fixed 256 entry array of pointers.

It is also not used for the list of busses as that is threaded through
struct zpci_bus not through struct zpci_dev.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 7b4cdadbc023..108e732d7b14 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -117,7 +117,6 @@ struct zpci_bus {
 struct zpci_dev {
 	struct zpci_bus *zbus;
 	struct list_head entry;		/* list of all zpci_devices, needed for hotplug, etc. */
-	struct list_head bus_next;
 	struct kref kref;
 	struct hotplug_slot hotplug_slot;
 
-- 
2.34.1

