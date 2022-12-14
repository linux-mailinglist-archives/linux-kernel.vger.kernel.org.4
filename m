Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDBA64C81D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiLNLgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiLNLf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:35:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74141ADAB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:35:55 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEBMKVn017349;
        Wed, 14 Dec 2022 11:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=QOFehjMfijkWTE7+vL1yB2+QrFjOga00vBG7DEY35dk=;
 b=I9cxCbOVRf2kYXNDZXM+WYvhfdMNdvYtmWJv9RSQaRwKfoQ8T5c5XPVazqdzHHIFKwyS
 hhvtf4EovjYCuHA2SSU8le+lfLYnfyK9SK3CoTmTLC0u9GrQi5Ey6A+fO6IotG7SID3b
 QRqRIwqS5+t2XftjoZzKAW2K0mRctujL3Q2hEfAanth1iW5i9t+7uFQJUuhcRp1ts/Kz
 WS2Xq4Lj864IbxwafvD9+3ypVI0d1y9THsLtEvVfuaeKbSfJxUN4utE7WT8U/18iWDEG
 HFhtHBhx/IqMOCkdftLzV2NNhpYWjB4oOsxMWrtBy1J2KI9B132gPYgexn2FfYAAIeO8 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mfdj08ae3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 11:35:51 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BEBPBIx032473;
        Wed, 14 Dec 2022 11:35:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mfdj08adf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 11:35:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDK6cBf029153;
        Wed, 14 Dec 2022 11:35:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mf0518u6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 11:35:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BEBZjaD19399166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 11:35:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B66D520040;
        Wed, 14 Dec 2022 11:35:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B6C120043;
        Wed, 14 Dec 2022 11:35:42 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.67.101])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Dec 2022 11:35:41 +0000 (GMT)
Date:   Wed, 14 Dec 2022 17:05:38 +0530
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: staging: vme_user: Replace the "<<" with BIT macro
Message-ID: <Y5m1CvaAc2Z8LO2k@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TiYLQ2KMN6sxUrw0goJiuYU3I1F6Thc-
X-Proofpoint-ORIG-GUID: YuUDho1Nf5CCc9byMvlQpkLRDI4RhDL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_04,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the "<<" operator with BIT macro, in accordance to the
checkpatch.pl script and Linux kernel coding-style guidelines.
Issues reported by checkpatch.pl:
	CHECK: Prefer using the BIT macro

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
 drivers/staging/vme_user/vme.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
index 98da8d039d60..faa9816046a9 100644
--- a/drivers/staging/vme_user/vme.h
+++ b/drivers/staging/vme_user/vme.h
@@ -2,6 +2,8 @@
 #ifndef _VME_H_
 #define _VME_H_
 
+#include <linux/bitops.h>
+
 /* Resource Type */
 enum vme_resource_type {
 	VME_MASTER,
@@ -54,20 +56,20 @@ enum vme_resource_type {
 #define VME_R_ROBIN_MODE	0x1
 #define VME_PRIORITY_MODE	0x2
 
-#define VME_DMA_PATTERN			(1<<0)
-#define VME_DMA_PCI			(1<<1)
-#define VME_DMA_VME			(1<<2)
+#define VME_DMA_PATTERN		BIT(0)
+#define VME_DMA_PCI			BIT(1)
+#define VME_DMA_VME			BIT(2)
 
-#define VME_DMA_PATTERN_BYTE		(1<<0)
-#define VME_DMA_PATTERN_WORD		(1<<1)
-#define VME_DMA_PATTERN_INCREMENT	(1<<2)
+#define VME_DMA_PATTERN_BYTE		BIT(0)
+#define VME_DMA_PATTERN_WORD		BIT(1)
+#define VME_DMA_PATTERN_INCREMENT	BIT(2)
 
-#define VME_DMA_VME_TO_MEM		(1<<0)
-#define VME_DMA_MEM_TO_VME		(1<<1)
-#define VME_DMA_VME_TO_VME		(1<<2)
-#define VME_DMA_MEM_TO_MEM		(1<<3)
-#define VME_DMA_PATTERN_TO_VME		(1<<4)
-#define VME_DMA_PATTERN_TO_MEM		(1<<5)
+#define VME_DMA_VME_TO_MEM		BIT(0)
+#define VME_DMA_MEM_TO_VME		BIT(1)
+#define VME_DMA_VME_TO_VME		BIT(2)
+#define VME_DMA_MEM_TO_MEM		BIT(3)
+#define VME_DMA_PATTERN_TO_VME		BIT(4)
+#define VME_DMA_PATTERN_TO_MEM		BIT(5)
 
 struct vme_dma_attr {
 	u32 type;
-- 
2.31.1

