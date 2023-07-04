Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C989746669
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjGDAMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGDAME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:12:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1471A18C;
        Mon,  3 Jul 2023 17:12:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8TGt006090;
        Tue, 4 Jul 2023 00:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=RpXnz22L2XIS+YNinDphTvreM6OGU3Eu+LVktLPt050=;
 b=riMj4IM3Ozsq71I6GR5k6AQWZI9gvcfXXy0RpxhZwdVfPuKMbrufKCDh4U6r8JZKoyG4
 QqIZbnx9m/1xE8xNOD4zT5Gl2lk0jrHouXekfODEShvs3KYtmwjmTKClCcfwXajWrp0g
 TUamRmje4TNeQkgrvxZVzrwXhdAlxFzcenOoJ/1hkDlV5aTKyRLoiBgm/PaaXMAKWLDZ
 c4k3ASth/z6/F9GyHRLGOIjgNHrk4uuPpZ+Ofltyp0h3ashn4VBy/g0552uDXrJ0aTU4
 +BYtEqZx9erPPEfh2/XJMsdIXBIHHGZKWVdLLCo8u+xJ0zgqdJmNAjRPIKHQ9Z3cfRBj qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc1akgtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 00:11:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363M1dwl039198;
        Tue, 4 Jul 2023 00:11:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3p412-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 00:11:42 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36402bLV002876;
        Tue, 4 Jul 2023 00:11:41 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rjak3p3xe-6;
        Tue, 04 Jul 2023 00:11:41 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     davem@davemloft.net
Cc:     david@fries.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zbr@ioremap.net, brauner@kernel.org,
        johannes@sipsolutions.net, ecree.xilinx@gmail.com, leon@kernel.org,
        keescook@chromium.org, socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        anjali.k.kulkarni@oracle.com
Subject: [PATCH v7 5/6] connector/cn_proc: Allow non-root users access
Date:   Mon,  3 Jul 2023 17:11:35 -0700
Message-ID: <20230704001136.2301645-6-anjali.k.kulkarni@oracle.com>
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
X-Proofpoint-GUID: Dc2Kdc1FpZkgEktTg2ZimozWIZU68q9V
X-Proofpoint-ORIG-GUID: Dc2Kdc1FpZkgEktTg2ZimozWIZU68q9V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a couple of reasons for not allowing non-root users access
initially  - one is there was some point no proper receive buffer
management in place for netlink multicast. But that should be long
fixed. See link below for more context.

Second is that some of the messages may contain data that is root only. But
this should be handled with a finer granularity, which is being done at the
protocol layer.  The only problematic protocols are nf_queue and the
firewall netlink. Hence, this restriction for non-root access was relaxed
for NETLINK_ROUTE initially:
https://lore.kernel.org/all/20020612013101.A22399@wotan.suse.de/

This restriction has also been removed for following protocols:
NETLINK_KOBJECT_UEVENT, NETLINK_AUDIT, NETLINK_SOCK_DIAG,
NETLINK_GENERIC, NETLINK_SELINUX.

Since process connector messages are not sensitive (process fork, exit
notifications etc.), and anyone can read /proc data, we can allow non-root
access here. However, since process event notification is not the only
consumer of NETLINK_CONNECTOR, we can make this change even more
fine grained than the protocol level, by checking for multicast group
within the protocol.

Allow non-root access for NETLINK_CONNECTOR via NL_CFG_F_NONROOT_RECV
but add new bind function cn_bind(), which allows non-root access only
for CN_IDX_PROC multicast group.

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/cn_proc.c   |  7 -------
 drivers/connector/connector.c | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index dfc84d44f804..bb1fa5d66cf9 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -410,12 +410,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 	    !task_is_in_init_pid_ns(current))
 		return;
 
-	/* Can only change if privileged. */
-	if (!__netlink_ns_capable(nsp, &init_user_ns, CAP_NET_ADMIN)) {
-		err = EPERM;
-		goto out;
-	}
-
 	if (msg->len == sizeof(*pinput)) {
 		pinput = (struct proc_input *)msg->data;
 		mc_op = pinput->mcast_op;
@@ -467,7 +461,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 		break;
 	}
 
-out:
 	cn_proc_ack(err, msg->seq, msg->ack);
 }
 
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index d1179df2b0ba..7f7b94f616a6 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -166,6 +166,23 @@ static int cn_call_callback(struct sk_buff *skb)
 	return err;
 }
 
+/*
+ * Allow non-root access for NETLINK_CONNECTOR family having CN_IDX_PROC
+ * multicast group.
+ */
+static int cn_bind(struct net *net, int group)
+{
+	unsigned long groups = (unsigned long) group;
+
+	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return 0;
+
+	if (test_bit(CN_IDX_PROC - 1, &groups))
+		return 0;
+
+	return -EPERM;
+}
+
 static void cn_release(struct sock *sk, unsigned long *groups)
 {
 	if (groups && test_bit(CN_IDX_PROC - 1, groups)) {
@@ -261,6 +278,8 @@ static int cn_init(void)
 	struct netlink_kernel_cfg cfg = {
 		.groups	= CN_NETLINK_USERS + 0xf,
 		.input	= cn_rx_skb,
+		.flags  = NL_CFG_F_NONROOT_RECV,
+		.bind   = cn_bind,
 		.release = cn_release,
 	};
 
-- 
2.41.0

