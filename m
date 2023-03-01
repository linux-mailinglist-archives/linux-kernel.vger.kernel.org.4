Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220E16A7422
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCATSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCATSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:18:42 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3001EBC2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677698315; bh=ogcEBaEy1wZAdHGyLeSR8qWSOuPxWcnTW1vgZPpNF7g=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=cVZYUaZgQCNYgW+huld/Ew+w+uy52upTvmhUeWnF0LcAFVQOcpIWMCaa8h7g3bCau
         bjb8TJ/WbA5H7kz4Cf7RQjQJ6k6Txpb1ur1xtmYgVeZIaL9QVnCAACbO3hdJh0A/GD
         E8NEm+fDgpicWQ4FFsF+zi/GGw0OJn4yeiGsE9Gc=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  1 Mar 2023 20:18:35 +0100 (CET)
X-EA-Auth: riO4H6yjRbeC5UwPFxBDYasXlEjMvqpapw0hlfyMNHgHFlSLPSGxpF9WZrPjX/YF0BgGiJbM+3h2bJNcJHEndQ==
Date:   Thu, 2 Mar 2023 00:48:29 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH RESEND] soc/tegra: cbb: Remove redundant error logging
Message-ID: <Y/+lBWIEycHz+cqn@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to platform_get_irq() already prints an error on failure within
its own implementation. So printing another error based on its return
value in the caller is redundant and should be removed. The clean up
also makes if condition block braces unnecessary. Remove that as well.

Issue identified using platform_get_irq.cocci coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note:
   The patch was successfully build tested for ARM64 config.
   Resending the patch for review and feedback.


 drivers/soc/tegra/cbb/tegra-cbb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra-cbb.c b/drivers/soc/tegra/cbb/tegra-cbb.c
index a8566b9dd8de..d9ce3d70813a 100644
--- a/drivers/soc/tegra/cbb/tegra-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra-cbb.c
@@ -127,20 +127,16 @@ int tegra_cbb_get_irq(struct platform_device *pdev, unsigned int *nonsec_irq,
 
 	if (num_intr == 2) {
 		irq = platform_get_irq(pdev, index);
-		if (irq <= 0) {
-			dev_err(&pdev->dev, "failed to get non-secure IRQ: %d\n", irq);
+		if (irq <= 0)
 			return -ENOENT;
-		}
 
 		*nonsec_irq = irq;
 		index++;
 	}
 
 	irq = platform_get_irq(pdev, index);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "failed to get secure IRQ: %d\n", irq);
+	if (irq <= 0)
 		return -ENOENT;
-	}
 
 	*sec_irq = irq;
 
-- 
2.34.1



