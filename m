Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79275EF361
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiI2KY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiI2KYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:24:51 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CA882ED4C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:24:50 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 2FB1520DEE80; Thu, 29 Sep 2022 03:24:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FB1520DEE80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664447090;
        bh=mWyDCK4sgwNQboz2oMaLFnl6zMEOPYFWjgXwMVYGH4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQq1j/TGTKNgftQPa/1lLz0CNf/6/sX0IV2JrXrkdUMoWX606HHPBjS81p0mfbKep
         upjEu4ANjuEYEUCBjwzHlL+jOkTnOSMWKPAvyvayrJi7zqDg18lEDsjUMzmcUXbNhQ
         w6DEZD2Z7EVjcKAlrXhoL1fcp+uo7bR2HGogVATw=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 1/2] mm/page_reporting: Add checks for page_reporting_order param value
Date:   Thu, 29 Sep 2022 03:24:40 -0700
Message-Id: <1664447081-14744-2-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code allows the page_reporting_order parameter to be changed
via sysfs to any integer value.  The new value is used immediately
in page reporting code with no validation, which could cause incorrect
behavior.  Fix this by adding validation of the new value.
Export this parameter for use in the driver that is calling the
page_reporting_register().
This is needed by drivers like hv_balloon to know the order of the
pages reported. Traditionally the values provided in the kernel boot
line or subsequently changed via sysfs take priority therefore, if
page_reporting_order parameter's value is set, it takes precedence
over the value passed while registering with the driver.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 mm/page_reporting.c | 50 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 382958eef8a9..29d67c824fd2 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -11,10 +11,42 @@
 #include "page_reporting.h"
 #include "internal.h"
 
-unsigned int page_reporting_order = MAX_ORDER;
-module_param(page_reporting_order, uint, 0644);
+/* Initialize to an unsupported value */
+unsigned int page_reporting_order = -1;
+
+int page_order_update_notify(const char *val, const struct kernel_param *kp)
+{
+	/*
+	 * If param is set beyond this limit, order is set to default
+	 * pageblock_order value
+	 */
+	return  param_set_uint_minmax(val, kp, 0, MAX_ORDER-1);
+}
+
+const struct kernel_param_ops page_reporting_param_ops = {
+	.set = &page_order_update_notify,
+	/*
+	 * For the get op, use param_get_int instead of param_get_uint.
+	 * This is to make sure that when unset the initialized value of
+	 * -1 is shown correctly
+	 */
+	.get = &param_get_int,
+};
+
+module_param_cb(page_reporting_order, &page_reporting_param_ops,
+			&page_reporting_order, 0644);
 MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
 
+/*
+ * This symbol is also a kernel parameter. Export the page_reporting_order
+ * symbol so that other drivers can access it to control order values without
+ * having to introduce another configurable parameter. Only one driver can
+ * register with the page_reporting driver for the service, so we have just
+ * one control parameter for the use case(which can be accessed in both
+ * drivers)
+ */
+EXPORT_SYMBOL_GPL(page_reporting_order);
+
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
@@ -330,10 +362,18 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	}
 
 	/*
-	 * Update the page reporting order if it's specified by driver.
-	 * Otherwise, it falls back to @pageblock_order.
+	 * If the page_reporting_order value is not set, we check if
+	 * an order is provided from the driver that is performing the
+	 * registration. If that is not provided either, we default to
+	 * pageblock_order.
 	 */
-	page_reporting_order = prdev->order ? : pageblock_order;
+
+	if (page_reporting_order == -1) {
+		if (prdev->order > 0 && prdev->order <= MAX_ORDER)
+			page_reporting_order = prdev->order;
+		else
+			page_reporting_order = pageblock_order;
+	}
 
 	/* initialize state and work structures */
 	atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
-- 
2.37.2

