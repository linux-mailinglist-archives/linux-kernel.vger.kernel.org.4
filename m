Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AEF615311
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKAUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKAUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:44 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD11C102
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667333908; bh=BkjXWlc0++dK5F1VA40ezcKdiL7mFatw/lwsnE+mg4s=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=eGfm3e/sYf70VLDsRKajG3/d/YCHdHb2Xqm1M/Codp0Ng5AhowJ2W8YMLeOGtBTH4
         tE4fsfHyo/c4yqbzHJCn/DKhUkP0/iKzZEjIT4CNNhnlf2H88badFLvrXfCcL8Ryfl
         vBDtfLPYd+3efLyvNMRD9o2++E+HRUjzhTMf5tPI=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Tue,  1 Nov 2022 21:18:27 +0100 (CET)
X-EA-Auth: bOEGrmhbXJNbPaPsvafkiw4ZtMkF0un82yihd8dwy1jDnv9hcDq9II9y30NwBBnDyW5QN4KpKF18JalbmAvTap9g85tSDmIz
Date:   Wed, 2 Nov 2022 01:48:18 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: r8188eu: remove unwanted variable implementation
Message-ID: <Y2F/CtEnjWlHgw9f@ubunlion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variables intended as the function return value are
initialized but their value does not change during function
execution. The initial value assigned to the variable is simply
returned to the caller. This makes the variable declaration
unnecessary and the initial value can be directly returned.

Following table lists the initial commits when the variables were first
introduced but have not been used since inception:

Variable  Function	File			     Inception Commit
ret	  rtw_sta_flush	r8188eu/core/rtw_ap.c	     [1]
ret	  amsdu_to_msdu r8188eu/core/rtw_recv.c	     [2]
ret	  rtw_p2p_set	r8188eu/os_dep/ioctl_linux.c [3]

[1] 'commit 9a7fe54ddc3a ("staging: r8188eu: Add source files for new driver - part 1")'
[2] 'commit 1cc18a22b96b ("staging: r8188eu: Add files for new driver - part 5")'
[3] 'commit a2c60d42d97c ("staging: r8188eu: Add files for new driver - part 16")'

However, local variable pull of the function update_txdesc from file
r8188eu/hal/rtl8188eu_xmit.c was in use prior to introduction of
commit ID [4] 7bdedfef085bb65. The clean-up associated with this
commit left the variable pull redundant.

[4] 'commit 7bdedfef085b ("staging: r8188eu: Remove mp, a.k.a. manufacturing process, code")'

The patch is produced using the following coccicheck options:
   COCCI=./scripts/coccinelle/misc/returnvar.cocci
   M=driver/staging/r8188eu/
   MODE=patch

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Include reason for why the variable declarations are not useful. Suggested
      by Julia Lawall <julia.lawall@inria.fr>


 drivers/staging/r8188eu/core/rtw_ap.c        | 5 ++---
 drivers/staging/r8188eu/core/rtw_recv.c      | 3 +--
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 24eb8dce9bfe..9eaf345e6a00 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1020,7 +1020,6 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 int rtw_sta_flush(struct adapter *padapter)
 {
 	struct list_head *phead, *plist;
-	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -1028,7 +1027,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
-		return ret;
+		return 0;

 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	phead = &pstapriv->asoc_list;
@@ -1051,7 +1050,7 @@ int rtw_sta_flush(struct adapter *padapter)

 	associated_clients_update(padapter, true);

-	return ret;
+	return 0;
 }

 /* called > TSR LEVEL for USB or SDIO Interface*/
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 4b68a543f68b..94f85cd7038d 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1415,7 +1415,6 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)

 	struct recv_priv *precvpriv = &padapter->recvpriv;
 	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
-	int	ret = _SUCCESS;

 	nr_subframes = 0;

@@ -1513,7 +1512,7 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 	prframe->len = 0;
 	rtw_free_recvframe(prframe, pfree_recv_queue);/* free this recv_frame */

-	return ret;
+	return _SUCCESS;
 }

 static bool check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 8e4a5acc0b18..6d1f56d1f9d7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -149,7 +149,6 @@ static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)

 static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bagg_pkt)
 {
-	int	pull = 0;
 	uint	qsel;
 	u8 data_rate, pwr_status, offset;
 	struct adapter		*adapt = pxmitframe->padapter;
@@ -295,7 +294,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	ODM_SetTxAntByTxInfo_88E(&haldata->odmpriv, pmem, pattrib->mac_id);

 	rtl8188eu_cal_txdesc_chksum(ptxdesc);
-	return pull;
+	return 0;
 }

 /* for non-agg data frame or  management frame */
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 8516e253bb03..59a97c5fb80c 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2979,8 +2979,6 @@ static int rtw_p2p_set(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
-
 	if (!memcmp(extra, "enable =", 7)) {
 		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
 	} else if (!memcmp(extra, "setDN =", 6)) {
@@ -3027,7 +3025,7 @@ static int rtw_p2p_set(struct net_device *dev,
 		rtw_p2p_set_persistent(dev, info, wrqu, &extra[11]);
 	}

-	return ret;
+	return 0;
 }

 static int rtw_p2p_get2(struct net_device *dev,
--
2.34.1



