Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32057709FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjESTJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjESTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:09:41 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81617E46
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:09:14 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDWGDs020891;
        Fri, 19 May 2023 19:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=XImtGcXiswX7NuQoNcuvDMJglsAAhZSLOkMprpqznVM=;
 b=H+smyH+OeM5mpcpRC2aGWDo5poKaztlwPCCowGXm6HXfawYpt6wz/ZcOn+lBzg3vzgzP
 MQX5qbDxXPbyxgmMvEmF6fMZGoIedhahg56vvPf4/lrO3tQkuHRQ9SvpbnL3iKSuxbub
 VadgGp0hqntwScxgsQX9KPZcCV/QxrivBzRt+jH/UpeAI+s8VQ2xXGhiZk8sTba0tt2k
 OXrVQtlEV+pp/5tu8pEA/4ljsEc0P9gXYAe3PICZO/KV8W/mscwrJppDMdGx/SLDxjfn
 k5eD45nb10OXpJrsQe9VsvcK0yri9FhYOxX1RwH3yz3FxqeX31MUE42XkHilUHADJyA1 NA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qnwwf07ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 19:07:56 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id DF95F13141;
        Fri, 19 May 2023 19:07:55 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id E57A98097FC;
        Fri, 19 May 2023 19:07:54 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 539923031304A; Fri, 19 May 2023 14:07:52 -0500 (CDT)
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v5 6/8] x86/platform/uv: UV support for sub-NUMA clustering
Date:   Fri, 19 May 2023 14:07:50 -0500
Message-Id: <20230519190752.3297140-7-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230519190752.3297140-1-steve.wahl@hpe.com>
References: <20230519190752.3297140-1-steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s2y7Y3t-POFCydW_bICVtOGG52kSZmNp
X-Proofpoint-ORIG-GUID: s2y7Y3t-POFCydW_bICVtOGG52kSZmNp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_14,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Sub-NUMA clustering (SNC) invalidates previous assumptions of a 1:1
relationship between blades, sockets, and nodes.  Fix these
assumptions and build tables correctly when SNC is enabled.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h   |  22 ++--
 arch/x86/kernel/apic/x2apic_uv_x.c | 162 +++++++++++++++++------------
 2 files changed, 107 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 0acfd1734c8b..5fa76c2ced51 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -177,6 +177,7 @@ struct uv_hub_info_s {
 	unsigned short		nr_possible_cpus;
 	unsigned short		nr_online_cpus;
 	short			memory_nid;
+	unsigned short		*node_to_socket;
 };
 
 /* CPU specific info with a pointer to the hub common info struct */
@@ -531,19 +532,18 @@ static inline void *uv_pnode_offset_to_vaddr(int pnode, unsigned long offset)
 {
 	unsigned int m_val = uv_hub_info->m_val;
 	unsigned long base;
-	unsigned short sockid, node;
+	unsigned short sockid;
 
 	if (m_val)
 		return __va(((unsigned long)pnode << m_val) | offset);
 
 	sockid = uv_pnode_to_socket(pnode);
-	node = uv_socket_to_node(sockid);
 
 	/* limit address of previous socket is our base, except node 0 is 0 */
-	if (!node)
+	if (sockid == 0)
 		return __va((unsigned long)offset);
 
-	base = (unsigned long)(uv_hub_info->gr_table[node - 1].limit);
+	base = (unsigned long)(uv_hub_info->gr_table[sockid - 1].limit);
 	return __va(base << UV_GAM_RANGE_SHFT | offset);
 }
 
@@ -650,7 +650,7 @@ static inline int uv_cpu_blade_processor_id(int cpu)
 /* Blade number to Node number (UV2..UV4 is 1:1) */
 static inline int uv_blade_to_node(int blade)
 {
-	return blade;
+	return uv_socket_to_node(blade);
 }
 
 /* Blade number of current cpu. Numnbered 0 .. <#blades -1> */
