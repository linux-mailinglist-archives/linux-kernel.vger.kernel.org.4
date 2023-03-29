Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE26CF00D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjC2RCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjC2RCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:02:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78618423C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:02:03 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TEj4Mf025729;
        Wed, 29 Mar 2023 17:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i41UaNvQyqXCKUINDBq99L3RK7D7oejpfnSLNETBBDI=;
 b=DNhu79y/ckeS8YUEQpd6r5jsqkubjbeuOMrIPPxGrV43ReSsNaDBfpbKvUQ/68oSBsAM
 9WKkj358tLSeBrB4UyFkIVkuZPm3H431C+uyY0/Py34NmnejPLC3LybpQk16vEyJN7L3
 dqFl04ZqEwHj3nTo+99Dl+Z1Vy/rByVlEul/YZdFydUp0e4gzLMK96fltB0MMg2VVVfG
 41SSbviRpTLg8MF5cZTzxTTun89p95rrdNlCeEl8aAqz/Rc1Ocr8odmFt8nXffJhSfgr
 OHwdXTx8cofSVsbS8NOT4nF1ArorKBgPpBEI8e3MIXlKNMcfpFFvNC/wqpQ7Do7/DWkA ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmnusf132-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:59 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32TGVMYl017725;
        Wed, 29 Mar 2023 17:01:58 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmnusf116-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:58 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32SIVrX3011933;
        Wed, 29 Mar 2023 17:01:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3phrk6ma5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32TH1of128115562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 17:01:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFB2C20040;
        Wed, 29 Mar 2023 17:01:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EB4D2004B;
        Wed, 29 Mar 2023 17:01:49 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.61.88])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Mar 2023 17:01:49 +0000 (GMT)
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     abhirupdeb@linux.vnet.ibm.com
Subject: [PATCH 2/5] staging: r8188eu: refactor block-comments
Date:   Wed, 29 Mar 2023 22:31:36 +0530
Message-Id: <ec30a75fd9719785459b01717b7440caeb308d07.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
References: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: klKOme-D_Qh-wSv7HxnVb_CV9wX8ruvO
X-Proofpoint-ORIG-GUID: IX2WmnAJn4X4NdW_fhIWXrS0U_IStuBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303290133
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix block comments by moving "/*" & "*/" symbols
on separate lines in adherence to the linux kernel
coding-style.

checkpatch warning produced:

WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 2ba1c1b25a76..9c2774eb5f78 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -381,8 +381,8 @@ static void _InitRetryFunction(struct adapter *Adapter)
 	/*  Set ACK timeout */
 	rtw_write8(Adapter, REG_ACKTO, 0x40);
 }
-
-/*-----------------------------------------------------------------------------
+/*
+ *-----------------------------------------------------------------------------
  * Function:	usb_AggSettingTxUpdate()
  *
  * Overview:	Separate TX/RX parameters update independent for TP detection and
@@ -396,7 +396,8 @@ static void _InitRetryFunction(struct adapter *Adapter)
  *	When		Who		Remark
  *	12/10/2010	MHC		Separate to smaller function.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void usb_AggSettingTxUpdate(struct adapter *Adapter)
 {
 	u32 value32;
@@ -414,8 +415,8 @@ static void usb_AggSettingTxUpdate(struct adapter *Adapter)
 
 	rtw_write32(Adapter, REG_TDECTRL, value32);
 }
-
-/*-----------------------------------------------------------------------------
+/*
+ *-----------------------------------------------------------------------------
  * Function:	usb_AggSettingRxUpdate()
  *
  * Overview:	Separate TX/RX parameters update independent for TP detection and
@@ -429,7 +430,8 @@ static void usb_AggSettingTxUpdate(struct adapter *Adapter)
  *	When		Who		Remark
  *	12/10/2010	MHC		Separate to smaller function.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void
 usb_AggSettingRxUpdate(
 		struct adapter *Adapter
-- 
2.31.1

