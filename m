Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEDC746662
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGDAL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGDAL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:11:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4513F189;
        Mon,  3 Jul 2023 17:11:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G82rJ025189;
        Tue, 4 Jul 2023 00:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=k4lVg+ioQMRouXrPLfCfzDz/8XWrr01cPRhXuK5D2Xw=;
 b=J71B907HxYhbPsQbhxRzVeIwcEvrDKXHNiZJLuyGslnKQgxIdLULv1hwKWbb56Kb/wJK
 8KKB8+cfjiKIKP2f4bPoT6qufGXCFnU0ntLUh8eaVVtwHD3Htj5f3d6xfnVUk3fsT7hc
 7pxjMTnLvTc2KBXj/eLUYcU+0wVgCGWXVGHjqAFJPusyzDep+10dQEPHRAqjIT0aCRBh
 I0591zmDJzF8IfUL/IIECuP3z578sCKoREloYeg2K6r1Do9tM0vnB1qGcHnBripZIK+T
 NmyRktkf/M/gMFummMliNv0q6Jcb8AKH0LDW+hK0OP2eub74VAfOrWqidIynCB5QwtXP JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6ckkrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 00:11:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363MQXkg039223;
        Tue, 4 Jul 2023 00:11:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3p3yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 00:11:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36402bLP002876;
        Tue, 4 Jul 2023 00:11:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rjak3p3xe-3;
        Tue, 04 Jul 2023 00:11:39 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     davem@davemloft.net
Cc:     david@fries.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zbr@ioremap.net, brauner@kernel.org,
        johannes@sipsolutions.net, ecree.xilinx@gmail.com, leon@kernel.org,
        keescook@chromium.org, socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        anjali.k.kulkarni@oracle.com
Subject: [PATCH v7 2/6] netlink: Add new netlink_release function
Date:   Mon,  3 Jul 2023 17:11:32 -0700
Message-ID: <20230704001136.2301645-3-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_17,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030219
X-Proofpoint-GUID: zl-21a6_xJsTD-8Gh7PhAR2qgH059XPg
X-Proofpoint-ORIG-GUID: zl-21a6_xJsTD-8Gh7PhAR2qgH059XPg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new function netlink_release is added in netlink_sock to store the
protocol's release function. This is called when the socket is deleted.
This can be supplied by the protocol via the release function in
netlink_kernel_cfg. This is being added for the NETLINK_CONNECTOR
protocol, so it can free it's data when socket is deleted.

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 include/linux/netlink.h  | 1 +
 net/netlink/af_netlink.c | 6 ++++++
 net/netlink/af_netlink.h | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index d73cfe5b6bc2..0db4ffe6186b 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -50,6 +50,7 @@ struct netlink_kernel_cfg {
 	struct mutex	*cb_mutex;
 	int		(*bind)(struct net *net, int group);
 	void		(*unbind)(struct net *net, int group);
+	void            (*release) (struct sock *sk, unsigned long *groups);
 };
 
 struct sock *__netlink_kernel_create(struct net *net, int unit,
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e75e5156e4ac..383c10c6e6e3 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -677,6 +677,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 	struct netlink_sock *nlk;
 	int (*bind)(struct net *net, int group);
 	void (*unbind)(struct net *net, int group);
+	void (*release)(struct sock *sock, unsigned long *groups);
 	int err = 0;
 
 	sock->state = SS_UNCONNECTED;
@@ -704,6 +705,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 	cb_mutex = nl_table[protocol].cb_mutex;
 	bind = nl_table[protocol].bind;
 	unbind = nl_table[protocol].unbind;
+	release = nl_table[protocol].release;
 	netlink_unlock_table();
 
 	if (err < 0)
@@ -719,6 +721,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
 	nlk->module = module;
 	nlk->netlink_bind = bind;
 	nlk->netlink_unbind = unbind;
+	nlk->netlink_release = release;
 out:
 	return err;
 
@@ -763,6 +766,8 @@ static int netlink_release(struct socket *sock)
 	 * OK. Socket is unlinked, any packets that arrive now
 	 * will be purged.
 	 */
+	if (nlk->netlink_release)
+		nlk->netlink_release(sk, nlk->groups);
 
 	/* must not acquire netlink_table_lock in any way again before unbind
 	 * and notifying genetlink is done as otherwise it might deadlock
@@ -2091,6 +2096,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
 		if (cfg) {
 			nl_table[unit].bind = cfg->bind;
 			nl_table[unit].unbind = cfg->unbind;
+			nl_table[unit].release = cfg->release;
 			nl_table[unit].flags = cfg->flags;
 		}
 		nl_table[unit].registered = 1;
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 90a3198a9b7f..fd424cd63f31 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -42,6 +42,8 @@ struct netlink_sock {
 	void			(*netlink_rcv)(struct sk_buff *skb);
 	int			(*netlink_bind)(struct net *net, int group);
 	void			(*netlink_unbind)(struct net *net, int group);
+	void			(*netlink_release)(struct sock *sk,
+						   unsigned long *groups);
 	struct module		*module;
 
 	struct rhash_head	node;
@@ -64,6 +66,8 @@ struct netlink_table {
 	struct module		*module;
 	int			(*bind)(struct net *net, int group);
 	void			(*unbind)(struct net *net, int group);
+	void                    (*release)(struct sock *sk,
+					   unsigned long *groups);
 	int			registered;
 };
 
-- 
2.41.0

