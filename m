Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DF474BB54
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjGHCR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGHCRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:17:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241FF1FEC;
        Fri,  7 Jul 2023 19:17:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3681Y2M6015819;
        Sat, 8 Jul 2023 02:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=xLudJOQwmHHxcJXYtQm2YLIRiqFvl/NaHfIQCnkdntk=;
 b=VZsodJ4debLdy3aJ5JZ0cYf9vNHcxWg9t3XYTe9r5JEUWPfk3G0z0i5euxyRvenXMstb
 0tykv1mBALbBR9ly9vUuEq9G649uqNs4hZjg+h3wEUnr0LQ4aE+52Msh6YRbk18OAZd4
 AfkX1HycglMboaBK1XE5meXz3cg5jomz35j2xtGjlkdWVQVdND5zrArANwcO4Ize/GuU
 JSOrvIrxh1SFrdmZOSPIIHetpRx6/85yXxZKlas4JDt6Ar5fZi3mzQ0tm+wV8YkIfocv
 FaC5VVwy6o9jzkQvLulXgHJFVz8YHZzMs8zXH0W4SoNkyXhrHDMChMKqEqEVPGiPOzmd nA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpx7v00wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jul 2023 02:16:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3681XPIq006169;
        Sat, 8 Jul 2023 02:15:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx87rkyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jul 2023 02:15:17 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3682FEKi002005;
        Sat, 8 Jul 2023 02:15:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rpx87rkuh-2;
        Sat, 08 Jul 2023 02:15:16 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     davem@davemloft.net
Cc:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        david@fries.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zbr@ioremap.net, brauner@kernel.org,
        johannes@sipsolutions.net, ecree.xilinx@gmail.com, leon@kernel.org,
        keescook@chromium.org, socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        anjali.k.kulkarni@oracle.com
Subject: [PATCH v8 1/6] netlink: Reverse the patch which removed filtering
Date:   Fri,  7 Jul 2023 19:15:07 -0700
Message-ID: <20230708021512.3929237-2-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708021512.3929237-1-anjali.k.kulkarni@oracle.com>
References: <20230708021512.3929237-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=984
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307080019
X-Proofpoint-ORIG-GUID: lavYOV19F6OMKsWwnlDsnCuW7x5rEltH
X-Proofpoint-GUID: lavYOV19F6OMKsWwnlDsnCuW7x5rEltH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use filtering at the connector & cn_proc layers, we need to enable
filtering in the netlink layer. This reverses the patch which removed
netlink filtering.

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netlink.h  |  5 +++++
 net/netlink/af_netlink.c | 27 +++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 19c0791ed9d5..d73cfe5b6bc2 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -227,6 +227,11 @@ bool netlink_strict_get_check(struct sk_buff *skb);
 int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
 int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
 		      __u32 group, gfp_t allocation);
+int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
+			       __u32 portid, __u32 group, gfp_t allocation,
+			       int (*filter)(struct sock *dsk,
+					     struct sk_buff *skb, void *data),
+			       void *filter_data);
 int netlink_set_err(struct sock *ssk, __u32 portid, __u32 group, int code);
 int netlink_register_notifier(struct notifier_block *nb);
 int netlink_unregister_notifier(struct notifier_block *nb);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 3a1e0fd5bf14..e75e5156e4ac 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1432,6 +1432,8 @@ struct netlink_broadcast_data {
 	int delivered;
 	gfp_t allocation;
 	struct sk_buff *skb, *skb2;
+	int (*tx_filter)(struct sock *dsk, struct sk_buff *skb, void *data);
+	void *tx_data;
 };
 
 static void do_one_broadcast(struct sock *sk,
@@ -1485,6 +1487,13 @@ static void do_one_broadcast(struct sock *sk,
 			p->delivery_failure = 1;
 		goto out;
 	}
+
+	if (p->tx_filter && p->tx_filter(sk, p->skb2, p->tx_data)) {
+		kfree_skb(p->skb2);
+		p->skb2 = NULL;
+		goto out;
+	}
+
 	if (sk_filter(sk, p->skb2)) {
 		kfree_skb(p->skb2);
 		p->skb2 = NULL;
@@ -1507,8 +1516,12 @@ static void do_one_broadcast(struct sock *sk,
 	sock_put(sk);
 }
 
-int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
-		      u32 group, gfp_t allocation)
+int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
+			       u32 portid,
+			       u32 group, gfp_t allocation,
+			       int (*filter)(struct sock *dsk,
+					     struct sk_buff *skb, void *data),
+			       void *filter_data)
 {
 	struct net *net = sock_net(ssk);
 	struct netlink_broadcast_data info;
@@ -1527,6 +1540,8 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
 	info.allocation = allocation;
 	info.skb = skb;
 	info.skb2 = NULL;
+	info.tx_filter = filter;
+	info.tx_data = filter_data;
 
 	/* While we sleep in clone, do not allow to change socket list */
 
@@ -1552,6 +1567,14 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
 	}
 	return -ESRCH;
 }
+EXPORT_SYMBOL(netlink_broadcast_filtered);
+
+int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
+		      u32 group, gfp_t allocation)
+{
+	return netlink_broadcast_filtered(ssk, skb, portid, group, allocation,
+					  NULL, NULL);
+}
 EXPORT_SYMBOL(netlink_broadcast);
 
 struct netlink_set_err_data {
-- 
2.41.0

