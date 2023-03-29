Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BAE6CF011
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjC2RCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjC2RCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:02:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9F65B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:02:09 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TGs7fM021598;
        Wed, 29 Mar 2023 17:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a8dPYwz2XaxhNOXY6HcQ9goah4VFyVpxG+pH0WuRrBA=;
 b=cpLFvMAolqkuXqRsx81+xO538wsy5+XiYojL3HkhbLVi/EWhF3U7NlTLGZlz2BPsXgdI
 wDOWTb/ptD9T5u9/Prj0w35y4Wjg1DAeus428spl6L6Y0bVz0McbaYgEGNhxjL5wegAH
 RN7+JQObrDkL81W5H5oYmYwP7XC0JTeAa0OCLYSX59idHjWqJkIgKM0e6KeMD4+oUS9l
 W7Jke7a/03lnmhfzpSnN4Iq5Hj+yCv9+rPVJG+Wb6wE01CQkCWgk0fWQ97VPa7tEKgUD
 Thv2K3cW4V5EQBXoXduDwge7hGP8lfDSxwwxZMzHuZZfCeRlYNKNBu/CSpHKnHcR4t3r 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmq6m46cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:02:05 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32TGs4pF001476;
        Wed, 29 Mar 2023 17:02:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pmq6m46bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:02:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32SNMkbH009626;
        Wed, 29 Mar 2023 17:02:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3phrk6n4jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 17:02:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32TH20AG21561980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 17:02:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CD4020043;
        Wed, 29 Mar 2023 17:02:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBF1320040;
        Wed, 29 Mar 2023 17:01:58 +0000 (GMT)
Received: from li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com (unknown [9.43.61.88])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Mar 2023 17:01:58 +0000 (GMT)
From:   Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     abhirupdeb@linux.vnet.ibm.com
Subject: [PATCH 5/5] staging: r8188eu: place constants on right side of comparison
Date:   Wed, 29 Mar 2023 22:31:39 +0530
Message-Id: <486b8b8414b8483422f1e05c9fca8f3dee6e8cb6.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
References: <cover.1679988016.git.abhirupdeb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kaUBMqraO-kZBIjI2ED77H870SQg043I
X-Proofpoint-ORIG-GUID: TCW2HtnGAMZX7xXTBjnlNheu_kaOlkiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_10,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290128
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comparison statements to place constants on the right hand
side of the equation to improve code-readability and
adhering to the linux kernel coding-style.

checkpatch warning produced:

WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c      |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c       |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 10 +++++-----
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    |  2 +-
 drivers/staging/r8188eu/include/rtw_mlme.h      |  4 ++--
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    |  6 +++---
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 8310d7f53982..dfbd1ad554e4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -28,7 +28,7 @@ static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
 			continue;
 
 		valid = reg & BIT(msgbox_num);
-		if (0 == valid)
+		if (valid == 0)
 			read_down = true;
 	} while ((!read_down) && (retry_cnts--));
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 0399872c4546..9dea34fdde15 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -108,7 +108,7 @@ void AntDivCompare8188E(struct adapter *Adapter, struct wlan_bssid_ex *dst, stru
 {
 	struct hal_data_8188e *hal_data = &Adapter->haldata;
 
-	if (0 != hal_data->AntDivCfg) {
+	if (hal_data->AntDivCfg != 0) {
 		/* select optimum_antenna for before linked =>For antenna diversity */
 		if (dst->Rssi >=  src->Rssi) {/* keep org parameter */
 			src->Rssi = dst->Rssi;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 73855bca76fe..4af9acb83c5b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -519,7 +519,7 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _size_byte, u8 *pbuf)
 		ret = iol_read_efuse(Adapter, _size_byte, pbuf);
 		iol_mode_enable(Adapter, 0);
 
-		if (_SUCCESS == ret)
+		if (ret == _SUCCESS)
 			return;
 	}
 
@@ -648,13 +648,13 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 	} else {
 		for (i = 0; i < (txpktbuf_bndy - 1); i++) {
 			status = _LLTWrite(padapter, i, i + 1);
-			if (_SUCCESS != status)
+			if (status != _SUCCESS)
 				return status;
 		}
 
 		/*  end of list */
 		status = _LLTWrite(padapter, (txpktbuf_bndy - 1), 0xFF);
-		if (_SUCCESS != status)
+		if (status != _SUCCESS)
 			return status;
 
 		/*  Make the other pages as ring buffer */
@@ -662,13 +662,13 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 		/*  Otherwise used as local loopback buffer. */
 		for (i = txpktbuf_bndy; i < Last_Entry_Of_TxPktBuf; i++) {
 			status = _LLTWrite(padapter, i, (i + 1));
-			if (_SUCCESS != status)
+			if (status != _SUCCESS)
 				return status;
 		}
 
 		/*  Let last entry point to the start entry of ring buffer */
 		status = _LLTWrite(padapter, Last_Entry_Of_TxPktBuf, txpktbuf_bndy);
-		if (_SUCCESS != status) {
+		if (status != _SUCCESS) {
 			return status;
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 6d1f56d1f9d7..f5e22b6bda57 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -513,7 +513,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 		pbuf = round_up(pbuf_tail, 8);
 
 		pfirstframe->agg_num++;
-		if (MAX_TX_AGG_PACKET_NUMBER == pfirstframe->agg_num)
+		if (pfirstframe->agg_num == MAX_TX_AGG_PACKET_NUMBER)
 			break;
 
 		if (pbuf < bulkptr) {
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 3ff653ff1d81..2efefc26f45a 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -454,7 +454,7 @@ static inline void set_fwstate(struct mlme_priv *pmlmepriv, int state)
 {
 	pmlmepriv->fw_state |= state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY == state)
+	if (state == _FW_UNDER_SURVEY)
 		pmlmepriv->bScanInProcess = true;
 }
 
@@ -462,7 +462,7 @@ static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, int state)
 {
 	pmlmepriv->fw_state &= ~state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY == state)
+	if (state == _FW_UNDER_SURVEY)
 		pmlmepriv->bScanInProcess = false;
 }
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 8e9b7b0664bc..21e8ffa04ab6 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3071,11 +3071,11 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 	if (copy_from_user(new_ifname, wrqu->data.pointer, IFNAMSIZ))
 		return -EFAULT;
 
-	if (0 == strcmp(rereg_priv->old_ifname, new_ifname))
+	if (strcmp(rereg_priv->old_ifname, new_ifname) == 0)
 		return ret;
 
 	ret = rtw_change_ifname(padapter, new_ifname);
-	if (0 != ret)
+	if (ret != 0)
 		goto exit;
 
 	if (!memcmp(rereg_priv->old_ifname, "disable%d", 9)) {
@@ -3558,7 +3558,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 		int probereq_wpsie_len = len;
 		u8 wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 
-		if ((_VENDOR_SPECIFIC_IE_ == probereq_wpsie[0]) &&
+		if ((probereq_wpsie[0] == _VENDOR_SPECIFIC_IE_) &&
 		    (!memcmp(&probereq_wpsie[2], wps_oui, 4))) {
 			cp_sz = min(probereq_wpsie_len, MAX_WPS_IE_LEN);
 
-- 
2.31.1

