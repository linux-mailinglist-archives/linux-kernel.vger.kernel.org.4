Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C120F72F39C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbjFNEgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbjFNEf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:35:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24231BD4;
        Tue, 13 Jun 2023 21:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686717355; x=1718253355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pExp2WMXGyNpxCyGDYOXewD2SNqta6zQBIAwkyT6MEY=;
  b=MBBAxp/iwb5IyinxAVKMqxiEJT09Z7M9iVRaoRNqvWvcF/+GCdzScyYX
   jv15em1L6PK6Pl+xQJvzfirrJwbl51yq+3MULo2j3Yh9qVsgL94B4Wo4Z
   ByFfKfT5zsUvgbGwsCvUu8Pd74dWwUPrb4u3F7MfJYz7cr4d1/K8STeGK
   8WynePFqffh4SCm5iVddZGzVJklqlwIIzwMSfG2KxFWOK7u7tLFFPg33i
   +kx93a4FEc4+ekLS5sknDSR+bufHWBMq3GBAKW84fIim57qqTXLqtphOU
   SwokxY3phf/HMUxeGthXChFZll7Uv8aFp+KfR/FQKqOH1br1osoUYefdA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="360998751"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="360998751"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 21:35:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="662251423"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="662251423"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.233.239])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 21:35:30 -0700
From:   alison.schofield@intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derick Marks <derick.w.marks@intel.com>
Subject: [PATCH v2 2/2] ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window
Date:   Tue, 13 Jun 2023 21:35:25 -0700
Message-Id: <2871681bbe6aeac8a5d8f197d6f21749da9d75d7.1686712819.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686712819.git.alison.schofield@intel.com>
References: <cover.1686712819.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
CFMWS not in SRAT") did not account for the case where the BIOS
only partially describes a CFMWS Window in the SRAT. That means
the omitted address ranges, of a partially described CFMWS Window,
do not get assigned to a NUMA node.

Replace the call to phys_to_target_node() with numa_add_memblks().
Numa_add_memblks() searches an HPA range for existing memblk(s)
and extends those memblk(s) to fill the entire CFMWS Window.

Extending the existing memblks is a simple strategy that reuses
SRAT defined proximity domains from part of a window to fill out
the entire window, based on the knowledge* that all of a CFMWS
window is of a similar performance class.

*Note that this heuristic will evolve when CFMWS Windows present
a wider range of characteristics. The extension of the proximity
domain, implemented here, is likely a step in developing a more
sophisticated performance profile in the future.

There is no change in behavior when the SRAT does not describe
the CFMWS Window at all. In that case, a new NUMA node with a
single memblk covering the entire CFMWS Window is created.

Fixes: fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
Reported-by: Derick Marks <derick.w.marks@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Derick Marks <derick.w.marks@intel.com>
---
 drivers/acpi/numa/srat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 1f4fc5f8a819..12f330b0eac0 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -310,11 +310,16 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
-	/* Skip if the SRAT already described the NUMA details for this HPA */
-	node = phys_to_target_node(start);
-	if (node != NUMA_NO_NODE)
+	/*
+	 * The SRAT may have already described NUMA details for all,
+	 * or a portion of, this CFMWS HPA range. Extend the memblks
+	 * found for any portion of the window to cover the entire
+	 * window.
+	 */
+	if (!numa_fill_memblks(start, end))
 		return 0;
 
+	/* No SRAT description. Create a new node. */
 	node = acpi_map_pxm_to_node(*fake_pxm);
 
 	if (node == NUMA_NO_NODE) {
-- 
2.37.3

