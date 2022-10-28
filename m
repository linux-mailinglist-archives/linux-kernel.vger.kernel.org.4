Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00AF6117CA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJ1QnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ1QnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:43:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA351E3ECD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:43:00 -0700 (PDT)
X-QQ-mid: bizesmtp65t1666975373t3ojrg6p
Received: from localhost.localdomain ( [139.227.214.232])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 29 Oct 2022 00:42:25 +0800 (CST)
X-QQ-SSF: 01100000002000G0Z000B00A0000000
X-QQ-FEAT: HIVLo4mOhq4qihiPUl/eRaSVdgWUX71V7R5uJ06BDbmcypBb+mqsGkSrPIOFf
        sKrNbRzeGR6sCZ1H3OiUHjyt+wfn5os6fTIYkTsB8pe2tenL2s5BycrsMwOrBWv2Sc00ike
        dudrKmbBzDD9ngtWBXSrX9TfUwsISaJr2Nc1GRNoaaq0jUvajcgDRrpt30FBewM+WA+GDMI
        6fHE8Uq6iqKKPyAeTo02wzRG8Kn8H/XSBu65Cpseho3ea17A7+ID7un6v/ml2/0CLbvuL0q
        dfEiplYMi8kIvgkrbRe2xqipb4XtqgBSWbr2DJm8zVYinnK2bOVqGo5AvqksVpFyy06DF+2
        5lduiK4MFuxQZlV+Z4pTZ9qmrWvdQ==
X-QQ-GoodBg: 0
From:   Soha Jin <soha@lohu.info>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Wende Tan <twd2.me@gmail.com>,
        Soha Jin <soha@lohu.info>
Subject: [PATCH v2] platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq
Date:   Sat, 29 Oct 2022 00:41:20 +0800
Message-Id: <20221028164120.2798-1-soha@lohu.info>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not only platform devices described by OF have named interrupts, but
devices described by ACPI also have named interrupts. The fwnode is an
abstraction to different standards, and using fwnode_irq_get_byname can
support more devices.

Moreover, when CONFIG_OF_IRQ is not enabled, there will be a stub method
always returning 0, the if statement can be removed safely.

Signed-off-by: Soha Jin <soha@lohu.info>
Tested-by: Wende Tan <twd2.me@gmail.com>
---
 drivers/base/platform.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 51bb2289865c..6cd7fd478c5f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -441,11 +441,9 @@ static int __platform_get_irq_byname(struct platform_device *dev,
 	struct resource *r;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		ret = of_irq_get_byname(dev->dev.of_node, name);
-		if (ret > 0 || ret == -EPROBE_DEFER)
-			return ret;
-	}
+	ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
+	if (ret > 0 || ret == -EPROBE_DEFER)
+		return ret;
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
 	if (r) {
-- 
2.30.2

