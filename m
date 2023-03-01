Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59816A6BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCALkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCALkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:40:20 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C753C781;
        Wed,  1 Mar 2023 03:40:01 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PRXFw5r7YzKmK6;
        Wed,  1 Mar 2023 19:34:44 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 1 Mar
 2023 19:39:42 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
Subject: [PATCH -next] watchdog: sbsa: Test WDOG_HW_RUNNING bit in suspend and resume
Date:   Wed, 1 Mar 2023 11:37:02 +0000
Message-ID: <20230301113702.76437-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sbsa_gwdt is enabled by BIOS, the kernel set WDOG_HW_RUNNING bit
and keep it alive before anyone else would open it. When system suspend,
the sbsa_gwdt would not be disabled because WDOG_ACTIVE is not set. Then
the sbsa_gwdt would reach timeout since no one touch it during system
suspend.

To solve this, just test WDOG_HW_RUNNING bit in suspend and disable the
sbsa_gwdt if the bit is set, then reopen it accordingly in resume
process.

Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/watchdog/sbsa_gwdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 9791c74aebd4..60875a710e43 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -360,7 +360,7 @@ static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
 {
 	struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&gwdt->wdd))
+	if (watchdog_hw_running(&gwdt->wdd))
 		sbsa_gwdt_stop(&gwdt->wdd);
 
 	return 0;
@@ -371,7 +371,7 @@ static int __maybe_unused sbsa_gwdt_resume(struct device *dev)
 {
 	struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(&gwdt->wdd))
+	if (watchdog_hw_running(&gwdt->wdd))
 		sbsa_gwdt_start(&gwdt->wdd);
 
 	return 0;
-- 
2.17.1

