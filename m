Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EE05E5EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiIVJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiIVJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:53:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC41D574E;
        Thu, 22 Sep 2022 02:53:08 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M9K6FQ034983;
        Thu, 22 Sep 2022 09:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O/FkUZcZHdTSV6fffQohW6KGZk2P6o8hiSx1qoKA0TI=;
 b=DDJcpfZ07SozZ0RlTaHGOCsiV6lnzGaH3p//0w2GP4fgmb4L2ka46LW59Vw52FYbqxRM
 SvwCQc8yZ7ogVl6GdQZM6TUPUT///Ple8XVBMWiq4S18Yf1VTEgQ7pt/6E3NzFPCCOOL
 FP35oh9UMjqrVazLH9pvovlq0Q/X3J1BSatdUJ+H0Rv0ZOAByrK7WVN84E64iHQBugEh
 LOmgPxkGrPuO953M9gHQ5oC1xFPxGLe2/FOAGPDCFZhyH4wLxfuNfALjesD1lAWboup+
 lSKnG/xIipHBcc6uZvtu4/SymdBKuzv6fbBKHxdlSQzwE9wJ519QX/H8kdlT8w++K0O5 WA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrn00h3v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:52:47 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28M9qi2L030696;
        Thu, 22 Sep 2022 09:52:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3jn5v8vt1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 09:52:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28M9r8AB41156992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 09:53:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8BAE4C040;
        Thu, 22 Sep 2022 09:52:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D7184C04A;
        Thu, 22 Sep 2022 09:52:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 09:52:41 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc:     linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] s390/pci: remove unused bus_next field from struct zpci_dev
Date:   Thu, 22 Sep 2022 11:52:38 +0200
Message-Id: <20220922095239.2115309-3-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922095239.2115309-1-schnelle@linux.ibm.com>
References: <20220922095239.2115309-1-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GokoN3rgH74zRpNEbckQtC9DPloQddAl
X-Proofpoint-ORIG-GUID: GokoN3rgH74zRpNEbckQtC9DPloQddAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_06,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=921 clxscore=1015 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220063
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
the devices on the virtual bus were connected in a linked list instead
of a fixed 256 entry array of pointers.

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

