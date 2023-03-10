Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9F6B54B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjCJWmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjCJWmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:42:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D6814FE04
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:41:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQg-0002dC-Cg; Fri, 10 Mar 2023 23:41:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQe-003GqP-UJ; Fri, 10 Mar 2023 23:41:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQe-003uEb-A7; Fri, 10 Mar 2023 23:41:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] bus: fsl-mc: fsl-mc-allocator: Drop if block with always wrong condition
Date:   Fri, 10 Mar 2023 23:41:25 +0100
Message-Id: <20230310224128.2638078-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Us0uaGo+ZVeSCyVAMYktRapjadAzUAbMySr9dkZDyhY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkC7IIiLBXyBkvldrNjLxXSuVihB+XZFHPrH9iZ bSlYnYChKKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAuyCAAKCRDB/BR4rcrs CUUWB/9/k9C4veBM5Ob0UtSIRQ0RivJZb9RntiAY5ubwFG0IuOjbbv7HTRcqEAHgS4cjiroDepr fSyQLcyu3ha75lLy3dvgFC61wso4UbZpTyPFO1GGUsmHihdhRP+nwnb14lQe40QPUX23fKiYKgZ 7QRGp3c+Vvlufr+G43AloQzBpDYgzqCyLH+KpXW9Wq2psPWujyDhQiFPTjci8dNQJnY/isPi6IP gsYRdbtoiB922C7ibOW7Zbu7jIjPxlTZHSlyrrrapXtN4jilw43+naa4rnKUgI9ql/lhClvqnzo LeD899Bgjn62Eyk5CVpT45EyFpAWkwkzDITW1VPBtDSVa/pU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fsl_mc_is_allocatable(mc_dev) evaluates to false, the driver won't
have bound to that device and then fsl_mc_allocator_remove() is never
called for that device. fsl_mc_allocator_remove() is the only caller of
fsl_mc_resource_pool_remove_device(), so the same check can be removed
from there.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index dced427ca8ba..e60faf8edaa1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -103,9 +103,6 @@ static int __must_check fsl_mc_resource_pool_remove_device(struct fsl_mc_device
 	struct fsl_mc_resource *resource;
 	int error = -EINVAL;
 
-	if (!fsl_mc_is_allocatable(mc_dev))
-		goto out;
-
 	resource = mc_dev->resource;
 	if (!resource || resource->data != mc_dev)
 		goto out;
@@ -613,9 +610,6 @@ static int fsl_mc_allocator_remove(struct fsl_mc_device *mc_dev)
 {
 	int error;
 
-	if (!fsl_mc_is_allocatable(mc_dev))
-		return -EINVAL;
-
 	if (mc_dev->resource) {
 		error = fsl_mc_resource_pool_remove_device(mc_dev);
 		if (error < 0)
-- 
2.39.1

