Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278A474BB4A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 04:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGHCP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 22:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGHCP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 22:15:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE5E1FD8;
        Fri,  7 Jul 2023 19:15:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3681i35v020786;
        Sat, 8 Jul 2023 02:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=qmeUsS7zFBj7NRNT7eXQe9a1TTvvEdA754mUtEqiSjQ=;
 b=oSyhUEabOaaybMxEsDt7BKhfAWYXP+nC73Aer3iAGnUNp/VMI9hFAg1XAdtxUex9pF0V
 hWKuX59uk1IYUi+YXjxfLvkpACour/CEvQekU9Qw6CX9ATdCt0/pe8ZEXY0zzX0Jdcgy
 JkjFv2tY+Z5K7Um1aCKU+HkeJrebttH1rfwQRWSlmzs+ikbLyFsGJAXNS0rTc7QwjLvd
 k5/dn43YQx2Lizgbhh5nk/mbgSCwfZzySl4DmQ7wasvM3VYsT7oFbMZBXSmu5Cijbh7t
 xtkJppp1pE6kdlZVqDAJrTIDy4yfG1t4YNuBClj9MxWE0NwVuRQ8Q+JZbfVj7YYNdfgF hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpxd0r0h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jul 2023 02:15:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3681Y0Cj007209;
        Sat, 8 Jul 2023 02:15:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx87rm41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Jul 2023 02:15:25 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3682FEKq002005;
        Sat, 8 Jul 2023 02:15:24 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rpx87rkuh-6;
        Sat, 08 Jul 2023 02:15:24 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     davem@davemloft.net
Cc:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        david@fries.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, zbr@ioremap.net, brauner@kernel.org,
        johannes@sipsolutions.net, ecree.xilinx@gmail.com, leon@kernel.org,
        keescook@chromium.org, socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        anjali.k.kulkarni@oracle.com
Subject: [PATCH v8 5/6] connector/cn_proc: Allow non-root users access
Date:   Fri,  7 Jul 2023 19:15:11 -0700
Message-ID: <20230708021512.3929237-6-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708021512.3929237-1-anjali.k.kulkarni@oracle.com>
References: <20230708021512.3929237-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307080019
X-Proofpoint-GUID: NPxQfFC-Oqj7BqPPy8y5crkM6qEW-IED
X-Proofpoint-ORIG-GUID: NPxQfFC-Oqj7BqPPy8y5crkM6qEW-IED
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
 drivers/connector/cn_proc.c   |  6 ------
 drivers/connector/connector.c | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index dfc84d44f804..05d562e9c8b1 100644
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

