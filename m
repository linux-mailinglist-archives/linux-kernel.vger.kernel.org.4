Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904E6C77A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCXGLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCXGLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:11:11 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8534028D0F;
        Thu, 23 Mar 2023 23:11:08 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=mx_xiang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32O69qcD019681-32O69qcE019681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Mar 2023 14:10:05 +0800
From:   Mingxuan Xiang <mx_xiang@hust.edu.cn>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: host: remove dead code in dwc3_host_get_irq()
Date:   Fri, 24 Mar 2023 14:09:34 +0800
Message-Id: <20230324060934.1686859-1-mx_xiang@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: mx_xiang@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the description of platform_get_irq()
 * Return: non-zero IRQ number on success, 
 			negative error number on failure.
and the code, platform_get_irq() will return -EINVAL
instead of IRQ0.

So platform_get_irq() no longer returns 0, there is no
need to check whether the return value is 0.

Found by Smatch:
drivers/usb/dwc3/host.c:60 dwc3_host_get_irq() 
	warn: platform_get_irq() does not return zero

Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
---
v2->v3: remove curly braces
v1->v2: remove redundant goto
Only compile tested.
---
 drivers/usb/dwc3/host.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f6f13e7f1ba1..61f57fe5bb78 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -52,13 +52,8 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 		goto out;
 
 	irq = platform_get_irq(dwc3_pdev, 0);
-	if (irq > 0) {
+	if (irq > 0)
 		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
-		goto out;
-	}
-
-	if (!irq)
-		irq = -EINVAL;
 
 out:
 	return irq;
-- 
2.39.2

