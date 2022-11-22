Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A963365C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiKVHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiKVHxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:53:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F72C32070
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:53:35 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGbxv3lTXzqSYG;
        Tue, 22 Nov 2022 15:49:39 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 15:53:33 +0800
Received: from linux-ibm.site (10.175.102.37) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 15:53:33 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Won Chung <wonchung@google.com>,
        "Hanjun Guo" <guohanjun@huawei.com>
Subject: [PATCH] driver core: location: Free struct acpi_pld_info *pld before return false
Date:   Tue, 22 Nov 2022 15:37:28 +0800
Message-ID: <1669102648-11517-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct acpi_pld_info *pld should be freed before the return of allocation
failure, to prevent memory leak, add the ACPI_FREE() to fix it.

Fixes: bc443c31def5 ("driver core: location: Check for allocations failure")
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/base/physical_location.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/physical_location.c b/drivers/base/physical_location.c
index 87af641..951819e 100644
--- a/drivers/base/physical_location.c
+++ b/drivers/base/physical_location.c
@@ -24,8 +24,11 @@ bool dev_add_physical_location(struct device *dev)
 
 	dev->physical_location =
 		kzalloc(sizeof(*dev->physical_location), GFP_KERNEL);
-	if (!dev->physical_location)
+	if (!dev->physical_location) {
+		ACPI_FREE(pld);
 		return false;
+	}
+
 	dev->physical_location->panel = pld->panel;
 	dev->physical_location->vertical_position = pld->vertical_position;
 	dev->physical_location->horizontal_position = pld->horizontal_position;
-- 
1.7.12.4

