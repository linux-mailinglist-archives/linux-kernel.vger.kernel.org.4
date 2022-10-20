Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD635606A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJTV3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJTV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:28:59 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498171A044A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666301324; bh=+D5i5YAW0v+FHBQ6QCrtrhRjGBTE/RrYIjjNrkBdjj4=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=A37Nr65/D2dcsKbQtBdpnVHEDAyROUC/nYZ3/0+fYNu5ellsArjU9LhAp4fx1M0IS
         CPMOPQVJXEkTs6n3AhPb5I+E+RQ+5rvrrpuIwtsK0Y9ygB5/6ugpDxTqkao/giH4Oz
         54saFkF4aE8uYHcSbLklzSRvFyhEmNuQBGVNnpxk=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 23:28:44 +0200 (CEST)
X-EA-Auth: CyLcF3VfroT4pXZI0VzvRRNpJ3VaUuKb2iSqeqe617a37HYTO0EI3Y0ELdHaS8zezYCM+UFghpkGOvnV4eCs+JaQRitBM+q9
Date:   Fri, 21 Oct 2022 02:58:39 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v4 04/11] staging: r8188eu: use htons macro instead of
 __constant_htons
Message-ID: <b46adfbdce0362ed0dbe0fc957ef2f47a93c24bb.1666299151.git.drv@mailo.com>
References: <cover.1666299151.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666299151.git.drv@mailo.com>
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

Changes in v4:
   -- None.

Changes in v3:
   1. Make this a driver-wide change. Feedback from philipp.g.hortmann@gmail.com
   2. Correct spelling in patch log. Feedback from joe@perches.com


 drivers/staging/r8188eu/core/rtw_br_ext.c |  6 +++---
 drivers/staging/r8188eu/core/rtw_xmit.c   | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index b418cbc307b3..a23f7df373ed 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -606,14 +606,14 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
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



