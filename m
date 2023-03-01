Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352546A747A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCATsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCATsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:48:38 -0500
X-Greylist: delayed 1781 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 11:48:20 PST
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A8271C;
        Wed,  1 Mar 2023 11:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677700090; bh=G8Do2SeddR9IDejdzfXb3mJ2yINZAw/nhNCrxZzNMRY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=gV519zEmvj4C4oNOXlhBA9+i64aevboY1rgNNx4PKLxoEWW6JgKJP23itMrurDJfu
         Px3lCOp2lbebQetpUtp7f787ciPnF1tGcHMUxzwDk3J7DptzLHsxeo4WvkQw0I4Dlb
         AO/qcQ0oantrR6J9L7YSOsn1DyVmzDhUcQeT/W5M=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  1 Mar 2023 20:48:10 +0100 (CET)
X-EA-Auth: hASAmwc8c6mMvRs+drNOd7GE2MX2lpbv4ZZC16GwJGIyF7aeVvkjA9YVkK/0oDZC1lfNol3EpAbLXaI5MtKzcX/mGBkLHTrw
Date:   Thu, 2 Mar 2023 01:18:06 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH RESEND] drm/tegra: sor: Remove redundant error logging
Message-ID: <Y/+r9jOO0s8sG4pX@ubun2204.myguest.virtualbox.org>
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

Issue identified using platform_get_irq.cocci coccicheck script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note:
   Resending the patch for review and feedback. Originally sent on Dec 12 2022.

 drivers/gpu/drm/tegra/sor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 8af632740673..ceaebd33408d 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3799,10 +3799,8 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	}
 
 	err = platform_get_irq(pdev, 0);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+	if (err < 0)
 		goto remove;
-	}
 
 	sor->irq = err;
 
-- 
2.34.1



