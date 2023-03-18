Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83D06BF867
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 08:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCRHBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 03:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCRHBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 03:01:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9AA298F4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 00:01:04 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32I3ptct015214;
        Sat, 18 Mar 2023 07:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=TSjFEwliMPXai+ARp5PX8oKYiiPEMJoY8yg/0nBOksY=;
 b=gJ8+6x9yBy0nJYA4PlnlAfADGshPbhXgFXVnWopQKpqx+nyvWgIQgAcx4074QNVJyBsW
 URMAxK7t83mEgDcINHgD4DoXad6+dObh1awZ6iE7Pg8apq5YIxZa862YujCPbcm+bgGR
 YO5fetRZmsv/lsKmdX0RJJfEppCOeO+5jBEDiMFsVxBspNWxh2+BsWwubu7I5b9fs1u7
 mDA5hrd21+M89dM/45hRO3FlV2qyR/4cl9mqDTLl6yVVO2OU0a4otLcWaTSlmWpUnB8G
 WV3AWVPScUBG9j8qQygZaxF86/2p/e8lh6JpnLn5rhmHcQiNXyytJaVbWBQStOFwfs+F Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pd5s6agq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Mar 2023 07:00:50 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32I6tRE4001443;
        Sat, 18 Mar 2023 07:00:50 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pd5s6agp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Mar 2023 07:00:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32I2sibS022346;
        Sat, 18 Mar 2023 07:00:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x686y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Mar 2023 07:00:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32I70jgC24117814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Mar 2023 07:00:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 855FA2004F;
        Sat, 18 Mar 2023 07:00:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15A8120043;
        Sat, 18 Mar 2023 07:00:44 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.37.140])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 18 Mar 2023 07:00:43 +0000 (GMT)
Date:   Sat, 18 Mar 2023 12:30:41 +0530
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: Replace "<<" with BIT macro
Message-ID: <ZBVhmU+5dVoExIH9@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aSJSHss7MSOjtUdqlvovGiyLdbbQXhPw
X-Proofpoint-ORIG-GUID: RfIj9RCOsLZYQs6CKvRiDChQyj6O5sqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-18_02,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303180056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the "<<" operator with BIT macro, in accordance to the
checkpatch.pl script and Linux kernel coding-style guidelines.

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
 drivers/staging/vme_user/vme_tsi148.h | 536 +++++++++++++-------------
 1 file changed, 268 insertions(+), 268 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index b3cb4a089cc8..57eafca2032c 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -536,22 +536,22 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 	/*
 	 *  PFCS Register Set
 	 */
-#define TSI148_PCFS_CMMD_SERR          (1<<8)	/* SERR_L out pin ssys err */
-#define TSI148_PCFS_CMMD_PERR          (1<<6)	/* PERR_L out pin  parity */
-#define TSI148_PCFS_CMMD_MSTR          (1<<2)	/* PCI bus master */
-#define TSI148_PCFS_CMMD_MEMSP         (1<<1)	/* PCI mem space access  */
-#define TSI148_PCFS_CMMD_IOSP          (1<<0)	/* PCI I/O space enable */
-
-#define TSI148_PCFS_STAT_RCPVE         (1<<15)	/* Detected Parity Error */
-#define TSI148_PCFS_STAT_SIGSE         (1<<14)	/* Signalled System Error */
-#define TSI148_PCFS_STAT_RCVMA         (1<<13)	/* Received Master Abort */
-#define TSI148_PCFS_STAT_RCVTA         (1<<12)	/* Received Target Abort */
-#define TSI148_PCFS_STAT_SIGTA         (1<<11)	/* Signalled Target Abort */
-#define TSI148_PCFS_STAT_SELTIM        (3<<9)	/* DELSEL Timing */
-#define TSI148_PCFS_STAT_DPAR          (1<<8)	/* Data Parity Err Reported */
-#define TSI148_PCFS_STAT_FAST          (1<<7)	/* Fast back-to-back Cap */
-#define TSI148_PCFS_STAT_P66M          (1<<5)	/* 66 MHz Capable */
-#define TSI148_PCFS_STAT_CAPL          (1<<4)	/* Capab List - address $34 */
+#define TSI148_PCFS_CMMD_SERR          BIT(8)	/* SERR_L out pin ssys err */
+#define TSI148_PCFS_CMMD_PERR          BIT(6)	/* PERR_L out pin  parity */
+#define TSI148_PCFS_CMMD_MSTR          BIT(2)	/* PCI bus master */
+#define TSI148_PCFS_CMMD_MEMSP         BIT(1)	/* PCI mem space access  */
+#define TSI148_PCFS_CMMD_IOSP          BIT(0)	/* PCI I/O space enable */
+
+#define TSI148_PCFS_STAT_RCPVE         BIT(15)	/* Detected Parity Error */
+#define TSI148_PCFS_STAT_SIGSE         BIT(14)	/* Signalled System Error */
+#define TSI148_PCFS_STAT_RCVMA         BIT(13)	/* Received Master Abort */
+#define TSI148_PCFS_STAT_RCVTA         BIT(12)	/* Received Target Abort */
+#define TSI148_PCFS_STAT_SIGTA         BIT(11)	/* Signalled Target Abort */
+#define TSI148_PCFS_STAT_SELTIM        BIT(9)	/* DELSEL Timing */
+#define TSI148_PCFS_STAT_DPAR          BIT(8)	/* Data Parity Err Reported */
+#define TSI148_PCFS_STAT_FAST          BIT(7)	/* Fast back-to-back Cap */
+#define TSI148_PCFS_STAT_P66M          BIT(5)	/* 66 MHz Capable */
+#define TSI148_PCFS_STAT_CAPL          BIT(4)	/* Capab List - address $34 */
 
 /*
  *  Revision ID/Class Code Registers   (CRG +$008)
@@ -572,17 +572,17 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
  *  Memory Base Address Lower Reg (CRG + $010)
  */
 #define TSI148_PCFS_MBARL_BASEL_M      (0xFFFFF<<12) /* Base Addr Lower Mask */
-#define TSI148_PCFS_MBARL_PRE          (1<<3)	/* Prefetch */
+#define TSI148_PCFS_MBARL_PRE          BIT(3)	/* Prefetch */
 #define TSI148_PCFS_MBARL_MTYPE_M      (3<<1)	/* Memory Type Mask */
-#define TSI148_PCFS_MBARL_IOMEM        (1<<0)	/* I/O Space Indicator */
+#define TSI148_PCFS_MBARL_IOMEM        BIT(0)	/* I/O Space Indicator */
 
 /*
  *  Message Signaled Interrupt Capabilities Register (CRG + $040)
  */
-#define TSI148_PCFS_MSICAP_64BAC       (1<<7)	/* 64-bit Address Capable */
+#define TSI148_PCFS_MSICAP_64BAC       BIT(7)	/* 64-bit Address Capable */
 #define TSI148_PCFS_MSICAP_MME_M       (7<<4)	/* Multiple Msg Enable Mask */
 #define TSI148_PCFS_MSICAP_MMC_M       (7<<1)	/* Multiple Msg Capable Mask */
-#define TSI148_PCFS_MSICAP_MSIEN       (1<<0)	/* Msg signaled INT Enable */
+#define TSI148_PCFS_MSICAP_MSIEN       BIT(0)	/* Msg signaled INT Enable */
 
 /*
  *  Message Address Lower Register (CRG +$044)
@@ -599,22 +599,22 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
  */
 #define TSI148_PCFS_PCIXCAP_MOST_M     (7<<4)	/* Max outstanding Split Tran */
 #define TSI148_PCFS_PCIXCAP_MMRBC_M    (3<<2)	/* Max Mem Read byte cnt */
-#define TSI148_PCFS_PCIXCAP_ERO        (1<<1)	/* Enable Relaxed Ordering */
-#define TSI148_PCFS_PCIXCAP_DPERE      (1<<0)	/* Data Parity Recover Enable */
+#define TSI148_PCFS_PCIXCAP_ERO        BIT(1)	/* Enable Relaxed Ordering */
+#define TSI148_PCFS_PCIXCAP_DPERE      BIT(0)	/* Data Parity Recover Enable */
 
 /*
  *  PCI-X Status Register (CRG +$054)
  */
-#define TSI148_PCFS_PCIXSTAT_RSCEM     (1<<29)	/* Received Split Comp Error */
+#define TSI148_PCFS_PCIXSTAT_RSCEM     BIT(29)	/* Received Split Comp Error */
 #define TSI148_PCFS_PCIXSTAT_DMCRS_M   (7<<26)	/* max Cumulative Read Size */
 #define TSI148_PCFS_PCIXSTAT_DMOST_M   (7<<23)	/* max outstanding Split Trans
 						 */
 #define TSI148_PCFS_PCIXSTAT_DMMRC_M   (3<<21)	/* max mem read byte count */
-#define TSI148_PCFS_PCIXSTAT_DC        (1<<20)	/* Device Complexity */
-#define TSI148_PCFS_PCIXSTAT_USC       (1<<19)	/* Unexpected Split comp */
-#define TSI148_PCFS_PCIXSTAT_SCD       (1<<18)	/* Split completion discard */
-#define TSI148_PCFS_PCIXSTAT_133C      (1<<17)	/* 133MHz capable */
-#define TSI148_PCFS_PCIXSTAT_64D       (1<<16)	/* 64 bit device */
+#define TSI148_PCFS_PCIXSTAT_DC        BIT(20)	/* Device Complexity */
+#define TSI148_PCFS_PCIXSTAT_USC       BIT(19)	/* Unexpected Split comp */
+#define TSI148_PCFS_PCIXSTAT_SCD       BIT(18)	/* Split completion discard */
+#define TSI148_PCFS_PCIXSTAT_133C      BIT(17)	/* 133MHz capable */
+#define TSI148_PCFS_PCIXSTAT_64D       BIT(16)	/* 64 bit device */
 #define TSI148_PCFS_PCIXSTAT_BN_M      (0xFF<<8)	/* Bus number */
 #define TSI148_PCFS_PCIXSTAT_DN_M      (0x1F<<3)	/* Device number */
 #define TSI148_PCFS_PCIXSTAT_FN_M      (7<<0)	/* Function Number */
@@ -646,23 +646,23 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  Outbound Translation Attribute
  */
