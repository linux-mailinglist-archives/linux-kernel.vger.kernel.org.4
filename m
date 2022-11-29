Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C093363BD40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiK2Js2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiK2Js0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:48:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C15A6469
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669715305; x=1701251305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wmsGItexe72sOyEj5wmVRCqyjTOHw7jcpbQam55oxUg=;
  b=BBFZZfxs3tzj+vCjL1NKmGQkXKAbZESqJSIEci+bgIcsPyobXtHsblgh
   MgHewkcu9NKU6LHUIMXxumSrDwuk9ynIskfL9rvIr5oogDt0wN43es1ZQ
   TL7kP4luwbFVdSR0oJuHDbHunTyGu0faEGCf4HeunN/w6YxoGC1u7ViPA
   tiQPW1+HK+oOJkleNAsIihnJ+5O4jbnQjztOlbnEMrUc+GPsS1TUS4Od6
   n9oFYqkiDjr2uoj0fOXUQ+tGnrj5Q7RApeTDZeg4kPJTpVehGZrJN+Xwk
   G4c2bTR0hWkMNNjqbzQQBNh+gD20ANtkGqs2+OLSnR4/t2lbtLAlGfA0l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379334018"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="379334018"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 01:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="645837594"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="645837594"
Received: from leirao-pc.bj.intel.com ([10.238.156.101])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2022 01:48:21 -0800
From:   Lei Rao <lei.rao@intel.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        hang.yuan@intel.com
Cc:     Lei Rao <lei.rao@intel.com>
Subject: [PATCH] nvme: clear the prp2 field of the nvme command.
Date:   Tue, 29 Nov 2022 17:48:11 +0800
Message-Id: <20221129094811.893586-1-lei.rao@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
field is garbage data. According to nvme spec, the prp2 is reserved if
the data transfer does not cross a memory page boundary. Writing a
reserved coded value into a controller property field produces undefined
results, so it needs to be cleared in nvme_setup_prp_simple().

Signed-off-by: Lei Rao <lei.rao@intel.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f4335519399d..488ad7dabeb8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -797,6 +797,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
 	if (bv->bv_len > first_prp_len)
 		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	else
+		cmnd->dptr.prp2 = 0;
 	return BLK_STS_OK;
 }
 
-- 
2.34.1

