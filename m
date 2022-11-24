Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E8637864
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKXMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKXMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:02:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D4429BA;
        Thu, 24 Nov 2022 04:02:57 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXwitGVnHQi9ZmUqlVj77DSD4Gtci8EfV/LggeUQzU0=;
        b=jj4vhR3wO8W10nK0vToffjcizb/dOuDU3ZiSaEv4+dvwIuZ4fxWKCxywjn6KBRn/dQEwf3
        FvBQYCLTJXCW8OyDArTz9x36KC5qDm4cdzqTOxkpWSp/fWWZ15PUy4hhv6/AX2ORlfptF6
        6RJcG8XJ/JaBjIHTWG/+60DRK0cKx1a4Fwr/83Q5hrc0m0MNSCEIO8oXxOfx4a9TTecAkC
        Bi8hofqkQ0nFgA6OPRHZ+7H4n+0uSwFjBMBbgnDsTUywgwHKjl1tEIU8z+VnqJYcd920rZ
        GE/+GqiCHsHkDCltQ9xzAHrvEPUbHuhKVB1I7egFzMns8l9cQQmv/HBgAm01Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXwitGVnHQi9ZmUqlVj77DSD4Gtci8EfV/LggeUQzU0=;
        b=MNiHTjY3xLbVmKLchGODcSt4sAzwPJ7eauASKkoNSEm+WUkXxbJUmPOEg7xqVAJjOm4DNQ
        QZIVRJFnvuVxvOAw==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Get UPI NodeID and GroupID
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-8-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-8-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929137480.4906.2483450142908065340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c4aebdb3b5f50fd0d83bf0fc2d49ac299f8b61df
Gitweb:        https://git.kernel.org/tip/c4aebdb3b5f50fd0d83bf0fc2d49ac299f8b61df
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:29 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:22 +01:00

perf/x86/intel/uncore: Get UPI NodeID and GroupID

The GIDNIDMAP register of UBOX device is used to get the topology
information in the snbep_pci2phy_map_init(). The same approach will be
used to discover UPI topology for ICX and SPR platforms.

Move common code that will be reused in next patches.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-8-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 33 ++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index f682a9a..6da5f69 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1372,6 +1372,28 @@ static struct pci_driver snbep_uncore_pci_driver = {
 
 #define NODE_ID_MASK	0x7
 
+/* Each three bits from 0 to 23 of GIDNIDMAP register correspond Node ID. */
+#define GIDNIDMAP(config, id)	(((config) >> (3 * (id))) & 0x7)
+
+static int upi_nodeid_groupid(struct pci_dev *ubox_dev, int nodeid_loc, int idmap_loc,
+			      int *nodeid, int *groupid)
+{
+	int ret;
+
+	/* get the Node ID of the local register */
+	ret = pci_read_config_dword(ubox_dev, nodeid_loc, nodeid);
+	if (ret)
+		goto err;
+
+	*nodeid = *nodeid & NODE_ID_MASK;
+	/* get the Node ID mapping */
+	ret = pci_read_config_dword(ubox_dev, idmap_loc, groupid);
+	if (ret)
+		goto err;
+err:
+	return ret;
+}
+
 /*
  * build pci bus to socket mapping
  */
@@ -1397,13 +1419,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 		 * the topology.
 		 */
 		if (nr_node_ids <= 8) {
-			/* get the Node ID of the local register */
-			err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
-			if (err)
-				break;
-			nodeid = config & NODE_ID_MASK;
-			/* get the Node ID mapping */
-			err = pci_read_config_dword(ubox_dev, idmap_loc, &config);
+			err = upi_nodeid_groupid(ubox_dev, nodeid_loc, idmap_loc,
+						 &nodeid, &config);
 			if (err)
 				break;
 
@@ -1421,7 +1438,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
 			 * to a particular node.
 			 */
 			for (i = 0; i < 8; i++) {
-				if (nodeid == ((config >> (3 * i)) & 0x7)) {
+				if (nodeid == GIDNIDMAP(config, i)) {
 					if (topology_max_die_per_package() > 1)
 						die_id = i;
 					else
