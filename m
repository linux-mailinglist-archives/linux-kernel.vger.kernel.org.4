Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC246423E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiLEHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiLEHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:55:03 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8511160;
        Sun,  4 Dec 2022 23:54:58 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NQbMz6wBXzkXr0;
        Mon,  5 Dec 2022 15:51:27 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 15:54:56 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <sre@kernel.org>, <linus.walleij@linaro.org>,
        <baolin.wang@linux.alibaba.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2] power: supply: fix null pointer dereferencing in power_supply_get_battery_info
Date:   Mon, 5 Dec 2022 15:51:53 +0800
Message-ID: <20221205075153.2830393-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when kmalloc() fail to allocate memory in kasprintf(), propname
will be NULL, strcmp() called by of_get_property() will cause
null pointer dereference.

So return ENOMEM if kasprintf() return NULL pointer.

Fixes: 3afb50d7125b ("power: supply: core: Add some helpers to use the battery OCV capacity table")
Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
v2:
- release resource instead of just returning error number
---
 drivers/power/supply/power_supply_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 4b5fb172fa99..afbe9eecfc30 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -750,6 +750,11 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		int i, tab_len, size;
 
 		propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
+		if (!propname) {
+			power_supply_put_battery_info(psy, info);
+			err = -ENOMEM;
+			goto out_put_node;
+		}
 		list = of_get_property(battery_np, propname, &size);
 		if (!list || !size) {
 			dev_err(&psy->dev, "failed to get %s\n", propname);
-- 
2.25.1

