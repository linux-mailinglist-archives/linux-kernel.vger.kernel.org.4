Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C6E605919
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJTHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJTHzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:55:05 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A244663862
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666252491; bh=3oEoMwohNKBPd+zk6iCl10WIgxrx6LNO3Rbth/3kk7g=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=D9VDSL17zM99E1AoGoa2p8hqjggURknRtQ7Zte31rggp6x1JRUCU/8dITHRCmSMcc
         xjv8PwALQxEQ+FD6DTfJ4ENINt6oabw4xXIHkwdwUGX+uWDnBoDn8Tys+UA76yCVxL
         rao8TaLRCJf12RodOBsu7hQ+QPSD+CWKMba02xTI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 09:54:51 +0200 (CEST)
X-EA-Auth: Xb2yLyLmfMaCBszIMlAVa3vz57SUh8jcot+dWk3Tbu4xgXSg5FKIPIb93od9bNjMEOoYioj4q8Ce1xzHnqsZvAR6IEaDmGt9
Date:   Thu, 20 Oct 2022 13:24:46 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v3 04/10] staging: r8188eu: use htons macro instead of
 __constant_htons
Message-ID: <f12c3a4cdcd5318f34487ecbc7d52c7ec5445de3.1666249716.git.drv@mailo.com>
References: <cover.1666249715.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666249715.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro "htons" is more efficient and clearer. It should be used for
constants instead of the __constant_htons macro. Resolves following
checkpatch script complaint:
        WARNING: __constant_htons should be htons


Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v3:
   1. Make this a driver-wide change. Feedback from philipp.g.hortmann@gmail.com
   2. Correct spelling in patch log. Feedback from joe@perches.com


 drivers/staging/r8188eu/core/rtw_br_ext.c |  6 +++---
 drivers/staging/r8188eu/core/rtw_xmit.c   | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 14797c2d6d76..718133c991d7 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -609,14 +609,14 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 	if (!priv->ethBrExtInfo.dhcp_bcst_disable) {
 		__be16 protocol = *((__be16 *)(skb->data + 2 * ETH_ALEN));

-		if (protocol == __constant_htons(ETH_P_IP)) { /*  IP */
+		if (protocol == htons(ETH_P_IP)) { /*  IP */
 			struct iphdr *iph = (struct iphdr *)(skb->data + ETH_HLEN);

 			if (iph->protocol == IPPROTO_UDP) { /*  UDP */
 				struct udphdr *udph = (struct udphdr *)((size_t)iph + (iph->ihl << 2));

-				if ((udph->source == __constant_htons(CLIENT_PORT)) &&
-				    (udph->dest == __constant_htons(SERVER_PORT))) { /*  DHCP request */
+				if ((udph->source == htons(CLIENT_PORT)) &&
+				    (udph->dest == htons(SERVER_PORT))) { /*  DHCP request */
 					struct dhcpMessage *dhcph =
 						(struct dhcpMessage *)((size_t)udph + sizeof(struct udphdr));
 					u32 cookie = be32_to_cpu((__be32)dhcph->cookie);
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 873d2c5c3634..4f8220428328 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1622,14 +1622,14 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 	spin_lock_bh(&padapter->br_ext_lock);
 	if (!(skb->data[0] & 1) && br_port &&
 	    memcmp(skb->data + ETH_ALEN, padapter->br_mac, ETH_ALEN) &&
-	    *((__be16 *)(skb->data + ETH_ALEN * 2)) != __constant_htons(ETH_P_8021Q) &&
-	    *((__be16 *)(skb->data + ETH_ALEN * 2)) == __constant_htons(ETH_P_IP) &&
+	    *((__be16 *)(skb->data + ETH_ALEN * 2)) != htons(ETH_P_8021Q) &&
+	    *((__be16 *)(skb->data + ETH_ALEN * 2)) == htons(ETH_P_IP) &&
 	    !memcmp(padapter->scdb_mac, skb->data + ETH_ALEN, ETH_ALEN) && padapter->scdb_entry) {
 		memcpy(skb->data + ETH_ALEN, GET_MY_HWADDR(padapter), ETH_ALEN);
 		padapter->scdb_entry->ageing_timer = jiffies;
 		spin_unlock_bh(&padapter->br_ext_lock);
 	} else {
-		if (*((__be16 *)(skb->data + ETH_ALEN * 2)) == __constant_htons(ETH_P_8021Q)) {
+		if (*((__be16 *)(skb->data + ETH_ALEN * 2)) == htons(ETH_P_8021Q)) {
 			is_vlan_tag = 1;
 			vlan_hdr = *((unsigned short *)(skb->data + ETH_ALEN * 2 + 2));
 			for (i = 0; i < 6; i++)
@@ -1637,10 +1637,10 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 			skb_pull(skb, 4);
 		}
 		if (!memcmp(skb->data + ETH_ALEN, padapter->br_mac, ETH_ALEN) &&
-		    (*((__be16 *)(skb->data + ETH_ALEN * 2)) == __constant_htons(ETH_P_IP)))
+		    (*((__be16 *)(skb->data + ETH_ALEN * 2)) == htons(ETH_P_IP)))
 			memcpy(padapter->br_ip, skb->data + WLAN_ETHHDR_LEN + 12, 4);

-		if (*((__be16 *)(skb->data + ETH_ALEN * 2)) == __constant_htons(ETH_P_IP)) {
+		if (*((__be16 *)(skb->data + ETH_ALEN * 2)) == htons(ETH_P_IP)) {
 			if (memcmp(padapter->scdb_mac, skb->data + ETH_ALEN, ETH_ALEN)) {
 				padapter->scdb_entry = (struct nat25_network_db_entry *)scdb_findEntry(padapter,
 							skb->data + WLAN_ETHHDR_LEN + 12);
@@ -1669,7 +1669,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 					skb_push(skb, 4);
 					for (i = 0; i < 6; i++)
 						*((unsigned short *)(skb->data + i * 2)) = *((unsigned short *)(skb->data + 4 + i * 2));
-					*((__be16 *)(skb->data + ETH_ALEN * 2)) = __constant_htons(ETH_P_8021Q);
+					*((__be16 *)(skb->data + ETH_ALEN * 2)) = htons(ETH_P_8021Q);
 					*((unsigned short *)(skb->data + ETH_ALEN * 2 + 2)) = vlan_hdr;
 				}

@@ -1708,7 +1708,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 			skb_push(skb, 4);
 			for (i = 0; i < 6; i++)
 				*((unsigned short *)(skb->data + i * 2)) = *((unsigned short *)(skb->data + 4 + i * 2));
-			*((__be16 *)(skb->data + ETH_ALEN * 2)) = __constant_htons(ETH_P_8021Q);
+			*((__be16 *)(skb->data + ETH_ALEN * 2)) = htons(ETH_P_8021Q);
 			*((unsigned short *)(skb->data + ETH_ALEN * 2 + 2)) = vlan_hdr;
 		}
 	}
--
2.30.2



