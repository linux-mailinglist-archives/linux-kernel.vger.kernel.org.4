Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29691678CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjAXApx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAXApv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:45:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90ED2ED4C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674521151; x=1706057151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/wzLkEnAqdDrA9q6+UgWLb7nmAJz6Hrh36W9SoY5p20=;
  b=g62PvPkEEFqssFoe3caq/VT/BFaQnWKOAXKLHYQANXOEwc22WudQ4DMh
   1jagOcI8zJRD6ir+agT7+878N2agyx2Wf20IW8a6q6QLiofqbJJ1KpQYx
   rZlZ0zRto6QR15NHxq5vUfM4JpuDvuu2XHu+xYi8ovecisk4laEurncsK
   zbznZpODGgwbMKE5fQ6iSABuGi7fMLi64Py1Ofppzh7yg/Auf861h9jR+
   JwOmrRTDiLfOqPyUtlzU0/TpKIsECBmkj2L+7E9kcXtFp5SWG8iP+MMhS
   L4GFriPXhJU9Qqw1uSrRkr9m9gF8Bhwx/a+evDkx/dJDFQ+VqqmG0KCG2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314101089"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="314101089"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="611855604"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="611855604"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by orsmga003.jf.intel.com with SMTP; 23 Jan 2023 16:45:43 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Jan 2023 02:45:42 +0200
From:   Ville Syrjala <ville.syrjala@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs mount regression
Date:   Tue, 24 Jan 2023 02:45:42 +0200
Message-Id: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Async probe caused a regression where we fail to find the
rootfs in time, leading an unbootable machine.

rootdelay=1 can be used as a workaround but that needlessly
slows down the boot by a whole extra second.

To get the best of both worlds perhaps there should be
some kind of async probe flush/sync just before attempting
to mount the rootfs?

In the meantime just switch back to a sync probe to fix
the regression.

Cc: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@fb.com>
Fixes: eac3ef262941 ("nvme-pci: split the initial probe from the rest path")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1ff8843bc4b3..d0f5e93d977e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3514,7 +3514,6 @@ static struct pci_driver nvme_driver = {
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
 	.driver		= {
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.1

