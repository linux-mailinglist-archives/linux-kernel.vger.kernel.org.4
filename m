Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56264718E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjEaWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjEaWON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:14:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2189C19F;
        Wed, 31 May 2023 15:13:52 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685571217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Idql9wYvayKlckV//P3YAjharrUUnA7q9DOtYjFM6JU=;
        b=gR3/ozlug71f8BWfJinh5G6JzawN+9PzXRf5WlymIk2wzgZiiayI7La0K5gdF11yDeNDVj
        nB3utUv/yB40crtr2X6cPjOtWruuBDt1gk/qymp93gz2OneYz8Q+OhCs9n6NVgyY5xkJDA
        gqmsNbQHP1Y62WliAwcMYkO4MNJn8F9oYXm9sKZHI2sLA4heKrZkUyv/kIV+lA3G+RQoCV
        g7tVUrtZnL9m7zZaVA31tCnkbmlnPhCvpDHBB4EREgj1UHe0YCLIgXeVn3VdeMaNvxrmCJ
        k9pyXnKwW4V9PhFszheUNLyV/88pDn2Xno5MxX50MYbHxP56j6kp1TZ0xK93oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685571217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Idql9wYvayKlckV//P3YAjharrUUnA7q9DOtYjFM6JU=;
        b=ZrRdBFDiF9mhpyRTVqiq/Tpv4YKyTwT+MaauI6BJbRoQzVo3yAV6M+OrF45nPv2Pz6TuH3
        ARxAEnnPkQImP+DQ==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Helper functions for allocating
 and freeing conversion tables
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168557121713.404.15918712839713361105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     45e9f9a99529a54a7ed195eea4aad102b9eadb23
Gitweb:        https://git.kernel.org/tip/45e9f9a99529a54a7ed195eea4aad102b9eadb23
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 19 May 2023 14:07:49 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 May 2023 09:34:59 -07:00

x86/platform/uv: Helper functions for allocating and freeing conversion tables

Add alloc_conv_table() and FREE_1_TO_1_TABLE() to reduce duplicated
code among the conversion tables we use.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230519190752.3297140-6-steve.wahl%40hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 97 +++++++++++++++--------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 2da84be..1bd15b1 100644
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
