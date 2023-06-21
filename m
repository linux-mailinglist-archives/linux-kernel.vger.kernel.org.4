Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF1737BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFUGuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjFUGtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:49:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587EF273A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687330044; x=1718866044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FL4viQoh2/5cl+BmlljLrt/kkNS/dDDnPTDOgJdOpNY=;
  b=XTppZTDemd+B+3plsBRmvzPLxEDzdexsU41nh0+jVihLz/Scbp8a044U
   MXq4CRoEm1Aw9TcjtUOUF52c6UWiEbGBqHHizL8bLH+/pfZKb5GxgzNkb
   8u3GxCb5amDcFCnYdLis1826FBRzgHMfyBdIXGCHJQ655Iy6nL9YfAuap
   ZXfnxjkaK5HP2fidVBhkDeFNggWhpUa1kR9ehOPik0p6GPCO/LKIPFW6q
   Nt1owTWFsv/7IdzCzbWgg/lfLyOO4f8oqcarxIQClT5cEpeZDRWG99g6l
   /BMear+xWUdiQfa7OnWJXzAhdXDzwoXCTFp4JTGHG6wmrdQoaFZEyXotD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389511916"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="389511916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 23:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779728091"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="779728091"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2023 23:47:22 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v2 2/2] firmware: stratix10-svc: fix bug in saving controller data
Date:   Wed, 21 Jun 2023 14:46:45 +0800
Message-Id: <20230621064645.1431883-3-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621064645.1431883-1-tien.sung.ang@intel.com>
References: <20230621064645.1431883-1-tien.sung.ang@intel.com>
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

