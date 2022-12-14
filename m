Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07EA64CFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiLNTJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiLNTJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:09:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A045E80
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:09:51 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEInYtq010704;
        Wed, 14 Dec 2022 19:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=gAwL5yOsP8eZyWzRSC0r/H4vhJ07hATE2/rquZmH+J0=;
 b=oAYma+elAQ/ivhGPD1C7G+dajSsDpOqmQz3xpLcSucBkLxjqSHDeEcSuTg/EhmDWmbC3
 yzb8PqL4SwGZPgj0Gfwby7OaDDbFdf3LnrpAjKK9bE/zFNR12E4yPSwLI2OTHR1QC6LM
 gmy5WoY2AnQLdXPfryj7SbYhXPTjYTQmqWI316U1rsgDJhMe3SNBLBnSj2qb3uT2cSYL
 K4NoW5zUwZI//FnnzIPq5DCZPyZ7PCLV70+sN5vXSpELHQJRlmLrqaxfCFWUXaTZ1Bn4
 kqusKJuwZal9465HOMPPgC+J/QWotrw7vBEKf6AKKLb/hkJmThq4E4HiQ/cyWO2KuR/m Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mfm3xgt34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 19:09:41 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BEIqKig019087;
        Wed, 14 Dec 2022 19:09:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mfm3xgsws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 19:09:40 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEBg8Fd030324;
        Wed, 14 Dec 2022 19:04:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3mf0519bh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 19:04:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BEJ4X2r41025796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 19:04:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D71120043;
        Wed, 14 Dec 2022 19:04:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA85220049;
        Wed, 14 Dec 2022 19:04:30 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.67.101])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Dec 2022 19:04:30 +0000 (GMT)
Date:   Thu, 15 Dec 2022 00:34:27 +0530
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH v2] staging: vme_user: Replace the "<<" with BIT macro
Message-ID: <Y5oeO4QQIhqrYb+R@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lSzDMoRQUuEQDpQpy3Xb2veXFiBo-Th-
X-Proofpoint-GUID: 7ecFUHCXvvw8oy7JncZP1lZhyMEY3WHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_09,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140155
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

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
Changes in v2:
	- Replace the previously used "<<" operator with BIT macro

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

