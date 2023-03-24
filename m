Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304766C7878
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjCXHIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCXHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:08:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33FD10ABA;
        Fri, 24 Mar 2023 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679641700; x=1711177700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wFx21pLLRhlzjgfRpaT39oVLARW7iuGOv5zrbZTnlkk=;
  b=abu2PdgA1eA702P8ApPn2n/+vMIRXDH5u+K5esz1fQAaD/SyvTv8hW03
   gj+1vkJnB/IsZnKc88jr6Kk4ZkdKsR7DbyHQdZElF+quhahn3NQ6VMwD6
   CPhsx/EE+494mQUekW6gvKTM+yzmCugKCxoASD1tGBpw3un9/IZcnx+YG
   pWhXbGBx3dZFwCNJbqRkcC0s7s2Rm7oGWLc/+Gkp1DaacJCMWSKe0q6CH
   IASfyqFyXoVdbiZS14CFHN7N9tBE3n1QWTwA3bOZPAXBRfdFXPrt2Km03
   ubDuAhtHHKcKEyfcpsukclgM+EjCfqkqs7st5OoKcR1UkFvK/dolAQcOX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402296729"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="402296729"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="747046060"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="747046060"
Received: from fli4-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.28.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:19 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] thermal/core: Enforce paired .bind/.unbind callbacks
Date:   Fri, 24 Mar 2023 15:08:06 +0800
Message-Id: <20230324070807.6342-4-rui.zhang@intel.com>
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

The .bind/.unbind callbacks are designed to allow the thermal zone
device to bind to/unbind from a matched cooling device, with thermal
instances created/deleted.

In this sense, .bind/.unbind callbacks must exist in pairs.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5225d65fb0e0..9c447f22cb39 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1258,6 +1258,11 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
 		return ERR_PTR(-EINVAL);
 
+	if ((ops->bind && !ops->unbind) || (!ops->bind && ops->unbind)) {
+		pr_err("Thermal zone device .bind/.unbind not paired\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (!thermal_class)
 		return ERR_PTR(-ENODEV);
 
-- 
2.25.1

