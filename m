Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF7708CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjESAFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjESAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:05:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383D1E77;
        Thu, 18 May 2023 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684454702; x=1715990702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3xHRy6KbwsjGx/sRwLZsoxpVJFd7CR2yUrei5ryLZ0=;
  b=Eb8ZRt8KiHsEN3EXssJCWv+OZ074B7MIrrnUiez0iq6VoMaZy8S/kE7/
   QZwCKhrEsZGvgwGGfayPhBls5vir9tk7lNyOEAbZ1hsZrz8XOeNf6/E2S
   GnrRcJnxuzksS5zzXqJlygOeCGtl0iVn5T4Svw2OdtV0YsVa91BWzqDt5
   I0dxomKp5E851pSIG3Js2ajdlTb3heEWqNDTk9GtREL7N7NkfgJ/pXw7a
   rMAk0Kuhdj/1jBhCqmNeNaah+/bNuzTxiYGDUfB10i1RBg+jeAt6dOviF
   jFdunp+IoLy4ERyx5XJzhPaPulgqDJ3ZTUOqTf6I+H7MuejZZ2aajrAp5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355446219"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="355446219"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="876634939"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="876634939"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.20.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:05:01 -0700
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
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window
Date:   Thu, 18 May 2023 17:04:56 -0700
Message-Id: <ef68b0601955f38b026b0bd41936a0aafea89446.1684448934.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684448934.git.alison.schofield@intel.com>
References: <cover.1684448934.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
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

