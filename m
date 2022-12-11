Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89B649491
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiLKNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:55:27 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280BDBE0F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 05:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1670766913; bh=xq+tOsyd0WnEBYZsDftkiZ/K0hXxhKqmak3ozClnAhA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Lw7qSXIeqY0zeGmSKrp3dOZ2ty0Y08YgUu/NU5OcVnZmRzmnrbv3QgL2NPJrD69rM
         zqjp4YLX3kM8FyRwyTwpBfS+vT/ECHRIHWCBGJhzXIk0YPdsMGeM0+icZpxRXX6Lnw
         dDZZujg51h0XESzbuOdd96640l5W2EFTrqla60nI=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 11 Dec 2022 14:55:13 +0100 (CET)
X-EA-Auth: 1vJpOd6xvyZUc0g7UMKSJAb/DUIrntROzP0Ci/lss0NuJBvm6qAzgGmuTPxapEaAUk3yo/Bjo0fCa7hkbNJRkqgJMiaiOOVj
Date:   Sun, 11 Dec 2022 19:25:08 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] drm/sprd: remove redundant error logging
Message-ID: <Y5XhPJ39ipMCcctq@qemulion>
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
 drivers/gpu/drm/sprd/sprd_dpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 88f4259680f1..db0bcea1d9f4 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -803,10 +803,8 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
 	}

 	ctx->irq = platform_get_irq(pdev, 0);
-	if (ctx->irq < 0) {
-		dev_err(dev, "failed to get dpu irq\n");
+	if (ctx->irq < 0)
 		return ctx->irq;
-	}

 	/* disable and clear interrupts before register dpu IRQ. */
 	writel(0x00, ctx->base + REG_DPU_INT_EN);
--
2.34.1



