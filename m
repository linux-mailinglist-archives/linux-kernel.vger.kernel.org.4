Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B074262DADA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiKQM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240078AbiKQM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A11725CB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688131; x=1700224131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4+L4macmpM66/vEIz+MAvlGT/49BgkmRfbdg36NVQp8=;
  b=F6tEVnXCansAS7lNFydnF7GGhc8JQ9muOoIUnGE+m842jgZrf+Avc3p2
   8YMqjPWqTVY1wejX04yEFk3lzOxHpbK0NHtGKU0IdZy7GFZXRfrHCtcGH
   +sfqr56bG3KfXHGPvRs0gq1nv25vcQztGeIsLVvL8ALYqw25qevWR8ssQ
   R44PkyApuBTmmJXHvr3JdhKz87U0BCKbCQzfc9Mz3RJoy6Gg4Dg23y+OP
   Z5WcaUOwk9KneWWypDNaa/xeN7mOGB4XSIZ0baFr3S9sJvIDNNJ6CpaVx
   UMXkKeWsZLl9FquyPUjjtiuqi4VOAjvgDPpp2jcYQ4cLLO1aXIDwtdXUy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199873"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199873"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604557"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604557"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:46 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 07/11] perf/x86/intel/uncore: Get UPI NodeID and GroupID
Date:   Thu, 17 Nov 2022 12:28:29 +0000
Message-Id: <20221117122833.3103580-8-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

The GIDNIDMAP register of UBOX device is used to get the topology
information in the snbep_pci2phy_map_init(). The same approach will be
used to discover UPI topology for ICX and SPR platforms.

Move common code that will be reused in next patches.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 33 +++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index f682a9a0f562..6da5f692afea 100644
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
-- 
2.25.1

