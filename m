Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC15709FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjESTKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjESTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:09:43 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C110CE
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:19 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDTVWA014535;
        Fri, 19 May 2023 19:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=rMtFGeLTLqs2vfIhLT9M8T7JC+BTSDdRFHdnK5EA330=;
 b=XzL5HRaJFK+bju2aJNuP5fhqryinCnnwnwagWqvr05NRdH5zUaBqh3YJQ2TNYYnyqs5E
 IoODkewrcZ8JtTMdNIKVvFtnoPjGJz8qGDC+uxyAi4emREZsGgtmzwRW+oq4E6sQiF4J
 OjjtPI0JPYCQ6wcnuo28PhayN68ygJ3nYlhryOaSLDfevsFxVSu1vk3BE9R7SoK5RDKo
 YqMSp4MHuVXsN/WPbmijWC8BIav0YLxdMaqC/l55hxgpHh8BXRz9M4+kR2FI0pzGBPrY
 S4eVrMjInxNjkqOC4nWbMIikT1bL+v+c53Swcoio0aJQTfL1YFzSrx0c/pyEoQz4C6vT Bg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qpa1gamap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:07:56 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 4E11C12E96;
        Fri, 19 May 2023 19:07:55 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0F412810920;
        Fri, 19 May 2023 19:07:55 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 51A5630313049; Fri, 19 May 2023 14:07:52 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 5/8] x86/platform/uv: helper functions for allocating and freeing conversion tables
Date:   Fri, 19 May 2023 14:07:49 -0500
Message-Id: <20230519190752.3297140-6-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230519190752.3297140-1-steve.wahl@hpe.com>
References: <20230519190752.3297140-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b-3b5yRCOcMxMuZWYKBIlv42gJsEKfpd
X-Proofpoint-GUID: b-3b5yRCOcMxMuZWYKBIlv42gJsEKfpd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190164
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add alloc_conv_table() and FREE_1_TO_1_TABLE() to reduce duplicated
code among the conversion tables we use.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 97 ++++++++++++++++--------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 2da84befabf0..1bd15b1f7712 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1491,16 +1491,50 @@ static __init void boot_init_possible_blades(struct uv_hub_info_s *hub_info)
 	pr_info("UV: number nodes/possible blades %d\n", uv_pb);
 }
 
