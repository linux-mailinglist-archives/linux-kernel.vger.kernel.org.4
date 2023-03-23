Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00066C5F22
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCWFoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCWFn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:43:59 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AF230E1;
        Wed, 22 Mar 2023 22:43:58 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=mx_xiang@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32N5gXaO025806-32N5gXaP025806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Mar 2023 13:42:46 +0800
From:   Mingxuan Xiang <mx_xiang@hust.edu.cn>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: host: remove dead code in dwc3_host_get_irq()
Date:   Thu, 23 Mar 2023 13:42:32 +0800
Message-Id: <20230323054232.1135734-1-mx_xiang@hust.edu.cn>
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
 drivers/usb/dwc3/host.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f6f13e7f1ba1..aa19c27344e6 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -57,9 +57,6 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 		goto out;
 	}
 
-	if (!irq)
-		irq = -EINVAL;
-
 out:
 	return irq;
 }
-- 
2.39.2

