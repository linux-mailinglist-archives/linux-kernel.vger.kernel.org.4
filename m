Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7040F6C7875
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCXHI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCXHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:08:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B969E2723;
        Fri, 24 Mar 2023 00:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679641697; x=1711177697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNQRMQLHwGWEKQ5jQmcWcG0jrDlQUzQ9voomVMZTSz8=;
  b=F4jTTHnMhJRVdfDYr1sqW1xw7ofz+7oJ+Q28R37QQei5ja0chpI+LGC8
   0bcoMm92u7djLPv75f1T+ygOOmUhbgDbXNVmmeBqOIo75ZVweCpytAGOF
   RosBzFrpNgM71FXopBLtbpaWLeAt8yiZLT2vAN7C+cMJIKnA14syONI6R
   Oy6Lfki9QG+qdHxTME1dz7/30m4Q34TrBZFyNLW4RNXdPY1eiuZGn0UjA
   GgGlHtQ6m5mH+Dx34hWvE2w263maJnKKc39gO8Pl5i++Kr1ovifcYPhZF
   9VX7UEmrefGpSo9Fv/K+Zx/BHIlOsyQRUzd8t7KEyF97jI+ZU96LLW2Vu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402296717"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="402296717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="747046053"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="747046053"
Received: from fli4-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.28.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:16 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] thermal/core: Reset cooling state during cooling device unregistration
Date:   Fri, 24 Mar 2023 15:08:04 +0800
Message-Id: <20230324070807.6342-2-rui.zhang@intel.com>
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

When unregistering a cooling device, it is possible that the cooling
device has been activated. And once the cooling device is unregistered,
no one will deactivate it anymore.

Reset cooling state during cooling device unregistration.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
In theory, this problem that this patch fixes can be triggered on a
platform with ACPI Active cooling, by
1. overheat the system to trigger ACPI active cooling
2. unload ACPI fan driver
3. check if the fan is still spinning
But I don't have such a system so I didn't trigger then problem and I
only did build & boot test.
---
 drivers/thermal/thermal_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 30ff39154598..fd54e6c10b60 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1192,6 +1192,10 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 		}
 	}
 
+	mutex_lock(&cdev->lock);
+	cdev->ops->set_cur_state(cdev, 0);
+	mutex_unlock(&cdev->lock);
+
 	mutex_unlock(&thermal_list_lock);
 
 	device_unregister(&cdev->device);
-- 
2.25.1

