Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB166AFEE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 09:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAOI2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 03:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjAOI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 03:28:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F96A25D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 00:28:17 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30F8C3as002061;
        Sun, 15 Jan 2023 08:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=D2AuUBEnQvG+uMrw55zRl5b7IpGA9aBKm/wWWWr7Chg=;
 b=MvfXMkwz++GPjKffTDRxnq1L/COrMkDkziP6V1QEs90Wjx6Enuo55VfvhmCETbvIR9oY
 zyZ30Bd0+rMGWN42F3Z3AO3CG6yVEXKU/0vE+GxZuYNrOJyIo3WJr0JtrNfwWCmuQet1
 p5IL61K5JUpSzoAd9l+3PivtvVhdtAiC1qypTjePipGiQ7ilWFJfDQ6Rw9aoW/WPIY5L
 2JCkr8DWhd0dTdXGryDc7PDOGJzxoetuyk4QnFEzBPlNSyP0kIV5cEwX0Muja55LpxQK
 DkAzVh6csAKEXqzonAMOzdbXAMR9pHLhpHiX1mZ03V7kJeaO4ynR1X3xsvvKJ6TFl2UN Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4ds006wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 08:28:07 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30F8C3g2002073;
        Sun, 15 Jan 2023 08:28:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n4ds006wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 08:28:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30F1dqPA004659;
        Sun, 15 Jan 2023 08:28:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16h53u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 08:28:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30F8S2Lg52756778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Jan 2023 08:28:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5C5220049;
        Sun, 15 Jan 2023 08:28:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8917020043;
        Sun, 15 Jan 2023 08:28:00 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.70.252])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 15 Jan 2023 08:28:00 +0000 (GMT)
Date:   Sun, 15 Jan 2023 13:57:56 +0530
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 RESEND] staging: vme_user: Replace the "<<" with BIT macro
Message-ID: <Y8O5DN9ehby8K487@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IdJMrimkO2XEp34vioptTnP0S2M6QMdY
X-Proofpoint-ORIG-GUID: 6fuzWXXMQoGD3wtUoa_FTSukWRUQlHqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_05,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301150060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

