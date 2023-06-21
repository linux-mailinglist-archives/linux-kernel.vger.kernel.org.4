Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDE73795A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFUCuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFUCt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:49:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C4610C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687315799; x=1718851799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IMtGCrLO3YpuKxkzasfmBJGNYdQfJI324OqayZwJdc4=;
  b=m0mi8CVW392pGYYGjBSmnh+SgT3lFSphnxhkIOi2Y+vcRqqehgv6//0L
   6e/X95kKxR4rX4KzJuKHvRlxoOmVe7+QnWzW4pPUagPgdUewZMgeZabQi
   yS0Z7XlkWCXbq1WsmeON0VxMvUH6ffUikk/9/X1zsf6Vyq5xbBfpxOgNm
   CG7TasWtBFDt/bA85ycqYTg5Tb4jpujbAZxq43GUP/79vHx+n/SzZx8Mo
   eADlEF+mRYuK6KK5sMh+AEE1IzFgCVnYDeprjIrMIPwR/eGCjZhZ3JVIH
   Kd+Gz/5iy/guvWmV5UwDIeBkliuyBHDXAh8e/PbLYUg4R96C+AkP0p+V0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358916416"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="358916416"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 19:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="743994770"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="743994770"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2023 19:49:57 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v1 2/2] firmware: stratix10-svc: fix bug in saving controller data
Date:   Wed, 21 Jun 2023 10:49:30 +0800
Message-Id: <20230621024930.1392294-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
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

From: Ang Tien Sung <tien.sung.ang@intel.com>

Fix the incorrect usage of platform_set_drvdata and dev_set_drvdata.
They both are of the same data and overrides each other. This resulted
in the rmmod of the svc driver to fail and throw a kernel panic
for kthread_stop and fifo free.

Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index ca713f39107e..60e08987c402 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -130,6 +130,7 @@ struct stratix10_svc_data {
  * @complete_status: state for completion
  * @invoke_fn: function to issue secure monitor call or hypervisor call
  * @sdm_lock: a mutex lock to allow only one pending sdm message per client
+ * @svc: manages the list of client svc drivers
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -144,6 +145,7 @@ struct stratix10_svc_controller {
 	svc_invoke_fn *invoke_fn;
 	/* Enforces atomic command sending to SDM */
 	struct mutex *sdm_lock;
+	struct stratix10_svc *svc;
 };
 
 /**
@@ -1252,6 +1254,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_kfifo;
 	}
+	controller->svc = svc;
 
 	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
 	if (!svc->stratix10_svc_rsu) {
@@ -1279,8 +1282,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		goto err_unregister_dev;
 	}
 
-	dev_set_drvdata(dev, svc);
-
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
@@ -1296,8 +1297,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 static int stratix10_svc_drv_remove(struct platform_device *pdev)
 {
-	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
+	struct stratix10_svc *svc = ctrl->svc;
 
 	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
-- 
2.25.1

