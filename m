Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B72640D19
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiLBSZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiLBSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:25:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334DD80DC;
        Fri,  2 Dec 2022 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670005516; x=1701541516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vHVG1zmi+voAUhJdqIebJ6t9QgESsGvpHFArjS4/Pac=;
  b=b6JUWx/1AQi4NkezOdtZCRUEb63rxL/HALnt0JmmWU5bSvpXiQnoL8/h
   947Gkej4q61BI7TpTa1vr6PsSGWuR8w/nX9CLCHvHsulQhsVZSdFmblHt
   Q8qf7/q1Sxs5VJEhiLxZwZT8BeSOUO35EyB8SfmvMF+RxaWbuCE8qB3kv
   u6TsVaebWv7CF6+PwOIsxN9xZ1kKXVZGS1njQ8I3rrqhii38avwlxkH5S
   gUwUTtEAZgoenoOb25iKW8YNJ0iAid8rkONEhjkVKohPyltrsxYFnA2Ed
   Q8jsi5qzZcUHnAzId3gqIaBfM+3QBU0sKGDczufPmNu8OU4Exj6n4sov3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="378166715"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="378166715"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:25:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="622786436"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="622786436"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 10:25:15 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     fenghua.yu@intel.com, dave.jiang@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: idxd: Let probe fail when workqueue cannot be enabled
Date:   Fri,  2 Dec 2022 10:25:04 -0800
Message-Id: <1e74e8d74255ff47271c4c9eada7635676ccd320.1670005163.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1670005163.git.reinette.chatre@intel.com>
References: <cover.1670005163.git.reinette.chatre@intel.com>
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

The workqueue is enabled when the appropriate driver is loaded and
disabled when the driver is removed. When the driver is removed it
assumes that the workqueue was enabled successfully and proceeds to
free allocations made during workqueue enabling.

Failure during workqueue enabling does not prevent the driver from
being loaded. This is because the error path within drv_enable_wq()
returns success unless a second failure is encountered
during the error path. By returning success it is possible to load
the driver even if the workqueue cannot be enabled and
allocations that do not exist are attempted to be freed during
driver remove.

Some examples of problematic flows:
(a)

 idxd_dmaengine_drv_probe() -> drv_enable_wq() -> idxd_wq_request_irq():
 In above flow, if idxd_wq_request_irq() fails then
 idxd_wq_unmap_portal() is called on error exit path, but
 drv_enable_wq() returns 0 because idxd_wq_disable() succeeds. The
 driver is thus loaded successfully.

 idxd_dmaengine_drv_remove()->drv_disable_wq()->idxd_wq_unmap_portal()
 Above flow on driver unload triggers the WARN in devm_iounmap() because
 the device resource has already been removed during error path of
 drv_enable_wq().

(b)

 idxd_dmaengine_drv_probe() -> drv_enable_wq() -> idxd_wq_request_irq():
 In above flow, if idxd_wq_request_irq() fails then
 idxd_wq_init_percpu_ref() is never called to initialize the percpu
 counter, yet the driver loads successfully because drv_enable_wq()
 returns 0.

 idxd_dmaengine_drv_remove()->__idxd_wq_quiesce()->percpu_ref_kill():
 Above flow on driver unload triggers a BUG when attempting to drop the
 initial ref of the uninitialized percpu ref:
 BUG: kernel NULL pointer dereference, address: 0000000000000010

Fix the drv_enable_wq() error path by returning the original error that
indicates failure of workqueue enabling. This ensures that the probe
fails when an error is encountered and the driver remove paths are only
attempted when the workqueue was enabled successfully.

Fixes: 1f2bb40337f0 ("dmaengine: idxd: move wq_enable() to device.c")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/dma/idxd/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 6f44fa8f78a5..fcd03d29a941 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1391,8 +1391,7 @@ int drv_enable_wq(struct idxd_wq *wq)
 err_irq:
 	idxd_wq_unmap_portal(wq);
 err_map_portal:
-	rc = idxd_wq_disable(wq, false);
-	if (rc < 0)
+	if (idxd_wq_disable(wq, false))
 		dev_dbg(dev, "wq %s disable failed\n", dev_name(wq_confdev(wq)));
 err:
 	return rc;
-- 
2.34.1