-#define TSI148_LCSR_OTAT_EN            (1<<31)	/* Window Enable */
-#define TSI148_LCSR_OTAT_MRPFD         (1<<18)	/* Prefetch Disable */
+#define TSI148_LCSR_OTAT_EN            BIT(31)	/* Window Enable */
+#define TSI148_LCSR_OTAT_MRPFD         BIT(18)	/* Prefetch Disable */
 
 #define TSI148_LCSR_OTAT_PFS_M         (3<<16)	/* Prefetch Size Mask */
 #define TSI148_LCSR_OTAT_PFS_2         (0<<16)	/* 2 Cache Lines P Size */
-#define TSI148_LCSR_OTAT_PFS_4         (1<<16)	/* 4 Cache Lines P Size */
+#define TSI148_LCSR_OTAT_PFS_4         BIT(16)	/* 4 Cache Lines P Size */
 #define TSI148_LCSR_OTAT_PFS_8         (2<<16)	/* 8 Cache Lines P Size */
 #define TSI148_LCSR_OTAT_PFS_16        (3<<16)	/* 16 Cache Lines P Size */
 
 #define TSI148_LCSR_OTAT_2eSSTM_M      (7<<11)	/* 2eSST Xfer Rate Mask */
 #define TSI148_LCSR_OTAT_2eSSTM_160    (0<<11)	/* 160MB/s 2eSST Xfer Rate */
-#define TSI148_LCSR_OTAT_2eSSTM_267    (1<<11)	/* 267MB/s 2eSST Xfer Rate */
+#define TSI148_LCSR_OTAT_2eSSTM_267    BIT(11)	/* 267MB/s 2eSST Xfer Rate */
 #define TSI148_LCSR_OTAT_2eSSTM_320    (2<<11)	/* 320MB/s 2eSST Xfer Rate */
 
 #define TSI148_LCSR_OTAT_TM_M          (7<<8)	/* Xfer Protocol Mask */
 #define TSI148_LCSR_OTAT_TM_SCT        (0<<8)	/* SCT Xfer Protocol */
-#define TSI148_LCSR_OTAT_TM_BLT        (1<<8)	/* BLT Xfer Protocol */
+#define TSI148_LCSR_OTAT_TM_BLT        BIT(8)	/* BLT Xfer Protocol */
 #define TSI148_LCSR_OTAT_TM_MBLT       (2<<8)	/* MBLT Xfer Protocol */
 #define TSI148_LCSR_OTAT_TM_2eVME      (3<<8)	/* 2eVME Xfer Protocol */
 #define TSI148_LCSR_OTAT_TM_2eSST      (4<<8)	/* 2eSST Xfer Protocol */
@@ -670,14 +670,14 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 
 #define TSI148_LCSR_OTAT_DBW_M         (3<<6)	/* Max Data Width */
 #define TSI148_LCSR_OTAT_DBW_16        (0<<6)	/* 16-bit Data Width */
-#define TSI148_LCSR_OTAT_DBW_32        (1<<6)	/* 32-bit Data Width */
+#define TSI148_LCSR_OTAT_DBW_32        BIT(6)	/* 32-bit Data Width */
 
-#define TSI148_LCSR_OTAT_SUP           (1<<5)	/* Supervisory Access */
-#define TSI148_LCSR_OTAT_PGM           (1<<4)	/* Program Access */
+#define TSI148_LCSR_OTAT_SUP           BIT(5)	/* Supervisory Access */
+#define TSI148_LCSR_OTAT_PGM           BIT(4)	/* Program Access */
 
 #define TSI148_LCSR_OTAT_AMODE_M       (0xf<<0)	/* Address Mode Mask */
 #define TSI148_LCSR_OTAT_AMODE_A16     (0<<0)	/* A16 Address Space */
-#define TSI148_LCSR_OTAT_AMODE_A24     (1<<0)	/* A24 Address Space */
+#define TSI148_LCSR_OTAT_AMODE_A24     BIT(0)	/* A24 Address Space */
 #define TSI148_LCSR_OTAT_AMODE_A32     (2<<0)	/* A32 Address Space */
 #define TSI148_LCSR_OTAT_AMODE_A64     (4<<0)	/* A32 Address Space */
 #define TSI148_LCSR_OTAT_AMODE_CRCSR   (5<<0)	/* CR/CSR Address Space */
@@ -689,17 +689,17 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  VME Master Control Register  CRG+$234
  */
-#define TSI148_LCSR_VMCTRL_VSA         (1<<27)	/* VMEbus Stop Ack */
-#define TSI148_LCSR_VMCTRL_VS          (1<<26)	/* VMEbus Stop */
-#define TSI148_LCSR_VMCTRL_DHB         (1<<25)	/* Device Has Bus */
-#define TSI148_LCSR_VMCTRL_DWB         (1<<24)	/* Device Wants Bus */
+#define TSI148_LCSR_VMCTRL_VSA         BIT(27)	/* VMEbus Stop Ack */
+#define TSI148_LCSR_VMCTRL_VS          BIT(26)	/* VMEbus Stop */
+#define TSI148_LCSR_VMCTRL_DHB         BIT(25)	/* Device Has Bus */
+#define TSI148_LCSR_VMCTRL_DWB         BIT(24)	/* Device Wants Bus */
 
-#define TSI148_LCSR_VMCTRL_RMWEN       (1<<20)	/* RMW Enable */
+#define TSI148_LCSR_VMCTRL_RMWEN       BIT(20)	/* RMW Enable */
 
 #define TSI148_LCSR_VMCTRL_ATO_M       (7<<16)	/* Master Access Time-out Mask
 						 */
 #define TSI148_LCSR_VMCTRL_ATO_32      (0<<16)	/* 32 us */
-#define TSI148_LCSR_VMCTRL_ATO_128     (1<<16)	/* 128 us */
+#define TSI148_LCSR_VMCTRL_ATO_128     BIT(16)	/* 128 us */
 #define TSI148_LCSR_VMCTRL_ATO_512     (2<<16)	/* 512 us */
 #define TSI148_LCSR_VMCTRL_ATO_2M      (3<<16)	/* 2 ms */
 #define TSI148_LCSR_VMCTRL_ATO_8M      (4<<16)	/* 8 ms */
@@ -709,7 +709,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 
 #define TSI148_LCSR_VMCTRL_VTOFF_M     (7<<12)	/* VMEbus Master Time off */
 #define TSI148_LCSR_VMCTRL_VTOFF_0     (0<<12)	/* 0us */
-#define TSI148_LCSR_VMCTRL_VTOFF_1     (1<<12)	/* 1us */
+#define TSI148_LCSR_VMCTRL_VTOFF_1     BIT(12)	/* 1us */
 #define TSI148_LCSR_VMCTRL_VTOFF_2     (2<<12)	/* 2us */
 #define TSI148_LCSR_VMCTRL_VTOFF_4     (3<<12)	/* 4us */
 #define TSI148_LCSR_VMCTRL_VTOFF_8     (4<<12)	/* 8us */
@@ -719,7 +719,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 
 #define TSI148_LCSR_VMCTRL_VTON_M      (7<<8)	/* VMEbus Master Time On */
 #define TSI148_LCSR_VMCTRL_VTON_4      (0<<8)	/* 8us */
-#define TSI148_LCSR_VMCTRL_VTON_8      (1<<8)	/* 8us */
+#define TSI148_LCSR_VMCTRL_VTON_8      BIT(8)	/* 8us */
 #define TSI148_LCSR_VMCTRL_VTON_16     (2<<8)	/* 16us */
 #define TSI148_LCSR_VMCTRL_VTON_32     (3<<8)	/* 32us */
 #define TSI148_LCSR_VMCTRL_VTON_64     (4<<8)	/* 64us */
@@ -730,22 +730,22 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_VMCTRL_VREL_M      (3<<3)	/* VMEbus Master Rel Mode Mask
 						 */
 #define TSI148_LCSR_VMCTRL_VREL_T_D    (0<<3)	/* Time on or Done */
-#define TSI148_LCSR_VMCTRL_VREL_T_R_D  (1<<3)	/* Time on and REQ or Done */
+#define TSI148_LCSR_VMCTRL_VREL_T_R_D  BIT(3)	/* Time on and REQ or Done */
 #define TSI148_LCSR_VMCTRL_VREL_T_B_D  (2<<3)	/* Time on and BCLR or Done */
 #define TSI148_LCSR_VMCTRL_VREL_T_D_R  (3<<3)	/* Time on or Done and REQ */
 
-#define TSI148_LCSR_VMCTRL_VFAIR       (1<<2)	/* VMEbus Master Fair Mode */
+#define TSI148_LCSR_VMCTRL_VFAIR       BIT(2)	/* VMEbus Master Fair Mode */
 #define TSI148_LCSR_VMCTRL_VREQL_M     (3<<0)	/* VMEbus Master Req Level Mask
 						 */
 
 /*
  *  VMEbus Control Register CRG+$238
  */
-#define TSI148_LCSR_VCTRL_LRE          (1<<31)	/* Late Retry Enable */
+#define TSI148_LCSR_VCTRL_LRE          BIT(31)	/* Late Retry Enable */
 
 #define TSI148_LCSR_VCTRL_DLT_M        (0xF<<24)	/* Deadlock Timer */
 #define TSI148_LCSR_VCTRL_DLT_OFF      (0<<24)	/* Deadlock Timer Off */
-#define TSI148_LCSR_VCTRL_DLT_16       (1<<24)	/* 16 VCLKS */
+#define TSI148_LCSR_VCTRL_DLT_16       BIT(24)	/* 16 VCLKS */
 #define TSI148_LCSR_VCTRL_DLT_32       (2<<24)	/* 32 VCLKS */
 #define TSI148_LCSR_VCTRL_DLT_64       (3<<24)	/* 64 VCLKS */
 #define TSI148_LCSR_VCTRL_DLT_128      (4<<24)	/* 128 VCLKS */
@@ -758,22 +758,22 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_VCTRL_DLT_16384    (0xB<<24)	/* 16384 VCLKS */
 #define TSI148_LCSR_VCTRL_DLT_32768    (0xC<<24)	/* 32768 VCLKS */
 
-#define TSI148_LCSR_VCTRL_NERBB        (1<<20)	/* No Early Release of Bus Busy
+#define TSI148_LCSR_VCTRL_NERBB        BIT(20)	/* No Early Release of Bus Busy
 						 */
 
