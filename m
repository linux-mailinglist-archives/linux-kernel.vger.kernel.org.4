Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F1F720D24
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 04:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjFCCJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbjFCCJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:09:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4561E4D;
        Fri,  2 Jun 2023 19:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685758170; x=1717294170;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+pAIGJKvRh7qS+esVik2IqS8poW9McX9jF5Ma8+7Pj8=;
  b=lqTinRtQ8ULE/4OTkxE070wSlpolX5BGls5WXUaysCuKp5AiKdYMm9gH
   STxV/jipZA8o8Yv//1k/VdLVkVf0kMUBtRC756VrNc9F08l52gsL9rbb6
   1Iq4fHeoR2vIHHnbMK1fjD3iF0liRJM7casYUx/MayejAySnpHSYU1e+p
   h4Gy5ktzcVARJ2WK9+4Dw6s3G8YyI4Txt+pXxEpWbp1nFyvcs3OfvDULk
   ADl6R/ptNsT9S0C6O6+vuA+H8UmKvq5nq6F4QvvgIhiwGyvoeZJjBWUK3
   5CYNPyoveJKusDamtY0GApOMlkNoKqHRAnUrTetppWLg8h3DWCZUbpaGm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="340649435"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="340649435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852354411"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="852354411"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.97.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:09:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 02 Jun 2023 19:09:21 -0700
Subject: [PATCH RFC 1/4] dax/bus: Fix leaked reference in
 alloc_dax_region()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-dax-region-put-v1-1-d8668f335d45@intel.com>
References: <20230602-dax-region-put-v1-0-d8668f335d45@intel.com>
In-Reply-To: <20230602-dax-region-put-v1-0-d8668f335d45@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Yongqiang Liu <liuyongqiang13@huawei.com>,
        Paul Cassella <cassella@hpe.com>, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685758165; l=1545;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=+pAIGJKvRh7qS+esVik2IqS8poW9McX9jF5Ma8+7Pj8=;
 b=23++xNTRjcMP4T5vDFqSFZUyo1YkZSoemfUGTjIUMhcqbFSXmYr5cAd6MW2Wr6cszXEqh1tkf
 NkYUKeFaToRARLPp8vO6Zk8hwWlXeXg+vJ7nCwlHcCYJKPsUiD/qPNW
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kref_init() initializes the ref count to 1.  An extra kref is taken on
the dax_region to be used by the caller.  If devm_add_action_or_reset()
fails this extra reference is leaked.

Drop the extra reference on error.

Fixes: d7fe1a67f658 ("dax: add region 'id', 'size', and 'align' attributes")
Cc: Dan Williams <dan.j.williams@intel.com
Suggested-by: Paul Cassella <cassella@hpe.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 227800053309..899e29d107b4 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -583,6 +583,7 @@ static void dax_region_unregister(void *region)
 	dax_region_put(dax_region);
 }
 
+/* The dax_region reference returned should be dropped with dax_region_put() */
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
 		unsigned long flags)
@@ -625,9 +626,13 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		return NULL;
 	}
 
+	/* Hold a reference to return to the caller */
 	kref_get(&dax_region->kref);
-	if (devm_add_action_or_reset(parent, dax_region_unregister, dax_region))
+	if (devm_add_action_or_reset(parent, dax_region_unregister,
+				     dax_region)) {
+		kref_put(&dax_region->kref, dax_region_free);
 		return NULL;
+	}
 	return dax_region;
 }
 EXPORT_SYMBOL_GPL(alloc_dax_region);

-- 
2.40.0