+static int __init alloc_conv_table(int num_elem, unsigned short **table)
+{
+	int i;
+	size_t bytes;
+
+	bytes = num_elem * sizeof(*table[0]);
+	*table = kmalloc(bytes, GFP_KERNEL);
+	if (WARN_ON_ONCE(!*table))
+		return -ENOMEM;
+	for (i = 0; i < num_elem; i++)
+		((unsigned short *)*table)[i] = SOCK_EMPTY;
+	return 0;
+}
+
+/* Remove conversion table if it's 1:1 */
+#define FREE_1_TO_1_TABLE(tbl, min, max, max2) free_1_to_1_table(&tbl, #tbl, min, max, max2)
+
+static void __init free_1_to_1_table(unsigned short **tp, char *tname, int min, int max, int max2)
+{
+	int i;
+	unsigned short *table = *tp;
+
+	if (table == NULL)
+		return;
+	if (max != max2)
+		return;
+	for (i = 0; i < max; i++) {
+		if (i != table[i])
+			return;
+	}
+	kfree(table);
+	*tp = NULL;
+	pr_info("UV: %s is 1:1, conversion table removed\n", tname);
+}
+
 static void __init build_socket_tables(void)
 {
 	struct uv_gam_range_entry *gre = uv_gre_table;
-	int num, nump;
+	int nums, numn, nump;
 	int cpu, i, lnid;
 	int minsock = _min_socket;
 	int maxsock = _max_socket;
 	int minpnode = _min_pnode;
 	int maxpnode = _max_pnode;
-	size_t bytes;
 
 	if (!gre) {
 		if (is_uv2_hub() || is_uv3_hub()) {
@@ -1511,22 +1545,20 @@ static void __init build_socket_tables(void)
 		BUG();
 	}
 
-	/* Build socket id -> node id, pnode */
-	num = maxsock - minsock + 1;
-	bytes = num * sizeof(_socket_to_node[0]);
-	_socket_to_node = kmalloc(bytes, GFP_KERNEL);
-	_socket_to_pnode = kmalloc(bytes, GFP_KERNEL);
-
+	numn = num_possible_nodes();
 	nump = maxpnode - minpnode + 1;
-	bytes = nump * sizeof(_pnode_to_socket[0]);
-	_pnode_to_socket = kmalloc(bytes, GFP_KERNEL);
-	BUG_ON(!_socket_to_node || !_socket_to_pnode || !_pnode_to_socket);
-
-	for (i = 0; i < num; i++)
-		_socket_to_node[i] = _socket_to_pnode[i] = SOCK_EMPTY;
-
-	for (i = 0; i < nump; i++)
-		_pnode_to_socket[i] = SOCK_EMPTY;
+	nums = maxsock - minsock + 1;
+
+	/* Allocate and clear tables */
+	if ((alloc_conv_table(nump, &_pnode_to_socket) < 0)
+	    || (alloc_conv_table(nums, &_socket_to_pnode) < 0)
+	    || (alloc_conv_table(numn, &_node_to_pnode) < 0)
+	    || (alloc_conv_table(nums, &_socket_to_node) < 0)) {
+		kfree(_pnode_to_socket);
+		kfree(_socket_to_pnode);
+		kfree(_node_to_pnode);
+		return;
+	}
 
 	/* Fill in pnode/node/addr conversion list values: */
 	pr_info("UV: GAM Building socket/pnode conversion tables\n");
@@ -1565,10 +1597,6 @@ static void __init build_socket_tables(void)
 	}
 
 	/* Set up physical blade to pnode translation from GAM Range Table: */
-	bytes = num_possible_nodes() * sizeof(_node_to_pnode[0]);
-	_node_to_pnode = kmalloc(bytes, GFP_KERNEL);
-	BUG_ON(!_node_to_pnode);
-
 	for (lnid = 0; lnid < num_possible_nodes(); lnid++) {
 		unsigned short sockid;
 
@@ -1585,31 +1613,12 @@ static void __init build_socket_tables(void)
 	}
 
 	/*
-	 * If socket id == pnode or socket id == node for all nodes,
+	 * If e.g. socket id == pnode for all pnodes,
 	 *   system runs faster by removing corresponding conversion table.
 	 */
-	pr_info("UV: Checking socket->node/pnode for identity maps\n");
-	if (minsock == 0) {
-		for (i = 0; i < num; i++)
-			if (_socket_to_node[i] == SOCK_EMPTY || i != _socket_to_node[i])
-				break;
-		if (i >= num) {
-			kfree(_socket_to_node);
-			_socket_to_node = NULL;
-			pr_info("UV: 1:1 socket_to_node table removed\n");
-		}
-	}
-	if (minsock == minpnode) {
-		for (i = 0; i < num; i++)
-			if (_socket_to_pnode[i] != SOCK_EMPTY &&
-				_socket_to_pnode[i] != i + minpnode)
-				break;
-		if (i >= num) {
-			kfree(_socket_to_pnode);
-			_socket_to_pnode = NULL;
-			pr_info("UV: 1:1 socket_to_pnode table removed\n");
-		}
-	}
+	FREE_1_TO_1_TABLE(_socket_to_node, _min_socket, nums, numn);
+	FREE_1_TO_1_TABLE(_socket_to_pnode, _min_pnode, nums, nump);
+	FREE_1_TO_1_TABLE(_pnode_to_socket, _min_pnode, nums, nump);
 }
 
 /* Check which reboot to use */
-- 
2.26.2