-#define TSI148_LCSR_VCTRL_SRESET       (1<<17)	/* System Reset */
-#define TSI148_LCSR_VCTRL_LRESET       (1<<16)	/* Local Reset */
+#define TSI148_LCSR_VCTRL_SRESET       BIT(17)	/* System Reset */
+#define TSI148_LCSR_VCTRL_LRESET       BIT(16)	/* Local Reset */
 
-#define TSI148_LCSR_VCTRL_SFAILAI      (1<<15)	/* SYSFAIL Auto Slot ID */
+#define TSI148_LCSR_VCTRL_SFAILAI      BIT(15)	/* SYSFAIL Auto Slot ID */
 #define TSI148_LCSR_VCTRL_BID_M        (0x1F<<8)	/* Broadcast ID Mask */
 
-#define TSI148_LCSR_VCTRL_ATOEN        (1<<7)	/* Arbiter Time-out Enable */
-#define TSI148_LCSR_VCTRL_ROBIN        (1<<6)	/* VMEbus Round Robin */
+#define TSI148_LCSR_VCTRL_ATOEN        BIT(7)	/* Arbiter Time-out Enable */
+#define TSI148_LCSR_VCTRL_ROBIN        BIT(6)	/* VMEbus Round Robin */
 
 #define TSI148_LCSR_VCTRL_GTO_M        (7<<0)	/* VMEbus Global Time-out Mask
 						 */
 #define TSI148_LCSR_VCTRL_GTO_8	      (0<<0)	/* 8 us */
-#define TSI148_LCSR_VCTRL_GTO_16	      (1<<0)	/* 16 us */
+#define TSI148_LCSR_VCTRL_GTO_16	      BIT(0)	/* 16 us */
 #define TSI148_LCSR_VCTRL_GTO_32	      (2<<0)	/* 32 us */
 #define TSI148_LCSR_VCTRL_GTO_64	      (3<<0)	/* 64 us */
 #define TSI148_LCSR_VCTRL_GTO_128      (4<<0)	/* 128 us */
@@ -784,48 +784,48 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  VMEbus Status Register  CRG + $23C
  */
-#define TSI148_LCSR_VSTAT_CPURST       (1<<15)	/* Clear power up reset */
-#define TSI148_LCSR_VSTAT_BRDFL        (1<<14)	/* Board fail */
-#define TSI148_LCSR_VSTAT_PURSTS       (1<<12)	/* Power up reset status */
-#define TSI148_LCSR_VSTAT_BDFAILS      (1<<11)	/* Board Fail Status */
-#define TSI148_LCSR_VSTAT_SYSFAILS     (1<<10)	/* System Fail Status */
-#define TSI148_LCSR_VSTAT_ACFAILS      (1<<9)	/* AC fail status */
-#define TSI148_LCSR_VSTAT_SCONS        (1<<8)	/* System Cont Status */
-#define TSI148_LCSR_VSTAT_GAP          (1<<5)	/* Geographic Addr Parity */
+#define TSI148_LCSR_VSTAT_CPURST       BIT(15)	/* Clear power up reset */
+#define TSI148_LCSR_VSTAT_BRDFL        BIT(14)	/* Board fail */
+#define TSI148_LCSR_VSTAT_PURSTS       BIT(12)	/* Power up reset status */
+#define TSI148_LCSR_VSTAT_BDFAILS      BIT(11)	/* Board Fail Status */
+#define TSI148_LCSR_VSTAT_SYSFAILS     BIT(10)	/* System Fail Status */
+#define TSI148_LCSR_VSTAT_ACFAILS      BIT(9)	/* AC fail status */
+#define TSI148_LCSR_VSTAT_SCONS        BIT(8)	/* System Cont Status */
+#define TSI148_LCSR_VSTAT_GAP          BIT(5)	/* Geographic Addr Parity */
 #define TSI148_LCSR_VSTAT_GA_M         (0x1F<<0)  /* Geographic Addr Mask */
 
 /*
  *  PCI Configuration Status Register CRG+$240
  */
-#define TSI148_LCSR_PSTAT_REQ64S       (1<<6)	/* Request 64 status set */
-#define TSI148_LCSR_PSTAT_M66ENS       (1<<5)	/* M66ENS 66Mhz enable */
-#define TSI148_LCSR_PSTAT_FRAMES       (1<<4)	/* Frame Status */
-#define TSI148_LCSR_PSTAT_IRDYS        (1<<3)	/* IRDY status */
-#define TSI148_LCSR_PSTAT_DEVSELS      (1<<2)	/* DEVL status */
-#define TSI148_LCSR_PSTAT_STOPS        (1<<1)	/* STOP status */
-#define TSI148_LCSR_PSTAT_TRDYS        (1<<0)	/* TRDY status */
+#define TSI148_LCSR_PSTAT_REQ64S       BIT(6)	/* Request 64 status set */
+#define TSI148_LCSR_PSTAT_M66ENS       BIT(5)	/* M66ENS 66Mhz enable */
+#define TSI148_LCSR_PSTAT_FRAMES       BIT(4)	/* Frame Status */
+#define TSI148_LCSR_PSTAT_IRDYS        BIT(3)	/* IRDY status */
+#define TSI148_LCSR_PSTAT_DEVSELS      BIT(2)	/* DEVL status */
+#define TSI148_LCSR_PSTAT_STOPS        BIT(1)	/* STOP status */
+#define TSI148_LCSR_PSTAT_TRDYS        BIT(0)	/* TRDY status */
 
 /*
  *  VMEbus Exception Attributes Register  CRG + $268
  */
-#define TSI148_LCSR_VEAT_VES           (1<<31)	/* Status */
-#define TSI148_LCSR_VEAT_VEOF          (1<<30)	/* Overflow */
-#define TSI148_LCSR_VEAT_VESCL         (1<<29)	/* Status Clear */
-#define TSI148_LCSR_VEAT_2EOT          (1<<21)	/* 2e Odd Termination */
-#define TSI148_LCSR_VEAT_2EST          (1<<20)	/* 2e Slave terminated */
-#define TSI148_LCSR_VEAT_BERR          (1<<19)	/* Bus Error */
-#define TSI148_LCSR_VEAT_LWORD         (1<<18)	/* LWORD_ signal state */
-#define TSI148_LCSR_VEAT_WRITE         (1<<17)	/* WRITE_ signal state */
-#define TSI148_LCSR_VEAT_IACK          (1<<16)	/* IACK_ signal state */
-#define TSI148_LCSR_VEAT_DS1           (1<<15)	/* DS1_ signal state */
-#define TSI148_LCSR_VEAT_DS0           (1<<14)	/* DS0_ signal state */
+#define TSI148_LCSR_VEAT_VES           BIT(31)	/* Status */
+#define TSI148_LCSR_VEAT_VEOF          BIT(30)	/* Overflow */
+#define TSI148_LCSR_VEAT_VESCL         BIT(29)	/* Status Clear */
+#define TSI148_LCSR_VEAT_2EOT          BIT(21)	/* 2e Odd Termination */
+#define TSI148_LCSR_VEAT_2EST          BIT(20)	/* 2e Slave terminated */
+#define TSI148_LCSR_VEAT_BERR          BIT(19)	/* Bus Error */
+#define TSI148_LCSR_VEAT_LWORD         BIT(18)	/* LWORD_ signal state */
+#define TSI148_LCSR_VEAT_WRITE         BIT(17)	/* WRITE_ signal state */
+#define TSI148_LCSR_VEAT_IACK          BIT(16)	/* IACK_ signal state */
+#define TSI148_LCSR_VEAT_DS1           BIT(15)	/* DS1_ signal state */
+#define TSI148_LCSR_VEAT_DS0           BIT(14)	/* DS0_ signal state */
 #define TSI148_LCSR_VEAT_AM_M          (0x3F<<8)	/* Address Mode Mask */
 #define TSI148_LCSR_VEAT_XAM_M         (0xFF<<0)	/* Master AMode Mask */
 
 /*
  * VMEbus PCI Error Diagnostics PCI/X Attributes Register  CRG + $280
  */
-#define TSI148_LCSR_EDPAT_EDPCL        (1<<29)
+#define TSI148_LCSR_EDPAT_EDPCL        BIT(29)
 
 /*
  *  Inbound Translation Starting Address Lower
@@ -851,36 +851,36 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  Inbound Translation Attribute
  */
-#define TSI148_LCSR_ITAT_EN            (1<<31)	/* Window Enable */
-#define TSI148_LCSR_ITAT_TH            (1<<18)	/* Prefetch Threshold */
+#define TSI148_LCSR_ITAT_EN            BIT(31)	/* Window Enable */
+#define TSI148_LCSR_ITAT_TH            BIT(18)	/* Prefetch Threshold */
 
 #define TSI148_LCSR_ITAT_VFS_M         (3<<16)	/* Virtual FIFO Size Mask */
 #define TSI148_LCSR_ITAT_VFS_64        (0<<16)	/* 64 bytes Virtual FIFO Size */
-#define TSI148_LCSR_ITAT_VFS_128       (1<<16)	/* 128 bytes Virtual FIFO Sz */
+#define TSI148_LCSR_ITAT_VFS_128       BIT(16)	/* 128 bytes Virtual FIFO Sz */
 #define TSI148_LCSR_ITAT_VFS_256       (2<<16)	/* 256 bytes Virtual FIFO Sz */
 #define TSI148_LCSR_ITAT_VFS_512       (3<<16)	/* 512 bytes Virtual FIFO Sz */
 
 #define TSI148_LCSR_ITAT_2eSSTM_M      (7<<12)	/* 2eSST Xfer Rate Mask */
 #define TSI148_LCSR_ITAT_2eSSTM_160    (0<<12)	/* 160MB/s 2eSST Xfer Rate */
-#define TSI148_LCSR_ITAT_2eSSTM_267    (1<<12)	/* 267MB/s 2eSST Xfer Rate */
+#define TSI148_LCSR_ITAT_2eSSTM_267    BIT(12)	/* 267MB/s 2eSST Xfer Rate */
 #define TSI148_LCSR_ITAT_2eSSTM_320    (2<<12)	/* 320MB/s 2eSST Xfer Rate */
 