@@ -662,23 +662,27 @@ static inline int uv_numa_blade_id(void)
 /*
  * Convert linux node number to the UV blade number.
  * .. Currently for UV2 thru UV4 the node and the blade are identical.
- * .. If this changes then you MUST check references to this function!
+ * .. UV5 needs conversion when sub-numa clustering is enabled.
  */
 static inline int uv_node_to_blade_id(int nid)
 {
-	return nid;
+	unsigned short *n2s = uv_hub_info->node_to_socket;
+
+	return n2s ? n2s[nid] : nid;
 }
 
 /* Convert a CPU number to the UV blade number */
 static inline int uv_cpu_to_blade_id(int cpu)
 {
-	return uv_node_to_blade_id(cpu_to_node(cpu));
+	return uv_cpu_hub_info(cpu)->numa_blade_id;
 }
 
 /* Convert a blade id to the PNODE of the blade */
 static inline int uv_blade_to_pnode(int bid)
 {
-	return uv_hub_info_list(uv_blade_to_node(bid))->pnode;
+	unsigned short *s2p = uv_hub_info->socket_to_pnode;
+
+	return s2p ? s2p[bid] : bid;
 }
 
 /* Nid of memory node on blade. -1 if no blade-local memory */
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1bd15b1f7712..10d3bdf874a0 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -546,7 +546,6 @@ unsigned long sn_rtc_cycles_per_second;
 EXPORT_SYMBOL(sn_rtc_cycles_per_second);
 
 /* The following values are used for the per node hub info struct */
-static __initdata unsigned short		*_node_to_pnode;
 static __initdata unsigned short		_min_socket, _max_socket;
 static __initdata unsigned short		_min_pnode, _max_pnode, _gr_table_len;
 static __initdata struct uv_gam_range_entry	*uv_gre_table;
@@ -554,6 +553,7 @@ static __initdata struct uv_gam_parameters	*uv_gp_table;
 static __initdata unsigned short		*_socket_to_node;
 static __initdata unsigned short		*_socket_to_pnode;
 static __initdata unsigned short		*_pnode_to_socket;
+static __initdata unsigned short		*_node_to_socket;
 
 static __initdata struct uv_gam_range_s		*_gr_table;
 
@@ -1293,6 +1293,7 @@ static void __init uv_init_hub_info(struct uv_hub_info_s *hi)
 	hi->nasid_shift		= uv_cpuid.nasid_shift;
 	hi->min_pnode		= _min_pnode;
 	hi->min_socket		= _min_socket;
+	hi->node_to_socket	= _node_to_socket;
 	hi->pnode_to_socket	= _pnode_to_socket;
 	hi->socket_to_node	= _socket_to_node;
 	hi->socket_to_pnode	= _socket_to_pnode;
@@ -1526,6 +1527,11 @@ static void __init free_1_to_1_table(unsigned short **tp, char *tname, int min,
 	pr_info("UV: %s is 1:1, conversion table removed\n", tname);
 }
 
