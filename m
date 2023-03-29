Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995216CF00F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjC2RCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjC2RCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:02:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1FC61A9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:02:04 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TFbmfY019207;
        Wed, 29 Mar 2023 17:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7EmFN9Ss2fTFc7pYNfqeVhgFx/it3abn7oZqIPfKU+g=;
 b=LpaXcfNRbdN5C4lL6r7hUmTW/yd+S0RYFdKTSfhROfTC3qJj1H6jqVDziqMI7d2qcBX9
 zsLVrDr0zt7y+OuD1NnSgvRQwcy1kmoMB68JlGUSUGm6GcH++fMT91oYtbSli7FkN/HB
 0dEN7ms7E6YXWZya+JK1MTA/Z/kTPRiWMmtTZdwO9oCkJKKQQcAzEYvIWPLlrTCTIbuf
 56w7jleUhoh1n/5M1mA86kg3y0DI+ERf0nyFtrrm0smZNaEoDIGzX/XPm4uKPcIf4LNY
 I0UL5SoPK+io7gaS3xwqoFUZQMjI5ef/nKGmnfZQe3NniOkRKx+F6uul4DdDBCQo9DMY ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmphbd4j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:59 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32TGab1K006653;
        Wed, 29 Mar 2023 17:01:59 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmphbd4gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:58 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32SHJIVp006663;
        Wed, 29 Mar 2023 17:01:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3phrk6v9q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:01:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32TH1s6H41877884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 17:01:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF5E32004E;
        Wed, 29 Mar 2023 17:01:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75C9A20040;
        Wed, 29 Mar 2023 17:01:52 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.61.88])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Mar 2023 17:01:52 +0000 (GMT)
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     abhirupdeb@linux.vnet.ibm.com
Subject: [PATCH 3/5] staging: r8188eu: remove redundant else after return
Date:   Wed, 29 Mar 2023 22:31:37 +0530
Message-Id: <52c5f24785b8a243e96904e3f26d0bbd63d34e6f.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
References: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: djuy2QIARDpeO4EsnofcTXQidq8NoX2X
X-Proofpoint-ORIG-GUID: ZZ2bynz5ejgqg64jRcPTKLKp_M3fCRyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290133
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove 'else'-clause that is not required after a
'return' statement.

checkpatch warning produced:

WARNING: else is not generally useful after a break or return

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 61 ++++++++++-----------
 drivers/staging/r8188eu/hal/usb_halinit.c   |  7 ++-
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 1b9cf7596a76..6302901a3be1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -7721,49 +7721,48 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	if (send_beacon(padapter) == _FAIL) {
 		return H2C_PARAMETERS_ERROR;
-	} else {
-		/* tx bc/mc frames after update TIM */
-		struct sta_info *psta_bmc;
-		struct list_head *xmitframe_plist, *xmitframe_phead;
-		struct xmit_frame *pxmitframe = NULL;
-		struct sta_priv  *pstapriv = &padapter->stapriv;
+	}
+	/* tx bc/mc frames after update TIM */
+	struct sta_info *psta_bmc;
+	struct list_head *xmitframe_plist, *xmitframe_phead;
+	struct xmit_frame *pxmitframe = NULL;
+	struct sta_priv  *pstapriv = &padapter->stapriv;
 
-		/* for BC/MC Frames */
-		psta_bmc = rtw_get_bcmc_stainfo(padapter);
-		if (!psta_bmc)
-			return H2C_SUCCESS;
+	/* for BC/MC Frames */
+	psta_bmc = rtw_get_bcmc_stainfo(padapter);
+	if (!psta_bmc)
+		return H2C_SUCCESS;
 
-		if ((pstapriv->tim_bitmap & BIT(0)) && (psta_bmc->sleepq_len > 0)) {
-			msleep(10);/*  10ms, ATIM(HIQ) Windows */
-			spin_lock_bh(&psta_bmc->sleep_q.lock);
+	if ((pstapriv->tim_bitmap & BIT(0)) && (psta_bmc->sleepq_len > 0)) {
+		msleep(10);/*  10ms, ATIM(HIQ) Windows */
+		spin_lock_bh(&psta_bmc->sleep_q.lock);
 
-			xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
-			xmitframe_plist = xmitframe_phead->next;
+		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
+		xmitframe_plist = xmitframe_phead->next;
 
-			while (xmitframe_phead != xmitframe_plist) {
-				pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
+		while (xmitframe_phead != xmitframe_plist) {
+			pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
 
-				xmitframe_plist = xmitframe_plist->next;
+			xmitframe_plist = xmitframe_plist->next;
 
-				list_del_init(&pxmitframe->list);
+			list_del_init(&pxmitframe->list);
 
-				psta_bmc->sleepq_len--;
-				if (psta_bmc->sleepq_len > 0)
-					pxmitframe->attrib.mdata = 1;
-				else
-					pxmitframe->attrib.mdata = 0;
+			psta_bmc->sleepq_len--;
+			if (psta_bmc->sleepq_len > 0)
+				pxmitframe->attrib.mdata = 1;
+			else
+				pxmitframe->attrib.mdata = 0;
 
-				pxmitframe->attrib.triggered = 1;
+			pxmitframe->attrib.triggered = 1;
 
-				pxmitframe->attrib.qsel = 0x11;/* HIQ */
+			pxmitframe->attrib.qsel = 0x11;/* HIQ */
 
-				spin_unlock_bh(&psta_bmc->sleep_q.lock);
-				if (rtl8188eu_hal_xmit(padapter, pxmitframe))
-					rtw_xmit_complete(padapter, pxmitframe);
-				spin_lock_bh(&psta_bmc->sleep_q.lock);
-			}
 			spin_unlock_bh(&psta_bmc->sleep_q.lock);
+			if (rtl8188eu_hal_xmit(padapter, pxmitframe))
+				rtw_xmit_complete(padapter, pxmitframe);
+			spin_lock_bh(&psta_bmc->sleep_q.lock);
 		}
+		spin_unlock_bh(&psta_bmc->sleep_q.lock);
 	}
 	return H2C_SUCCESS;
 }
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 9c2774eb5f78..8a8d74f0f2a6 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -596,10 +596,11 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		Adapter->bFWReady = false;
 		haldata->fw_ractrl = false;
 		return status;
-	} else {
-		Adapter->bFWReady = true;
-		haldata->fw_ractrl = false;
 	}
+
+	Adapter->bFWReady = true;
+	haldata->fw_ractrl = false;
+
 	/* Initialize firmware vars */
 	Adapter->pwrctrlpriv.bFwCurrentInPSMode = false;
 	haldata->LastHMEBoxNum = 0;
-- 
2.31.1