-#define TSI148_LCSR_ITAT_2eSSTB        (1<<11)	/* 2eSST Bcast Xfer Protocol */
-#define TSI148_LCSR_ITAT_2eSST         (1<<10)	/* 2eSST Xfer Protocol */
-#define TSI148_LCSR_ITAT_2eVME         (1<<9)	/* 2eVME Xfer Protocol */
-#define TSI148_LCSR_ITAT_MBLT          (1<<8)	/* MBLT Xfer Protocol */
-#define TSI148_LCSR_ITAT_BLT           (1<<7)	/* BLT Xfer Protocol */
+#define TSI148_LCSR_ITAT_2eSSTB        BIT(11)	/* 2eSST Bcast Xfer Protocol */
+#define TSI148_LCSR_ITAT_2eSST         BIT(10)	/* 2eSST Xfer Protocol */
+#define TSI148_LCSR_ITAT_2eVME         BIT(9)	/* 2eVME Xfer Protocol */
+#define TSI148_LCSR_ITAT_MBLT          BIT(8)	/* MBLT Xfer Protocol */
+#define TSI148_LCSR_ITAT_BLT           BIT(7)	/* BLT Xfer Protocol */
 
 #define TSI148_LCSR_ITAT_AS_M          (7<<4)	/* Address Space Mask */
 #define TSI148_LCSR_ITAT_AS_A16        (0<<4)	/* A16 Address Space */
-#define TSI148_LCSR_ITAT_AS_A24        (1<<4)	/* A24 Address Space */
+#define TSI148_LCSR_ITAT_AS_A24        BIT(4)	/* A24 Address Space */
 #define TSI148_LCSR_ITAT_AS_A32        (2<<4)	/* A32 Address Space */
 #define TSI148_LCSR_ITAT_AS_A64        (4<<4)	/* A64 Address Space */
 
-#define TSI148_LCSR_ITAT_SUPR          (1<<3)	/* Supervisor Access */
-#define TSI148_LCSR_ITAT_NPRIV         (1<<2)	/* Non-Priv (User) Access */
-#define TSI148_LCSR_ITAT_PGM           (1<<1)	/* Program Access */
-#define TSI148_LCSR_ITAT_DATA          (1<<0)	/* Data Access */
+#define TSI148_LCSR_ITAT_SUPR          BIT(3)	/* Supervisor Access */
+#define TSI148_LCSR_ITAT_NPRIV         BIT(2)	/* Non-Priv (User) Access */
+#define TSI148_LCSR_ITAT_PGM           BIT(1)	/* Program Access */
+#define TSI148_LCSR_ITAT_DATA          BIT(0)	/* Data Access */
 
 /*
  *  GCSR Base Address Lower Address  CRG +$404
@@ -890,18 +890,18 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  GCSR Attribute Register CRG + $408
  */
-#define TSI148_LCSR_GCSRAT_EN          (1<<7)	/* Enable access to GCSR */
+#define TSI148_LCSR_GCSRAT_EN          BIT(7)	/* Enable access to GCSR */
 
 #define TSI148_LCSR_GCSRAT_AS_M        (7<<4)	/* Address Space Mask */
 #define TSI148_LCSR_GCSRAT_AS_A16       (0<<4)	/* Address Space 16 */
-#define TSI148_LCSR_GCSRAT_AS_A24       (1<<4)	/* Address Space 24 */
+#define TSI148_LCSR_GCSRAT_AS_A24       BIT(4)	/* Address Space 24 */
 #define TSI148_LCSR_GCSRAT_AS_A32       (2<<4)	/* Address Space 32 */
 #define TSI148_LCSR_GCSRAT_AS_A64       (4<<4)	/* Address Space 64 */
 
-#define TSI148_LCSR_GCSRAT_SUPR        (1<<3)	/* Sup set -GCSR decoder */
-#define TSI148_LCSR_GCSRAT_NPRIV       (1<<2)	/* Non-Privliged set - CGSR */
-#define TSI148_LCSR_GCSRAT_PGM         (1<<1)	/* Program set - GCSR decoder */
-#define TSI148_LCSR_GCSRAT_DATA        (1<<0)	/* DATA set GCSR decoder */
+#define TSI148_LCSR_GCSRAT_SUPR        BIT(3)	/* Sup set -GCSR decoder */
+#define TSI148_LCSR_GCSRAT_NPRIV       BIT(2)	/* Non-Privliged set - CGSR */
+#define TSI148_LCSR_GCSRAT_PGM         BIT(1)	/* Program set - GCSR decoder */
+#define TSI148_LCSR_GCSRAT_DATA        BIT(0)	/* DATA set GCSR decoder */
 
 /*
  *  CRG Base Address Lower Address  CRG + $410
@@ -911,18 +911,18 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  CRG Attribute Register  CRG + $414
  */
-#define TSI148_LCSR_CRGAT_EN           (1<<7)	/* Enable PRG Access */
+#define TSI148_LCSR_CRGAT_EN           BIT(7)	/* Enable PRG Access */
 
 #define TSI148_LCSR_CRGAT_AS_M         (7<<4)	/* Address Space */
 #define TSI148_LCSR_CRGAT_AS_A16       (0<<4)	/* Address Space 16 */
-#define TSI148_LCSR_CRGAT_AS_A24       (1<<4)	/* Address Space 24 */
+#define TSI148_LCSR_CRGAT_AS_A24       BIT(4)	/* Address Space 24 */
 #define TSI148_LCSR_CRGAT_AS_A32       (2<<4)	/* Address Space 32 */
 #define TSI148_LCSR_CRGAT_AS_A64       (4<<4)	/* Address Space 64 */
 
-#define TSI148_LCSR_CRGAT_SUPR         (1<<3)	/* Supervisor Access */
-#define TSI148_LCSR_CRGAT_NPRIV        (1<<2)	/* Non-Privliged(User) Access */
-#define TSI148_LCSR_CRGAT_PGM          (1<<1)	/* Program Access */
-#define TSI148_LCSR_CRGAT_DATA         (1<<0)	/* Data Access */
+#define TSI148_LCSR_CRGAT_SUPR         BIT(3)	/* Supervisor Access */
+#define TSI148_LCSR_CRGAT_NPRIV        BIT(2)	/* Non-Privliged(User) Access */
+#define TSI148_LCSR_CRGAT_PGM          BIT(1)	/* Program Access */
+#define TSI148_LCSR_CRGAT_DATA         BIT(0)	/* Data Access */
 
 /*
  *  CR/CSR Offset Lower Register  CRG + $41C
@@ -932,7 +932,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  CR/CSR Attribute register  CRG + $420
  */
-#define TSI148_LCSR_CRAT_EN            (1<<7)	/* Enable access to CR/CSR */
+#define TSI148_LCSR_CRAT_EN            BIT(7)	/* Enable access to CR/CSR */
 
 /*
  *  Location Monitor base address lower register  CRG + $428
@@ -942,18 +942,18 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 /*
  *  Location Monitor Attribute Register  CRG + $42C
  */
-#define TSI148_LCSR_LMAT_EN            (1<<7)	/* Enable Location Monitor */
+#define TSI148_LCSR_LMAT_EN            BIT(7)	/* Enable Location Monitor */
 
 #define TSI148_LCSR_LMAT_AS_M          (7<<4)	/* Address Space MASK  */
 #define TSI148_LCSR_LMAT_AS_A16        (0<<4)	/* A16 */
-#define TSI148_LCSR_LMAT_AS_A24        (1<<4)	/* A24 */
+#define TSI148_LCSR_LMAT_AS_A24        BIT(4)	/* A24 */
 #define TSI148_LCSR_LMAT_AS_A32        (2<<4)	/* A32 */
 #define TSI148_LCSR_LMAT_AS_A64        (4<<4)	/* A64 */
 
-#define TSI148_LCSR_LMAT_SUPR          (1<<3)	/* Supervisor Access */
-#define TSI148_LCSR_LMAT_NPRIV         (1<<2)	/* Non-Priv (User) Access */
-#define TSI148_LCSR_LMAT_PGM           (1<<1)	/* Program Access */
-#define TSI148_LCSR_LMAT_DATA          (1<<0)	/* Data Access  */
+#define TSI148_LCSR_LMAT_SUPR          BIT(3)	/* Supervisor Access */
+#define TSI148_LCSR_LMAT_NPRIV         BIT(2)	/* Non-Priv (User) Access */
+#define TSI148_LCSR_LMAT_PGM           BIT(1)	/* Program Access */
+#define TSI148_LCSR_LMAT_DATA          BIT(0)	/* Data Access  */
 
 /*
  *  Broadcast Pulse Generator Timer Register  CRG + $438
@@ -969,34 +969,34 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
  *  VMEbus Interrupt Control Register           CRG + $43C
  */
 #define TSI148_LCSR_VICR_CNTS_M        (3<<22)	/* Cntr Source MASK */
-#define TSI148_LCSR_VICR_CNTS_DIS      (1<<22)	/* Cntr Disable */
+#define TSI148_LCSR_VICR_CNTS_DIS      BIT(22)	/* Cntr Disable */
 #define TSI148_LCSR_VICR_CNTS_IRQ1     (2<<22)	/* IRQ1 to Cntr */
 #define TSI148_LCSR_VICR_CNTS_IRQ2     (3<<22)	/* IRQ2 to Cntr */
 
 #define TSI148_LCSR_VICR_EDGIS_M       (3<<20)	/* Edge interrupt MASK */
-#define TSI148_LCSR_VICR_EDGIS_DIS     (1<<20)	/* Edge interrupt Disable */
+#define TSI148_LCSR_VICR_EDGIS_DIS     BIT(20)	/* Edge interrupt Disable */
 #define TSI148_LCSR_VICR_EDGIS_IRQ1    (2<<20)	/* IRQ1 to Edge */
 #define TSI148_LCSR_VICR_EDGIS_IRQ2    (3<<20)	/* IRQ2 to Edge */
 
 #define TSI148_LCSR_VICR_IRQIF_M       (3<<18)	/* IRQ1* Function MASK */
-#define TSI148_LCSR_VICR_IRQIF_NORM    (1<<18)	/* Normal */
+#define TSI148_LCSR_VICR_IRQIF_NORM    BIT(18)	/* Normal */
 #define TSI148_LCSR_VICR_IRQIF_PULSE   (2<<18)	/* Pulse Generator */
 #define TSI148_LCSR_VICR_IRQIF_PROG    (3<<18)	/* Programmable Clock */
 #define TSI148_LCSR_VICR_IRQIF_1U      (4<<18)	/* 1us Clock */
 
 #define TSI148_LCSR_VICR_IRQ2F_M       (3<<16)	/* IRQ2* Function MASK */
