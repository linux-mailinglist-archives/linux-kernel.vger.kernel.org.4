Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4726CF00C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjC2RCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjC2RB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:01:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F719B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:01:57 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TG85tG002684;
        Wed, 29 Mar 2023 17:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=F9yX2WC6VArjVxIghV6sIzckH95iX1QSVi05tlWgbHg=;
 b=Y0oc8K2gRL4k5zv8/v+Ob+su8MzKbeOrCOZxWtPazEuyRDSns1gqOQtVIQZ38zNqSgYA
 RP1Ria4XE9AzJhc9UETY/PBD6ft3SsNSe3q42tx6+8OdlmX91WB1bkkrOPWz+VpJwK0k
 OfWDzS0/pF6tT5vsi0muruYfj7r5d3eWOvwuYimiIhtjjy+y0dCixZ7glzzHKe26gYQD
 fTon2ugRxM5ksfuCesrdP3+MA87THcRXuLXgEOl8ksknbAG28EB53xnFBvD5NC5PP3fY
 zwFPavwvBqIJKVb/idC2Wicc+GM45g9jx+RSirUpz8My5X81prDFBFDmsE2tPrZ+Cf9b lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmn83g0kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32TG0Jnf030259;
        Wed, 29 Mar 2023 17:01:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmn83g0jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32SMITZE019492;
        Wed, 29 Mar 2023 17:01:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3phrk6n5rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32TH1mLL17826472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 17:01:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FA3A2004E;
        Wed, 29 Mar 2023 17:01:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91E9120043;
        Wed, 29 Mar 2023 17:01:46 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.61.88])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Mar 2023 17:01:46 +0000 (GMT)
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     abhirupdeb@linux.vnet.ibm.com
Subject: [PATCH 1/5] staging: r8188eu: add blank line after declaration
Date:   Wed, 29 Mar 2023 22:31:35 +0530
Message-Id: <96d80bac35397888da089268a50a0528d7acd84a.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
References: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z7yZkJwFlHnAP52bN6TrwPSXxYhU1pWa
X-Proofpoint-GUID: rvLWfVI9GaKwc9eIwT2ButVneT8C_jEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290128
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank line after variable declaration to improve
code-readability and resolve checkpatch warnings.

checkpatch warning produced:

WARNING: Missing a blank line after declarations

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d28b4dc2a767..2ba1c1b25a76 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -93,6 +93,7 @@ u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 
 	/*  HW Power on sequence */
 	struct hal_data_8188e *haldata = &adapt->haldata;
+
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
@@ -295,6 +296,7 @@ static void _InitTransferPageSize(struct adapter *Adapter)
 	/*  Tx page size is always 128. */
 
 	u8 value8;
+
 	value8 = _PSRX(PBP_128) | _PSTX(PBP_128);
 	rtw_write8(Adapter, REG_PBP, value8);
 }
-- 
2.31.1

