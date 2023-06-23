Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1973AF47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjFWENK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjFWEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:13:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10892117
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687493578; x=1719029578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vpq3KTccPLYbTcrUvpJYgigfCRCzXQUnV2vaEnLrOuE=;
  b=mDHBJzHk9/AgVvi9Q0FeVq2lBp2vjiqaPKDGcl/oQOYnu/J6455Vp8d6
   nTGeFnkEe+fIXY6EyBEte/rio4fb6Cql3i9BMFMyBApwEPPGGk6s+SHYg
   jYwlVJHc/cwwM4lRPP6FjpPUAWXBzJ2i5ZKtpdCCPu657gkqMa5/v5jME
   KyLq5QxyZ6XqJdJ4u2OpBKixO8BH0LlZ6YuciLsza3u6QZNX1Vf81XSoq
   L/ZjmvAD/JD/yPKBnogpLcCsK3egWAGoiAxZknCeO9L/45Ut7R+lD54wk
   Im1Rs78nPz+fR9kHKAO4VVhy5AUrV2DvihOR7IRng+A+cmoeticJuDtH+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="360705353"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="360705353"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 21:12:58 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749627071"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="749627071"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 21:12:55 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: fix bug in saving controller data
Date:   Fri, 23 Jun 2023 12:12:19 +0800
Message-Id: <20230623041219.1865239-2-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623041219.1865239-1-tien.sung.ang@intel.com>
References: <20230623041219.1865239-1-tien.sung.ang@intel.com>
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
in the rmmod of the svc driver to fail and throw a kernel panic for
kthread_stop and fifo free.

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

