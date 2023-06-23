Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7138173AF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFWESR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjFWERl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:17:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B592681
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687493837; x=1719029837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iWZGGyix0Jnxf4rnOLnziW88Q3MJPq4sHB9rNqCUItQ=;
  b=A2XNEvxMpN3fwvAZWwT4Q2762W5LxIj4TkE5uJe5k7StWK9IseU+LUIt
   3edW0QEJb4WPE5SBTfqt9EUjoCFawtAZ0rUQheh8myL8wrJlwnou6ZaT8
   43yTHEMedBp6kJeRVQ9GsUYV+X3BCg0+2Gq4MC7f7PthqrfZGwadojs0W
   Sx6AQawKVd/vou8EfiIABJcb34Cu6jGR7uNAcunqh15Eul5RoJmYqOy9B
   zeoFFaNX5JyME8XhLm7EtDKtPg/ffJK8bMmZ8STtVPVBnp2KzzCAeJ2wp
   GdlKc7kYbUu4bbjvIGAMRIK9Mj0GE5OgcYysjog9V+Zwd5Py58wZhBZWz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350445617"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350445617"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 21:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="744859485"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="744859485"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2023 21:17:12 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: fix bug in saving controller data
Date:   Fri, 23 Jun 2023 12:16:41 +0800
Message-Id: <20230623041641.1865437-2-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623041641.1865437-1-tien.sung.ang@intel.com>
References: <20230623041641.1865437-1-tien.sung.ang@intel.com>
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
in the rmmod of the svc driver to fail and throw a kernel panic for
kthread_stop and fifo free.

Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")
Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 80f4e2d14e04..cb72e52bd681 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -133,6 +133,7 @@ struct stratix10_svc_data {
  * @complete_status: state for completion
  * @svc_fifo_lock: protect access to service message data queue
  * @invoke_fn: function to issue secure monitor call or hypervisor call
+ * @svc: manages the list of client svc drivers
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -149,6 +150,7 @@ struct stratix10_svc_controller {
 	struct completion complete_status;
 	spinlock_t svc_fifo_lock;
 	svc_invoke_fn *invoke_fn;
+	struct stratix10_svc *svc;
 };
 
 /**
@@ -1191,6 +1193,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_free_kfifo;
 	}
+	controller->svc = svc;
 
 	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
 	if (!svc->stratix10_svc_rsu) {
@@ -1218,8 +1221,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		goto err_unregister_dev;
 	}
 
-	dev_set_drvdata(dev, svc);
-
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
@@ -1235,8 +1236,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 static int stratix10_svc_drv_remove(struct platform_device *pdev)
 {
-	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
+	struct stratix10_svc *svc = ctrl->svc;
 
 	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
-- 
2.25.1