-#define TSI148_LCSR_VICR_IRQ2F_NORM    (1<<16)	/* Normal */
+#define TSI148_LCSR_VICR_IRQ2F_NORM    BIT(16)	/* Normal */
 #define TSI148_LCSR_VICR_IRQ2F_PULSE   (2<<16)	/* Pulse Generator */
 #define TSI148_LCSR_VICR_IRQ2F_PROG    (3<<16)	/* Programmable Clock */
 #define TSI148_LCSR_VICR_IRQ2F_1U      (4<<16)	/* 1us Clock */
 
-#define TSI148_LCSR_VICR_BIP           (1<<15)	/* Broadcast Interrupt Pulse */
+#define TSI148_LCSR_VICR_BIP           BIT(15)	/* Broadcast Interrupt Pulse */
 
-#define TSI148_LCSR_VICR_IRQC          (1<<12)	/* VMEbus IRQ Clear */
-#define TSI148_LCSR_VICR_IRQS          (1<<11)	/* VMEbus IRQ Status */
+#define TSI148_LCSR_VICR_IRQC          BIT(12)	/* VMEbus IRQ Clear */
+#define TSI148_LCSR_VICR_IRQS          BIT(11)	/* VMEbus IRQ Status */
 
 #define TSI148_LCSR_VICR_IRQL_M        (7<<8)	/* VMEbus SW IRQ Level Mask */
-#define TSI148_LCSR_VICR_IRQL_1        (1<<8)	/* VMEbus SW IRQ Level 1 */
+#define TSI148_LCSR_VICR_IRQL_1        BIT(8)	/* VMEbus SW IRQ Level 1 */
 #define TSI148_LCSR_VICR_IRQL_2        (2<<8)	/* VMEbus SW IRQ Level 2 */
 #define TSI148_LCSR_VICR_IRQL_3        (3<<8)	/* VMEbus SW IRQ Level 3 */
 #define TSI148_LCSR_VICR_IRQL_4        (4<<8)	/* VMEbus SW IRQ Level 4 */
