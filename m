Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E18656E09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiL0Sr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0Sr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:47:27 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D38C75B;
        Tue, 27 Dec 2022 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672166840; bh=2S5RKj0QcrEEWtKwPpcpUFIPdyQBeGymwnI0h0TfvRs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=EOtp/gR6nr6ZW/pSEkYSxekMI8r5UnfYcoO2Pf2xk/LBvOWDb1wH49l4YGMByWn5L
         AnvfirxsAA73fuPF9E5CAvEYL0DFPaVuDtHnauBqMJOy10BwGTum8Sqao91s97vqkg
         d5c+qYhj/d08u58hOv5ihIdQ9lOP+pcoevt/ZNlM=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 27 Dec 2022 19:47:20 +0100 (CET)
X-EA-Auth: eh4aWBOqXM8zlyBx5vUHM3kW6Z6FtHguRCMzJAdXbIklLRAt3EolwzZIKCDoMaD+B/ThxNFpJgI8lL6S2B4v0iKyaCm/776g
Date:   Wed, 28 Dec 2022 00:17:16 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] gpu: host1x: No need for Null pointer check before kfree
Message-ID: <Y6s9tOVk5A8NFmyH@qemulion>
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

kfree() & vfree() internally performs NULL check on the pointer handed
to it and take no action if it indeed is NULL. Hence there is no need
for a pre-check of the memory pointer before handing it to
kfree()/vfree().

Issue reported by ifnullfree.cocci Coccinelle semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/gpu/host1x/fence.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
index df428bcbae69..42498902947f 100644
--- a/drivers/gpu/host1x/fence.c
+++ b/drivers/gpu/host1x/fence.c
@@ -93,8 +93,7 @@ static void host1x_syncpt_fence_release(struct dma_fence *f)
 {
 	struct host1x_syncpt_fence *sf = to_host1x_fence(f);

-	if (sf->waiter)
-		kfree(sf->waiter);
+	kfree(sf->waiter);

 	dma_fence_free(f);
 }
--
2.34.1



