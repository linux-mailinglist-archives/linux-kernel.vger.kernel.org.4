Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519B66B287A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCIPMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCIPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:12:19 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243FE3C7BC;
        Thu,  9 Mar 2023 07:09:05 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=yalongz@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 329F8HZF004348-329F8HZG004348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Mar 2023 23:08:22 +0800
From:   Yalong Zou <yalongz@hust.edu.cn>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yalong Zou <yalongz@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: remove dead code in dwc3_gadget_get_irq
Date:   Thu,  9 Mar 2023 23:08:15 +0800
Message-Id: <20230309150815.1884260-1-yalongz@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: yalongz@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() only return non-zero irq number on success, or
negative error number on failure.

There is no need to check the return value of platform_get_irq()
to determine the return value of dwc3_gadget_get_irq(), removing
them to solve this problem.

Signed-off-by: Yalong Zou <yalongz@hust.edu.cn>
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/usb/dwc3/gadget.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3c63fa97a680..6318dd2855cc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4409,11 +4409,6 @@ static int dwc3_gadget_get_irq(struct dwc3 *dwc)
 		goto out;
 
 	irq = platform_get_irq(dwc3_pdev, 0);
-	if (irq > 0)
-		goto out;
-
-	if (!irq)
-		irq = -EINVAL;
 
 out:
 	return irq;
-- 
2.39.2