@@ -1014,29 +1014,29 @@ static const int TSI148_LCSR_VICR_IRQL[8] = { 0, TSI148_LCSR_VICR_IRQL_1,
 /*
  *  Interrupt Enable Register   CRG + $440
  */
-#define TSI148_LCSR_INTEN_DMA1EN       (1<<25)	/* DMAC 1 */
-#define TSI148_LCSR_INTEN_DMA0EN       (1<<24)	/* DMAC 0 */
-#define TSI148_LCSR_INTEN_LM3EN        (1<<23)	/* Location Monitor 3 */
-#define TSI148_LCSR_INTEN_LM2EN        (1<<22)	/* Location Monitor 2 */
-#define TSI148_LCSR_INTEN_LM1EN        (1<<21)	/* Location Monitor 1 */
-#define TSI148_LCSR_INTEN_LM0EN        (1<<20)	/* Location Monitor 0 */
-#define TSI148_LCSR_INTEN_MB3EN        (1<<19)	/* Mail Box 3 */
-#define TSI148_LCSR_INTEN_MB2EN        (1<<18)	/* Mail Box 2 */
-#define TSI148_LCSR_INTEN_MB1EN        (1<<17)	/* Mail Box 1 */
-#define TSI148_LCSR_INTEN_MB0EN        (1<<16)	/* Mail Box 0 */
-#define TSI148_LCSR_INTEN_PERREN       (1<<13)	/* PCI/X Error */
-#define TSI148_LCSR_INTEN_VERREN       (1<<12)	/* VMEbus Error */
-#define TSI148_LCSR_INTEN_VIEEN        (1<<11)	/* VMEbus IRQ Edge */
-#define TSI148_LCSR_INTEN_IACKEN       (1<<10)	/* IACK */
-#define TSI148_LCSR_INTEN_SYSFLEN      (1<<9)	/* System Fail */
-#define TSI148_LCSR_INTEN_ACFLEN       (1<<8)	/* AC Fail */
-#define TSI148_LCSR_INTEN_IRQ7EN       (1<<7)	/* IRQ7 */
-#define TSI148_LCSR_INTEN_IRQ6EN       (1<<6)	/* IRQ6 */
-#define TSI148_LCSR_INTEN_IRQ5EN       (1<<5)	/* IRQ5 */
-#define TSI148_LCSR_INTEN_IRQ4EN       (1<<4)	/* IRQ4 */
-#define TSI148_LCSR_INTEN_IRQ3EN       (1<<3)	/* IRQ3 */
-#define TSI148_LCSR_INTEN_IRQ2EN       (1<<2)	/* IRQ2 */
-#define TSI148_LCSR_INTEN_IRQ1EN       (1<<1)	/* IRQ1 */
+#define TSI148_LCSR_INTEN_DMA1EN       BIT(25)	/* DMAC 1 */
+#define TSI148_LCSR_INTEN_DMA0EN       BIT(24)	/* DMAC 0 */
+#define TSI148_LCSR_INTEN_LM3EN        BIT(23)	/* Location Monitor 3 */
+#define TSI148_LCSR_INTEN_LM2EN        BIT(22)	/* Location Monitor 2 */
+#define TSI148_LCSR_INTEN_LM1EN        BIT(21)	/* Location Monitor 1 */
+#define TSI148_LCSR_INTEN_LM0EN        BIT(20)	/* Location Monitor 0 */
+#define TSI148_LCSR_INTEN_MB3EN        BIT(19)	/* Mail Box 3 */
+#define TSI148_LCSR_INTEN_MB2EN        BIT(18)	/* Mail Box 2 */
+#define TSI148_LCSR_INTEN_MB1EN        BIT(17)	/* Mail Box 1 */
+#define TSI148_LCSR_INTEN_MB0EN        BIT(16)	/* Mail Box 0 */
+#define TSI148_LCSR_INTEN_PERREN       BIT(13)	/* PCI/X Error */
+#define TSI148_LCSR_INTEN_VERREN       BIT(12)	/* VMEbus Error */
+#define TSI148_LCSR_INTEN_VIEEN        BIT(11)	/* VMEbus IRQ Edge */
+#define TSI148_LCSR_INTEN_IACKEN       BIT(10)	/* IACK */
+#define TSI148_LCSR_INTEN_SYSFLEN      BIT(9)	/* System Fail */
+#define TSI148_LCSR_INTEN_ACFLEN       BIT(8)	/* AC Fail */
+#define TSI148_LCSR_INTEN_IRQ7EN       BIT(7)	/* IRQ7 */
+#define TSI148_LCSR_INTEN_IRQ6EN       BIT(6)	/* IRQ6 */
+#define TSI148_LCSR_INTEN_IRQ5EN       BIT(5)	/* IRQ5 */
+#define TSI148_LCSR_INTEN_IRQ4EN       BIT(4)	/* IRQ4 */
+#define TSI148_LCSR_INTEN_IRQ3EN       BIT(3)	/* IRQ3 */
+#define TSI148_LCSR_INTEN_IRQ2EN       BIT(2)	/* IRQ2 */
+#define TSI148_LCSR_INTEN_IRQ1EN       BIT(1)	/* IRQ1 */
 
 static const int TSI148_LCSR_INTEN_LMEN[4] = { TSI148_LCSR_INTEN_LM0EN,
 					TSI148_LCSR_INTEN_LM1EN,
@@ -1054,29 +1054,29 @@ static const int TSI148_LCSR_INTEN_IRQEN[7] = { TSI148_LCSR_INTEN_IRQ1EN,
 /*
  *  Interrupt Enable Out Register CRG + $444
  */
-#define TSI148_LCSR_INTEO_DMA1EO       (1<<25)	/* DMAC 1 */
-#define TSI148_LCSR_INTEO_DMA0EO       (1<<24)	/* DMAC 0 */
-#define TSI148_LCSR_INTEO_LM3EO        (1<<23)	/* Loc Monitor 3 */
-#define TSI148_LCSR_INTEO_LM2EO        (1<<22)	/* Loc Monitor 2 */
-#define TSI148_LCSR_INTEO_LM1EO        (1<<21)	/* Loc Monitor 1 */
-#define TSI148_LCSR_INTEO_LM0EO        (1<<20)	/* Location Monitor 0 */
-#define TSI148_LCSR_INTEO_MB3EO        (1<<19)	/* Mail Box 3 */
-#define TSI148_LCSR_INTEO_MB2EO        (1<<18)	/* Mail Box 2 */
-#define TSI148_LCSR_INTEO_MB1EO        (1<<17)	/* Mail Box 1 */
-#define TSI148_LCSR_INTEO_MB0EO        (1<<16)	/* Mail Box 0 */
-#define TSI148_LCSR_INTEO_PERREO       (1<<13)	/* PCI/X Error */
-#define TSI148_LCSR_INTEO_VERREO       (1<<12)	/* VMEbus Error */
-#define TSI148_LCSR_INTEO_VIEEO        (1<<11)	/* VMEbus IRQ Edge */
-#define TSI148_LCSR_INTEO_IACKEO       (1<<10)	/* IACK */
-#define TSI148_LCSR_INTEO_SYSFLEO      (1<<9)	/* System Fail */
-#define TSI148_LCSR_INTEO_ACFLEO       (1<<8)	/* AC Fail */
-#define TSI148_LCSR_INTEO_IRQ7EO       (1<<7)	/* IRQ7 */
-#define TSI148_LCSR_INTEO_IRQ6EO       (1<<6)	/* IRQ6 */
-#define TSI148_LCSR_INTEO_IRQ5EO       (1<<5)	/* IRQ5 */
-#define TSI148_LCSR_INTEO_IRQ4EO       (1<<4)	/* IRQ4 */
-#define TSI148_LCSR_INTEO_IRQ3EO       (1<<3)	/* IRQ3 */
-#define TSI148_LCSR_INTEO_IRQ2EO       (1<<2)	/* IRQ2 */
-#define TSI148_LCSR_INTEO_IRQ1EO       (1<<1)	/* IRQ1 */
+#define TSI148_LCSR_INTEO_DMA1EO       BIT(25)	/* DMAC 1 */
+#define TSI148_LCSR_INTEO_DMA0EO       BIT(24)	/* DMAC 0 */
+#define TSI148_LCSR_INTEO_LM3EO        BIT(23)	/* Loc Monitor 3 */
+#define TSI148_LCSR_INTEO_LM2EO        BIT(22)	/* Loc Monitor 2 */
+#define TSI148_LCSR_INTEO_LM1EO        BIT(21)	/* Loc Monitor 1 */
+#define TSI148_LCSR_INTEO_LM0EO        BIT(20)	/* Location Monitor 0 */
+#define TSI148_LCSR_INTEO_MB3EO        BIT(19)	/* Mail Box 3 */
+#define TSI148_LCSR_INTEO_MB2EO        BIT(18)	/* Mail Box 2 */
+#define TSI148_LCSR_INTEO_MB1EO        BIT(17)	/* Mail Box 1 */
+#define TSI148_LCSR_INTEO_MB0EO        BIT(16)	/* Mail Box 0 */
+#define TSI148_LCSR_INTEO_PERREO       BIT(13)	/* PCI/X Error */
+#define TSI148_LCSR_INTEO_VERREO       BIT(12)	/* VMEbus Error */
+#define TSI148_LCSR_INTEO_VIEEO        BIT(11)	/* VMEbus IRQ Edge */
+#define TSI148_LCSR_INTEO_IACKEO       BIT(10)	/* IACK */
+#define TSI148_LCSR_INTEO_SYSFLEO      BIT(9)	/* System Fail */
+#define TSI148_LCSR_INTEO_ACFLEO       BIT(8)	/* AC Fail */
+#define TSI148_LCSR_INTEO_IRQ7EO       BIT(7)	/* IRQ7 */
+#define TSI148_LCSR_INTEO_IRQ6EO       BIT(6)	/* IRQ6 */
+#define TSI148_LCSR_INTEO_IRQ5EO       BIT(5)	/* IRQ5 */
+#define TSI148_LCSR_INTEO_IRQ4EO       BIT(4)	/* IRQ4 */
+#define TSI148_LCSR_INTEO_IRQ3EO       BIT(3)	/* IRQ3 */
+#define TSI148_LCSR_INTEO_IRQ2EO       BIT(2)	/* IRQ2 */
+#define TSI148_LCSR_INTEO_IRQ1EO       BIT(1)	/* IRQ1 */
 
 static const int TSI148_LCSR_INTEO_LMEO[4] = { TSI148_LCSR_INTEO_LM0EO,
 					TSI148_LCSR_INTEO_LM1EO,
@@ -1094,29 +1094,29 @@ static const int TSI148_LCSR_INTEO_IRQEO[7] = { TSI148_LCSR_INTEO_IRQ1EO,
 /*
  *  Interrupt Status Register CRG + $448
  */
-#define TSI148_LCSR_INTS_DMA1S         (1<<25)	/* DMA 1 */
-#define TSI148_LCSR_INTS_DMA0S         (1<<24)	/* DMA 0 */
-#define TSI148_LCSR_INTS_LM3S          (1<<23)	/* Location Monitor 3 */
-#define TSI148_LCSR_INTS_LM2S          (1<<22)	/* Location Monitor 2 */
-#define TSI148_LCSR_INTS_LM1S          (1<<21)	/* Location Monitor 1 */
-#define TSI148_LCSR_INTS_LM0S          (1<<20)	/* Location Monitor 0 */
-#define TSI148_LCSR_INTS_MB3S          (1<<19)	/* Mail Box 3 */
-#define TSI148_LCSR_INTS_MB2S          (1<<18)	/* Mail Box 2 */
-#define TSI148_LCSR_INTS_MB1S          (1<<17)	/* Mail Box 1 */
-#define TSI148_LCSR_INTS_MB0S          (1<<16)	/* Mail Box 0 */
-#define TSI148_LCSR_INTS_PERRS         (1<<13)	/* PCI/X Error */
-#define TSI148_LCSR_INTS_VERRS         (1<<12)	/* VMEbus Error */
-#define TSI148_LCSR_INTS_VIES          (1<<11)	/* VMEbus IRQ Edge */
-#define TSI148_LCSR_INTS_IACKS         (1<<10)	/* IACK */
-#define TSI148_LCSR_INTS_SYSFLS        (1<<9)	/* System Fail */
-#define TSI148_LCSR_INTS_ACFLS         (1<<8)	/* AC Fail */
-#define TSI148_LCSR_INTS_IRQ7S         (1<<7)	/* IRQ7 */
-#define TSI148_LCSR_INTS_IRQ6S         (1<<6)	/* IRQ6 */
-#define TSI148_LCSR_INTS_IRQ5S         (1<<5)	/* IRQ5 */
-#define TSI148_LCSR_INTS_IRQ4S         (1<<4)	/* IRQ4 */
-#define TSI148_LCSR_INTS_IRQ3S         (1<<3)	/* IRQ3 */
-#define TSI148_LCSR_INTS_IRQ2S         (1<<2)	/* IRQ2 */
-#define TSI148_LCSR_INTS_IRQ1S         (1<<1)	/* IRQ1 */
+#define TSI148_LCSR_INTS_DMA1S         BIT(25)	/* DMA 1 */
+#define TSI148_LCSR_INTS_DMA0S         BIT(24)	/* DMA 0 */
+#define TSI148_LCSR_INTS_LM3S          BIT(23)	/* Location Monitor 3 */
+#define TSI148_LCSR_INTS_LM2S          BIT(22)	/* Location Monitor 2 */
+#define TSI148_LCSR_INTS_LM1S          BIT(21)	/* Location Monitor 1 */
+#define TSI148_LCSR_INTS_LM0S          BIT(20)	/* Location Monitor 0 */
+#define TSI148_LCSR_INTS_MB3S          BIT(19)	/* Mail Box 3 */
+#define TSI148_LCSR_INTS_MB2S          BIT(18)	/* Mail Box 2 */
+#define TSI148_LCSR_INTS_MB1S          BIT(17)	/* Mail Box 1 */
+#define TSI148_LCSR_INTS_MB0S          BIT(16)	/* Mail Box 0 */
+#define TSI148_LCSR_INTS_PERRS         BIT(13)	/* PCI/X Error */
+#define TSI148_LCSR_INTS_VERRS         BIT(12)	/* VMEbus Error */
+#define TSI148_LCSR_INTS_VIES          BIT(11)	/* VMEbus IRQ Edge */
+#define TSI148_LCSR_INTS_IACKS         BIT(10)	/* IACK */
+#define TSI148_LCSR_INTS_SYSFLS        BIT(9)	/* System Fail */
+#define TSI148_LCSR_INTS_ACFLS         BIT(8)	/* AC Fail */
+#define TSI148_LCSR_INTS_IRQ7S         BIT(7)	/* IRQ7 */
+#define TSI148_LCSR_INTS_IRQ6S         BIT(6)	/* IRQ6 */
+#define TSI148_LCSR_INTS_IRQ5S         BIT(5)	/* IRQ5 */
+#define TSI148_LCSR_INTS_IRQ4S         BIT(4)	/* IRQ4 */
+#define TSI148_LCSR_INTS_IRQ3S         BIT(3)	/* IRQ3 */
+#define TSI148_LCSR_INTS_IRQ2S         BIT(2)	/* IRQ2 */
+#define TSI148_LCSR_INTS_IRQ1S         BIT(1)	/* IRQ1 */
 
 static const int TSI148_LCSR_INTS_LMS[4] = { TSI148_LCSR_INTS_LM0S,
 					TSI148_LCSR_INTS_LM1S,
@@ -1131,22 +1131,22 @@ static const int TSI148_LCSR_INTS_MBS[4] = { TSI148_LCSR_INTS_MB0S,
 /*
  *  Interrupt Clear Register CRG + $44C
  */
-#define TSI148_LCSR_INTC_DMA1C         (1<<25)	/* DMA 1 */
-#define TSI148_LCSR_INTC_DMA0C         (1<<24)	/* DMA 0 */
-#define TSI148_LCSR_INTC_LM3C          (1<<23)	/* Location Monitor 3 */
-#define TSI148_LCSR_INTC_LM2C          (1<<22)	/* Location Monitor 2 */
-#define TSI148_LCSR_INTC_LM1C          (1<<21)	/* Location Monitor 1 */
-#define TSI148_LCSR_INTC_LM0C          (1<<20)	/* Location Monitor 0 */
-#define TSI148_LCSR_INTC_MB3C          (1<<19)	/* Mail Box 3 */
-#define TSI148_LCSR_INTC_MB2C          (1<<18)	/* Mail Box 2 */
-#define TSI148_LCSR_INTC_MB1C          (1<<17)	/* Mail Box 1 */
-#define TSI148_LCSR_INTC_MB0C          (1<<16)	/* Mail Box 0 */
-#define TSI148_LCSR_INTC_PERRC         (1<<13)	/* VMEbus Error */
-#define TSI148_LCSR_INTC_VERRC         (1<<12)	/* VMEbus Access Time-out */
-#define TSI148_LCSR_INTC_VIEC          (1<<11)	/* VMEbus IRQ Edge */
-#define TSI148_LCSR_INTC_IACKC         (1<<10)	/* IACK */
-#define TSI148_LCSR_INTC_SYSFLC        (1<<9)	/* System Fail */
-#define TSI148_LCSR_INTC_ACFLC         (1<<8)	/* AC Fail */
+#define TSI148_LCSR_INTC_DMA1C         BIT(25)	/* DMA 1 */
+#define TSI148_LCSR_INTC_DMA0C         BIT(24)	/* DMA 0 */
+#define TSI148_LCSR_INTC_LM3C          BIT(23)	/* Location Monitor 3 */
+#define TSI148_LCSR_INTC_LM2C          BIT(22)	/* Location Monitor 2 */
+#define TSI148_LCSR_INTC_LM1C          BIT(21)	/* Location Monitor 1 */
+#define TSI148_LCSR_INTC_LM0C          BIT(20)	/* Location Monitor 0 */
+#define TSI148_LCSR_INTC_MB3C          BIT(19)	/* Mail Box 3 */
+#define TSI148_LCSR_INTC_MB2C          BIT(18)	/* Mail Box 2 */
+#define TSI148_LCSR_INTC_MB1C          BIT(17)	/* Mail Box 1 */
+#define TSI148_LCSR_INTC_MB0C          BIT(16)	/* Mail Box 0 */
+#define TSI148_LCSR_INTC_PERRC         BIT(13)	/* VMEbus Error */
+#define TSI148_LCSR_INTC_VERRC         BIT(12)	/* VMEbus Access Time-out */
+#define TSI148_LCSR_INTC_VIEC          BIT(11)	/* VMEbus IRQ Edge */
+#define TSI148_LCSR_INTC_IACKC         BIT(10)	/* IACK */
+#define TSI148_LCSR_INTC_SYSFLC        BIT(9)	/* System Fail */
+#define TSI148_LCSR_INTC_ACFLC         BIT(8)	/* AC Fail */
 
 static const int TSI148_LCSR_INTC_LMC[4] = { TSI148_LCSR_INTC_LM0C,
 					TSI148_LCSR_INTC_LM1C,
@@ -1192,15 +1192,15 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 /*
  *  DMA Control (0-1) Registers CRG + $500
  */
-#define TSI148_LCSR_DCTL_ABT           (1<<27)	/* Abort */
-#define TSI148_LCSR_DCTL_PAU           (1<<26)	/* Pause */
-#define TSI148_LCSR_DCTL_DGO           (1<<25)	/* DMA Go */
+#define TSI148_LCSR_DCTL_ABT           BIT(27)	/* Abort */
+#define TSI148_LCSR_DCTL_PAU           BIT(26)	/* Pause */
+#define TSI148_LCSR_DCTL_DGO           BIT(25)	/* DMA Go */
 
-#define TSI148_LCSR_DCTL_MOD           (1<<23)	/* Mode */
+#define TSI148_LCSR_DCTL_MOD           BIT(23)	/* Mode */
 
 #define TSI148_LCSR_DCTL_VBKS_M        (7<<12)	/* VMEbus block Size MASK */
 #define TSI148_LCSR_DCTL_VBKS_32       (0<<12)	/* VMEbus block Size 32 */
-#define TSI148_LCSR_DCTL_VBKS_64       (1<<12)	/* VMEbus block Size 64 */
+#define TSI148_LCSR_DCTL_VBKS_64       BIT(12)	/* VMEbus block Size 64 */
 #define TSI148_LCSR_DCTL_VBKS_128      (2<<12)	/* VMEbus block Size 128 */
 #define TSI148_LCSR_DCTL_VBKS_256      (3<<12)	/* VMEbus block Size 256 */
 #define TSI148_LCSR_DCTL_VBKS_512      (4<<12)	/* VMEbus block Size 512 */
@@ -1210,7 +1210,7 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 
 #define TSI148_LCSR_DCTL_VBOT_M        (7<<8)	/* VMEbus back-off MASK */
 #define TSI148_LCSR_DCTL_VBOT_0        (0<<8)	/* VMEbus back-off  0us */
-#define TSI148_LCSR_DCTL_VBOT_1        (1<<8)	/* VMEbus back-off 1us */
+#define TSI148_LCSR_DCTL_VBOT_1        BIT(8)	/* VMEbus back-off 1us */
 #define TSI148_LCSR_DCTL_VBOT_2        (2<<8)	/* VMEbus back-off 2us */
 #define TSI148_LCSR_DCTL_VBOT_4        (3<<8)	/* VMEbus back-off 4us */
 #define TSI148_LCSR_DCTL_VBOT_8        (4<<8)	/* VMEbus back-off 8us */
@@ -1220,7 +1220,7 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 
 #define TSI148_LCSR_DCTL_PBKS_M        (7<<4)	/* PCI block size MASK */
 #define TSI148_LCSR_DCTL_PBKS_32       (0<<4)	/* PCI block size 32 bytes */
-#define TSI148_LCSR_DCTL_PBKS_64       (1<<4)	/* PCI block size 64 bytes */
+#define TSI148_LCSR_DCTL_PBKS_64       BIT(4)	/* PCI block size 64 bytes */
 #define TSI148_LCSR_DCTL_PBKS_128      (2<<4)	/* PCI block size 128 bytes */
 #define TSI148_LCSR_DCTL_PBKS_256      (3<<4)	/* PCI block size 256 bytes */
 #define TSI148_LCSR_DCTL_PBKS_512      (4<<4)	/* PCI block size 512 bytes */
@@ -1230,7 +1230,7 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 
 #define TSI148_LCSR_DCTL_PBOT_M        (7<<0)	/* PCI back off MASK */
 #define TSI148_LCSR_DCTL_PBOT_0        (0<<0)	/* PCI back off 0us */
-#define TSI148_LCSR_DCTL_PBOT_1        (1<<0)	/* PCI back off 1us */
+#define TSI148_LCSR_DCTL_PBOT_1        BIT(0)	/* PCI back off 1us */
 #define TSI148_LCSR_DCTL_PBOT_2        (2<<0)	/* PCI back off 2us */
 #define TSI148_LCSR_DCTL_PBOT_4        (3<<0)	/* PCI back off 3us */
 #define TSI148_LCSR_DCTL_PBOT_8        (4<<0)	/* PCI back off 4us */
@@ -1241,14 +1241,14 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 /*
  *  DMA Status Registers (0-1)  CRG + $504
  */
-#define TSI148_LCSR_DSTA_SMA           (1<<31)	/* PCI Signalled Master Abt */
-#define TSI148_LCSR_DSTA_RTA           (1<<30)	/* PCI Received Target Abt */
-#define TSI148_LCSR_DSTA_MRC           (1<<29)	/* PCI Max Retry Count */
-#define TSI148_LCSR_DSTA_VBE           (1<<28)	/* VMEbus error */
-#define TSI148_LCSR_DSTA_ABT           (1<<27)	/* Abort */
-#define TSI148_LCSR_DSTA_PAU           (1<<26)	/* Pause */
-#define TSI148_LCSR_DSTA_DON           (1<<25)	/* Done */
-#define TSI148_LCSR_DSTA_BSY           (1<<24)	/* Busy */
+#define TSI148_LCSR_DSTA_SMA           BIT(31)	/* PCI Signalled Master Abt */
+#define TSI148_LCSR_DSTA_RTA           BIT(30)	/* PCI Received Target Abt */
+#define TSI148_LCSR_DSTA_MRC           BIT(29)	/* PCI Max Retry Count */
+#define TSI148_LCSR_DSTA_VBE           BIT(28)	/* VMEbus error */
+#define TSI148_LCSR_DSTA_ABT           BIT(27)	/* Abort */
+#define TSI148_LCSR_DSTA_PAU           BIT(26)	/* Pause */
+#define TSI148_LCSR_DSTA_DON           BIT(25)	/* Done */
+#define TSI148_LCSR_DSTA_BSY           BIT(24)	/* Busy */
 
 /*
  *  DMA Current Link Address Lower (0-1)
@@ -1260,20 +1260,20 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
  */
 #define TSI148_LCSR_DSAT_TYP_M         (3<<28)	/* Source Bus Type */
 #define TSI148_LCSR_DSAT_TYP_PCI       (0<<28)	/* PCI Bus */
-#define TSI148_LCSR_DSAT_TYP_VME       (1<<28)	/* VMEbus */
+#define TSI148_LCSR_DSAT_TYP_VME       BIT(28)	/* VMEbus */
 #define TSI148_LCSR_DSAT_TYP_PAT       (2<<28)	/* Data Pattern */
 
-#define TSI148_LCSR_DSAT_PSZ           (1<<25)	/* Pattern Size */
-#define TSI148_LCSR_DSAT_NIN           (1<<24)	/* No Increment */
+#define TSI148_LCSR_DSAT_PSZ           BIT(25)	/* Pattern Size */
+#define TSI148_LCSR_DSAT_NIN           BIT(24)	/* No Increment */
 
 #define TSI148_LCSR_DSAT_2eSSTM_M      (3<<11)	/* 2eSST Trans Rate Mask */
 #define TSI148_LCSR_DSAT_2eSSTM_160    (0<<11)	/* 160 MB/s */
-#define TSI148_LCSR_DSAT_2eSSTM_267    (1<<11)	/* 267 MB/s */
+#define TSI148_LCSR_DSAT_2eSSTM_267    BIT(11)	/* 267 MB/s */
 #define TSI148_LCSR_DSAT_2eSSTM_320    (2<<11)	/* 320 MB/s */
 
 #define TSI148_LCSR_DSAT_TM_M          (7<<8)	/* Bus Transfer Protocol Mask */
 #define TSI148_LCSR_DSAT_TM_SCT        (0<<8)	/* SCT */
-#define TSI148_LCSR_DSAT_TM_BLT        (1<<8)	/* BLT */
+#define TSI148_LCSR_DSAT_TM_BLT        BIT(8)	/* BLT */
 #define TSI148_LCSR_DSAT_TM_MBLT       (2<<8)	/* MBLT */
 #define TSI148_LCSR_DSAT_TM_2eVME      (3<<8)	/* 2eVME */
 #define TSI148_LCSR_DSAT_TM_2eSST      (4<<8)	/* 2eSST */
@@ -1281,14 +1281,14 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 
 #define TSI148_LCSR_DSAT_DBW_M         (3<<6)	/* Max Data Width MASK */
 #define TSI148_LCSR_DSAT_DBW_16        (0<<6)	/* 16 Bits */
-#define TSI148_LCSR_DSAT_DBW_32        (1<<6)	/* 32 Bits */
+#define TSI148_LCSR_DSAT_DBW_32        BIT(6)	/* 32 Bits */
 
-#define TSI148_LCSR_DSAT_SUP           (1<<5)	/* Supervisory Mode */
-#define TSI148_LCSR_DSAT_PGM           (1<<4)	/* Program Mode */
+#define TSI148_LCSR_DSAT_SUP           BIT(5)	/* Supervisory Mode */
+#define TSI148_LCSR_DSAT_PGM           BIT(4)	/* Program Mode */
 
 #define TSI148_LCSR_DSAT_AMODE_M       (0xf<<0)	/* Address Space Mask */
 #define TSI148_LCSR_DSAT_AMODE_A16     (0<<0)	/* A16 */
-#define TSI148_LCSR_DSAT_AMODE_A24     (1<<0)	/* A24 */
+#define TSI148_LCSR_DSAT_AMODE_A24     BIT(0)	/* A24 */
 #define TSI148_LCSR_DSAT_AMODE_A32     (2<<0)	/* A32 */
 #define TSI148_LCSR_DSAT_AMODE_A64     (4<<0)	/* A64 */
 #define TSI148_LCSR_DSAT_AMODE_CRCSR   (5<<0)	/* CR/CSR */
@@ -1301,16 +1301,16 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
  *  DMA Destination Attribute Registers (0-1)
  */
 #define TSI148_LCSR_DDAT_TYP_PCI       (0<<28)	/* Destination PCI Bus  */
-#define TSI148_LCSR_DDAT_TYP_VME       (1<<28)	/* Destination VMEbus */
+#define TSI148_LCSR_DDAT_TYP_VME       BIT(28)	/* Destination VMEbus */
 
 #define TSI148_LCSR_DDAT_2eSSTM_M      (3<<11)	/* 2eSST Transfer Rate Mask */
 #define TSI148_LCSR_DDAT_2eSSTM_160    (0<<11)	/* 160 MB/s */
-#define TSI148_LCSR_DDAT_2eSSTM_267    (1<<11)	/* 267 MB/s */
+#define TSI148_LCSR_DDAT_2eSSTM_267    BIT(11)	/* 267 MB/s */
 #define TSI148_LCSR_DDAT_2eSSTM_320    (2<<11)	/* 320 MB/s */
 
 #define TSI148_LCSR_DDAT_TM_M          (7<<8)	/* Bus Transfer Protocol Mask */
 #define TSI148_LCSR_DDAT_TM_SCT        (0<<8)	/* SCT */
-#define TSI148_LCSR_DDAT_TM_BLT        (1<<8)	/* BLT */
+#define TSI148_LCSR_DDAT_TM_BLT        BIT(8)	/* BLT */
 #define TSI148_LCSR_DDAT_TM_MBLT       (2<<8)	/* MBLT */
 #define TSI148_LCSR_DDAT_TM_2eVME      (3<<8)	/* 2eVME */
 #define TSI148_LCSR_DDAT_TM_2eSST      (4<<8)	/* 2eSST */
@@ -1318,14 +1318,14 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 
 #define TSI148_LCSR_DDAT_DBW_M         (3<<6)	/* Max Data Width MASK */
 #define TSI148_LCSR_DDAT_DBW_16        (0<<6)	/* 16 Bits */
-#define TSI148_LCSR_DDAT_DBW_32        (1<<6)	/* 32 Bits */
+#define TSI148_LCSR_DDAT_DBW_32        BIT(6)	/* 32 Bits */
 
-#define TSI148_LCSR_DDAT_SUP           (1<<5)	/* Supervisory/User Access */
-#define TSI148_LCSR_DDAT_PGM           (1<<4)	/* Program/Data Access */
+#define TSI148_LCSR_DDAT_SUP           BIT(5)	/* Supervisory/User Access */
+#define TSI148_LCSR_DDAT_PGM           BIT(4)	/* Program/Data Access */
 
 #define TSI148_LCSR_DDAT_AMODE_M       (0xf<<0)	/* Address Space Mask */
 #define TSI148_LCSR_DDAT_AMODE_A16      (0<<0)	/* A16 */
-#define TSI148_LCSR_DDAT_AMODE_A24      (1<<0)	/* A24 */
+#define TSI148_LCSR_DDAT_AMODE_A24      BIT(0)	/* A24 */
 #define TSI148_LCSR_DDAT_AMODE_A32      (2<<0)	/* A32 */
 #define TSI148_LCSR_DDAT_AMODE_A64      (4<<0)	/* A64 */
 #define TSI148_LCSR_DDAT_AMODE_CRCSR   (5<<0)	/* CRC/SR */
@@ -1338,7 +1338,7 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
  *  DMA Next Link Address Lower
  */
 #define TSI148_LCSR_DNLAL_DNLAL_M      (0x3FFFFFF<<6)	/* Address Mask */
-#define TSI148_LCSR_DNLAL_LLA          (1<<0)  /* Last Link Address Indicator */
+#define TSI148_LCSR_DNLAL_LLA          BIT(0)  /* Last Link Address Indicator */
 
 /*
  *  DMA 2eSST Broadcast Select
@@ -1352,22 +1352,22 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 /*
  *  GCSR Control and Status Register  CRG + $604
  */
-#define TSI148_GCSR_GCTRL_LRST         (1<<15)	/* Local Reset */
-#define TSI148_GCSR_GCTRL_SFAILEN      (1<<14)	/* System Fail enable */
-#define TSI148_GCSR_GCTRL_BDFAILS      (1<<13)	/* Board Fail Status */
-#define TSI148_GCSR_GCTRL_SCON         (1<<12)	/* System Copntroller */
-#define TSI148_GCSR_GCTRL_MEN          (1<<11)	/* Module Enable (READY) */
-
-#define TSI148_GCSR_GCTRL_LMI3S        (1<<7)	/* Loc Monitor 3 Int Status */
-#define TSI148_GCSR_GCTRL_LMI2S        (1<<6)	/* Loc Monitor 2 Int Status */
-#define TSI148_GCSR_GCTRL_LMI1S        (1<<5)	/* Loc Monitor 1 Int Status */
-#define TSI148_GCSR_GCTRL_LMI0S        (1<<4)	/* Loc Monitor 0 Int Status */
-#define TSI148_GCSR_GCTRL_MBI3S        (1<<3)	/* Mail box 3 Int Status */
-#define TSI148_GCSR_GCTRL_MBI2S        (1<<2)	/* Mail box 2 Int Status */
-#define TSI148_GCSR_GCTRL_MBI1S        (1<<1)	/* Mail box 1 Int Status */
-#define TSI148_GCSR_GCTRL_MBI0S        (1<<0)	/* Mail box 0 Int Status */
-
-#define TSI148_GCSR_GAP                (1<<5)	/* Geographic Addr Parity */
+#define TSI148_GCSR_GCTRL_LRST         BIT(15)	/* Local Reset */
+#define TSI148_GCSR_GCTRL_SFAILEN      BIT(14)	/* System Fail enable */
+#define TSI148_GCSR_GCTRL_BDFAILS      BIT(13)	/* Board Fail Status */
+#define TSI148_GCSR_GCTRL_SCON         BIT(12)	/* System Copntroller */
+#define TSI148_GCSR_GCTRL_MEN          BIT(11)	/* Module Enable (READY) */
+
+#define TSI148_GCSR_GCTRL_LMI3S        BIT(7)	/* Loc Monitor 3 Int Status */
+#define TSI148_GCSR_GCTRL_LMI2S        BIT(6)	/* Loc Monitor 2 Int Status */
+#define TSI148_GCSR_GCTRL_LMI1S        BIT(5)	/* Loc Monitor 1 Int Status */
+#define TSI148_GCSR_GCTRL_LMI0S        BIT(4)	/* Loc Monitor 0 Int Status */
+#define TSI148_GCSR_GCTRL_MBI3S        BIT(3)	/* Mail box 3 Int Status */
+#define TSI148_GCSR_GCTRL_MBI2S        BIT(2)	/* Mail box 2 Int Status */
+#define TSI148_GCSR_GCTRL_MBI1S        BIT(1)	/* Mail box 1 Int Status */
+#define TSI148_GCSR_GCTRL_MBI0S        BIT(0)	/* Mail box 0 Int Status */
+
+#define TSI148_GCSR_GAP                BIT(5)	/* Geographic Addr Parity */
 #define TSI148_GCSR_GA_M               (0x1F<<0)  /* Geographic Address Mask */
 
 /*
@@ -1377,20 +1377,20 @@ static const int TSI148_LCSR_INTC_MBC[4] = { TSI148_LCSR_INTC_MB0C,
 /*
  *  CR/CSR Bit Clear Register CRG + $FF4
  */
-#define TSI148_CRCSR_CSRBCR_LRSTC      (1<<7)	/* Local Reset Clear */
-#define TSI148_CRCSR_CSRBCR_SFAILC     (1<<6)	/* System Fail Enable Clear */
-#define TSI148_CRCSR_CSRBCR_BDFAILS    (1<<5)	/* Board Fail Status */
-#define TSI148_CRCSR_CSRBCR_MENC       (1<<4)	/* Module Enable Clear */
-#define TSI148_CRCSR_CSRBCR_BERRSC     (1<<3)	/* Bus Error Status Clear */
+#define TSI148_CRCSR_CSRBCR_LRSTC      BIT(7)	/* Local Reset Clear */
+#define TSI148_CRCSR_CSRBCR_SFAILC     BIT(6)	/* System Fail Enable Clear */
+#define TSI148_CRCSR_CSRBCR_BDFAILS    BIT(5)	/* Board Fail Status */
+#define TSI148_CRCSR_CSRBCR_MENC       BIT(4)	/* Module Enable Clear */
+#define TSI148_CRCSR_CSRBCR_BERRSC     BIT(3)	/* Bus Error Status Clear */
 
 /*
  *  CR/CSR Bit Set Register CRG+$FF8
  */
-#define TSI148_CRCSR_CSRBSR_LISTS      (1<<7)	/* Local Reset Clear */
-#define TSI148_CRCSR_CSRBSR_SFAILS     (1<<6)	/* System Fail Enable Clear */
-#define TSI148_CRCSR_CSRBSR_BDFAILS    (1<<5)	/* Board Fail Status */
-#define TSI148_CRCSR_CSRBSR_MENS       (1<<4)	/* Module Enable Clear */
-#define TSI148_CRCSR_CSRBSR_BERRS      (1<<3)	/* Bus Error Status Clear */
+#define TSI148_CRCSR_CSRBSR_LISTS      BIT(7)	/* Local Reset Clear */
+#define TSI148_CRCSR_CSRBSR_SFAILS     BIT(6)	/* System Fail Enable Clear */
+#define TSI148_CRCSR_CSRBSR_BDFAILS    BIT(5)	/* Board Fail Status */
+#define TSI148_CRCSR_CSRBSR_MENS       BIT(4)	/* Module Enable Clear */
+#define TSI148_CRCSR_CSRBSR_BERRS      BIT(3)	/* Bus Error Status Clear */
 
 /*
  *  CR/CSR Base Address Register CRG + FFC
-- 
2.31.1

