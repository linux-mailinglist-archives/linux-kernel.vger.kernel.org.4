Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555FC6E5D06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjDRJJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDRJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:09:01 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D617A85;
        Tue, 18 Apr 2023 02:08:40 -0700 (PDT)
Received: from legion.. ([172.16.0.254])
        (user=lidaxian@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33I98CGR017477-33I98CGS017477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Apr 2023 17:08:18 +0800
From:   Li Yang <lidaxian@hust.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Li Yang <lidaxian@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()
Date:   Tue, 18 Apr 2023 17:07:57 +0800
Message-Id: <20230418090758.18756-1-lidaxian@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: lidaxian@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:
drivers/usb/phy/phy-tahvo.c: tahvo_usb_probe()
warn: missing unwind goto?

After geting irq, if ret < 0, it will return without error handling to
free memory.
Just add error handling to fix this problem.

Fixes: 0d45a1373e66 ("usb: phy: tahvo: add IRQ check")
Signed-off-by: Li Yang <lidaxian@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
The issue is found by static analysis, and the patch remains untest.
---
 drivers/usb/phy/phy-tahvo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index f2d2cc586c5b..184a5f3d7473 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -390,8 +390,11 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, tu);
 
 	tu->irq = ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not get irq: %d\n",
+				ret);
+		goto err_remove_phy;
+	}
 	ret = request_threaded_irq(tu->irq, NULL, tahvo_usb_vbus_interrupt,
 				   IRQF_ONESHOT,
 				   "tahvo-vbus", tu);
-- 
2.34.1