+/*
+ * Build Socket Tables
+ * If the number of nodes is >1 per socket, socket to node table will
+ * contain lowest node number on that socket.
+ */
 static void __init build_socket_tables(void)
 {
 	struct uv_gam_range_entry *gre = uv_gre_table;
@@ -1552,27 +1558,25 @@ static void __init build_socket_tables(void)
 	/* Allocate and clear tables */
 	if ((alloc_conv_table(nump, &_pnode_to_socket) < 0)
 	    || (alloc_conv_table(nums, &_socket_to_pnode) < 0)
-	    || (alloc_conv_table(numn, &_node_to_pnode) < 0)
+	    || (alloc_conv_table(numn, &_node_to_socket) < 0)
 	    || (alloc_conv_table(nums, &_socket_to_node) < 0)) {
 		kfree(_pnode_to_socket);
 		kfree(_socket_to_pnode);
-		kfree(_node_to_pnode);
+		kfree(_node_to_socket);
 		return;
 	}
 
 	/* Fill in pnode/node/addr conversion list values: */
-	pr_info("UV: GAM Building socket/pnode conversion tables\n");
 	for (; gre->type != UV_GAM_RANGE_TYPE_UNUSED; gre++) {
 		if (gre->type == UV_GAM_RANGE_TYPE_HOLE)
 			continue;
 		i = gre->sockid - minsock;
-		/* Duplicate: */
-		if (_socket_to_pnode[i] != SOCK_EMPTY)
-			continue;
-		_socket_to_pnode[i] = gre->pnode;
+		if (_socket_to_pnode[i] == SOCK_EMPTY)
+			_socket_to_pnode[i] = gre->pnode;
 
 		i = gre->pnode - minpnode;
-		_pnode_to_socket[i] = gre->sockid;
+		if (_pnode_to_socket[i] == SOCK_EMPTY)
+			_pnode_to_socket[i] = gre->sockid;
 
 		pr_info("UV: sid:%02x type:%d nasid:%04x pn:%02x pn2s:%2x\n",
 			gre->sockid, gre->type, gre->nasid,
@@ -1582,34 +1586,29 @@ static void __init build_socket_tables(void)
 
 	/* Set socket -> node values: */
 	lnid = NUMA_NO_NODE;
-	for_each_present_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		int nid = cpu_to_node(cpu);
 		int apicid, sockid;
 
 		if (lnid == nid)
 			continue;
 		lnid = nid;
+
 		apicid = per_cpu(x86_cpu_to_apicid, cpu);
 		sockid = apicid >> uv_cpuid.socketid_shift;
-		_socket_to_node[sockid - minsock] = nid;
-		pr_info("UV: sid:%02x: apicid:%04x node:%2d\n",
-			sockid, apicid, nid);
-	}
 
-	/* Set up physical blade to pnode translation from GAM Range Table: */
-	for (lnid = 0; lnid < num_possible_nodes(); lnid++) {
-		unsigned short sockid;
+		if (_socket_to_node[sockid - minsock] == SOCK_EMPTY)
+			_socket_to_node[sockid - minsock] = nid;
 
-		for (sockid = minsock; sockid <= maxsock; sockid++) {
-			if (lnid == _socket_to_node[sockid - minsock]) {
-				_node_to_pnode[lnid] = _socket_to_pnode[sockid - minsock];
-				break;
-			}
-		}
-		if (sockid > maxsock) {
-			pr_err("UV: socket for node %d not found!\n", lnid);
-			BUG();
-		}
+		if (_node_to_socket[nid] == SOCK_EMPTY)
+			_node_to_socket[nid] = sockid;
+
+		pr_info("UV: sid:%02x: apicid:%04x socket:%02d node:%03x s2n:%03x\n",
+			sockid,
+			apicid,
+			_node_to_socket[nid],
+			nid,
+			_socket_to_node[sockid - minsock]);
 	}
 
 	/*
@@ -1617,6 +1616,7 @@ static void __init build_socket_tables(void)
 	 *   system runs faster by removing corresponding conversion table.
 	 */
 	FREE_1_TO_1_TABLE(_socket_to_node, _min_socket, nums, numn);
+	FREE_1_TO_1_TABLE(_node_to_socket, _min_socket, nums, numn);
 	FREE_1_TO_1_TABLE(_socket_to_pnode, _min_pnode, nums, nump);
 	FREE_1_TO_1_TABLE(_pnode_to_socket, _min_pnode, nums, nump);
 }
@@ -1702,12 +1702,13 @@ static __init int uv_system_init_hubless(void)
 static void __init uv_system_init_hub(void)
 {
 	struct uv_hub_info_s hub_info = {0};
-	int bytes, cpu, nodeid;
+	int bytes, cpu, nodeid, bid;
 	unsigned short min_pnode = USHRT_MAX, max_pnode = 0;
 	char *hub = is_uv5_hub() ? "UV500" :
 		    is_uv4_hub() ? "UV400" :
 		    is_uv3_hub() ? "UV300" :
 		    is_uv2_hub() ? "UV2000/3000" : NULL;
+	struct uv_hub_info_s **uv_hub_info_list_blade;
 
 	if (!hub) {
 		pr_err("UV: Unknown/unsupported UV hub\n");
@@ -1730,9 +1731,12 @@ static void __init uv_system_init_hub(void)
 	build_uv_gr_table();
 	set_block_size();
 	uv_init_hub_info(&hub_info);
-	uv_possible_blades = num_possible_nodes();
-	if (!_node_to_pnode)
+	/* If UV2 or UV3 may need to get # blades from HW */
+	if (is_uv(UV2|UV3) && !uv_gre_table)
 		boot_init_possible_blades(&hub_info);
+	else
+		/* min/max sockets set in decode_gam_rng_tbl */
+		uv_possible_blades = (_max_socket - _min_socket) + 1;
 
 	/* uv_num_possible_blades() is really the hub count: */
 	pr_info("UV: Found %d hubs, %d nodes, %d CPUs\n", uv_num_possible_blades(), num_possible_nodes(), num_possible_cpus());
@@ -1741,79 +1745,98 @@ static void __init uv_system_init_hub(void)
 	hub_info.coherency_domain_number = sn_coherency_id;
 	uv_rtc_init();
 
+	/*
+	 * __uv_hub_info_list[] is indexed by node, but there is only
+	 * one hub_info structure per blade.  First, allocate one
+	 * structure per blade.  Further down we create a per-node
+	 * table (__uv_hub_info_list[]) pointing to hub_info
+	 * structures for the correct blade.
+	 */
+
 	bytes = sizeof(void *) * uv_num_possible_blades();
-	__uv_hub_info_list = kzalloc(bytes, GFP_KERNEL);
-	BUG_ON(!__uv_hub_info_list);
+	uv_hub_info_list_blade = kzalloc(bytes, GFP_KERNEL);
+	if (WARN_ON_ONCE(!uv_hub_info_list_blade))
+		return;
 
 	bytes = sizeof(struct uv_hub_info_s);
-	for_each_node(nodeid) {
+	for_each_possible_blade(bid) {
 		struct uv_hub_info_s *new_hub;
 
-		if (__uv_hub_info_list[nodeid]) {
-			pr_err("UV: Node %d UV HUB already initialized!?\n", nodeid);
-			BUG();
+		/* Allocate & fill new per hub info list */
+		new_hub = (bid == 0) ?  &uv_hub_info_node0
+			: kzalloc_node(bytes, GFP_KERNEL, uv_blade_to_node(bid));
+		if (WARN_ON_ONCE(!new_hub)) {
+			/* do not kfree() bid 0, which is statically allocated */
+			while (--bid > 0)
+				kfree(uv_hub_info_list_blade[bid]);
+			kfree(uv_hub_info_list_blade);
+			return;
 		}
 
-		/* Allocate new per hub info list */
-		new_hub = (nodeid == 0) ?  &uv_hub_info_node0 : kzalloc_node(bytes, GFP_KERNEL, nodeid);
-		BUG_ON(!new_hub);
-		__uv_hub_info_list[nodeid] = new_hub;
-		new_hub = uv_hub_info_list(nodeid);
-		BUG_ON(!new_hub);
+		uv_hub_info_list_blade[bid] = new_hub;
 		*new_hub = hub_info;
 
 		/* Use information from GAM table if available: */
-		if (_node_to_pnode)
-			new_hub->pnode = _node_to_pnode[nodeid];
+		if (uv_gre_table)
+			new_hub->pnode = uv_blade_to_pnode(bid);
 		else /* Or fill in during CPU loop: */
 			new_hub->pnode = 0xffff;
 
-		new_hub->numa_blade_id = uv_node_to_blade_id(nodeid);
+		new_hub->numa_blade_id = bid;
 		new_hub->memory_nid = NUMA_NO_NODE;
 		new_hub->nr_possible_cpus = 0;
 		new_hub->nr_online_cpus = 0;
 	}
 
+	/*
+	 * Now populate __uv_hub_info_list[] for each node with the
+	 * pointer to the struct for the blade it resides on.
+	 */
+
+	bytes = sizeof(void *) * num_possible_nodes();
+	__uv_hub_info_list = kzalloc(bytes, GFP_KERNEL);
+	if (WARN_ON_ONCE(!__uv_hub_info_list)) {
+		for_each_possible_blade(bid)
+			/* bid 0 is statically allocated */
+			if (bid != 0)
+				kfree(uv_hub_info_list_blade[bid]);
+		kfree(uv_hub_info_list_blade);
+		return;
+	}
+
+	for_each_node(nodeid)
+		__uv_hub_info_list[nodeid] = uv_hub_info_list_blade[uv_node_to_blade_id(nodeid)];
+
 	/* Initialize per CPU info: */
 	for_each_possible_cpu(cpu) {
-		int apicid = per_cpu(x86_cpu_to_apicid, cpu);
-		int numa_node_id;
+		int apicid = early_per_cpu(x86_cpu_to_apicid, cpu);
+		unsigned short bid;
 		unsigned short pnode;
 
-		nodeid = cpu_to_node(cpu);
-		numa_node_id = numa_cpu_node(cpu);
 		pnode = uv_apicid_to_pnode(apicid);
+		bid = uv_pnode_to_socket(pnode) - _min_socket;
 
-		uv_cpu_info_per(cpu)->p_uv_hub_info = uv_hub_info_list(nodeid);
+		uv_cpu_info_per(cpu)->p_uv_hub_info = uv_hub_info_list_blade[bid];
 		uv_cpu_info_per(cpu)->blade_cpu_id = uv_cpu_hub_info(cpu)->nr_possible_cpus++;
 		if (uv_cpu_hub_info(cpu)->memory_nid == NUMA_NO_NODE)
 			uv_cpu_hub_info(cpu)->memory_nid = cpu_to_node(cpu);
 
-		/* Init memoryless node: */
-		if (nodeid != numa_node_id &&
-		    uv_hub_info_list(numa_node_id)->pnode == 0xffff)
-			uv_hub_info_list(numa_node_id)->pnode = pnode;
-		else if (uv_cpu_hub_info(cpu)->pnode == 0xffff)
+		if (uv_cpu_hub_info(cpu)->pnode == 0xffff)
 			uv_cpu_hub_info(cpu)->pnode = pnode;
 	}
 
-	for_each_node(nodeid) {
-		unsigned short pnode = uv_hub_info_list(nodeid)->pnode;
+	for_each_possible_blade(bid) {
+		unsigned short pnode = uv_hub_info_list_blade[bid]->pnode;
 
-		/* Add pnode info for pre-GAM list nodes without CPUs: */
-		if (pnode == 0xffff) {
-			unsigned long paddr;
+		if (pnode == 0xffff)
+			continue;
 
-			paddr = node_start_pfn(nodeid) << PAGE_SHIFT;
-			pnode = uv_gpa_to_pnode(uv_soc_phys_ram_to_gpa(paddr));
-			uv_hub_info_list(nodeid)->pnode = pnode;
-		}
 		min_pnode = min(pnode, min_pnode);
 		max_pnode = max(pnode, max_pnode);
-		pr_info("UV: UVHUB node:%2d pn:%02x nrcpus:%d\n",
-			nodeid,
-			uv_hub_info_list(nodeid)->pnode,
-			uv_hub_info_list(nodeid)->nr_possible_cpus);
+		pr_info("UV: HUB:%2d pn:%02x nrcpus:%d\n",
+			bid,
+			uv_hub_info_list_blade[bid]->pnode,
+			uv_hub_info_list_blade[bid]->nr_possible_cpus);
 	}
 
 	pr_info("UV: min_pnode:%02x max_pnode:%02x\n", min_pnode, max_pnode);
@@ -1821,6 +1844,9 @@ static void __init uv_system_init_hub(void)
 	map_mmr_high(max_pnode);
 	map_mmioh_high(min_pnode, max_pnode);
 
+	kfree(uv_hub_info_list_blade);
+	uv_hub_info_list_blade = NULL;
+
 	uv_nmi_setup();
 	uv_cpu_init();
 	uv_setup_proc_files(0);
-- 
2.26.2

