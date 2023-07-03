Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EC7456E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGCIFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjGCIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:04:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814F10E5;
        Mon,  3 Jul 2023 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688371433; x=1719907433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+KEWHKPpqNaiI+WNm1olqE9/TBQfa5bBD6OIb1rqfsw=;
  b=lKJR5COESjgAjmyj1ZRYFH3eSz/pThN0F4FzNkZedMC2S/afK10whMN4
   LEHGHEbRipyQmoc+L2TdyMav2zvdEhXpprI4ThDpe0I6/Ym8O0vWb4eqh
   Hsl1cTU3TAdaIAxOYHWy9K4Dvw7n2dx3xSNgoYlUfxAhJbM9VHHYh1cdS
   RMddsaQ0kwezzy3JOdOGwBngogriZ0os4oEbglWth628pvgfquXD8FTKx
   sogGZ2n7aptgoF5dzSmchMK+/qjouTPT9lijzUfQpSjRCxw2z76HNTvte
   VBWLmAUx8lAbxZdSscfOLXeC09+ko/knovAlQ11cpV9nlzTNhIB5JY9ky
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366304100"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366304100"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="862994575"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="862994575"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:36 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v7 8/9] acpi/nfit: Remove unnecessary .remove callback
Date:   Mon,  3 Jul 2023 11:02:51 +0300
Message-ID: <20230703080252.2899090-9-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703080252.2899090-1-michal.wilczynski@intel.com>
References: <20230703080252.2899090-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nfit driver doesn't use .remove() callback and provide an empty function
as it's .remove() callback. Remove empty acpi_nfit_remove() and
initialization of callback.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 124e928647d3..16bf17a3d6ff 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3402,11 +3402,6 @@ static int acpi_nfit_add(struct acpi_device *adev)
 					adev);
 }
 
-static void acpi_nfit_remove(struct acpi_device *adev)
-{
-	/* see acpi_nfit_unregister */
-}
-
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
 {
 	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
@@ -3488,7 +3483,6 @@ static struct acpi_driver acpi_nfit_driver = {
 	.ids = acpi_nfit_ids,
 	.ops = {
 		.add = acpi_nfit_add,
-		.remove = acpi_nfit_remove,
 	},
 };
 
-- 
2.41.0

