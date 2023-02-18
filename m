Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCED69B786
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 02:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBRBik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 20:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRBij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 20:38:39 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD3B5D3DC;
        Fri, 17 Feb 2023 17:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676684318; x=1708220318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S9pcj8A3kuWdxO/qpytQHbhEZebV7ayvDbM+nYuhP4U=;
  b=TxFaw0b12xzr6zG62bntBaVm4IBYsJHrFMsRAIhkR7QfKI3QylNexHaU
   WkLq1i+kZ/sTxr1Sf1jj6y8GcAr9WbZnZJyEbarySQqc4EbdMHq3F1P7e
   C+ZOhuPClrE0xpGdO9YKlUqrkUI0JF1MrJjJF1FE4/l8equG0NnSYhdpL
   oby2qbB/6L0sVVKT7tqtSBlxSATX+LYq+aQmtaSEa5oRnDDCTrW9npikr
   UX0Auyd+WrhZOzDeSMPglMlf++rVDrRRjfYwuANwv6J3MJd9VbPc06AY6
   mPVvMZlmWg5PLlOQXFq6v0GSmIaXmuyJf0S0/lRwxW3I8JwaQ/e9kmjV8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="333491010"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="333491010"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 17:38:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="620572604"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="620572604"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.133.15])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 17:38:37 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/hdm: dev_warn() on unsupported mixed mode decoder
Date:   Fri, 17 Feb 2023 17:38:34 -0800
Message-Id: <20230218013834.31237-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

A mixed mode decoder is programmed with device physical addresses
that span both ram and pmem partitions of a memdev.

Linux does not support mixed mode decoders. The driver rejects
sysfs writes that try to set decoder mode to mixed, and if a
resource bieng allocated is not wholly contained in either the
pmem or ram partition of a memdev, it is also rejected. Basically,
the CXL region driver is not going to create regions with mixed
mode decoders, but the BIOS could.

If the kernel driver sees the mixed mode decoder, it will fail to
enable the region, and emit a dev_dbg() message.

A dev_dbg() is not noisy enough in this case. Change the message
to be a dev_warn() that explicitly says mixed mode is not supported.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 45deda18ed32..9eaf93c8ebb0 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -294,8 +294,8 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	else if (resource_contains(&cxlds->ram_res, res))
 		cxled->mode = CXL_DECODER_RAM;
 	else {
-		dev_dbg(dev, "decoder%d.%d: %pr mixed\n", port->id,
-			cxled->cxld.id, cxled->dpa_res);
+		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
+			 port->id, cxled->cxld.id, cxled->dpa_res);
 		cxled->mode = CXL_DECODER_MIXED;
 	}
 

base-commit: a5fcd228ca1db9810ba1ed461c90b6ee933b9daf
-- 
2.37.3

