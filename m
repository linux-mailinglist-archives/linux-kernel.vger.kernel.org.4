Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C365F568D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJEOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJEOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:38:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293887CAA4;
        Wed,  5 Oct 2022 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664980685; x=1696516685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uI6x+OuIX8Zsde+No42SImigImxqe3gZvNiHUYWU+j8=;
  b=aDpn+9XMHsE0e2+ffSeqpDI8Hx3l944EC+sk718neEhyYHBoJzmScMwP
   Zw0iF3Y40EAX89qBN+2SAXnb+1mDRMNTid2Z+TppHDuKztHUBNyI8imOT
   1yDBQvPOkGJwr709GbgsImivwuGLXXYjOPhVMRp3HUsyrTIM4SNHo9rZM
   3q4NGnETFiRLeiZ1zT1UbPx7JcAPBoAN29eiv+VGx+tkLXzlBzfX9ZqnO
   0nWWBRen7iK58BapVOA0V0hCVRqZiSZZzkjgJVAmF6BX+DM6ay2E2aCuS
   qotsAV8D6n+BTG7IZ5zrqJcv/TWrwDyIzDOXOyTPQnd2EOiVwzgn8Qbn+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304744012"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="304744012"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 07:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="619481343"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="619481343"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Oct 2022 07:38:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6221A155; Wed,  5 Oct 2022 17:38:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 2/2] soc: fsl: qe: Switch to use fwnode instead of of_node
Date:   Wed,  5 Oct 2022 17:38:12 +0300
Message-Id: <20221005143812.33503-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005143812.33503-1-andriy.shevchenko@linux.intel.com>
References: <20221005143812.33503-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF node in the GPIO library is deprecated and soon
will be removed.

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/soc/fsl/qe/gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 99f7de43c3c6..9abb45ab138b 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -19,6 +19,8 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/property.h>
+
 #include <soc/fsl/qe/qe.h>
 
 struct qe_gpio_chip {
@@ -179,7 +181,7 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
 		goto err0;
 	}
 
-	if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
+	if (!fwnode_device_is_compatible(gc->fwnode, "fsl,mpc8323-qe-pario-bank")) {
 		pr_debug("%s: tried to get a non-qe pin\n", __func__);
 		err = -EINVAL;
 		goto err0;
-- 
2.35.1

