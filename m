Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3504651A37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 06:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiLTFZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 00:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiLTFZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 00:25:36 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF61C12759
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 21:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671513916; bh=sFskYXbidjd/kcmqsM6ylTeRnbnKAC12byfrx9G5ZBw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=e0NyAsLbQs/avEnwiC7ZsVK9GU4zrPuQ2XS2Ty1xYms0TvZepQfGJFyoXdovGjoPg
         nLFh9Azc+zv2bYdeL81WbyjoQwjCRe+8KHm/0j+9fgCl8r4OFQLTKGwboLCvlQzsrA
         h66ImFahB2Wf5lr5pJmUA8uWAo9X2/daha3s3yRU=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 20 Dec 2022 06:25:16 +0100 (CET)
X-EA-Auth: UI0gHJBKyazNjZiXWvC0DmV1kOkEQvUhUW4KYOzbDoHDVw8pLiXzVtXTgzUhY3wuuWiIusiFO/ZVMxGyeNWUeIXmzD/eWeUJ
Date:   Tue, 20 Dec 2022 10:55:11 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] ARM/dma-mapping: use kvzalloc for fallback memory allocation
 need
Message-ID: <Y6FHN9RyUKsQLo0i@qemulion>
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

When the memory sizes are not known upfront, it is preferred to use the
kvzalloc helper function instead of direct conditional evaluation of
size and kzalloc/vzalloc fallback design. The kvzalloc helper function
in this case is more efficient as it avoids indefinite kzalloc retries
when a small memory size is needed but is unavailable.
This LWN article has further details on the advantages of using
kvzalloc in case of fallback memory allocation needs:
 	https://lwn.net/Articles/711653/

This patch proposal is based on following Coccinelle warning using the
kvmalloc.cocci semantic patch.

arch/arm/mm/dma-mapping.c:858:28-29: WARNING opportunity for kvmalloc

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: The patch proposal is compile tested only.

 arch/arm/mm/dma-mapping.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c135f6e37a00..2b79af377a81 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -855,10 +855,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	int i = 0;
 	int order_idx = 0;

-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvzalloc(array_size, GFP_KERNEL);
 	if (!pages)
 		return NULL;

--
2.34.1



