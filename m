Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7057162EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjE3ODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjE3OC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:02:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B72EA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685455378; x=1716991378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Odlz6QoyGHLlPacaqDxKEe73Bq1p2WtniVZNmbgCKKY=;
  b=Ne5lq2MjZQwSI4I6RUoIaSXLy6GPab/42FTeoyArlzDs3jWqs8gIKlTk
   Xv+mD2V5+/79Ion13mpSzdUEjfuGrDwMyyvS1I8OPE0YihpRVfUUK9x9B
   nnybVjc0Pfpuj75TIpf9U33MF/OT0xgfz3nAt/Sl3nINo6Oty05L7V1AX
   lCaaiEKIfhtHb6XplgLzDAnCFrwU16jTjh7y16OFpeIz1cCFa1rH3RVsV
   6/N+oa2yy4jDTNGdljwkS9Lx6J0K0cEloWBvQrg143tm4AznPQsYczS6d
   E6O6xLUO9UTlsSvKXrm7nY8c3b1TAdpeP7jLl8wurT1yMW9HCw2OLEpwi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383179417"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383179417"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 07:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="953142977"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="953142977"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.105.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 07:02:56 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     arnd@arndb.de
Cc:     hch@lst.de, andriy.shevchenko@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] misc: enclosure: remove get_active callback
Date:   Tue, 30 May 2023 16:02:22 +0200
Message-Id: <20230530140223.13994-2-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230530140223.13994-1-mariusz.tkaczyk@linux.intel.com>
References: <20230530140223.13994-1-mariusz.tkaczyk@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback is not used, remove it. Leave possibility to read cached
ecomp->active value.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
---
 drivers/misc/enclosure.c  | 4 +---
 include/linux/enclosure.h | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 1b010d9267c9..59704fdb962a 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -534,11 +534,9 @@ static ssize_t set_component_status(struct device *cdev,
 static ssize_t get_component_active(struct device *cdev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct enclosure_device *edev = to_enclosure_device(cdev->parent);
 	struct enclosure_component *ecomp = to_enclosure_component(cdev);
 
-	if (edev->cb->get_active)
-		edev->cb->get_active(edev, ecomp);
+	/* The value may have been updated by edev->cb->set_active(). */
 	return sysfs_emit(buf, "%d\n", ecomp->active);
 }
 
diff --git a/include/linux/enclosure.h b/include/linux/enclosure.h
index 1c630e2c2756..8d09c6d07bf1 100644
--- a/include/linux/enclosure.h
+++ b/include/linux/enclosure.h
@@ -62,8 +62,6 @@ struct enclosure_component_callbacks {
 	int (*set_fault)(struct enclosure_device *,
 			 struct enclosure_component *,
 			 enum enclosure_component_setting);
-	void (*get_active)(struct enclosure_device *,
-			   struct enclosure_component *);
 	int (*set_active)(struct enclosure_device *,
 			  struct enclosure_component *,
 			  enum enclosure_component_setting);
-- 
2.26.2

