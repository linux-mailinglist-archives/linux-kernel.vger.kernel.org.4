Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A9C736258
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjFTDxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjFTDxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:53:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D6E6C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687233179; x=1718769179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JpbJWsSwaaC/drH3jVErY68tkxJVzs0eFRjWRRqjgjc=;
  b=FMDGcy1nGLunMd40QrlhcTpeqTNlhc2b38Paunz9x916xJIrPL3YaQLo
   slQMknFoyo2yQSy8BCIIf+LS93vpdJ6Cr0vY8tjClTSmIVJy23ZKeA7w3
   YgmyUGwq+vqnE5KB2s+McBVd62q0c9WVPyqV5ygmz1rywbrSAW0OZbHeN
   NJwqyEkeOH2GDw4Wo9tad3o2N6f+pKqDKQjF3oCYARUHmzVGdTnpEJJhR
   vNQQk5Khz3/bwyJeRtoS+6aoofbAYSxltnit8t6HaIONr27W2caerSHIs
   rfksx2shlJ9AxrDTLgsYJ80Ynofa3yvdTFsCXb1wmtHi+a1/L2m4MC92p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="340101191"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="340101191"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:52:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838059971"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838059971"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga004.jf.intel.com with ESMTP; 19 Jun 2023 20:52:56 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 2/2] firmware: stratix10-svc: fix bug in saving controller data
Date:   Tue, 20 Jun 2023 11:52:34 +0800
Message-Id: <20230620035234.1158109-1-tien.sung.ang@intel.com>
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

