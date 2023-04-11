Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5CF6DD363
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjDKGuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjDKGth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:49:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469BB40DB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195744; x=1712731744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KLcSzST6hDd+fcr/F74YMXpjYh9sQavSmsQ3e9U8YPk=;
  b=mMWV0gZF369JfYk0K9qcRLqRY1D8k4cXx7WLPcY0ABcB0Ctye7x6o8EH
   eJLOIzDvLiweUPWuZf0r5PUCUu0aMCrcR0Xn3yedv2wEUf+8SrgIuhvkI
   tWFaAxY7opeGypBTgXms5iaiGsW/NfuUnEjSkbjDuTx2HykG10rvxZxpo
   p6zplp/Eytu8n1We1ZUZmwaG2WYO8L4Zrn9IPr+bDyyDyRZThfT7UoVaB
   94iw7bxLwI0uPeN1Zxt69BNR9XNmSfUH9rDGKr0t/ms+J2iWAmZzXdEi1
   ivcMmnYFYNOFGa02jof6aqb1htqOObUVxfAYceLfIDbfXvSfykgATlEL+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028553"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028553"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256594"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256594"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:24 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/17] iommu/vt-d: Do not use GFP_ATOMIC when not needed
Date:   Tue, 11 Apr 2023 14:48:05 +0800
Message-Id: <20230411064815.31456-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

There is no need to use GFP_ATOMIC here. GFP_KERNEL is already used for
some other memory allocations just a few lines above.

Commit e3a981d61d15 ("iommu/vt-d: Convert allocations to GFP_KERNEL") has
changed the other memory allocation flags.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/e2a8a1019ffc8a86b4b4ed93def3623f60581274.1675542576.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index df9e261af0b5..a1b987335b31 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -548,7 +548,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		goto out_free_table;
 	}
 
-	bitmap = bitmap_zalloc(INTR_REMAP_TABLE_ENTRIES, GFP_ATOMIC);
+	bitmap = bitmap_zalloc(INTR_REMAP_TABLE_ENTRIES, GFP_KERNEL);
 	if (bitmap == NULL) {
 		pr_err("IR%d: failed to allocate bitmap\n", iommu->seq_id);
 		goto out_free_pages;
-- 
2.34.1

