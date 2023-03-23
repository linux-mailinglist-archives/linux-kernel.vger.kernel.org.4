Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2874F6C6D03
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCWQLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjCWQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:11:22 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B204A32CCF;
        Thu, 23 Mar 2023 09:10:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VeUu73m_1679587840;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VeUu73m_1679587840)
          by smtp.aliyun-inc.com;
          Fri, 24 Mar 2023 00:10:53 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [RESEND PATCH] driver/perf: arm-cmn: support ACPI probe
Date:   Fri, 24 Mar 2023 00:10:38 +0800
Message-Id: <1679587838-80000-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI companion devices call insert_resource() in platform_device_add()
to claim the device resources. If the resources are claimed again before
ioremap(), and the addresses of multiple resources overlap, it will
return -BUSY, causing the driver to fail to load.

For example, the CMN700 on my machine is set with two resources similar
to CMN600, and the overlap of resource addresses makes the CMN driver
unable to match my CMN700. The error log:

[  12.016837] arm-cmn ARMHC700:00: can't request region for resource [mem 0x40000000-0x4fffffff]
[  12.028230] arm-cmn: probe of ARMHC700:00 failed with error -16
[  12.036832] arm-cmn ARMHC700:01: can't request region for resource [mem 0x40040000000-0x4004fffffff]
[  12.051289] arm-cmn: probe of ARMHC700:01 failed with error -16

So let ACPI companion devices call arm_cmn_acpi_probe() and not claim
resource again. In addition, the arm_cmn_acpi_probe() and
arm_cmn_of_probe() functions are refactored to make them compatible
with both CMN600 and CMN-ANY.

Fixes: 61ec1d875812 ("perf/arm-cmn: Demarcate CMN-600 specifics")
Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 drivers/perf/arm-cmn.c | 57 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 1deb61b..beb3b37 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2206,7 +2206,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	return 0;
 }
 
-static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
+static int arm_cmn_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
 {
 	struct resource *cfg, *root;
 
@@ -2214,12 +2214,21 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
 	if (!cfg)
 		return -EINVAL;
 
-	root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!root)
-		return -EINVAL;
+	/* If ACPI defines more than one resource, such as cmn-600, then there may be
+	 * a deviation between ROOTNODEBASE and PERIPHBASE, and ROOTNODEBASE can
+	 * be obtained from the second resource. Otherwise, it can be considered that
+	 * ROOT NODE BASE is PERIPHBASE. This is compatible with cmn-600 and cmn-any.
+	 */
+	if (pdev->num_resources > 1) {
+		root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!root)
+			return -EINVAL;
 
-	if (!resource_contains(cfg, root))
-		swap(cfg, root);
+		if (!resource_contains(cfg, root))
+			swap(cfg, root);
+	} else {
+		root = cfg;
+	}
 	/*
 	 * Note that devm_ioremap_resource() is dumb and won't let the platform
 	 * device claim cfg when the ACPI companion device has already claimed
@@ -2227,17 +2236,30 @@ static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *c
 	 * appropriate name, we don't really need to do it again here anyway.
 	 */
 	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
-	if (!cmn->base)
-		return -ENOMEM;
+	if (IS_ERR(cmn->base))
+		return PTR_ERR(cmn->base);
 
 	return root->start - cfg->start;
 }
 
-static int arm_cmn600_of_probe(struct device_node *np)
+static int arm_cmn_of_probe(struct platform_device *pdev, struct arm_cmn *cmn)
 {
 	u32 rootnode;
+	int ret;
+
+	cmn->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cmn->base))
+		return PTR_ERR(cmn->base);
 
-	return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
+	/* If of_property_read_u32() return -EINVAL, it means that device tree has
+	 * not define root-node, and root-node will return 0, which is compatible
+	 * with cmn-600 and cmn-any.
+	 */
+	ret = of_property_read_u32(pdev->dev.of_node, "arm,root-node", &rootnode);
+	if (ret == -EINVAL)
+		return 0;
+
+	return rootnode;
 }
 
 static int arm_cmn_probe(struct platform_device *pdev)
@@ -2255,16 +2277,11 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	cmn->model = (unsigned long)device_get_match_data(cmn->dev);
 	platform_set_drvdata(pdev, cmn);
 
-	if (cmn->model == CMN600 && has_acpi_companion(cmn->dev)) {
-		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
-	} else {
-		rootnode = 0;
-		cmn->base = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(cmn->base))
-			return PTR_ERR(cmn->base);
-		if (cmn->model == CMN600)
-			rootnode = arm_cmn600_of_probe(pdev->dev.of_node);
-	}
+	if (has_acpi_companion(cmn->dev))
+		rootnode = arm_cmn_acpi_probe(pdev, cmn);
+	else
+		rootnode = arm_cmn_of_probe(pdev, cmn);
+
 	if (rootnode < 0)
 		return rootnode;
 
-- 
1.8.3.1

