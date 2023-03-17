Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749CD6BDF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCQDHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCQDGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:06:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0425CB1ED1;
        Thu, 16 Mar 2023 20:06:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 826B24B3;
        Thu, 16 Mar 2023 20:06:43 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0DE63F64C;
        Thu, 16 Mar 2023 20:05:53 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     scclevenger@os.amperecomputing.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] of/platform: Skip coresight etm4x devices from AMBA bus
Date:   Fri, 17 Mar 2023 08:35:00 +0530
Message-Id: <20230317030501.1811905-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317030501.1811905-1-anshuman.khandual@arm.com>
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow other drivers to claim a device, disregarding the "priority" of
"arm,primecell". e.g., CoreSight ETM4x devices could be accessed via MMIO
(AMBA Bus) or via CPU system instructions. The CoreSight ETM4x platform
driver can now handle both types of devices. In order to make sure the
driver gets to handle the "MMIO based" devices, which always had the
"arm,primecell" compatible, we have two options :

1) Remove the "arm,primecell" from the DTS. But this may be problematic
 for an older kernel without the support.

2) The other option is to allow OF code to "ignore" the arm,primecell
priority for a selected list of compatibles. This would make sure that
both older kernels and the new kernels work fine without breaking
the functionality. The new DTS could always have the "arm,primecell"
removed.

This patch implements Option (2).

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Co-developed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Signed-off-by: Suzuki Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/of/platform.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b2bd2e783445..59ff1a38ccaa 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -325,6 +325,13 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
 	return NULL;
 }
 
+static const struct of_device_id of_ignore_amba_table[] = {
+#ifdef CONFIG_CORESIGHT_SOURCE_ETM4X
+	{ .compatible = "arm,coresight-etm4x" },
+#endif
+	{}    /* NULL terminated */
+};
+
 /**
  * of_platform_bus_create() - Create a device for a node and its children.
  * @bus: device node of the bus to instantiate
@@ -373,7 +380,8 @@ static int of_platform_bus_create(struct device_node *bus,
 		platform_data = auxdata->platform_data;
 	}
 
-	if (of_device_is_compatible(bus, "arm,primecell")) {
+	if (of_device_is_compatible(bus, "arm,primecell") &&
+	    unlikely(!of_match_node(of_ignore_amba_table, bus))) {
 		/*
 		 * Don't return an error here to keep compatibility with older
 		 * device tree files.
-- 
2.25.1

