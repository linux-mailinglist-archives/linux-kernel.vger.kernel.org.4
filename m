Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C3D74F901
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGKU0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGKU0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:26:46 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C483195
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:26:45 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BEWD0N010176;
        Tue, 11 Jul 2023 20:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=wrbYbxmSsn84uXtccGkdG1hHBv4JrqdqdbnPlrwx+qE=;
 b=ZN/6ruNIdWQL+RPFXjizBeaLe9sPvTdI2CBGTh3eyr7HhNWWguYqX3R/Ocs2CUXXddnD
 PxY8IziAMYm9jE06np8nx/8bOrNGvlqNpeMCryIZX60tH4JT2H4gXI/Ee4grS3xFE2sC
 VjJFDvj9A4IrUrhPFtpWTKhBnoHLgkh1h4aFhpcVc77yXVarao8LIouyEiHZBgQJbl8r
 nafIzNXGU/J8ECwGzx3iNpE0wWzj0ZVZLZ0g47V2R+NAntwhDh7+VL1841/QDhJK2Wha
 ehs0OurYFf7Fuo6p1qZi/E44fm/B5IFvpa87OwH1+Mb4XJIIKUueynv2TTHZN/ImGkjn cw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rrwfj7vnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 20:26:20 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 0044314799;
        Tue, 11 Jul 2023 20:26:19 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id D9CF38081F7;
        Tue, 11 Jul 2023 20:26:18 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 2B261302F47FB; Tue, 11 Jul 2023 15:26:18 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Abort UV initialization when reduced nr_cpus requires it
Date:   Tue, 11 Jul 2023 15:26:18 -0500
Message-Id: <20230711202618.85562-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DQUnrhds4lpglLy9FKrTR_ghPaq-sceI
X-Proofpoint-GUID: DQUnrhds4lpglLy9FKrTR_ghPaq-sceI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nr_cpus is set to a smaller number than actually present, there
is some node-to-socket mapping info we won't get access to in
build_socket_tables().  This could later result in using a -1 value
for some array indexing, and eventual kernel page faults.

To avoid this, if any unfilled table entries are found, print a
warning message, and resume initializing, acting as if this is not a
UV system.  UV features will be unavailable, but we will not cause
kernel dumps.

This is a condition we expect only in platform debugging situations,
not in day-to-day operation.

Fixes: 8a50c5851927 ("x86/platform/uv: UV support for sub-NUMA clustering")
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 58 ++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9384d5b4b8e..8cf3f61b0000 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1567,11 +1567,13 @@ static void __init free_1_to_1_table(unsigned short **tp, char *tname, int min,
  * If the number of nodes is >1 per socket, socket to node table will
  * contain lowest node number on that socket.
  */
-static void __init build_socket_tables(void)
+static int __init build_socket_tables(void)
 {
 	struct uv_gam_range_entry *gre = uv_gre_table;
 	int nums, numn, nump;
-	int cpu, i, lnid;
+	int cpu, i, lnid, nid;
+	int sockid;
+	int rc = 0;
 	int minsock = _min_socket;
 	int maxsock = _max_socket;
 	int minpnode = _min_pnode;
@@ -1580,11 +1582,12 @@ static void __init build_socket_tables(void)
 	if (!gre) {
 		if (is_uv2_hub() || is_uv3_hub()) {
 			pr_info("UV: No UVsystab socket table, ignoring\n");
-			return;
+			return 0;
 		}
 		pr_err("UV: Error: UVsystab address translations not available!\n");
 		WARN_ON_ONCE(!gre);
-		return;
+		rc = -EINVAL;
+		goto err_free_tables;
 	}
 
 	numn = num_possible_nodes();
@@ -1596,10 +1599,8 @@ static void __init build_socket_tables(void)
 	    || (alloc_conv_table(nums, &_socket_to_pnode) < 0)
 	    || (alloc_conv_table(numn, &_node_to_socket) < 0)
 	    || (alloc_conv_table(nums, &_socket_to_node) < 0)) {
-		kfree(_pnode_to_socket);
-		kfree(_socket_to_pnode);
-		kfree(_node_to_socket);
-		return;
+		rc = -ENOMEM;
+		goto err_free_tables;
 	}
 
 	/* Fill in pnode/node/addr conversion list values: */
@@ -1623,9 +1624,9 @@ static void __init build_socket_tables(void)
 	/* Set socket -> node values: */
 	lnid = NUMA_NO_NODE;
 	for_each_possible_cpu(cpu) {
-		int nid = cpu_to_node(cpu);
-		int apicid, sockid;
+		int apicid;
 
+		nid = cpu_to_node(cpu);
 		if (lnid == nid)
 			continue;
 		lnid = nid;
@@ -1647,6 +1648,28 @@ static void __init build_socket_tables(void)
 			_socket_to_node[sockid - minsock]);
 	}
 
+	/*
+	 * If nr_cpus=<val> is used to reduce the cpu count below
+	 * what's actually present, the cpu loop above may not find
+	 * all the node to socket mappings needed to complete these
+	 * tables.  Abort UV init and act like a non-uv system if this
+	 * happens.
+	 */
+	for_each_node(nid) {
+		if (_node_to_socket[nid] == SOCK_EMPTY) {
+			pr_err("UV: Incomplete node table (nr_cpus too small?)\n");
+			rc = -EINVAL;
+			goto err_free_tables;
+		}
+	}
+	for (sockid = 0; sockid < nums; sockid++) {
+		if (_socket_to_node[sockid] == SOCK_EMPTY) {
+			pr_err("UV: Incomplete socket table (nr_cpus too small?)\n");
+			rc = -EINVAL;
+			goto err_free_tables;
+		}
+	}
+
 	/*
 	 * If e.g. socket id == pnode for all pnodes,
 	 *   system runs faster by removing corresponding conversion table.
@@ -1655,6 +1678,17 @@ static void __init build_socket_tables(void)
 	FREE_1_TO_1_TABLE(_node_to_socket, _min_socket, nums, numn);
 	FREE_1_TO_1_TABLE(_socket_to_pnode, _min_pnode, nums, nump);
 	FREE_1_TO_1_TABLE(_pnode_to_socket, _min_pnode, nums, nump);
+
+	return 0;
+
+ err_free_tables:
+	kfree(_pnode_to_socket);
+	kfree(_socket_to_pnode);
+	kfree(_node_to_socket);
+	kfree(_socket_to_node);
+	/* make is_uv_system() return false from now on */
+	uv_system_type = UV_NONE;
+	return rc;
 }
 
 /* Check which reboot to use */
@@ -1763,7 +1797,9 @@ static void __init uv_system_init_hub(void)
 		return;
 	}
 
-	build_socket_tables();
+	if (build_socket_tables() < 0)
+		return;
+
 	build_uv_gr_table();
 	set_block_size();
 	uv_init_hub_info(&hub_info);
-- 
2.26.2

