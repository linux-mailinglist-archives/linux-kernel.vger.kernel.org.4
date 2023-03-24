Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08446C7879
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCXHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCXHIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:08:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B95261;
        Fri, 24 Mar 2023 00:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679641702; x=1711177702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Is2PNwJDYKRvv3xNHfYVY2PhgMrlEfNhGTel6iyfNy8=;
  b=aUvsfTZqzs4/PkVoh8LJ+/8S0So/E1+Cli7KlLLMJP3dsW6toxaS+VW6
   RWalAUS/V4yHCoj+Bq1IlqZ+PXT2tSC+cQ5wCQbY/suSft6+mS9fMdPYD
   /a4s4k/HdgrJ7QSQqtjg1f6JhCGTpv/gzu3sLhh1n3PIWrLfnWyInZBtP
   0nG5tWLX+Cue+Y3Sd9aaVN1G2Cs6+ECswDbBueFwFrpQ/ep+nQIacm8IN
   a183X1RDkm3Pel4aoTZLZN+GtNF1eiwhDGMLWFz7DOCzqjhkjv2Bq5Quk
   fs724P15gRpswH6w6CEtoVARjkR+WfGZtMeDfkbHknKysWgPS5I3VFBnF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402296736"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="402296736"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="747046063"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="747046063"
Received: from fli4-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.28.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:20 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] thermal/core: Avoid unbind for thermal zones without .unbind()
Date:   Fri, 24 Mar 2023 15:08:07 +0800
Message-Id: <20230324070807.6342-5-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324070807.6342-1-rui.zhang@intel.com>
References: <20230324070807.6342-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ops->bind()/unbind() callback is the only way to bind/unbind a
cooling device to/from a thermal zone.

Optimize the code to avoid trying unbind when .unbind() callback doesn't
exist.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9c447f22cb39..1af36450f13e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1411,6 +1411,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	}
 	list_del(&tz->node);
 
+	if (!tz->ops->unbind)
+		goto unbind_done;
+
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node) {
 		struct thermal_instance *ti;
@@ -1428,8 +1431,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		continue;
 
 unbind:
-		if (tz->ops->unbind)
-			tz->ops->unbind(tz, cdev);
+		tz->ops->unbind(tz, cdev);
 
 		/*
 		 * The thermal instances for current thermal zone has been
@@ -1441,6 +1443,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		mutex_unlock(&cdev->lock);
 	}
 
+unbind_done:
 	mutex_unlock(&thermal_list_lock);
 
 	cancel_delayed_work_sync(&tz->poll_queue);
-- 
2.25.1

