Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD46C642B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCWJ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCWJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:55:31 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A429614215;
        Thu, 23 Mar 2023 02:54:06 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=mx_xiang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32N9rDdw000357-32N9rDdx000357
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Mar 2023 17:53:17 +0800
From:   Mingxuan Xiang <mx_xiang@hust.edu.cn>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: host: remove dead code in dwc3_host_get_irq()
Date:   Thu, 23 Mar 2023 17:53:10 +0800
Message-Id: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
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

platform_get_irq() no longer returns 0, so there is no
need to check whether the return value is 0.

Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
---
v1->v2: remove redundant goto
 drivers/usb/dwc3/host.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f6f13e7f1ba1..ca1e8294e835 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -54,12 +54,8 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 	irq = platform_get_irq(dwc3_pdev, 0);
 	if (irq > 0) {
 		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
-		goto out;
 	}
 
-	if (!irq)
-		irq = -EINVAL;
-
 out:
 	return irq;
 }
-- 
2.39.2

