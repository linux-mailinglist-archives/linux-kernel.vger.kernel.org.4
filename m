Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736FC6632EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjAIVaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbjAIV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:29:23 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F251145A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:29:17 -0800 (PST)
Received: from dslb-188-096-147-178.188.096.pools.vodafone-ip.de ([188.96.147.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pEzhg-0007iD-Oo; Mon, 09 Jan 2023 22:29:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 11/12] staging: r8188eu: xmit_priv's vcs is not used
Date:   Mon,  9 Jan 2023 22:28:51 +0100
Message-Id: <20230109212852.75612-12-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230109212852.75612-1-martin@kaiser.cx>
References: <20230108185738.597105-1-martin@kaiser.cx>
 <20230109212852.75612-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vcs component in struct xmit_priv is set but not used. We can remove
vcs and the rtw_update_protection function, whose only job is to set vcs.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    |  5 ----
 drivers/staging/r8188eu/core/rtw_xmit.c    | 34 ----------------------
 drivers/staging/r8188eu/include/rtw_xmit.h |  2 --
 drivers/staging/r8188eu/os_dep/os_intfs.c  |  1 -
 4 files changed, 42 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index b272123626ac..fb7d0e161fdd 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -444,8 +444,6 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 	if (check_fwstate(pmlmepriv, _FW_LINKED) &&
 	    is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
 		update_network(&pmlmepriv->cur_network.network, pnetwork, adapter, true);
-		rtw_update_protection(adapter, (pmlmepriv->cur_network.network.IEs) + sizeof(struct ndis_802_11_fixed_ie),
-				      pmlmepriv->cur_network.network.IELength);
 	}
 
 }
@@ -1027,9 +1025,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 		break;
 	}
 
-	rtw_update_protection(padapter, (cur_network->network.IEs) +
-			      sizeof(struct ndis_802_11_fixed_ie),
-			      (cur_network->network.IELength));
 	rtw_update_ht_cap(padapter, cur_network->network.IEs, cur_network->network.IELength);
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 1cd560630de3..8b055e3fbfa5 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1099,40 +1099,6 @@ s32 rtw_put_snap(u8 *data, u16 h_proto)
 	return SNAP_SIZE + sizeof(u16);
 }
 
-void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
-{
-	uint	protection;
-	u8	*perp;
-	int	 erp_len;
-	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	struct	registry_priv *pregistrypriv = &padapter->registrypriv;
-
-	switch (pxmitpriv->vcs_setting) {
-	case DISABLE_VCS:
-		pxmitpriv->vcs = NONE_VCS;
-		break;
-	case ENABLE_VCS:
-		break;
-	case AUTO_VCS:
-	default:
-		perp = rtw_get_ie(ie, _ERPINFO_IE_, &erp_len, ie_len);
-		if (!perp) {
-			pxmitpriv->vcs = NONE_VCS;
-		} else {
-			protection = (*(perp + 2)) & BIT(1);
-			if (protection) {
-				if (pregistrypriv->vcs_type == RTS_CTS)
-					pxmitpriv->vcs = RTS_CTS;
-				else
-					pxmitpriv->vcs = CTS_TO_SELF;
-			} else {
-				pxmitpriv->vcs = NONE_VCS;
-			}
-		}
-		break;
-	}
-}
-
 void rtw_count_tx_stats(struct adapter *padapter, struct xmit_frame *pxmitframe, int sz)
 {
 	struct sta_info *psta = NULL;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 77d79c43209f..abac0103b53a 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -268,7 +268,6 @@ struct	xmit_priv {
 	uint	frag_len;
 	struct adapter	*adapter;
 	u8   vcs_setting;
-	u8	vcs;
 	u64	tx_bytes;
 	u64	tx_pkts;
 	u64	tx_drop;
@@ -311,7 +310,6 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv,
 		     struct xmit_buf *pxmitbuf);
 void rtw_count_tx_stats(struct adapter *padapter,
 			struct xmit_frame *pxmitframe, int sz);
-void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len);
 s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr,
 		     struct pkt_attrib *pattrib);
 s32 rtw_put_snap(u8 *data, u16 h_proto);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index ae03d39de092..f022f6b1cf3e 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -393,7 +393,6 @@ static void rtw_init_default_value(struct adapter *padapter)
 
 	/* xmit_priv */
 	pxmitpriv->vcs_setting = pregistrypriv->vrtl_carrier_sense;
-	pxmitpriv->vcs = pregistrypriv->vcs_type;
 	pxmitpriv->frag_len = pregistrypriv->frag_thresh;
 
 	/* mlme_priv */
-- 
2.30.2

