Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A431364BDAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiLMTz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiLMTzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:55:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071221A39C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:55:51 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDJWxL1003226;
        Tue, 13 Dec 2022 19:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=Nz+oMYUXNSwyCA0OyESTudg6sgnwGqY9qJUO8ezl8Nw=;
 b=ZPWOCOilWr/t9aVbJfGz6uXNjRx9UHG2tCS9tKpnlRDmRaxwC9nxrMr9A5SS09uzpj1X
 JhTWSJvq1FIbhbCfGNxojsK6UuMFnwRC+26qJJKXeDL2nn5e95KQzqDYOVwhbd0CAYf0
 1PfjXKQlkc4DmhwAYVZk1LQlrrLbIckQco+VEUrEzzZXJeK+5KPkswUamGPJyEgZCydI
 Z5Rlf0G3C/URzJfnP3ZUTI1nYd5awKSC3WClCUe6XoTVgGgrsCpEJRV4/ZOGxeVTdd1t
 ZcfOFxTeNWLMegZ74AY6zLGcY/k5q3rXXSuuDTgILvn8qMlQ2iVeDaIXpI52YtsS/W82 tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3meyn9regx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 19:55:46 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BDJXqR6005073;
        Tue, 13 Dec 2022 19:55:46 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3meyn9regp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 19:55:46 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDEIv6N030674;
        Tue, 13 Dec 2022 19:55:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mchr5uc1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 19:55:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDJtfxp45154804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 19:55:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C719F20049;
        Tue, 13 Dec 2022 19:55:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAB7220043;
        Tue, 13 Dec 2022 19:55:39 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.94.137])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 13 Dec 2022 19:55:39 +0000 (GMT)
Date:   Wed, 14 Dec 2022 01:25:36 +0530
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: Add spaces around "<<"
Message-ID: <Y5jYuKfm9d59h6bd@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QOYFX_owzdf7nkxvyQ0tO-mlaAu_4mnM
X-Proofpoint-ORIG-GUID: 3--nR4D5iiyuJWz4qmn2BRjZkrGbVidw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around the "<<" in adherence to the Linux kernel coding-style.
The issues were reported by checkpatch.pl.

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
 drivers/staging/vme_user/vme.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
index 98da8d039d60..a74724457d29 100644
--- a/drivers/staging/vme_user/vme.h
+++ b/drivers/staging/vme_user/vme.h
@@ -54,20 +54,20 @@ enum vme_resource_type {
 #define VME_R_ROBIN_MODE	0x1
 #define VME_PRIORITY_MODE	0x2
 
-#define VME_DMA_PATTERN			(1<<0)
-#define VME_DMA_PCI			(1<<1)
-#define VME_DMA_VME			(1<<2)
-
-#define VME_DMA_PATTERN_BYTE		(1<<0)
-#define VME_DMA_PATTERN_WORD		(1<<1)
-#define VME_DMA_PATTERN_INCREMENT	(1<<2)
-
-#define VME_DMA_VME_TO_MEM		(1<<0)
-#define VME_DMA_MEM_TO_VME		(1<<1)
-#define VME_DMA_VME_TO_VME		(1<<2)
-#define VME_DMA_MEM_TO_MEM		(1<<3)
-#define VME_DMA_PATTERN_TO_VME		(1<<4)
-#define VME_DMA_PATTERN_TO_MEM		(1<<5)
+#define VME_DMA_PATTERN			(1 << 0)
+#define VME_DMA_PCI			(1 << 1)
+#define VME_DMA_VME			(1 << 2)
+
+#define VME_DMA_PATTERN_BYTE		(1 << 0)
+#define VME_DMA_PATTERN_WORD		(1 << 1)
+#define VME_DMA_PATTERN_INCREMENT	(1 << 2)
+
+#define VME_DMA_VME_TO_MEM		(1 << 0)
+#define VME_DMA_MEM_TO_VME		(1 << 1)
+#define VME_DMA_VME_TO_VME		(1 << 2)
+#define VME_DMA_MEM_TO_MEM		(1 << 3)
+#define VME_DMA_PATTERN_TO_VME		(1 << 4)
+#define VME_DMA_PATTERN_TO_MEM		(1 << 5)
 
 struct vme_dma_attr {
 	u32 type;
-- 
2.31.1

