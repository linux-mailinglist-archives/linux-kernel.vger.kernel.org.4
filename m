Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA03473D1AA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjFYPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFYPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:18:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B51B8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687706293; x=1719242293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NbhV1jUvIvoPeaMjWeaCFCY5V1AWw9RzK0uK6KP563I=;
  b=S9m44QiBfsasQInK9mKlcQwBofYKrUAYfbXkz07OzxCorx9lKSSc36qR
   OCdf0guBmUHdEujJDs9GZyhWIcKj2WF469mlEo/nBIfVzOOoW5E3KbJrT
   dzWpgpEsFU4JAP+NbRS57jQIhda/0mOUweMh4RspgYtODIjpCK4NDbjZ9
   hDY8dZaL7u3JQIFBLlbhUtnSTxLiLFjhTeEqZm4HRO9mmw+0303zYFZFb
   LCt9S94vunDc6mV/gDUMS6jzMFauxT+8xuRBv2lPWgu2kWVC0qHUoTj8X
   qVtUQcuqvWtQMENbIQMY5AYYUCFzCcqzblxUbLuBW1IJgIPNw2mIjrCKL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391255102"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="391255102"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 08:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840004542"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="840004542"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2023 08:18:10 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 5/5] iommu/vt-d: debugfs: Dump entry pointing to huge page
Date:   Sun, 25 Jun 2023 23:04:42 +0800
Message-Id: <20230625150442.42197-6-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20230625150442.42197-1-Jingqi.liu@intel.com>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the page table entry pointing to a huge page, the data below the
level of the huge page is meaningless and does not need to be dumped.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index e4d3b7836076..f5e26cc21905 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -326,9 +326,14 @@ static inline unsigned long level_to_directory_size(int level)
 static inline void
 dump_page_info(struct seq_file *m, unsigned long iova, u64 *path)
 {
-	seq_printf(m, "0x%013lx |\t0x%016llx\t0x%016llx\t0x%016llx\t0x%016llx\t0x%016llx\n",
-		   iova >> VTD_PAGE_SHIFT, path[5], path[4],
-		   path[3], path[2], path[1]);
+	seq_printf(m, "0x%013lx |\t0x%016llx\t0x%016llx\t0x%016llx",
+		   iova >> VTD_PAGE_SHIFT, path[5], path[4], path[3]);
+	if (path[2]) {
+		seq_printf(m, "\t0x%016llx", path[2]);
+		if (path[1])
+			seq_printf(m, "\t0x%016llx", path[1]);
+	}
+	seq_putc(m, '\n');
 }
 
 static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
-- 
2.21.3

